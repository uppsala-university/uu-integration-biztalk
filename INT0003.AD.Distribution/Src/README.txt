
ReceiveAndDebatchADGroupChanges.odx tas bort och ers�tts med debatch p� receive port och mappning p� sendport
	sendporten filtrerar p� port och meddelande typ

ReceiveAndDebatchADIndividualChanges.odx tas bort och ers�tts med debatch p� receive port och mappning p� sendport
	sendporten filtrerar p� port och meddelande typ


Specifik port filtrerar p� meddelanden som inte har n�gon subscriber men som kommer fr�n dessa portar, null adapter??

�ven nedan tas bort och nanteras av null adapter
HandleAllADGroupChanges.odx
HandleAllADIndividualChanges.odx

SuppressRoutingFailure ser till att inget extra report meddelande skapas (gammal BUG i BizTalk)


