
Ordered delivery = OD

OD uppn�s via en kombination av en pollande SQL receive port och en SQL sendport, som f�rrutom att den uppdaterar meddelande status, h�mtar n�sta meddelande i "k�n".

INT0001.Ladok2.Events portens syfte �r att initiera OD fl�det, sendporten INT0001.Ladok2.Send_Update uppdaterar meddelande status och ser till att n�stkommande meddelanden h�mtas en och en.

1) INT0001.Ladok2.Events pollar n�sta meddelande i "k�".
	AckRequired promotas med v�rdet true vilket s�ger till BTS att den ska skapa en ACK/NACK beroende p� om meddelandet kommit fram till mottagaren eller inte.
2) Meddelandet skickas till en sendporten INT0001.Ladok2.Send_Events utifr�n meddelande typen. Alla meddelanden skickas till samma k�. Routing sker p� f�ltet meType.
3) INT0001.Ladok2.Send_Update
	Porten ser till att statusen p� meddelandet �ndras till processed = 1 om meddelandet kommit fram till mottagaren.
	D� en ACK inte inneh�ller n�gon body inneh�ller l�sningen en pipeline komponent som skapar en XMl av contexten. 
	Viktigt h�r �r att context inneh�ller EventId som �r det id som h�ller reda p� nuvarande meddelande. En ACK �rver all context fr�n original meddelandet.

	Samtidigt h�mtar porten n�sta meddelande i "k�".
	INT0001.Ladok2.Send_Update ser till att meddelandet har samma meddelande typ som porten INT0001.Ladok2.Events via en mappning.

	�ven h�r promotas AckRequired med v�rdet true vilket s�ger till BTS att den ska skapa en ACK/NACK.

4) ... d� sendporten INT0001.Ladok2.Send_Events prenumenerar p� alla filer av typen http://schemas.microsoft.com/Sql/2008/05/TypedPolling/ladokevents#TypedPolling  
		s� kommer den �ven plocka meddelande fr�n INT0001.Ladok2.Send_Update.

	H�r kommer fl�det forts�tta mellan INT0001.Ladok2.Send_Update och INT0001.Ladok2.Events �nda tills det inte finns fler meddelanden att prcessas.

5) N�r det inte finns fler meddelanden att processas v�ntar fl�det p� att det sak komma nya meddelande n via poten INT0001.Ladok2.Events. 
	

	SuppressRoutingFailure ser till att inget extra report meddelande skapas (gammal BUG i BizTalk)

	+ Plus
		Vi beh�ver inte kompilera om orkesteringen f�r ett nytt meddelande (kunde dock hanteras via generisk port)
		Meddelanden k�as inte upp internt i BizTalk (g�r att l�sas via samma update som INT0001.Ladok2.Send_Update)
		L�sningen klarar av hur m�nga omf�rs�k som helst, lite b�kigt med orkestrering om ens m�jligt.
	
	- Minus
		Funkar bara om meddelandet endast har EN target, vilket den har i denna l�sning.
		L�sningen inneh�ller m�nga custom pipelines d� l�sningen �r lite okonventionell.

	

