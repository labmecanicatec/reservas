{include file='globalheader.tpl'}

<div class="container">
    <div class="panel panel-danger">
        <div class="panel-heading"><h2 id="titulo">{$AppTitle}</h2></div>
        <div class="panel-body">
            <h4 style="text-align: center;">Reanudaremos servicios en:</h4> 

            <!-- Contador regresivo -->
            <section style="text-align: center;">
                <div id="counter" class="hasCountdown">
                    <span class="countdown_row countdown_show3">
                        <span class="countdown_section">
                            <span class="countdown_amount" id="days"></span>Días
                        </span>
                        <span class="countdown_section">
                            <span class="countdown_amount" id="hours"></span>Horas
                        </span>
                        <span class="countdown_section">
                            <span class="countdown_amount" id="minutes"></span>Minutos
                        </span>
                        <span class="countdown_section">
                            <span class="countdown_amount" id="seconds"></span>Segundos
                        </span>
                    </span>
                </div>
            </section>
             <!-- Fin contador regresivo -->

            <h4 style="text-align: center;">Información de contacto del Administrador de {$AppTitle}:</h4>

            <h4 style="text-align: center;">Teléfono: 3239300 ext 5046 <br>
            Correo electrónico: <a href="mailto:labmecanicatec@udistrital.edu.co" target="_top">labmecanicatec@udistrital.edu.co</a> </h4>
        </div>
    </div>
</div>
{include file="javascript-includes.tpl"}
{include file='globalfooter.tpl'}
<script>
document.addEventListener('DOMContentLoaded', () => { 

 //===
 // VARIABLES
 //===
 const DATE_TARGET = new Date('2024-02-06 22:00:00 GMT-0500');
 // DOM for render
 const SPAN_DAYS = document.querySelector('span#days');
 const SPAN_HOURS = document.querySelector('span#hours');
 const SPAN_MINUTES = document.querySelector('span#minutes');
 const SPAN_SECONDS = document.querySelector('span#seconds');
 // Milliseconds for the calculations
 const MILLISECONDS_OF_A_SECOND = 1000;
 const MILLISECONDS_OF_A_MINUTE = MILLISECONDS_OF_A_SECOND * 60;
 const MILLISECONDS_OF_A_HOUR = MILLISECONDS_OF_A_MINUTE * 60;
 const MILLISECONDS_OF_A_DAY = MILLISECONDS_OF_A_HOUR * 24

 //===
 // FUNCTIONS
 //===

 /**
 * Method that updates the countdown and the sample
 */
 function updateCountdown() {
     // Calcs
     const NOW = new Date()
     const DURATION = DATE_TARGET - NOW;
     const REMAINING_DAYS = Math.floor(DURATION / MILLISECONDS_OF_A_DAY);
     const REMAINING_HOURS = Math.floor((DURATION % MILLISECONDS_OF_A_DAY) / MILLISECONDS_OF_A_HOUR);
     const REMAINING_MINUTES = Math.floor((DURATION % MILLISECONDS_OF_A_HOUR) / MILLISECONDS_OF_A_MINUTE);
     const REMAINING_SECONDS = Math.floor((DURATION % MILLISECONDS_OF_A_MINUTE) / MILLISECONDS_OF_A_SECOND);
     // Thanks Pablo Monteserín (https://pablomonteserin.com/cuenta-regresiva/)

     // Render
     SPAN_DAYS.textContent = REMAINING_DAYS;
     SPAN_HOURS.textContent = REMAINING_HOURS;
     SPAN_MINUTES.textContent = REMAINING_MINUTES;
     SPAN_SECONDS.textContent = REMAINING_SECONDS;
 }

 //===
 // INIT
 //===
 updateCountdown();
 // Refresh every second
 setInterval(updateCountdown, MILLISECONDS_OF_A_SECOND);
});
setTimeout('document.location.reload()', 5000)
</script>