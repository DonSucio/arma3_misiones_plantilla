/*
    fn_diaryLosAhmed.sqf
    --------------------
    Basado en tu BLOQUE 3.
*/
if (!hasInterface) exitWith {};


[] spawn {

    // Esperamos a que el jugador exista y tenga UID (por si acaso)
    waitUntil { !isNull player && {getPlayerUID player != ""} };

    // Crear tema de diario
    player createDiarySubject ["LOS_AHMED", "Los Ahmed"];

    private _dia1Text =
    "<font color='#C00000' size='20' face='PuristaBold'>MANDO COMPONENTE TERRESTRE (DON)</font><br/>" +
    "<font color='#DDDDDD' size='14' face='PuristaMedium'>Día 1 – Inspección del complejo de Alikampos</font><br/>" +
    "<font color='#555555'>────────────────────────────────</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>SITUACIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "Se reciben informaciones sobre desvío de materiales de construcción y desaparición de armamento español, " +
    "presuntamente vinculados a la empresa Construcciones Ahmed. Los números de serie de varios contenedores " +
    "no cuadran y parte del material falta en los inventarios." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>MISIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "➤ Inspeccionar la zona industrial de almacenamiento de la empresa Ahmed.<br/>" +
    "➤ Verificar el contenido de los contenedores sospechosos.<br/>" +
    "➤ Detener a cualquier individuo implicado en el desvío de material." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>DESARROLLO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• A la llegada al complejo, se observa una supuesta empresa de seguridad privada protegiendo las instalaciones, " +
    "  con personal fuertemente armado y aspecto claramente insurgente.<br/>" +
    "• Se accede al recinto y, tras contactar con un trabajador, se inicia la inspección de las distintas áreas de almacenaje.<br/>" +
    "• Un helicóptero aterriza en la zona industrial y descarga un contenedor. Al abrirlo, se localizan contenedores más pequeños " +
    "  cargados de armamento español.<br/>" +
    "• Se procede a la detención de un trabajador de la empresa Ahmed para su posterior interrogatorio.<br/>" +
    "• La seguridad privada abandona la entrada en un vehículo que acude a recogerlos, evitando el contacto directo con las tropas españolas.<br/>" +
    "• Mientras continúa el registro, aparecen varios individuos armados desde la zona boscosa inferior y abren fuego contra la unidad. " +
    "  El contacto escala hasta aproximadamente una treintena de enemigos, con apoyo puntual de un vehículo con placas improvisadas " +
    "  y ametralladora pesada en una colina, que dispara brevemente antes de retirarse.<br/>" +
    "• Durante la inspección también se observa un helicóptero de fabricación rusa extrayendo otro contenedor del complejo industrial." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>RESULTADO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• Contenedores con armamento español localizados en instalaciones de Construcciones Ahmed.<br/>" +
    "• Un trabajador de la empresa detenido para interrogatorio.<br/>" +
    "• Contacto de intensidad media-alta con fuerzas hostiles (aprox. 30 combatientes), con retirada enemiga tras el enfrentamiento.<br/>" +
    "• Observado helicóptero de diseño ruso retirando al menos un contenedor adicional del complejo.<br/>" +
    "• La unidad regresa a base sin bajas propias, con la misión cumplida de forma parcial y la empresa Ahmed bajo fuerte sospecha " +
    "  de implicación en el desvío de material." +
    "</font>";

    private _dia2Text =
    "<font color='#C00000' size='20' face='PuristaBold'>MANDO COMPONENTE TERRESTRE (DON)</font><br/>" +
    "<font color='#DDDDDD' size='14' face='PuristaMedium'>Día 2 – Capturas en Abdera</font><br/>" +
    "<font color='#555555'>────────────────────────────────</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>SITUACIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "Tras los sucesos del Día 1, se identifica a varios trabajadores de la empresa Construcciones Ahmed " +
    "en la localidad de Abdera como posibles implicados en el desvío de material y armamento español. " +
    "La tensión con la población local musulmana es elevada y existe riesgo de presencia insurgente en la zona." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>MISIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "➤ Desplazarse de noche a la población de Abdera en vehículos Lince M2.<br/>" +
    "➤ Infiltrar en el núcleo urbano y capturar a cuatro trabajadores de Construcciones Ahmed de interés para la investigación.<br/>" +
    "➤ Extraer a los detenidos para su posterior interrogatorio." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>DESARROLLO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• El briefing se realiza de noche fuera de base, simulando una salida rutinaria a pie para no alertar a la empresa Ahmed.<br/>" +
    "• La unidad se desplaza en Lince M2 hasta las proximidades de Abdera, desciende de los vehículos y se infiltra a pie en el pueblo.<br/>" +
    "• Se aseguran las viviendas objetivo y se captura a los cuatro trabajadores señalados sin resistencia inicial.<br/>" +
    "• Durante la operación, un civil madrugador en vehículo ilumina accidentalmente a un soldado español con los faros. " +
    "  El civil huye; se intenta detener el vehículo disparando a las ruedas, sin éxito.<br/>" +
    "• Pocos minutos después llegan dos hombres armados en una pick-up Hilux para comprobar la situación. " +
    "  Son rodeados, desarmados y detenidos, siendo sometidos a interrogatorio y malos tratos en el interior de una de las casas.<br/>" +
    "• Uno de los detenidos advierte que, si no se le permite comunicarse por radio, en cinco minutos acudirán más hombres armados al pueblo. " +
    "  La advertencia es ignorada.<br/>" +
    "• Transcurrido ese tiempo, irrumpen hasta cuatro vehículos cargados de insurgentes, produciéndose un intenso tiroteo en el área.<br/>" +
    "• En las viviendas de los objetivos se localizan cajas con armamento. " +
    "  Ante la imposibilidad de evacuar todo el material de forma segura, se decide colocar cargas y demoler las casas, " +
    "  provocando graves daños colaterales en las viviendas adyacentes y una importante catástrofe humanitaria en Abdera." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>RESULTADO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• Cuatro trabajadores de Construcciones Ahmed capturados y extraídos del área.<br/>" +
    "• Dos individuos adicionales armados detenidos tras acudir en Hilux a la zona de operaciones.<br/>" +
    "• Fuerte enfrentamiento con elementos insurgentes, con rechazo del ataque y ruptura de contacto.<br/>" +
    "• Armamento localizado y destruido mediante demolición de las viviendas objetivo, con severos daños en el entorno urbano.<br/>" +
    "• Incremento significativo del rechazo y hostilidad de la población civil de Abdera hacia la presencia española." +
    "</font>";

    private _dia3Text =
    "<font color='#C00000' size='20' face='PuristaBold'>MANDO COMPONENTE TERRESTRE (DON)</font><br/>" +
    "<font color='#DDDDDD' size='14' face='PuristaMedium'>Día 3 – Ayuda humanitaria en Abdera</font><br/>" +
    "<font color='#555555'>────────────────────────────────</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>SITUACIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "Tras la operación de captura y la destrucción de varias viviendas en Abdera, la situación con la población local " +
    "se ha deteriorado gravemente. Se han registrado protestas y una creciente presión mediática sobre la presencia española " +
    "en la isla." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>MISIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "➤ Recoger material de ayuda humanitaria en el buque atracado en el puerto.<br/>" +
    "➤ Desplazarse en convoy hasta Abdera y entregar los suministros bajo coordinación de personal civil (IDAP).<br/>" +
    "➤ Contribuir a reducir la tensión con la población local y mejorar la percepción de la fuerza española." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>DESARROLLO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• La jornada comienza con un briefing y un serio rapapolvo a la unidad por los hechos del día anterior, especialmente por los disparos " +
    "  y la destrucción de viviendas en Abdera.<br/>" +
    "• A la salida de la base, una manifestación se concentra frente a una de las puertas: barricadas, lanzamiento de piedras, " +
    "  neumáticos ardiendo y presencia destacada de medios de comunicación grabando la protesta.<br/>" +
    "• La unidad se desplaza al buque en el puerto, donde se carga el material de ayuda humanitaria en contenedores.<br/>" +
    "• Posteriormente, el convoy se dirige a Abdera. A la llegada, un responsable de IDAP asume la coordinación de la distribución " +
    "  e indica al teniente dónde depositar los contenedores.<br/>" +
    "• La población local recibe a las tropas con gritos, insultos y exigencias de que se marchen, mientras la prensa entrevista " +
    "  a civiles y trata de obtener declaraciones de los militares.<br/>" +
    "• La tensión aumenta cuando se lanzan bengalas rojas y varios civiles se plantan delante de los camiones para bloquear su avance, " +
    "  generándose enfrentamientos verbales entre manifestantes y soldados.<br/>" +
    "• En un intento de dispersar a la multitud, un teniente ordena disparos al aire con fuego real. Los periodistas graban el incidente " +
    "  y quedan visibles en el suelo las vainas de los cartuchos usados.<br/>" +
    "• La situación se mantiene muy tensa hasta que el convoy consigue completar parcialmente la entrega y replegarse del pueblo." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>RESULTADO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• Parte del material de ayuda humanitaria entregado en Abdera bajo supervisión de IDAP.<br/>" +
    "• Amplia cobertura mediática de las protestas contra la presencia española, incluyendo imágenes de los disparos al aire " +
    "  y testimonios muy críticos de la población local.<br/>" +
    "• Sin bajas propias, pero sin mejora apreciable de la relación con la población de Abdera; la tensión social y la presión " +
    "  mediática aumentan tras el uso de fuego real para dispersar a los civiles." +
    "</font>";

    private _dia4Text =
    "<font color='#C00000' size='20' face='PuristaBold'>MANDO COMPONENTE TERRESTRE (DON)</font><br/>" +
    "<font color='#DDDDDD' size='14' face='PuristaMedium'>Día 4 – Surgimiento de la insurgencia</font><br/>" +
    "<font color='#555555'>────────────────────────────────</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>SITUACIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "Tras los incidentes en Abdera y el uso de fuego real frente a civiles, la situación general en la isla se ha deteriorado " +
    "de forma crítica. Se informa de que la población musulmana en la zona noroeste del AO se ha organizado y se ha alzado en armas, " +
    "constituyendo una guerrilla insurgente con armamento variado (fusiles de asalto, ametralladoras medias y vehículos armados). " +
    "Se desconoce el origen exacto de su financiación y abastecimiento, aunque se sospecha apoyo externo. " +
    "Adicionalmente, la empresa Construcciones Ahmed, responsable de las obras en la base española, ha abandonado repentinamente " +
    "el proyecto sin explicación y se ha perdido su rastro. Se estima que las actuaciones previas de la fuerza española " +
    "han contribuido a acelerar esta escalada." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>MISIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "➤ Establecer cuatro puntos de control (checkpoints) en las localidades de Galati, Syrta, Kore y Negades.<br/>" +
    "➤ Limitarse a la construcción y señalización de los controles, sin permanecer desplegados de forma permanente en ellos.<br/>" +
    "➤ Evaluar la reacción insurgente ante la presencia española en estas localidades clave." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>DESARROLLO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• La jornada comienza con un nuevo briefing y reprimenda específica por los disparos al aire del Día 3.<br/>" +
    "• Se declara toda la zona noroeste del AO, delimitada en el mapa por una frontera roja, como territorio hostil bajo influencia insurgente.<br/>" +
    "• Las unidades se desplazan sucesivamente a Galati, Syrta, Kore y Negades, iniciando las tareas de montaje de los puntos de control.<br/>" +
    "• Durante los trabajos de construcción, los elementos desplegados son hostigados en varias ocasiones con fuego a larga distancia " +
    "  desde áreas montañosas, sin que el enemigo busque un combate cercano.<br/>" +
    "• Se causan bajas entre los insurgentes y se intenta evacuar a uno de ellos como detenido, pero el individuo fallece durante " +
    "  el traslado de regreso a base.<br/>" +
    "• Junto a su cuerpo se localiza un documento en el que aparecen listadas las localidades de Negades, Kore, Syrta y Galati, " +
    "  acompañado de la instrucción de impedir por todos los medios el establecimiento de controles en dichas poblaciones." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>RESULTADO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• Checkpoints construidos en Galati, Syrta, Kore y Negades, pese al hostigamiento insurgente durante las labores de montaje.<br/>" +
    "• Bajas confirmadas entre los elementos hostiles; un insurgente fallece durante el intento de evacuación como prisionero.<br/>" +
    "• Documento incautado que confirma conocimiento previo de la misión por parte de la insurgencia, incluyendo la lista exacta " +
    "  de localidades objetivo.<br/>" +
    "• El hallazgo del documento refuerza la sospecha de posible filtración de información operativa desde el interior de la base " +
    "  (potencial topo) y coincide con la desaparición de Construcciones Ahmed del proyecto de la base." +
    "</font>";

    private _dia5Text =
    "<font color='#C00000' size='20' face='PuristaBold'>MANDO COMPONENTE TERRESTRE (DON)</font><br/>" +
    "<font color='#DDDDDD' size='14' face='PuristaMedium'>Día 5 – Operación encubierta en Agios Konstantinos (Día 1/2)</font><br/>" +
    "<font color='#555555'>────────────────────────────────</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>SITUACIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "La insurgencia en la zona noroeste del AO se encuentra activa y organizada. Días atrás se detectó la llegada al aeropuerto " +
    "principal de Altis de cinco individuos de origen afgano, vestidos de traje y con perfil claramente sospechoso. El seguimiento " +
    "de estos sujetos los ha vinculado a la región bajo control insurgente, incluyendo la localidad de Agios Konstantinos, " +
    "y se sospecha que podrían estar implicados en la dirección, financiación o asesoramiento de la estructura insurgente. " +
    "Dos de ellos han sido localizados con certeza en Agios Konstantinos; el paradero de los otros tres se desconoce dentro de la zona roja." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>MISIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "➤ Ejecutar una operación encubierta de dos jornadas, con inserción nocturna, NVG y armamento silenciado.<br/>" +
    "➤ Infiltrar un elemento por mar (lanchas) y otro mediante salto paracaidista sobre la zona de Agios Konstantinos y alrededores.<br/>" +
    "➤ Localizar y capturar a los cinco individuos de origen afgano, priorizando el sigilo y evitando comprometer la operación.<br/>" +
    "➤ Minimizar el contacto con la población civil y evitar incidentes adicionales que deterioren aún más la situación en el AO." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>DESARROLLO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• El briefing se realiza de noche, detallando una operación de larga duración con despliegue encubierto y persistencia entre jornadas.<br/>" +
    "• Un grupo se infiltra por mar, zarpando desde la planta de energía al norte de Aggelochori y navegando separado de la costa " +
    "  hasta insertarse en la parte norte de Agios Konstantinos.<br/>" +
    "• El segundo elemento realiza un salto paracaidista sobre una zona montañosa al este de Agios Konstantinos, " +
    "  desde donde establece observación y comienza la infiltración terrestre.<br/>" +
    "• Se confirma la presencia de dos de los cinco objetivos afganos dentro de Agios Konstantinos; el resto se mantiene en paradero " +
    "  desconocido dentro de la zona insurgente delimitada por la frontera roja, quedando su localización para jornadas posteriores.<br/>" +
    "• Durante la primera noche, las patrullas acceden a varias viviendas de civiles en Agios Konstantinos, generando alarma " +
    "  entre la población musulmana local, ya de por sí hostil tras los eventos previos de la campaña.<br/>" +
    "• El grupo paracaidista también entra en casas particulares, llegando a encontrarse con habitantes que reaccionan lanzando piedras " +
    "  contra las tropas. Algunos civiles son detenidos temporalmente en sus propias viviendas y posteriormente liberados al repliegue.<br/>" +
    "• A pesar de los errores en materia de sigilo y trato con la población, se consigue capturar sin dificultades a los dos VIPs " +
    "  con paradero conocido en la localidad.<br/>" +
    "• Tras las capturas, la fuerza se repliega hacia la costa de Agios Konstantinos para la extracción por mar. El acercamiento " +
    "  de las lanchas a la orilla, junto con el ruido de los motores, termina de alertar a buena parte del pueblo en plena noche." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>RESULTADO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• Dos de los cinco individuos de origen afgano localizados y capturados en Agios Konstantinos.<br/>" +
    "• Operación encubierta parcialmente comprometida por entradas en viviendas civiles, detenciones temporales y ruido durante " +
    "  la extracción por mar.<br/>" +
    "• Sin bajas propias durante esta primera jornada de la operación, pero con un incremento adicional de la hostilidad de la población " +
    "  local hacia la presencia española.<br/>" +
    "• La misión permanece en curso al final del Día 5, con la fuerza concentrada en la costa junto a las lanchas y los dos VIPs " +
    "  bajo custodia." +
    "</font>";

    private _dia6Text =
    "<font color='#C00000' size='20' face='PuristaBold'>MANDO COMPONENTE TERRESTRE (DON)</font><br/>" +
    "<font color='#DDDDDD' size='14' face='PuristaMedium'>Día 6 – Operación encubierta en Agios Konstantinos (Día 2/2)</font><br/>" +
    "<font color='#555555'>────────────────────────────────</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>SITUACIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "Tras la primera noche de operaciones, se ha logrado capturar a dos de los cinco individuos de origen afgano objetivo de la misión. " +
    "Ambos se encuentran bajo custodia en el punto de extracción. La insurgencia regional ha reforzado la seguridad en las poblaciones costeras " +
    "y se esperan reacciones para investigar los hechos ocurridos en Agios Konstantinos. Siguen sin localizarse los otros tres VIPs, " +
    "presumiblemente escondidos en diferentes puntos de la zona roja." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>MISIÓN</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "➤ Completar la operación encubierta capturando a los tres VIPs restantes.<br/>" +
    "➤ Exfiltrar con seguridad a todos los detenidos hacia las fuerzas españolas desplegadas en retaguardia.<br/>" +
    "➤ Mantener, en la medida de lo posible, el carácter discreto de la operación para evitar una reacción masiva de la insurgencia." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>DESARROLLO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• La jornada se reanuda en la costa, donde el elemento aún desplegado embarca a los dos VIPs capturados en las lanchas y se retira por mar " +
    "  mientras cuatro vehículos enemigos se aproximan al área para investigar lo ocurrido; la fuerza consigue alejarse al límite de ser detectada.<br/>" +
    "• Las lanchas regresan hasta el punto original de inserción por helicóptero, donde les esperan un camión español y dos Lince M2 preparados " +
    "  como fuerza de evacuación. Se entregan allí los dos detenidos para su traslado seguro.<br/>" +
    "• Se valora brevemente la posibilidad de lanzar una incursión directa en vehículos sobre toda la región, opción que se descarta por el elevado riesgo " +
    "  de activar a todas las fuerzas insurgentes. Finalmente se decide dividir el área de operaciones en varios sectores y organizar a la fuerza en grupos " +
    "  independientes para la búsqueda de los tres VIPs restantes.<br/>" +
    "• El elemento paracaidista regresa hacia Agios Konstantinos, comprobando que la población se encuentra fuertemente ocupada por combatientes enemigos. " +
    "  Para evitar el contacto directo llegan a aproximarse prácticamente a la arena de la playa y continúan avanzando pegados a la costa, " +
    "  pese a la recomendación de mantener mayor separación. Más adelante abandonan la lancha, observan a distancia un control de carretera y prosiguen " +
    "  por la montaña hasta una zona de aerogeneradores, donde son detectados por centinelas armados. Se inicia un tiroteo que rompe el sigilo " +
    "  y provoca el envío de múltiples patrullas hacia su posición.<br/>" +
    "• Los otros dos pelotones en lanchas continúan costeando hacia el norte hasta una zona con dos objetivos próximos. Desde posiciones de observación " +
    "  detectan movimiento entre ambas viviendas y observan cómo un individuo abandona una de ellas en vehículo para dirigirse a la otra. " +
    "  Allí identifican a uno de los VIPs saliendo al exterior. Se coordina el fuego para abatir a los objetivos en campo abierto; " +
    "  el VIP intenta huir corriendo hacia la costa para hacerse con una lancha, pero es neutralizado cuando intenta embarcar y posteriormente " +
    "  estabilizado para asegurar su captura.<br/>" +
    "• En el objetivo contiguo se localizan cajas con armamento. Pese al carácter encubierto de la operación, se decide colocar cargas y destruir " +
    "  todo el material mediante detonación, lo que alerta de inmediato a las fuerzas insurgentes cercanas y provoca el envío de varios vehículos a la zona. " +
    "  Los pelotones logran replegar con rapidez, regresar a las lanchas y alejarse de la costa antes de ser fijados.<br/>" +
    "• Posteriormente se aproximan por mar a otra vivienda cercana a la costa donde se esperaba encontrar a otro VIP, pero este ha abandonado la zona " +
    "  antes de su llegada. En su lugar, la fuerza se enfrenta a un elevado número de combatientes, en torno a cuarenta individuos distribuidos en grupos " +
    "  por el entorno. La presión enemiga y la pérdida total de discreción llevan a declarar la operación como fallida desde el punto de vista del plan " +
    "  de infiltración inicial, a pesar de las capturas realizadas." +
    "</font><br/><br/>" +

    "<font color='#9FAF6B' size='14' face='PuristaMedium'>RESULTADO</font><br/>" +
    "<font color='#EAEAEA' size='12' face='PuristaMedium'>" +
    "• Tres de los cinco VIPs objetivo de la operación encubierta capturados y puestos a disposición de las fuerzas españolas.<br/>" +
    "• Carácter clandestino de la misión comprometido por los combates y la destrucción de material enemigo, con fuerte reacción insurgente " +
    "  en toda la zona costera.<br/>" +
    "• Desestabilización significativa de la estructura insurgente regional, que ve mermados sus mandos y su logística.<br/>" +
    "• El conjunto de enfrentamientos y acciones de estos días provoca un éxodo masivo de población musulmana de la isla, " +
    "  que intenta regresar a Afganistán ante el temor a nuevas operaciones y al colapso de la célula insurgente local." +
    "</font>";


    private _records = [
        ["Día 1 – Inspección del complejo de Alikampos", _dia1Text],
        ["Día 2 – Capturas en Abdera", _dia2Text],
        ["Día 3 – Ayuda humanitaria en Abdera", _dia3Text],
        ["Día 4 – Surgimiento de la insurgencia", _dia4Text],
        ["Día 5 – Operación encubierta en Agios Konstantinos (Día 1/2)", _dia5Text],
        ["Día 6 – Operación encubierta en Agios Konstantinos (Día 2/2)", _dia6Text]
    ];

    // Arma muestra primero el último creado → los creamos en orden inverso
    reverse _records;

    {
        player createDiaryRecord ["LOS_AHMED", _x];
    } forEach _records;
};
