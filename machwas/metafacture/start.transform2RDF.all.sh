#!/usr/bin/env bash

#setze die Umgebungsvariablen so, damit sie zur Deiner lokalen Umgebung passen
source ../../setEnvironment.sh

#wechsle in das Basisverzeichnis Deiner lokalen Umgebung
cd $PROJECTDIR

#starte Metafacture mit Hilfe des Fluxmechanismus
#dem Startscript (flux.sh) muss der workflow angegeben werden (der von Dir definiert wurde)
./flux.sh machwas/metafacture/transform2RDF.all.flux
