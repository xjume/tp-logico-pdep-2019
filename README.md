# ¿Democracia? ¡Lógico!

### 1 · Candidatos y partidos
+ Definir la base de conocimientos.
+ En caso de que algo no se refleje en la misma justificar el por qué. 

### 2 · Provincia picante

Queremos saber si una provincia **esPicante/1**. Esto se da cuando al menos dos partidos presentan candidatos en dicha provincia y además esta tiene más de 1 millón de habitantes.

Por ejemplo:

_Buenos Aires es picante. Santa fé no es picante. San Luis no es picante._

### 3 · PASO

Modelar el predicado **leGanaA/3** el cual relaciona a dos candidatos y una provincia, y nos dice si un candidato le ganaría a otro en una provincia. Para ello:

* El partido del ganador debe competir en la provincia. 
* Si el partido del perdedor también compite en la provincia, se evalúa el que tenga el mayor porcentaje de votos en la provincia. Si hay empate, no se cumple la relación.
* Si ambos candidatos pertenecen al mismo partido, la relación se cumple si el partido compite en la provincia. 

Por ejemplo:

`leGanaA(frank, garrett, tierraDelFuego)` `True`

`leGanaA(frank, jackie, santaFe` `True`

`leGanaA(claire, jackie, misiones)` `False`

`leGanaA(frank, claire, tierraDelFuego)` `True`

`leGanaA(heather, linda, buenosAires)` `False`


### 4 · El gran candidato

Se pide realizar **elGranCandidato/1**. Un candidato es el gran candidato si se cumple:

* Para todas las provincias en las cuales su partido compite, el mismo gana.
* Es el candidato más joven de su partido

##### El único gran candidato es Frank. ¿Cómo podemos estar seguros de esto? ¿Qué tipo de consulta deberíamos realizar? ¿Con qué concepto está relacionado?


### 5 · Malas consultoras

La consultora cometió un error al pasarnos los resultados de las encuestas. Para eso, realizaremos el predicado **ajusteConsultora/3**, el cual relaciona un partido, una provincia y el verdadero porcentaje de votos, los cuales se ajustarán de la siguiente manera:

+ Si el partido ganaba en la provincia, se le resta 20%.
+ En otro caso, se le suma 5%

Por ejemplo:

_La intención de voto del partido rojo en Buenos Aires quedaría en 20._

_La intención de voto del partido azul en Neuquén quedaría en 15._

##### Si ahora quisiéramos evaluar todos los predicados con los valores reales de votos, ¿Qué cambios deberíamos hacer? ¿Cuántos predicados deberíamos modificar?

### 6 · Promesas de campaña

Antes de votar debemos informarnos sobre cuáles son las promesas de cada partido, representadas con functores:

`% inflacion(cotaInferior, cotaSuperior)`

`% construir(listaDeObras)`

`% nuevosPuestosDeTrabajo(cantidad)`

Las obras también son functores que tienen el edilicio a construir y la cantidad. Por ejemplo:

`% edilicio(hospital, 800)`

Dicho esto se pide modelar en la base de conocimiento el predicado **promete/2** que relaciona a un partido con una promesa de campaña teniendo en cuenta que:

+ El partido azul promete construir 1000 hospitales, 100 jardines y 5 escuelas, mientras que el  partido amarillo promete la construcción de 100 hospitales, 1 universidad y 200 comisarías. El partido rojo no prometió obras edilicias.
+ El partido rojo promete generar 800000 nuevos puestos de trabajo, el partido amarillo 10000. El partido azul se llamó al silencio sobre este tópico.

Con respecto a la inflación:
+ el partido azul promete mantenerla entre el 2% y el 4%;
+ el partido amarillo asegura poder mantenerla entre el 1% y el 15%;
+ el partido rojo logró vitoreos cuando anunció que de ganar lograría que no sea superior al 30% (pero tampoco menor al 10%).

### 7 · Ajustes de boca de urna

Las promesas influyen en la gente a la hora de las elecciones, por lo que podemos obtener cuanto se ve modificada la intención de voto de cada partido. Cada promesa tendrá un diferente peso en el electorado:
+ Para la inflación, la intención de votos disminuirá de manera directamente proporcional al promedio de las cotas de la promesa realizada.
+ En cuanto a los nuevos puestos de trabajo, si se promete realizar más de 50.000 nuevos puestos, sumará 3%. En el resto de los casos no sumará nuevos votos al partido.
+ Por último, las construcciones impactarán según el edilicio a construir:
  + hospitales: sin importar la cantidad, suma 2%.
  + jardines y escuelas: suma 0,1% por cada edilicio.
  + comisarías: suma 2% si se construyen exactamente 200.
  + universidades: la  descree que un partido construya una universidad, por ende no suma.
  + cualquier otro edilicio resta un 1% porque la población lo considera un gasto innecesario.

Se pide modelar el predicado **influenciaDePromesas/2** para relacionar una promesa con la variación de intención de votos.

Por ejemplo:

_Para una promesa de inflación entre 2% y 4%, la intención de voto será de -3%_

_Si se prometen 800000 nuevos puestos de trabajo, la intención será de 3%. En cambio, para 40000 nuevos puestos, no habrá intenciones de votos para la promesa_

_Una promesa de construir 1000 hospitales, 100 jardines y 5 escuelas sumará 2% por los hospitales y 10,5% por los jardines y escuelas, lo que da un total de 12,5%_

_Una promesa de construir 100 hospitales, 1 universidad y 200 comisarías sumará 2% por los hospitales y 2% por las comisarías, dando un total de 4%._

### 8 · Nuevos votos

A partir de sus promesas, queremos realizar el predicado **promedioDeCrecimiento/2** en donde relacionamos un partido con la sumatoria de crecimiento brindado por cada promesa. 

Por ejemplo:

_El partido azul suma 12,5% por sus obras y resta 3% por su promesa de inflación, dando un total de 9,5%_

_El partido rojo suma 3% por sus puestos de trabajo, pero resta 20% por la inflación. En total queda en 17% negativo._

_El partido amarillo suma 4% por sus obras y resta 8% por la inflación. Termina con -4%._
