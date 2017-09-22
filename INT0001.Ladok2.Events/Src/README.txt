
Ordered delivery = OD

OD uppnås via en kombination av en pollande SQL receive port och en SQL sendport, som förrutom att den uppdaterar meddelande status, hämtar nästa meddelande i "kön".

INT0001.Ladok2.Events portens syfte är att initiera OD flödet, sendporten INT0001.Ladok2.Send_Update uppdaterar meddelande status och ser till att nästkommande meddelanden hämtas en och en.

1) INT0001.Ladok2.Events pollar nästa meddelande i "kö".
	AckRequired promotas med värdet true vilket säger till BTS att den ska skapa en ACK/NACK beroende på om meddelandet kommit fram till mottagaren eller inte.
2) Meddelandet skickas till en sendporten INT0001.Ladok2.Send_Events utifrån meddelande typen. Alla meddelanden skickas till samma kö. Routing sker på fältet meType.
3) INT0001.Ladok2.Send_Update
	Porten ser till att statusen på meddelandet ändras till processed = 1 om meddelandet kommit fram till mottagaren.
	Då en ACK inte innehåller någon body innehåller lösningen en pipeline komponent som skapar en XMl av contexten. 
	Viktigt här är att context innehåller EventId som är det id som håller reda på nuvarande meddelande. En ACK ärver all context från original meddelandet.

	Samtidigt hämtar porten nästa meddelande i "kö".
	INT0001.Ladok2.Send_Update ser till att meddelandet har samma meddelande typ som porten INT0001.Ladok2.Events via en mappning.

	Även här promotas AckRequired med värdet true vilket säger till BTS att den ska skapa en ACK/NACK.

4) ... då sendporten INT0001.Ladok2.Send_Events prenumenerar på alla filer av typen http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents#TypedPolling  
		så kommer den även plocka meddelande från INT0001.Ladok2.Send_Update.

	Här kommer flödet fortsätta mellan INT0001.Ladok2.Send_Update och INT0001.Ladok2.Events ända tills det inte finns fler meddelanden att prcessas.

5) När det inte finns fler meddelanden att processas väntar flödet på att det sak komma nya meddelande n via poten INT0001.Ladok2.Events. 
	

	SuppressRoutingFailure ser till att inget extra report meddelande skapas (gammal BUG i BizTalk)

	+ Plus
		Vi behöver inte kompilera om orkesteringen för ett nytt meddelande (kunde dock hanteras via generisk port)
		Meddelanden köas inte upp internt i BizTalk (går att lösas via samma update som INT0001.Ladok2.Send_Update)
		Lösningen klarar av hur många omförsök som helst, lite bökigt med orkestrering om ens möjligt.
	
	- Minus
		Funkar bara om meddelandet endast har EN target, vilket den har i denna lösning.
		Lösningen innehåller många custom pipelines då lösningen är lite okonventionell.

	

