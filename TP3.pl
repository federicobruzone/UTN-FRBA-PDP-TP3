% Trabajo Practico No. 3 - "Inmobiliaria"
% Grupo 15. Integrantes: BRUZONE, Federico; LOTT, Sebastian
% 1a Entrega: 10/5/2017
% 2a Entrega: 10/6/2017

%Entidades - Casas:
propiedad("Tinsmith Circle 1774", 700, 3, true, 0).
propiedad("Av Moreno 708", 2000, 7, true, 30).
propiedad("Av Siempre Viva 742", 1000, 4, true, 0).
propiedad("Calle Falsa 123", 200, 3, false, 0).

%Getters - Casas:
nombrePropiedad(_Propiedad, NombrePropiedad) :- propiedad(NombrePropiedad, _,_,_,_).
precioAlquiler(NombrePropiedad, Precio) :- propiedad(NombrePropiedad, Precio,_,_,_).
cantidadAmbientes(NombrePropiedad, Ambientes) :- propiedad(NombrePropiedad, _, Ambientes,_,_).
tieneJardin(NombrePropiedad) :- propiedad(NombrePropiedad,_,_,true,_).
tienePiscina(NombrePropiedad) :- propiedad(NombrePropiedad,_,_,_,MetrosCuadrados), MetrosCuadrados > 0.
metrosPiscina(NombrePropiedad, MetrosCuadrados) :- tienePiscina(NombrePropiedad), propiedad(NombrePropiedad,_,_,_,MetrosCuadrados).

% Entidades - Caracteristicas:
caracteristica("2 ambientes").
caracteristica("3 ambientes").
caracteristica("Jardin").
caracteristica("Piscina de 15 mts cuadrados").
caracteristica("Piscina de 100 mts cuadrados").
	
% Entidades - Personas:
persona("Carlos").
persona("Ana").
persona("Maria").
persona("Pedro").
persona("Chameleon").

% Reglas - Casas:
tienenMismosAmbientes(Propiedad1, Propiedad2) :-
	cantidadAmbientes(Propiedad1, Ambientes),
	cantidadAmbientes(Propiedad2, Ambientes),
	Propiedad1 \= Propiedad2.
tieneAmbientes(NombrePropiedad, Cantidad) :- 
	cantidadAmbientes(NombrePropiedad, Ambientes),
	Ambientes >= Cantidad.
tieneMetrosPiscina(NombrePropiedad, Cantidad) :- 
	tienePiscina(NombrePropiedad),
	metrosPiscina(NombrePropiedad, MetrosCuadrados),
	MetrosCuadrados >= Cantidad.
	
%Reglas - Caracteristicas:
tieneCaracteristica(Casa, caracteristica("Jardin")) :-
	tieneJardin(Casa).
tieneCaracteristica(Casa, caracteristica("2 ambientes")) :-
	tieneAmbientes(Casa, 2).
tieneCaracteristica(Casa, caracteristica("3 ambientes")) :-
	tieneAmbientes(Casa, 3).
tieneCaracteristica(Casa, caracteristica("Piscina de 15 mts cuadrados")) :-
	tieneMetrosPiscina(Casa, 15).
tieneCaracteristica(Casa, caracteristica("Piscina de 100 mts cuadrados")) :-
	tieneMetrosPiscina(Casa, 100).

seDeseaCaracteristica(Casa, Caracteristica) :-
	busca(persona(_Persona), Caracteristica),
	tieneCaracteristica(Casa, Caracteristica).

existeConEsaCaracteristica(Caracteristica) :-
	busca(persona(_Persona), Caracteristica),
	tieneCaracteristica(_Casa, Caracteristica).

noExisteConEsaCaracteristica(Caracteristica) :-
	busca(persona(_Persona), Caracteristica),
	not(tieneCaracteristica(_Casa, Caracteristica)).
	
%Reglas - Personas:
busca(persona("Carlos"), caracteristica("3 ambientes")).
busca(persona("Carlos"), caracteristica("Jardin")).
busca(persona("Ana"), caracteristica("Piscina de 100 mts cuadrados")).
busca(persona("Maria"), caracteristica("2 ambientes")).
busca(persona("Maria"), caracteristica("Piscina de 15 mts cuadrados")).
busca(persona("Pedro"), Caracteristica) :- 
	busca(persona("Maria"), Caracteristica).
busca(persona("Chameleon"), Caracteristica) :- 
	persona(Persona), 
	Persona \= "Chameleon", 
	busca(persona(Persona), Caracteristica).

tieneLoQueQuiere(Persona, Casa) :- 
	busca(persona(Persona), Caracteristica),
	tieneCaracteristica(Casa, Caracteristica).



/* CONSULTAS:
******Consulta 1******
?- metrosPiscina(_, 30).
true .

?- metrosPiscina(Casa, 30).
Casa = "Av Moreno 708" .

******Consulta 2******
?- tienenMismosAmbientes(Casa1, Casa2).
Casa1 = "Tinsmith Circle 1774",
Casa2 = "Calle Falsa 123" ;
Casa1 = "Calle Falsa 123",
Casa2 = "Tinsmith Circle 1774" ;
false.

******Consulta 3******
?- busca(persona("Carlos"), Caracteristica).
Caracteristica = caracteristica("3 ambientes") ;
Caracteristica = caracteristica("Jardin") ;
false.0

******Consulta 4******
?- tieneAmbientes(_, 2).
true .

******Consulta 5******
?- tieneLoQueQuiere("Pedro", Casa).
Casa = "Tinsmith Circle 1774" ;
Casa = "Av Moreno 708" ;
Casa = "Av Siempre Viva 742" ;
Casa = "Calle Falsa 123" ;
Casa = "Av Moreno 708" ;
false.

******Consulta 6******
?- seDeseaCaracteristica("Av Moreno 708", Caracteristica).
Caracteristica = caracteristica("3 ambientes") ;
Caracteristica = caracteristica("Jardin") ;
Caracteristica = caracteristica("2 ambientes") ;
Caracteristica = caracteristica("Piscina de 15 mts cuadrados") ;
Caracteristica = caracteristica("2 ambientes") ;
Caracteristica = caracteristica("Piscina de 15 mts cuadrados") ;
Caracteristica = caracteristica("3 ambientes") ;
Caracteristica = caracteristica("Jardin") ;
Caracteristica = caracteristica("2 ambientes") ;
Caracteristica = caracteristica("Piscina de 15 mts cuadrados") ;
Caracteristica = caracteristica("2 ambientes") ;
Caracteristica = caracteristica("Piscina de 15 mts cuadrados") ;
false.

******Consulta 7******
?- noExisteConEsaCaracteristica(Caracteristica).
Caracteristica = caracteristica("Piscina de 100 mts cuadrados") ;
Caracteristica = caracteristica("Piscina de 100 mts cuadrados") ;
false.
*/

