#!/usr/bin/env bash

#setze die Umgebungsvariablen so, damit sie zur Deiner lokalen Umgebung passen
source ../../setEnvironment.sh

echo "java -jar limes-tool/LIMES.jar linking/configs/limes_config_u57_1-u57_1.xml"
echo
echo "das limes tool wird aufgerufen und ihm wird über eine Konfiguration angegeben, welche Daten untersucht werden sollen"

echo
echo "Bitte return für weiter... "
read
java -jar limes-tool/LIMES.jar linking/configs/limes_config_u57_1-u57_1.xml



	




