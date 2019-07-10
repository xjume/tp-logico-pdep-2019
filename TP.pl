%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%       Base de conocimiento       %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

candidato(frank,rojo).
candidato(claire,rojo).
candidato(garrett,azul).
candidato(jackie,amarillo).
candidato(linda,azul).
candidato(catherine,rojo).
candidato(seth,amarillo).
candidato(heather,amarillo).

edad(frank,50).
edad(claire,52).
edad(garrett,64).
edad(peter,26).
edad(jackie,38).
edad(linda,30).
edad(catherine,59).
edad(heather,50).

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

% No se define el partido violeta porque no tiene candidatos.
% No se define la no pertenencia de Peter al partido Amarillo porque
% solo declaramos verdades.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%               - 2 -               %%%%
%%%%         Provincia picante         %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

esPicante(Provincia):-
	sePostula(Candidato1,Provincia),
	sePostula(Candidato2,Provincia),
	masDeUnMillon(Provincia),
	Candidato1 \= Candidato2.

masDeUnMillon(Provincia):-
	habitantes(Provincia,Habitantes),
	Habitantes > 1000000.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%               - 3 -               %%%%
%%%%               PASO                %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

leGanaA(Candidato1,Candidato2,Provincia) :-
	compite(Candidato1,Provincia,_),
	not(compite(Candidato2,Provincia,_)).

leGanaA(Candidato1,Candidato2,Provincia):-
	compite(Candidato1,Provincia,Partido1),
	compite(Candidato2,Provincia,Partido2),
	intencionDeVotoEn(Provincia,Partido1,Porcentaje1),
	intencionDeVotoEn(Provincia,Partido2,Porcentaje2),
	Porcentaje1 > Porcentaje2.

leGanaA(Candidato1,Candidato2,Provincia) :-
	candidato(Candidato1,Partido),
	candidato(Candidato2,Partido),
	sePostula(Partido,Provincia).

compite(Candidato,Provincia,Partido):-
	candidato(Candidato,Partido),
	sePostula(Partido,Provincia).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%               - 4 -               %%%%
%%%%         El gran candidato         %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elGranCandidato(Candidato):-
    candidato(Candidato,Partido),
    forall(compite(_,Provincia,Partido), elPartidoGanaEnEsaProvincia(Partido,Provincia)),
    esElMasJoven(Candidato,Partido).

esElMasJoven(CandidatoJoven,Partido):-
    candidato(CandidatoJoven,Partido),
    forall(candidato(Candidato,Partido), esMenor(CandidatoJoven,Candidato)).

esMenor(Candidato,CandidatoMayor):-
    candidato(Candidato,Partido),
    candidato(CandidatoMayor,Partido),
    edad(Candidato,Edad),
    edad(CandidatoMayor,EdadMayor),
    Edad<EdadMayor.

esMenor(Candidato,CandidatoMayor):-
    sonElMismo(Candidato,CandidatoMayor).

sonElMismo(Elemento,Elemento).

elPartidoGanaEnEsaProvincia(Partido,Provincia):-
    sePostula(Partido,Provincia),
    postulacionUnica(Provincia).

elPartidoGanaEnEsaProvincia(Partido,Provincia):-
    sePostula(Partido,Provincia),
    forall(sePostula(Partido,Provincia),intencionDeVotosMayor(Partido,_,Provincia)).

postulacionUnica(Provincia):-
	sePostula(UnPartido,Provincia),
	forall(sePostula(Partido,Provincia),sonElMismo(Partido,UnPartido)).

intencionDeVotosMayor(Partido1,Partido2,Provincia):-
    sePostula(Partido1,Provincia),
    sePostula(Partido2,Provincia),
    intencionDeVotoEn(Provincia,Partido1,Porcentaje1),
    intencionDeVotoEn(Provincia,Partido2,Porcentaje2),
    Porcentaje1 > Porcentaje2.

% Deberíamos realizar una consulta de tipo Existencial, ya que nos permite conocer al individuo que satisface la relación.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%               - 5 -               %%%%
%%%%         Malas consultoras         %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ajusteConsultora(Partido,Provincia,PorcentajeVotos):-
    porcentajeVoto(Provincia,Partido,PorcentajeVotos).

porcentajeVoto(Provincia,Partido,PorcentajeVotos):-
    intencionDeVotoEn(Provincia,Partido,Porcentaje),
    not(ganaPartido(Partido,Provincia)),
    PorcentajeVotos is Porcentaje + 5.

porcentajeVoto(Provincia,Partido,PorcentajeVotos):-
    ganaPartido(Partido,Provincia),
    intencionDeVotoEn(Provincia,Partido,Porcentaje),
    PorcentajeVotos is Porcentaje - 20.

ganaPartido(Partido,Provincia):-
    leGanaA(Candidato,_,Provincia),
    elGranCandidato(Candidato),
    candidato(Candidato,Partido).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%               - 6 -               %%%%
%%%%        Promesas de campaña        %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

promete(azul,construir(edilicio(hospital,1000))).
promete(azul,construir(edilicio(jardin,100))).
promete(azul,construir(edilicio(escuela,5))).
promete(amarillo,construir(edilicio(hospital,100))).
promete(amarillo,construir(edilicio(universidad,1))).
promete(amarillo,construir(edilicio(comisaria,200))).
promete(rojo,nuevosPuestosDeTrabajo(800000)).
promete(amarillo,nuevosPuestosDeTrabajo(10000)).
promete(azul,inflacion(2,4)).
promete(amarillo,inflacion(1,15)).
promete(rojo,inflacion(10,30)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%               - 7 -               %%%%
%%%%      Ajustes de boca de urna      %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

influenciaDePromesas(inflacion(CotaInf,CotaSup),Variacion):-
	Variacion is -((CotaSup+CotaInf)/2).

influenciaDePromesas(nuevosPuestosDeTrabajo(Puestos),3):-
	Puestos > 50000.

influenciaDePromesas(nuevosPuestosDeTrabajo(Puestos),0):-
	Puestos =< 50000.

influenciaDePromesas(construir(edilicio(hospital,_)),2).

influenciaDePromesas(construir(edilicio(jardin,Cantidad)),Variacion):-
	Variacion is Cantidad * 0.1.

influenciaDePromesas(construir(edilicio(escuela,Cantidad)),Variacion):-
	Variacion is Cantidad * 0.1.

influenciaDePromesas(construir(edilicio(comisaria,200)),2).

influenciaDePromesas(construir(edilicio(universidad,_)),0).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%               - 8 -               %%%%
%%%%           Nuevos votos            %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

promedioDeCrecimiento(Partido,SumatoriaCrecimiento):-
	partido(Partido),		% Generador de Partido.
	findall(Porcentaje,	influenciaDePromesasDelPartido(_,Porcentaje,Partido),Porcentajes),
	sumlist(Porcentajes,SumatoriaCrecimiento).

partido(Partido):-
	sePostula(Partido,_).

influenciaDePromesasDelPartido(Promesa,Porcentaje,Partido):-
	promete(Partido,Promesa),
	influenciaDePromesas(Promesa,Porcentaje).
