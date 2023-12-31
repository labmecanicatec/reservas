<?php

require_once(ROOT_DIR . 'lib/Application/Reservation/namespace.php');
require_once(ROOT_DIR . 'Pages/Ajax/ReservationEmailPage.php');
require_once(ROOT_DIR . 'lib/Email/Messages/ReservationShareEmail.php');

class ReservationEmailPresenter
{
    /**
     * @var IReservationEmailPage
     */
    private $page;

    /**
     * @var UserSession
     */
    private $userSession;
    /**
     * @var IReservationRepository
     */
    private $reservationRepository;
    /**
     * @var IUserRepository
     */
    private $userRepository;
    /**
     * @var IAttributeRepository
     */
    private $attributeRepository;
    /**
     * @var IPermissionService
     */
    private $permissionService;

    public function __construct(
        IReservationEmailPage $page,
        UserSession $userSession,
        IReservationRepository $reservationRepository,
        IUserRepository $userRepository,
        IAttributeRepository $attributeRepository,
        IPermissionService $permissionService
    ) {
        $this->page = $page;
        $this->userSession = $userSession;
        $this->reservationRepository = $reservationRepository;
        $this->userRepository = $userRepository;
        $this->attributeRepository = $attributeRepository;
        $this->permissionService = $permissionService;
    }

    public function PageLoad()
    {
        $referenceNumber = $this->page->GetReferenceNumber();
        $existingSeries = $this->reservationRepository->LoadByReferenceNumber($referenceNumber);
        $existingSeries->UpdateBookedBy($this->userSession);
        $owner = $this->userRepository->LoadById($existingSeries->UserId());

        if (!$this->HasPermissionToSend($existingSeries)) {
            Log::Debug('Attempting to email reservation but user does not have permission. Reference Number %s, UserId %s', $existingSeries->CurrentInstance()->ReferenceNumber(), $this->userSession->UserId);
            return;
        }

        foreach ($this->page->GetEmailAddresses() as $emailAddress) {
            Log::Debug('Emailing reservation details. Reference Number %s, UserId %s, To %s', $existingSeries->CurrentInstance()->ReferenceNumber(), $this->userSession->UserId, $emailAddress);

            $email = new ReservationShareEmail($owner, $emailAddress, $existingSeries, $this->attributeRepository, $this->userRepository);
            ServiceLocator::GetEmailService()->Send($email);
        }
    }

    private function HasPermissionToSend(ExistingReservationSeries $existingSeries)
    {
        if ($existingSeries->UserId() == $this->userSession->UserId || $this->userSession->IsAdmin) {
            return true;
        }

        foreach ($existingSeries->AllResources() as $resource) {
            if (!$this->permissionService->CanViewResource($resource, $this->userSession)) {
                return false;
            }
        }

        return true;
    }
}
