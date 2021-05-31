
function enviar(){   // Si el formulario esta valido, llama a la funcion enviarDenuncia
	document.querySelector("#formulario");
	if(formularioEsValido(formulario)){
		enviarDenuncia(); 
	}
}


function obtenerCampos(selector){ //Obtiene el valor del campo en el que esta trabajando 
return document.querySelector(selector).value;
}


function enviarDenuncia(){   
document.querySelector("#modalNombre").textContent=obtenerCampos("#Nombre");
document.querySelector("#modalApellido").textContent=obtenerCampos("#Apellido");
document.querySelector("#modalTipoBullying").textContent=obtenerCampos("[name=TipoBullying]:checked");
document.querySelector("#modalBarrio").textContent=obtenerCampos("#barrios");
document.querySelector("#modalContacto").textContent=obtenerCampos("#Contacto");
document.querySelector("#modalMensaje").textContent=obtenerCampos("#Mensaje");
$("#confirmarModal").modal({show:true});
}


function limpiar(){
document.querySelector("#formulario");
formulario.classList.remove("was-validated");
formulario.reset();
}


function formularioEsValido (formulario) {
  let esValido;

  if (formulario.checkValidity() === false) {
    formulario.classList.add('was-validated');
    esValido = false;
  }  
  else {
    esValido = true;  
  }

  return(esValido)
}

/*Ejecuta la funcion cargarBarrios al iniciar la pagina*/
window.addEventListener('load', function() { 
  // carga los barrios en el select
  cargarBarrios();
});


// Carga los barrios en el <select>
function cargarBarrios () {
  const barrios = [
    "Agronomía"
    ,"Almagro"
    ,"Balvanera"
    ,"Barracas"
    ,"Belgrano"
    ,"Boedo"
    ,"Caballito"
    ,"Chacarita"
    ,"Coghlan"
    ,"Colegiales"
    ,"Constitución"
    ,"Flores"
    ,"Floresta"
    ,"La Boca"
    ,"La Paternal"
    ,"Liniers"
    ,"Mataderos"
    ,"Monte Castro"
    ,"Monserrat"
    ,"Nueva Pompeya"
    ,"Núñez"
    ,"Palermo"
    ,"Parque Avellaneda"
    ,"Parque Chacabuco"
    ,"Parque Chas"
    ,"Parque Patricios"
    ,"Puerto Madero"
    ,"Recoleta"
    ,"Retiro"
    ,"Saavedra"
    ,"San Cristóbal"
    ,"San Nicolás"
    ,"San Telmo"
    ,"Vélez Sársfield"
    ,"Versalles"
    ,"Villa Crespo"
    ,"Villa del Parque"
    ,"Villa Devoto"
    ,"Villa General Mitre"
    ,"Villa Lugano"
    ,"Villa Luro"
    ,"Villa Ortúzar"
    ,"Villa Pueyrredón"
    ,"Villa Real"
    ,"Villa Riachuelo"
    ,"Villa Santa Rita"
    ,"Villa Soldati"
    ,"Villa Urquiza"
  ];

  // consulta el select con los barrios
  let select = document.querySelector("#barrios");
  let option = "";

  for (let barrio of barrios) {
    option = select.innerHTML
    option = option + "<option value='" + barrio + "'>" + barrio
    select.innerHTML = option;
  }


  /*FUNCIONES DE BOTONES INICIO*/
}
document.getElementById("Enviar").addEventListener("click", function(){
   enviar();
});


document.getElementById("clear").addEventListener("click", function(){
   limpiar();
});

 /*FUNCIONES DE BOTONES FIN */

