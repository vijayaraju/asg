<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<% Option Explicit %>
<!--#include file="config.asp" -->
<%

'-------------------------------------------------------------------------------'
'	ASP Stats Generator															'
' Copyright 2003-2006 - Carletti Simone										'
'-------------------------------------------------------------------------------'
'																				'
'	Autore:																		'
'	--------------------------													'
'	Simone Carletti (weppos)													'
'																				'
'	Collaboratori 																'
'	[che ringrazio vivamente per l'impegno ed il tempo dedicato]				'
'	--------------------------													'
'	@ imente 			- www.imente.it | www.imente.org						'
'	@ ToroSeduto		- www.velaforfun.com									'
'																				'
'	Hanno contribuito															'
'	[anche a loro un grazie speciale per le idee apportate]						'
'	--------------------------													'
'	@ Gli utenti del forum con consigli e segnalazioni							'
'	@ subxus (suggerimento generazione grafica dei report)						'
'																				'
'	Verifica le proposte degli utenti, implementate o da implementare al link	'
'	http://www.weppos.com/forum/forum_posts.asp?TID=140&PN=1					'
'																				'
'-------------------------------------------------------------------------------'
'																				'
'	Informazioni sulla Licenza													'
'	--------------------------													'
'	Questo � un programma gratuito; potete modificare ed adattare il codice		'
'	(a vostro rischio) in qualsiasi sua parte nei termini delle condizioni		'
'	della licenza che lo accompagna.											'
'																				'
'	Non � consentito utilizzare l'applicazione per conseguire ricavi 			'
'	personali, distribuirla, venderla o diffonderla come una propria 			'
'	creazione anche se modificata nel codice, senza un esplicito e scritto 		'
'	consenso dell'autore.														'
'																				'
'	Potete modificare il codice sorgente (a vostro rischio) per adattarlo 		'
'	alle vostre esigenze o integrarlo nel sito; nel caso le funzioni possano	'
'	essere di utilit� pubblica vi invitiamo a comunicarlo per poterle 			'
'	implementare in una futura versione e per contribuire allo sviluppo 		'
'	del programma.																'
'																				'
'	In nessun caso l'autore sar� responsabile di danni causati da una 			'
'	modifica, da un uso non corretto o da un uso qualsiasi 						'
'	dell'applicazione.															'
'																				'
'	Nell'utilizzo devono rimanere intatte tutte le informazioni sul 			'
'	copyright; � possibile modificare o rimuovere unicamente le indicazioni 	'
'	espressamente specificate.													'
'																				'
'	Numerose ore sono state impiegate nello sviluppo del progetto e, anche 		'
'	se non vincolante ai fini dell'uso, sarebbe gratificante l'inserimento		'
'	di un link all'applicazione sul vostro sito.								'
'																				'
'	NESSUNA GARANZIA															'
'	------------------------- 													'
'	Questo programma � distribuito nella speranza che possa essere utile ma 	'
'	senza GARANZIA DI ALCUN GENERE.												'
'	L'utente si assume tutte le responsabilit� nell'uso.						'
'																				'
'-------------------------------------------------------------------------------'

'********************************************************************************'
'*																				*'	
'*	VIOLAZIONE DELLA LICENZA													*'
'*	 																			*'
'*	L'utilizzo dell'applicazione violando le condizioni di licenza comporta la 	*'
'*	perdita immediata della possibilit� d'uso ed � PERSEGUIBILE LEGALMENTE!		*'
'*																				*'
'********************************************************************************'


'// ATTENZIONE! Protezione statistiche.
'	Modificare solo se necessario e se sicuri.
'	Impostazioni errate possono compromettere la privacy.
Call AllowEntry("True", "False", "False", intAsgSecurity)


'Dichiara Variabili
Dim mese			'Riferimento per output
Dim elenca			'Tutti | Mese
Dim dettagli		'Motore di cui mostrare le informazioni


'Grafico
Dim intAsgLarColMax		'Larghezza massima in px delle colonne dipendente dalla pag

Dim intAsgMax				'Valore massimo di pagine visitate
Dim intAsgParte

Dim intAsgTotMeseHits		'Valore totale per mese di pagine visitate
Dim intAsgTotMeseVisits		'Valore totale per mese di accessi unici


'Read setting variables from querystring
mese = Request.QueryString("mese")
elenca = Request.QueryString("elenca")
dettagli = Request.QueryString("dettagli")
strAsgSortBy = Request.QueryString("sort")
strAsgSortOrder = Request.QueryString("order")


'If period variable is empty then set it to the current month
If mese = "" Then mese = dtmAsgMonth & "-" & dtmAsgYear
'If the variable is empty set it to monthly report
If elenca = "" Then elenca = "mese"
' Set the sorting order depending on querystring
if strAsgSortOrder = "ASC" then 
	strAsgSortOrder = "ASC"
else
	strAsgSortOrder = "DESC"
end if
'If a time period has been chosen then build the variable to query the database
If Request.QueryString("showperiod") = strAsgTxtShow Then mese = Request.QueryString("periodmm") & "-" & Request.QueryString("periodyy")


'Set max total column width
intAsgLarColMax = 300				'Largezza massima colonne | Rapportata alla dimensione della pagina


'Richiama totale
If elenca = "mese" Then 
	strAsgSQL = "SELECT Sum(Hits) As SumHits, Sum(Visits) AS SumVisits FROM "&strAsgTablePrefix&"Query WHERE Mese = '" & mese & "' "
ElseIf elenca = "tutti" Then 
	strAsgSQL = "SELECT Sum(Hits) As SumHits, Sum(Visits) AS SumVisits FROM "&strAsgTablePrefix&"Query "
End If

objAsgRs.Open strAsgSQL, objAsgConn
If objAsgRs.EOF Then
	intAsgTotMeseHits = 0
	intAsgTotMeseVisits = 0
Else
	intAsgTotMeseHits = objAsgRs("SumHits")
	intAsgTotMeseVisits = objAsgRs("SumVisits")
End If
objAsgRs.Close
'Accertati che non siano nulli
If intAsgTotMeseHits = 0 OR "[]" & intAsgTotMeseHits = "[]" Then intAsgTotMeseHits = 0
If intAsgTotMeseVisits = 0 OR "[]" & intAsgTotMeseVisits = "[]" Then intAsgTotMeseVisits = 0


'Richiama valore Massimo
If elenca = "mese" Then 
	strAsgSQL = "SELECT SUM(Hits) AS SumHits FROM "&strAsgTablePrefix&"Query WHERE Mese = '" & mese & "' GROUP BY Engine ORDER BY SUM(Hits) DESC"
ElseIf elenca = "tutti" Then 
	strAsgSQL = "SELECT SUM(Hits) AS SumHits FROM "&strAsgTablePrefix&"Query GROUP BY Engine ORDER BY SUM(Hits) DESC"
End If
objAsgRs.Open strAsgSQL, objAsgConn, 2, 3
If objAsgRs.EOF Then
	intAsgMax = 0
Else
	objAsgRs.MoveFirst
	intAsgMax = objAsgRs("SumHits")
End If
objAsgRs.Close

'Calcola unit� singola
If intAsgMax = 0 OR "[]" & intAsgMax = "[]" Then intAsgMax = 1
intAsgParte = intAsgLarColMax/intAsgMax


'Read sorting order from querystring
'// Filter QS values and associate them 
'// with their respective database fields
Select Case strAsgSortBy
	Case "hts" strAsgSortByFld = "SUM(Hits)"
	Case "visits" strAsgSortByFld = "SUM(Visits)"
	Case "engine" strAsgSortByFld = "Engine"
	Case Else strAsgSortByFld = "SUM(Visits)"
End Select

'Richiama le Dichiarazioni per la 
'paginazione avanzata
Call DimPaginazioneAvanzata()

'Richiama le Dichiarazioni per la 
'paginazione avanzata dei dettagli
Call DimPaginazioneAvanzataDettagli()

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%= strAsgSiteName %> | ASP Stats Generator <%= strAsgVersion %></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="copyright" content="Copyright (C) 2003-2004 Carletti Simone" />
<link href="stile.css" rel="stylesheet" type="text/css" />
<!--#include file="includes/inc_meta.asp" -->

<!-- 	ASP Stats Generator <%= strAsgVersion %> � una applicazione gratuita 
		per il monitoraggio degli accessi e dei visitatori ai siti web 
		creata e sviluppata da Simone Carletti.
		
		Puoi scaricarne una copia gratuita sul sito ufficiale http://www.weppos.com/ -->

</head>
<!--#include file="includes/header.asp" -->
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
		  <tr align="center" valign="middle">
			<td align="center" background="<%= strAsgSknPathImage & strAsgSknTableBarBgImage %>" bgcolor="<%= strAsgSknTableBarBgColour %>" height="20" class="bartitle"><%= UCase(strAsgTxtSearchEngine) %></td>
		  </tr>
		  <tr bgcolor="<%= strAsgSknTableLayoutBorderColour %>">
			<td align="center" height="1"></td>
		  </tr>
		</table><br />
		<table width="90%" border="0" align="center" cellpadding="1" cellspacing="1">
		  <tr bgcolor="<%= strAsgSknTableTitleBgColour %>" align="center" class="normaltitle">
			<td width="5%"  background="<%= strAsgSknPathImage & strAsgSknTableTitleBgImage %>" height="16"></td>
			<td width="28%" background="<%= strAsgSknPathImage & strAsgSknTableTitleBgImage %>"><%= UCase(strAsgTxtEngine) %>
				<a href="engine.asp?<%= "mese=" & mese & "&elenca=" & elenca & "&dettagli=" & dettagli & "&sort=engine&order=DESC" %>" title="<%= strAsgTxtOrderBy & "&nbsp;" & strAsgTxtEngine & "&nbsp;" & strAsgTxtDesc %>">
				<img src="<%= strAsgSknPathImage%>arrow_down.gif" border="0" align="absmiddle" /></a>
				<a href="engine.asp?<%= "mese=" & mese & "&elenca=" & elenca & "&dettagli=" & dettagli & "&sort=engine&order=ASC" %>" title="<%= strAsgTxtOrderBy & "&nbsp;" & strAsgTxtEngine & "&nbsp;" & strAsgTxtAsc %>">
				<img src="<%= strAsgSknPathImage%>arrow_up.gif" border="0" align="absmiddle" /></a></td>
			<td width="12%"  background="<%= strAsgSknPathImage & strAsgSknTableTitleBgImage %>"><%= UCase(strAsgTxtSmHits) %></td>
			<td width="50%" background="<%= strAsgSknPathImage & strAsgSknTableTitleBgImage %>">
				<a href="engine.asp?<%= "mese=" & mese & "&elenca=" & elenca & "&dettagli=" & dettagli & "&sort=hits&order=DESC" %>" title="<%= strAsgTxtOrderBy & "&nbsp;" & strAsgTxtHits & "&nbsp;" & strAsgTxtDesc %>">
				<img src="<%= strAsgSknPathImage%>arrow_down.gif" border="0" align="absmiddle" /></a>
				<a href="engine.asp?<%= "mese=" & mese & "&elenca=" & elenca & "&dettagli=" & dettagli & "&sort=hits&order=ASC" %>" title="<%= strAsgTxtOrderBy & "&nbsp;" & strAsgTxtHits & "&nbsp;" & strAsgTxtAsc %>">
				<img src="<%= strAsgSknPathImage%>arrow_up.gif" border="0" align="absmiddle" /></a>
			&nbsp;&nbsp;<%= UCase(strAsgTxtGraph) %>&nbsp;&nbsp;
				<a href="engine.asp?<%= "mese=" & mese & "&elenca=" & elenca & "&dettagli=" & dettagli & "&sort=visits&order=DESC" %>" title="<%= strAsgTxtOrderBy & "&nbsp;" & strAsgTxtVisits & "&nbsp;" & strAsgTxtDesc %>">
				<img src="<%= strAsgSknPathImage%>arrow_down.gif" border="0" align="absmiddle" /></a>
				<a href="engine.asp?<%= "mese=" & mese & "&elenca=" & elenca & "&dettagli=" & dettagli & "&sort=visits&order=ASC" %>" title="<%= strAsgTxtOrderBy & "&nbsp;" & strAsgTxtVisits & "&nbsp;" & strAsgTxtAsc %>">
				<img src="<%= strAsgSknPathImage%>arrow_up.gif" border="0" align="absmiddle" /></a></td>
			<td width="5%" background="<%= strAsgSknPathImage & strAsgSknTableTitleBgImage %>"></td>
		  </tr>
		<%

		If elenca = "mese" Then 
			'Initialise SQL string to select data
			strAsgSQL = "SELECT SUM(Hits) AS SumHits, SUM(Visits) As SumVisits, Engine FROM "&strAsgTablePrefix&"Query WHERE Mese = '" & mese & "' "
			'Call the function to search into the database if there are enought information to do that
			strAsgSQL = CheckSearchForData(strAsgSQL, false)
		ElseIf elenca = "tutti" Then 
			'Initialise SQL string to select data
			strAsgSQL = "SELECT SUM(Hits) AS SumHits, SUM(Visits) As SumVisits, Engine FROM "&strAsgTablePrefix&"Query "
			'Call the function to search into the database if there are enought information to do that
			strAsgSQL = CheckSearchForData(strAsgSQL, true)
		End If
		
		'Group information by following fields
		strAsgSQL = strAsgSQL & " GROUP BY Engine "
		'Order record by selected field 
		strAsgSQL = strAsgSQL & " ORDER BY " & strAsgSortByFld & " " & strAsgSortOrder & ""
		
		'Prepara il Rs
		objAsgRs.CursorType = 3
		objAsgRs.LockType = 3
		
		'Apri il Rs
		objAsgRs.Open strAsgSQL, objAsgConn
			
			'Il Rs � vuoto
			If objAsgRs.EOF Then
				
				'If it is a search query then show no results advise
				If Len(asgSearchfor) > 0 AND Len(asgSearchin) > 0 Then
	
					'// Row - No current record	for search terms		
					Call BuildTableContNoRecord(5, "search")
					
				'Else show general no record information
				Else
	
					'// Row - No current record			
					Call BuildTableContNoRecord(5, "standard")
					
				End If
				
			Else
			
				objAsgRs.PageSize = RecordsPerPage
				objAsgRs.AbsolutePage = page
				
				For PaginazioneLoop = 1 To RecordsPerPage
					
					If Not objAsgRs.EOF Then			
					
		%>		  
		  <tr class="smalltext" bgcolor="<%= strAsgSknTableContBgColour %>">
			<td background="<%= strAsgSknPathImage & strAsgSknTableContBgImage %>" align="center"><img src="images/engine.asp?icon=<%= objAsgRs("Engine") %>" alt="<%= objAsgRs("Engine") %>" /></td>
			<td background="<%= strAsgSknPathImage & strAsgSknTableContBgImage %>" align="left"><%
											
				'Write an anchor
				Response.Write(vbCrLf & "<a name=""" & objAsgRs("Engine") & """></a>")
			
			%>
			<a href="engine.asp?<%= "dettagli=" & objAsgRs("Engine") & "&page=" & page & "&mese=" & mese & "&elenca=" & elenca & "&searchfor=" & asgSearchfor & "&searchin=" & asgSearchin & "&sort=" & strAsgSortBy & "&order=" & strAsgSortOrder & "#" & objAsgRs("Engine") & "" %>" title="<%= strAsgTxtSearchQuery%>">
			<% 
				'Icona espansa se Corrisponde
				If Trim(dettagli) <> "" AND objAsgRs("Engine") = Trim(dettagli) Then
					Response.Write("<img src=""" & strAsgSknPathImage & "expanded.gif"" alt=""" & strAsgTxtSearchQuery & """ border=""0"" align=""absmiddle"" />")
				'Icona espandi se Differente
				Else
					Response.Write("<img src=""" & strAsgSknPathImage & "expand.gif"" alt=""" & strAsgTxtSearchQuery & """ border=""0"" align=""absmiddle"" />")
				End If
			
			%></a>&nbsp;<%= HighlightSearchKey(objAsgRs("Engine"), "Engine") %></td>
			<td background="<%= strAsgSknPathImage & strAsgSknTableContBgImage %>" align="right"><%= objAsgRs("SumHits") & "<br />" & objAsgRs("SumVisits") %></td>
			<td background="<%= strAsgSknPathImage & strAsgSknTableContBgImage %>">
				<img src="<%= strAsgSknPathImage%>bar_graph_image_hits_h.gif" width="<%= FormatNumber(objAsgRs("SumHits")*intAsgParte, 2) %>" height="9" alt="<%= strAsgTxtHits %>" align="absmiddle" /> [<%= CalcolaPercentuale(intAsgTotMeseHits, objAsgRs("SumHits")) %>]<br />
				<img src="<%= strAsgSknPathImage%>bar_graph_image_visits_h.gif" width="<%= FormatNumber(objAsgRs("SumVisits")*intAsgParte, 2) %>" height="9" alt="<%= strAsgTxtVisits %>" align="absmiddle" /> [<%= CalcolaPercentuale(intAsgTotMeseVisits, objAsgRs("SumVisits")) %>]
			</td>
			<td background="<%= strAsgSknPathImage & strAsgSknTableContBgImage %>" align="center"></td>
		  </tr>
		<% 
			If Trim(dettagli) <> "" AND objAsgRs("Engine") = Trim(dettagli) Then
				
				Dim objAsgRs2
				
				'Mostra le query al motore
				Set objAsgRs2 = Server.CreateObject("ADODB.Recordset")
				
				If elenca = "mese" Then 
					strAsgSQL = "SELECT Query, Hits, Visits, SERP_Page FROM "&strAsgTablePrefix&"Query WHERE Engine = '" & dettagli & "' AND Mese = '" & mese & "' "
				ElseIf elenca = "tutti" Then 
					strAsgSQL = "SELECT Query, Hits, Visits, SERP_Page FROM "&strAsgTablePrefix&"Query WHERE Engine = '" & dettagli & "' "
				End If
				
				strAsgSQL = strAsgSQL & " ORDER BY Visits DESC, Hits DESC"
		
		
		%>
		  <tr class="smalltext">
			<td colspan="5"><br />
				<!-- Contenitore Dettagli -->
				<table width="100%" border="0" cellspacing="0" cellpadding="1" align="center">
				  <tr>
					<td width="7%" valign="top" align="center"><img src="<%= strAsgSknPathImage %>openarrow.gif" width="25" height="25" border="0" alt="<%= strAsgTxtDetails %>"></td>
					<td width="86%">
					<!-- Dettagli Query Motore -->
					<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
					  <tr bgcolor="<%= strAsgSknTableTitleBgColour %>" align="center" class="normaltitle">
						<td width="76%" background="<%= strAsgSknPathImage & strAsgSknTableTitleBgImage %>" height="16"><%= UCase(strAsgTxtEngine) %></td>
						<td width="12%" background="<%= strAsgSknPathImage & strAsgSknTableTitleBgImage %>"><%= UCase(strAsgTxtSmHits) %></td>
						<td width="12%" background="<%= strAsgSknPathImage & strAsgSknTableTitleBgImage %>"><%= UCase(strAsgTxtSmVisits) %></td>
					  </tr>
					  <% 
					
					'Prepara il Rs
					objAsgRs2.CursorType = 3
					objAsgRs2.LockType = 3
					
					'Apri il Rs
					objAsgRs2.Open strAsgSQL, objAsgConn
						
						'Il Rs � vuoto
						If objAsgRs2.EOF Then
							
							'// Row - No current record			
							Call BuildTableContNoRecord(3, "standard")
							
						Else

							objAsgRs2.PageSize = detRecordsPerPage
							objAsgRs2.AbsolutePage = detpage
							
							For detPaginazioneLoop = 1 To detRecordsPerPage
								If Not objAsgRs2.EOF Then			

					  %>
					  <tr bgcolor="<%= strAsgSknTableContBgColour %>" class="smalltext">
						<td background="<%= strAsgSknPathImage & strAsgSknTableContBgImage %>" align="left"><% If objAsgRs2("SERP_Page") > 0 Then Response.Write("&nbsp;<a href=""serp.asp?serp=" & objAsgRs2("SERP_Page") & "&mese=" & mese &"&elenca=" & elenca & """ title=""" & strAsgTxtQuery & "&nbsp;" & objAsgRs2("SERP_Page") & "&deg;&nbsp;" & strAsgTxtPage & """><span class=""notetext"">[" & objAsgRs2("SERP_Page") & "]</span></a>") %>&nbsp;<%= objAsgRs2("Query") %></td>
						<td background="<%= strAsgSknPathImage & strAsgSknTableContBgImage %>" align="right"><%= objAsgRs2("Hits") %></td>
						<td background="<%= strAsgSknPathImage & strAsgSknTableContBgImage %>" align="right"><%= objAsgRs2("Visits") %></td>
					  </tr>
					  <%
						
								objAsgRs2.MoveNext
								End If
							Next
							End If
								
						'// Row - End table spacer			
						Call BuildTableContEndSpacer(3)
				
						'// Row - Advanced details data sorting
						Response.Write(vbCrLf & "<tr class=""smalltext""><td colspan=""3"" align=""center""><br />")
						Call PaginazioneAvanzataDettagli("engine.asp", "")
						Response.Write(vbCrLf & "<br /><br /></td></tr>")
									  
						objAsgRs2.Close
						Set objAsgRs2 = Nothing
					  
					  %>
					</table><br />
					<!-- Fine Dettagli Query Motore -->
					</td>
					<td width="7%"></td>
				  </tr>
				</table>
				<!-- Fine Contenitore Dettagli -->
			</td>
		  </tr>
		<%
			'Fine condizione dettagli
			End If

				objAsgRs.MoveNext
				End If
			Next
			End If
				
		'// Row - End table spacer			
		Call BuildTableContEndSpacer(5)

		'// Row - Advanced data sorting
		Response.Write(vbCrLf & "<tr class=""smalltext""><td colspan=""5"" align=""center""><br />")
		Call PaginazioneAvanzata("engine.asp", "")
		Response.Write(vbCrLf & "<br /><br /></td></tr>")

		objAsgRs.Close

		'Reset Server Objects
		Set objAsgRs = Nothing
		objAsgConn.Close
		Set objAsgConn = Nothing
				
		'// Riga - Debug automatico icone		
		Call BuildTableContCheckIcon(5, "engine", page)

		'// Row - Data output panels
		Response.Write(vbCrLf & "<tr class=""smalltext"" align=""center"" valign=""top""><td colspan=""5"" height=""25""><br />")
		Call GoToPeriod("engine.asp", "")
		Call GoToGrouping("engine.asp", "")
		Call SearchForData("engine.asp", "", "Engine")
		Response.Write(vbCrLf & "</td></tr>")
		
		%>
		</table><br />
<%

'Footer
Response.Write(vbCrLf & "		<table width=""100%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""1"">")
'// Row - Footer Border Line
Call BuildFooterBorderLine()

'***** START WARNING - REMOVAL or MODIFICATION IN PART or ALL OF THIS CODE WILL VIOLATE THE LICENSE AGREEMENT	******
'***** INIZIO AVVERTENZA - RIMOZIONE o MODIFICA PARZIALE/TOTALE DEL CODICE COMPORTA VIOLAZIONE DELLA LICENZA  	******
Response.Write(vbCrLf & "		  <tr align=""center"" valign=""middle"">")
Response.Write(vbCrLf & "			<td align=""center"" background=""" & strAsgSknPathImage & strAsgSknTableBarBgImage & """ bgcolor=""" & strAsgSknTableBarBgColour & """ height=""20"" class=""footer"">ASP Stats Generator [" & strAsgVersion & "] - &copy; 2003-2006 <a href=""http://www.weppos.com/"" class=""linkfooter"">weppos</a>")
If blnAsgElabTime Then Response.Write(" - " & strAsgTxtThisPageWasGeneratedIn & "&nbsp;" & FormatNumber(Timer() - startAsgElab, 4) & "&nbsp;" & strAsgTxtSeconds)
Response.Write(						"</td>")
Response.Write(vbCrLf & "		  </tr>")
'***** END WARNING - REMOVAL or MODIFICATION IN PART or ALL OF THIS CODE WILL VIOLATE THE LICENSE AGREEMENT	******
'***** FINE AVVERTENZA - RIMOZIONE o MODIFICA PARZIALE/TOTALE DEL CODICE COMPORTA VIOLAZIONE DELLA LICENZA  ******

Response.Write(vbCrLf & "		</table>")
Response.Write(vbCrLf & "	  </td></tr>")
Response.Write(vbCrLf & "	</table>")
Response.Write(vbCrLf & "  </td></tr>")
Response.Write(vbCrLf & "</table>")

%>
<!--#include file="includes/footer.asp" -->
</body></html>