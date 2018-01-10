#!/usr/bin/env bash

#setze die Umgebungsvariablen so, damit sie zur Deiner lokalen Umgebung passen
source ../../setEnvironment.sh

cd $PROJECTDIR/machwas

echo "Ausführen der Abfrage:"
echo "apache-jena-3.6.0/bin/sparql \
            --data=$PROJECTDIR/machwas/linking/data/dbpedia/dbpedia_blocks/u57_1.nt \
            --query=$PROJECTDIR/machwas/linking/data/dbpedia/query/query.dbpedia.txt"

echo
echo "Es werden die Personen aus dem (geblockten) DBPedia File gelesen, die wir in unserem Limes Beispiel
    zur Verlinkung bereits genutzt haben"

echo
echo "Bitte return für weiter... "
read

echo "einen kurzen Moment Geduld, das File wird gerade von Sparql gelesen"


apache-jena-3.6.0/bin/sparql \
            --data=$PROJECTDIR/machwas/linking/data/dbpedia/dbpedia_blocks/u57_1.nt \
            --query=$PROJECTDIR/machwas/linking/data/dbpedia/query/query.dbpedia.txt




	




