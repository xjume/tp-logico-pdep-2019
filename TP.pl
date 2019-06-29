%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%1 Candidatos y partidos%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

candidato(frank,rojo).
candidato(claire,rojo).
candidato(garrett,azul).
candidato(jackie,amarillo).
candidato(linda,azul).
candidato(catherine,rojo).
candidato(seth,amarillo).
candidato(heather,amarillo).
% No se defune el partido violeta en mi universo porque no tiene
% candidatos.

edad(frank,50).
edad(claire,52).
edad(garrett,64).
edad(peter,26).
edad(jackie,38).
edad(linda,30).
edad(catherine,59).
% edad(heather,50). Pongo esto porque diceque nacio en 1969 y no
% se si teng que hacer un predicado para sacar la edad????????

sePostula(azul,buenosAires).
sePostula(azul,chaco).
sePostula(azul,tierraDelFuego).
sePostula(azul,sanLuis).
sePostula(azul,neuquen).
sePostula(rojo,buenosAires).
sePostula(rojo,santaFe).
sePostula(rojo,cordoba).
sePostula(rojo,chubut).
sePostula(rojo,tierraDelFuego).
sePostula(rojo,sanLuis).
sePostula(amarillo,chaco).
sePostula(amarillo,formosa).
sePostula(amarillo,tucuman).
sePostula(amarillo,salta).
sePostula(amarillo,santaCruz).
sePostula(amarillo,laPampa).
sePostula(amarillo,corrientes).
sePostula(amarillo,misiones).
sePostula(amarillo,buenosAires).

habitantes(buenosAires,15355000).
habitantes(chaco,1143201).
habitantes(tierraDelFuego,160720).
habitantes(sanLuis,489255).
habitantes(neuquen,637913).
habitantes(santaFe,3397532).
habitantes(cordoba,3567654).
habitantes(chubut,577466).
habitantes(formosa,527895).
habitantes(tucuman,1687305).
habitantes(salta,1333365).
habitantes(santaCruz,273964).
habitantes(laPampa,349299).
habitantes(corrientes,992595).
habitantes(misiones,1189446).

not(sePostula(rojo,formosa)).
not(candidato(peter,amarillo)).

%%%%%%%%%%%%%%%%%%%%%%%
%%2 Provincia picante%%
%%%%%%%%%%%%%%%%%%%%%%%

esPicante(Provincia) :-
	sePostula(Candidato1,Provincia),
	sePostula(Candidato2,Provincia),
	masDeUnMillon(Provincia),
	Candidato1 \= Candidato2.

masDeUnMillon(Provincia) :-
	habitantes(Provincia,Habitantes),
	Habitantes > 1000000.

%%%%%%%%%%
%%3 PASO%%
%%%%%%%%%%
% intencionDeVotoEn(Provincia, Partido, Porcentaje)
intencionDeVotoEn(buenosAires, rojo, 40).
intencionDeVotoEn(buenosAires, azul, 30).
intencionDeVotoEn(buenosAires, amarillo, 30).
intencionDeVotoEn(chaco, rojo, 50).
intencionDeVotoEn(chaco, azul, 20).
intencionDeVotoEn(chaco, amarillo, 0).
intencionDeVotoEn(tierraDelFuego, rojo, 40).
intencionDeVotoEn(tierraDelFuego, azul, 20).
intencionDeVotoEn(tierraDelFuego, amarillo, 10).
intencionDeVotoEn(sanLuis, rojo, 50).
intencionDeVotoEn(sanLuis, azul, 20).
intencionDeVotoEn(sanLuis, amarillo, 0).
intencionDeVotoEn(neuquen, rojo, 80).
intencionDeVotoEn(neuquen, azul, 10).
intencionDeVotoEn(neuquen, amarillo, 0).
intencionDeVotoEn(santaFe, rojo, 20).
intencionDeVotoEn(santaFe, azul, 40).
intencionDeVotoEn(santaFe, amarillo, 40).
intencionDeVotoEn(cordoba, rojo, 10).
intencionDeVotoEn(cordoba, azul, 60).
intencionDeVotoEn(cordoba, amarillo, 20).
intencionDeVotoEn(chubut, rojo, 15).
intencionDeVotoEn(chubut, azul, 15).
intencionDeVotoEn(chubut, amarillo, 15).
intencionDeVotoEn(formosa, rojo, 0).
intencionDeVotoEn(formosa, azul, 0).
intencionDeVotoEn(formosa, amarillo, 0).
intencionDeVotoEn(tucuman, rojo, 40).
intencionDeVotoEn(tucuman, azul, 40).
intencionDeVotoEn(tucuman, amarillo, 20).
intencionDeVotoEn(salta, rojo, 30).
intencionDeVotoEn(salta, azul, 60).
intencionDeVotoEn(salta, amarillo, 10).
intencionDeVotoEn(santaCruz, rojo, 10).
intencionDeVotoEn(santaCruz, azul, 20).
intencionDeVotoEn(santaCruz, amarillo, 30).
intencionDeVotoEn(laPampa, rojo, 25).
intencionDeVotoEn(laPampa, azul, 25).
intencionDeVotoEn(laPampa, amarillo, 40).
intencionDeVotoEn(corrientes, rojo, 30).
intencionDeVotoEn(corrientes, azul, 30).
intencionDeVotoEn(corrientes, amarillo, 10).
intencionDeVotoEn(misiones, rojo, 90).
intencionDeVotoEn(misiones, azul, 0).
intencionDeVotoEn(misiones, amarillo, 0).

leGanaA(Candidato1,_,Provincia) :-
	compite(Candidato1,Provincia).

leGanaA(Candidato1,Candidato2,Provincia) :-
	candidato(Candidato1,Partido1),
	sePostula(Partido1,Provincia),
	candidato(Candidato2,Partido2),
	sePostula(Partido2,Provincia),
	intencionDeVotoEn(Provincia,Partido1,Porcentaje1),
	intencionDeVotoEn(Provincia,Partido2,Porcentaje2),
	Porcentaje1 \= Porcentaje2,
	Porcentaje1 > Porcentaje2.

leGanaA(Candidato1,Candidato2,Provincia) :-
	candidato(Candidato1,Partido),
	candidato(Candidato2,Partido),
	sePostula(Partido,Provincia).

compite(Candidato,Provincia) :-
	candidato(Candidato,Partido),
	sePostula(Partido,Provincia).

%%%%%%%%%%%%%%%%%%%%%%%
%%4 El gran candidato%%
%%%%%%%%%%%%%%%%%%%%%%%

elGranCandidato(Candidato) :-
	forall(compite(Candidato,Provincia), leGanaA(Candidato,_,Provincia)),
	esElMasJoven(Candidato).

% Deber�amos realizar una consulta de tipo Existencial, ya que nos
% permite conocer el individuo que satisface la relacion.

%%%%%%%%%%%%%%%%%%%%%%%
%%5 Malas consultoras%%
%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%
%%6 Promesas de campa�a%%
%%%%%%%%%%%%%%%%%%%%%%%%%

promete(azul,construir(edilicio(hospital,1000))).
promete(azul,construir(edilicio(jardin,100))).
promete(azul,construir(edilicio(escuela,5))).
promete(amarillo,construir(edilicio(hospital,100))).
promete(amarillo,construir(edilicio(universidad,1))).
promete(amarillo,consturir(edilicio(comisaria,200))).
promete(rojo,nuevosPuestosDeTrabajo(800000)).
promete(amarillo,nuevosPuestosDeTrabajo(10000)).
promete(azul,inflacion(2,4)).
promete(amarillo,inflacion(1,15)).
promete(rojo,inflacion(10,30)) :-
	leGanaA(rojo,_,_).
















