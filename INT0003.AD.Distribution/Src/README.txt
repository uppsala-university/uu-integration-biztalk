
ReceiveAndDebatchADGroupChanges.odx tas bort och ersätts med debatch på receive port och mappning på sendport
	sendporten filtrerar på port och meddelande typ

ReceiveAndDebatchADIndividualChanges.odx tas bort och ersätts med debatch på receive port och mappning på sendport
	sendporten filtrerar på port och meddelande typ


Specifik port filtrerar på meddelanden som inte har någon subscriber men som kommer från dessa portar, null adapter??

Även nedan tas bort och nanteras av null adapter
HandleAllADGroupChanges.odx
HandleAllADIndividualChanges.odx

SuppressRoutingFailure ser till att inget extra report meddelande skapas (gammal BUG i BizTalk)


