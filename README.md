Aufgabenstellung

Das Projekt stellt ein Verwaltungssystem eines Sicherheitsunternehmens dar, das nur für die innere Benutzung dieses Unternehmens vorausgesehen wird. Ein (oder mehrere, s. Aussicht) Mitarbeiter patrouilliert die Stadt. Falls es eine Alarmmeldung gibt, wird das Objekt von dem zuständigen Mitarbeiter kontrolliert und nach Einbrüchen untersucht. Die auf einem Handy oder Tablet laufende Anwendung bietet dem Fahrer beste Navigationsmöglichkeiten und wichtige Informationen des Zielpunktes. Der Schwerpunkt liegt auf der Karten / Navigationsfunktionalität.

Zu den Kunden des Unternehmens gehören große / kleine Firmen und Geschäfte, die eigene Einrichtungen in der Stadt haben (z.B. Lager/Büros/Laden) und kontinuierliche Überwachung von diesen Objekten benötigen. Es wird unterstellt, dass in diesen Einrichtungen die Meldeanlagen montiert werden, die u.a. einen Einbruch melden. 
 
Architekturbeschreibung

Die Projektarchitektur kann der Abb. 1 entnommen werden.
 
Abb. 1: Architektur des XMLProjects.

Das Projekt ist in Cocoon integriert. Die mit Hilfe von XML führende Datenbank wird als die Grundlage für die Funktionalität des Systems benutzt:
-	Auflistung von allen Mitarbeiter des Unternehmens mit entsprechenden Informationen;
-	Auflistung von allen Kunden des Unternehmens;
-	Auflistung aller Unfälle;
-	Rechnungserstellung;
-	Anzeige von allen oder nur bestimmten Schutzobjekten auf der Karte;
-	Darstellung der Route bis zum Objekt.
Die Daten werden mit Hilfe XSLT und XSL-FO ausgewertet. 

 
Beschreibung von Dateien und Ordnern:
•	XMLProject/sitemap.xmap – beschreibt, welche .xml-Dateien mit welchen .xslt-Dateien für alle Requests transformiert werden sollen
•	XMLProject /css/ – CSS des Projekts
•	XMLProject /DB/xml/ – Datenbank in XML-Format
•	XMLProject /DB/xsd/ – Regeln für die Datenbank (xml-Schema)
•	XMLProject /js/ – JavaScript
•	XMLProject /xslt/ – XSLT des Projekts

Wichtige Details der Lösung

Für die Kartenfunktionalität wird ein GoogleMaps JavaScript Api-Schlüssel benutzt. Dieser soll für die weitere Nutzung durch den eigenen ersetzt werden (irgendwann wird aktueller Schlüssel deaktiviert). Dazu folgen Sie den Link https://console.developers.google.com/ 
Um den JS-Code zu vereinfachen wird eine JQuery-2.2.0-Bibliothek eingesetzt. Diese ist als Local-Datei (XMLProject/js/jquery-2.2.0.js) dem Projekt eingeschlossen.
 
Beschreibung der Nutzungsbedingungen

Für die Nutzung der aktuellen Version der Anwendung wird folgende Software / Hardwareumgebung empfohlen:
-	Apache Cocoon 2.1.12
-	Aktuelle Version eines Internet-Browsers (2015/16)
-	Internet-Zugang
-	Betriebssystem und Hardware, die die oben erwähnte unterstützen
Zur Nutzung soll XMLProjekt-Ordner in Cocoon/build/webapp/ kopiert werden. Nach dem Serverstart kann die Anwendung unter der Adresse (bei Defaulteinstellungen des Cocoon Servers) http://localhost:8888/XMLProject/ erreicht werden. Das System kann auch mit Hilfe von Tomcat Apache Server gestartet werden, wenn der ganze Cocoon-Ordner mit XMLProject zu Tomcat/webapps/ kopiert wird. Der Aufruf (bei Defaulteinstellungen des Apache / Tomcat Servers): http://localhost:8080/cocoon/XMLProject/ (nicht vergessen Tomcat vorher zu starten).

 
Bewertung und Ausblick

Im Weiteren sollte folgende Funktionalität erbracht werden:
-	XML-Datenbank über Browser zu bearbeiten, z.B. Erstellung von einem neuen Kunden. Momentan wird die in XML schon vorhandene Information verarbeitet, eine Modifizierung der DB erfolgt ausschließlich manuell (neue Einträge in db.xml eintippen);
-	mehrere Patrouille-Wagen mit zugehörigen Gebieten zu verwalten;
-	GeoCoding: die echten Adressen sollen über Google Service in Geokoordinaten automatisch übersetzt werden. Aktuell werden die Koordinaten des Standortes zu jeden Schutzobjekt in XML eingetragen;
-	für die Navigation soll der aktuelle Standort des Benutzers erkannt werden (z.B. GPS des Gerätes) und als Startpunkt eingesetzt;
-	Distance Matrix Service von Google mit einbinden, um beispielsweise die Dauer der Fahrt oder die Entfernung bis zum Ziel zu empfangen;
-	Rechnungserstellung soll vernünftig implementiert werden.
 
Verwendete Literatur

-	“XML-Technologien”-Scripte von Heide-Rose Vatterrott, Hochschule Bremen, Fakultät 4 - Elektrotechnik und Informatik
-	http://www.w3.org/XML/
-	http://www.w3schools.com/xml/default.asp
-	http://stackoverflow.com
-	https://developers.google.com/maps/
 
