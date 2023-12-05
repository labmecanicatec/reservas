var nav4 = window.Event ? true : false; 
function acceptNum(evt){  
// NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57  
var key = nav4 ? evt.which : evt.keyCode;  
return (key <= 13 || (key >= 48 && key <= 57)); 
} 

function obtnercarrera(evt){
    var str=document.getElementById("codigo").value;
    var codigo_proyecto = str.substr(5, 3);

    $.ajax({
        url: 'https://rita.udistrital.edu.co:23604/adminlab/getProyecto/'+codigo_proyecto,
        type: 'get',
        dataType: 'json',
        success: function(response){
            var len = 0;
            $('#txtOrganization').empty(); // Empty <tbody>
    
            if(response['data'] != null){
                len = response['data'].length;
            }
    
            if(len > 0){
                for(var i=0; i<len; i++){
                    var proyecto_curricular = response['data'][i].proyecto_curricular;
                    var inputNombre = document.getElementById("txtOrganization");
                    inputNombre.value = proyecto_curricular;
                }
            }else{
                var inputNombre = document.getElementById("txtOrganization");
                    inputNombre.value = '';
            }
    
        }
        });
}


function maximo() {
    //se almacena el texto que contiene el textarea al que se enlaza el evento, referenciado como "this"
    var texto = this.value;
    //si la longitud del texto ya es mayor que 255, se devuelve false cancelando el evento
    if (texto.length > 11) {
        this.value = texto.substr(0,11);
        return false;
    }
}
window.onload = function() {
    document.getElementById ('codigo').addEventListener("keyup", maximo , false);
}


function validarCodigo(){
    if($("#codigo").val().length < 11) {  
        $("#myModal").modal(); 
		document.getElementById("codigo").focus();
    }
}


  