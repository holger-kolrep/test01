# Hier anpassen
$pfad="D:\Ordner2\"
$logpfad="D:\Ordner\"
$PSEmailServer = "192.168.0.3"
$emailempfaenger="kolrep@turbo-post.de"
$emailabsender="EPNutzer1 <EPNutzer1@turbo-post.de>"
$tagezurueck=-7

#die 3 auskommentierten Zeilen einmalig ausführen, um Passwort verschlüsselt zu speichern
#(Get-Credential).password | ConvertFrom-SecureString > MailPW.txt
#$pw = Get-Content .\MailPW.txt | ConvertTo-SecureString
#$cred = New-Object System.Management.Automation.PSCredential "EPNutzer1", $pw

# Datum von heute ermitteln und Stichtag berechnen, ab dem Änderungen registriert werden
$text="nichts neues"
$datum=(Get-date ).AddDays($tagezurueck)
#$datum=Get-date  -Format  "MM/dd/yyyy"

#Ermitteln und Log schreiben
$text=(Get-ChildItem $pfad | Where-Object {($_.lastwritetime -gt $datum)})
Get-ChildItem $pfad | Where-Object {($_.lastwritetime -gt $datum)}| Out-File $logpfad\log.txt

#Email versenden
if($text -ne "nichts neues") 
{
	Send-MailMessage -to $emailempfaenger -from $emailabsender -Subject "Datei-Eingang" -Attachments $logpfad\log.txt
}
