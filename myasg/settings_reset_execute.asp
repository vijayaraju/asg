<%@ LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!--#include file="config.asp" -->
<!--#include file="includes/inc_array_table.asp" -->
<!--#include file="asg-lib/file.asp" -->
<%

' 
' = ASP Stats Generator - Powerful and reliable ASP website counter
' 
' Copyright (c) 2003-2008 Simone Carletti <weppos@weppos.net>
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
' 
' @category        ASP Stats Generator
' @package         ASP Stats Generator
' @author          Simone Carletti <weppos@weppos.net>
' @copyright       2003-2008 Simone Carletti
' @license         http://www.opensource.org/licenses/mit-license.php
' @version         SVN: $Id$
' 


'// ATTENZIONE! Protezione statistiche.
'	Modificare solo se necessario e se sicuri.
'	Impostazioni errate possono compromettere la privacy.
Call AllowEntry("False", "False", "False", intAsgSecurity)


'Inizializza variabili
Dim strAsgTable		'Tabella da resettare
Dim strAsgTimerange
Dim strAsgWeekrange
Dim strAsgMsg		'Messaggio Reset
Dim blnAsgDoNotExecute
DIm dtmResetDateTime		'Holds a DateTime variable used to reset data


'-----------------------------------------------------------------------------------------
' Reset tabella
'-----------------------------------------------------------------------------------------
' Funzione:	Reset della tabella in base a parametri passati
' Data: 	03.04.2004
' Commenti:		
'-----------------------------------------------------------------------------------------
function ResetTableIndicated(ByVal databasetable)
	
	'Componi la parte di delete della stringa SQL
	strAsgSQL = "DELETE * FROM " & strAsgTablePrefix & databasetable & " "
	
	
	'-----------------------------------------------------------------------------------------
	' Reset settimanali e particolari
	'-----------------------------------------------------------------------------------------
	If databasetable = "Detail" AND IsNumeric(strAsgWeekrange) Then
			
			'Consenti il reset
			blnAsgDoNotExecute = False
			'Trasforma il valore in numerico
			strAsgWeekrange = CInt(strAsgWeekrange)
			'Calculate reset date
			dtmResetDateTime = DateAdd("ww", -strAsgWeekrange, dtmAsgDate)
			dtmResetDateTime = Year(dtmResetDateTime) & "/" & Month(dtmResetDateTime) & "/" & Day(dtmResetDateTime)
			'Crea la riga di condizione
			strAsgSQL = strAsgSQL & "WHERE Data < #" & dtmResetDateTime & "# "

	End If 


	'-----------------------------------------------------------------------------------------
	' Reset mensili e classici
	'-----------------------------------------------------------------------------------------
	'Reset completo
	If strAsgTimerange = "full" Then
			'
			'Consenti il reset
			blnAsgDoNotExecute = False
	'Reset escluso mese corrente
	ElseIf strAsgTimerange = "0" Then
		
		'Controllo coerenza reset mensile
		If databasetable <> "Detail" AND databasetable <> "IP" Then 
			strAsgSQL = strAsgSQL & "WHERE Mese <> '" & dtmAsgMonth & "-" & dtmAsgYear & "' "
			'Consenti il reset
			blnAsgDoNotExecute = False
		ElseIf databasetable = "Detail" Then 
			'Calculate reset date
			dtmResetDateTime = Date() 'DateAdd("m", -1, dtmAsgDate)
			dtmResetDateTime = Year(dtmResetDateTime) & "/" & Month(dtmResetDateTime) & "/" & 1
			'Crea la riga di condizione
			strAsgSQL = strAsgSQL & "WHERE Data < #" & dtmResetDateTime & "# "
			'Consenti il reset
			blnAsgDoNotExecute = False
		Else
			'Ferma il reset
			blnAsgDoNotExecute = True
		End If
	
	'Reset escluso numero di mesi
	ElseIf IsNumeric(strAsgTimerange) AND CInt(strAsgTimerange) > 0 Then
		
		Dim dateloop
		
		'Controllo coerenza reset mensile
		If databasetable <> "Detail" AND databasetable <> "IP" Then 
			
			'Consenti il reset
			blnAsgDoNotExecute = False
			'Crea la radice di condizione
			strAsgSQL = strAsgSQL & "WHERE Mese <> '" & Right("0" & Month(dtmAsgDate), 2) & "-" & Year(dtmAsgDate) & "' "

			'Trasforma il valore in numerico
			strAsgTimerange = Cint(strAsgTimerange)
			
			For dateloop = 1 to strAsgTimerange
				'Calcola la differenza di tempo
				dtmAsgDate = DateAdd("m", -1, dtmAsgDate)
				'Prepara la condizione
				strAsgSQL = strAsgSQL & "AND Mese <> '" & Right("0" & Month(dtmAsgDate), 2) & "-" & Year(dtmAsgDate) & "' "
			Next

		ElseIf databasetable = "Detail" Then 
			
			'Consenti il reset
			blnAsgDoNotExecute = False
			'Trasforma il valore in numerico
			strAsgTimerange = Cint(strAsgTimerange)
			'Calculate reset date
			dtmResetDateTime = DateAdd("m", -strAsgTimerange, dtmAsgDate)
			dtmResetDateTime = Year(dtmResetDateTime) & "/" & Month(dtmResetDateTime) & "/" & Day(dtmResetDateTime)
			'Crea la riga di condizione
			strAsgSQL = strAsgSQL & "WHERE Data < #" & dtmResetDateTime & "# "

		Else
			'Ferma il reset
			blnAsgDoNotExecute = True
		End If
		
	Else
			'Ferma il reset
			blnAsgDoNotExecute = True
	End If

'Response.Write(strAsgSQL) : Response.End()
	If Not blnAsgDoNotExecute = True Then
		objAsgConn.Execute(strAsgSQL)
		strAsgMsg = strAsgMsg & strAsgTxtTable & "&nbsp;" & databasetable & "&nbsp;" & strAsgTxtCorrectlyDeleted & " <br />"
	End If

end function 

strAsgTable = Trim(Request.QueryString("table"))
strAsgTimerange = Trim(Request.QueryString("timerange"))
strAsgWeekrange = Trim(Request.QueryString("weekrange"))
'On Error Resume Next


'Reset generale
If strAsgTable = 0 Then
		
	For looptmp = 1 to Ubound(aryAsgTable)
	
		Call ResetTableIndicated(aryAsgTable(looptmp, 1))
	
	Next
	
'Reset selezionato
ElseIf strAsgTable <> 0 AND Len(strAsgTable) > 0 Then
	
	Call ResetTableIndicated(aryAsgTable(strAsgTable, 1))
	
Else
	
	'Reset Server Objects
	Set objAsgRs = Nothing
	objAsgConn.Close
	Set objAsgConn = Nothing
	Response.Redirect "settings_reset.asp?msg=error"

End If

'Reset Server Objects
Set objAsgRs = Nothing
objAsgConn.Close
Set objAsgConn = Nothing


' compact and restore database
Call asgDatabaseAccessCompact(strAsgMapPath, strAsgMapPathTo)
' replace original database with compacted one
Call asgFileReplace(strAsgMapPathTo, strAsgMapPath)


'Nel caso si siano verificati errori valorizza una variabile
'e mostrali poi a video continuando l'esecuzione
If err <> 0 then 
    strAsgMsg = strAsgMsg & strAsgTxtError & ": <br />" & err.description & "<br />" 
Else 
    strAsgMsg = strAsgMsg & "<br />" & strAsgTxtDatabaseSuccessfullyCompactedOn & "<br /><span class=""notetext"">" & strAsgMapPathTo & "</span><br />"
    strAsgMsg = strAsgMsg & strAsgTxtDatabaseSuccessfullyRenamedTo & "<br /><span class=""notetext"">" & strAsgMapPath & "</span><br />"
End if 


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%= strAsgSiteName %> | powered by ASP Stats Generator <%= ASG_VERSION %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="copyright" content="Copyright (C) 2003-2008 Carletti Simone, All Rights Reserved" />
<meta name="generator" content="ASP Stats Generator <%= ASG_VERSION %>" /> <!-- leave this for stats -->

<!--#include file="asg-includes/layout/head.asp" -->

<!--
  ASP Stats Generator (release <%= ASG_VERSION %>) is a free software package
  completely written in ASP programming language, for real time visitor tracking.
  Get your own copy for free at http://www.asp-stats-com/ !
-->

</head>

<!--#include file="asg-includes/layout/header.asp" -->
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
		  <tr align="center" valign="middle">
			<td align="center" background="<%= strAsgSknPathImage & strAsgSknTableBarBgImage %>" bgcolor="<%= strAsgSknTableBarBgColour %>" height="20" class="bartitle"><%= UCase(strAsgTxtResetSettings) %></td>
		  </tr>
		  <tr bgcolor="<%= strAsgSknTableLayoutBorderColour %>">
			<td align="center" height="1"></td>
		  </tr>
		</table><br />
		<table width="70%" border="0" align="center" cellpadding="1" cellspacing="1">
		  <tr bgcolor="<%= strAsgSknTableTitleBgColour %>" class="normaltitle">
			<td background="<%= strAsgSknPathImage & strAsgSknTableTitleBgImage %>" align="center" height="16"><%= UCase(strAsgTxtExecutionReport) %></td>
		  </tr>
		  <tr class="smalltext" bgcolor="<%= strAsgSknTableContBgColour %>">
			<td background="<%= strAsgSknPathImage & strAsgSknTableContBgImage %>" width="100%" align="center"><br />
			<%= strAsgMsg %><br /><br />
			</td>
		  </tr>
		<%
				
		'// Row - End table spacer			
		Call BuildTableContEndSpacer(2)

		%>
		</table><br />
<%

' Footer
Response.Write(vbCrLf & "<table width=""100%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""1"">")
'// Row - Footer Border Line
Call BuildFooterBorderLine()

' ***** START WARNING - REMOVAL or MODIFICATION IN PART or ALL OF THIS CODE WILL VIOLATE THE LICENSE AGREEMENT	******
' ***** INIZIO AVVERTENZA - RIMOZIONE o MODIFICA PARZIALE/TOTALE DEL CODICE COMPORTA VIOLAZIONE DELLA LICENZA  	******
Response.Write("<tr align=""center"" valign=""middle"">")
Response.Write("<td align=""center"" background=""" & strAsgSknPathImage & strAsgSknTableBarBgImage & """ bgcolor=""" & strAsgSknTableBarBgColour & """ height=""20"" class=""footer""><a href=""http://www.asp-stats.com/"" class=""linkfooter"" title=""ASP Stats Generator Homepage"">ASP Stats Generator</a> " & ASG_VERSION & " - &copy; 2003-2008 <a href=""http://www.weppos.com/"" class=""linkfooter"" title=""Weppos.com Homepage"">weppos</a>")
if ASG_CONFIG_ELABTIME then Response.Write(" - " & asgElabtime())
Response.Write("</td>")
Response.Write("</tr>")
' ***** END WARNING - REMOVAL or MODIFICATION IN PART or ALL OF THIS CODE WILL VIOLATE THE LICENSE AGREEMENT	******
' ***** FINE AVVERTENZA - RIMOZIONE o MODIFICA PARZIALE/TOTALE DEL CODICE COMPORTA VIOLAZIONE DELLA LICENZA  ******

Response.Write("</table>")

%>
<!--#include file="asg-includes/layout/footer.asp" -->

</body></html>