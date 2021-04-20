<?php

require_once(ROOT_DIR . '/lib/Reminder.class.php');

class FakeReminder extends Reminder
{
	function FakeReminder() {
		$day = date('d');
		$mon = date('m');
		$year = date('Y');

		$this->id = 'reminderid';
		$this->resid = 'resid';
		$this->start_time = 480;
		$this->end_time = 960;
		$this->start_date = mktime(0,0,0, $mon, $day-1, $year);
		$this->end_date = mktime(0,0,0, $mon, $day, $year);
		$this->resource_name = 'resource name';
		$this->location = 'location';
		$this->machid = 'machid';
		$this->email = 'email@email.com';
		$this->memberid = 'memberid';
		$this->timezone = 8;
	}
}
