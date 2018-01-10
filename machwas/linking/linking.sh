#!/usr/bin/env bash

#setze die Umgebungsvariablen so, damit sie zur Deiner lokalen Umgebung passen
source ../../setEnvironment.sh


export context_prefix=https://resources.swissbib.ch
export swissbib_data_dir=$PROJECTDIR/machwas/linking/data/swissbib/person
export context_dir=$PROJECTDIR/machwas/linking/data/swissbib/contexts
 


#Schritt 1: wir haben mit Metafacture Personenentitäten erstellt (im RDF Format JSON-LD)
# Diese JSON-LD Subjekte werden nun in das n-triple Format umgewandelt

echo "Start: Umwandlung der person subjekte aus dem Metafacture workflow (JSON-LD) in das RDF Format n-triples"
echo "es werden die Daten aus dem Verzeichnis $swissbib_data_dir verwendet"
echo
echo "Bitte return für weiter... "
read

java -jar  reshaper-tool/reshaperdf-1.0-SNAPSHOT.jar \
                                    ntriplify \
                                    $swissbib_data_dir \
                                    swissbib.nt \
                                    $context_prefix/document/context.jsonld \
                                    $context_dir/document/context.jsonld \
                                    $context_prefix/item/context.jsonld \
                                    $context_dir/item/context.jsonld \
                                    $context_prefix/organisation/context.jsonld \
                                    $context_dir/organisation/context.jsonld \
                                    $context_prefix/person/context.jsonld \
                                    $context_dir/person/context.jsonld \
                                    $context_prefix/resource/context.jsonld \
                                    $context_dir/resource/context.jsonld \
                                    $context_prefix/work/context.jsonld \
                                    $context_dir/work/context.jsonld &>import.log



echo
echo "Fertig! - Ergebnis im file $PROJECTDIR/machwas/linking/swissbib.nt - die Endung .nt steht für n-triples"
echo
echo



echo "einzelne statements der n-tripels, die für den linking Prozess nicht benötigt werden, kann man entfernen"
echo "Bitte return für weiter... "
read

java -jar  reshaper-tool/reshaperdf-1.0-SNAPSHOT.jar \
                                    filter \
                                    whitelist \
                                    swissbib.nt \
                                    data/swissbib/filter_4_compression.txt \
                                    swissbib_smaller.nt
echo
echo "Fertig! Ergebnis im file $PROJECTDIR/machwas/linking/swissbib_smaller.nt"
echo
echo

echo "Die n-triples im reduzierten dataset in $PROJECTDIR/machwas/linking/swissbib_smaller.nt werden nun sortiert"
echo "Bei uns mit nur einem Datensatz kaum nötig..."
echo "Bitte return für weiter... "
read

java -jar  reshaper-tool/reshaperdf-1.0-SNAPSHOT.jar sort swissbib_smaller.nt swissbib_sorted.nt
echo
echo
echo "Fertig! Ergebnis im file $PROJECTDIR/machwas/linking/swissbib_sorted.nt"
echo

echo "da die Triples sortiert wurden, kann ich Duplikate relativ leicht erkennen und diese entfernen"
echo "Bitte return für weiter... "
read

java -jar  reshaper-tool/reshaperdf-1.0-SNAPSHOT.jar removeduplicates swissbib_sorted.nt swissbib_sorted_wo_dup.nt
echo
echo "Fertig! Ergebnis im file $PROJECTDIR/machwas/linking/swissbib_sorted_wo_dup.nt"
echo
echo


#extract person (ich möchte nur Subjekte vom Typ person behandeln
echo "Da ich nur Subjekte vom typ person behandeln möchte \"<iri-subjekt> a http://xmlns.com/foaf/0.1/Person\" werden diese selektiert"
echo "Bitte return für weiter... "
read
java -jar  reshaper-tool/reshaperdf-1.0-SNAPSHOT.jar \
                                    extractresources \
                                    swissbib_sorted_wo_dup.nt \
                                    swissbib_persons_all.nt \
                                    http://www.w3.org/1999/02/22-rdf-syntax-ns#type \
                                    http://xmlns.com/foaf/0.1/Person 0 -1
echo
echo "Fertig! Ergebnis im file $PROJECTDIR/machwas/linking/swissbib_persons_all.nt"
echo
echo

echo "Nochmals eine Filterfunktion zur Verringerung der Datenmenge"
echo "Bitte return für weiter... "
read
java -jar  reshaper-tool/reshaperdf-1.0-SNAPSHOT.jar \
                                    filter \
                                    whitelist \swissbib_persons_all.nt \
                                    data/swissbib/filter_4_linking.txt \
                                    swissbib_persons_4_linking.nt

echo
echo "Fertig! Ergebnis im file $PROJECTDIR/machwas/linking/swissbib_persons_4_linking.nt"
echo
echo


echo "Block persons by last name - Aufbau der Daten für den Blockmechanismus - s. Artikel Gesis"
echo "Bitte return für weiter... "
read
java -jar  reshaper-tool/reshaperdf-1.0-SNAPSHOT.jar block  swissbib_persons_4_linking.nt swissbib_blocks http://xmlns.com/foaf/0.1/lastName 0 1
echo
echo "Fertig! die geblockten Daten befinden sich im Verzeichnis $PROJECTDIR/machwas/linking/data/swissbib/swissbib_blocks"
echo " und können mit den Blocks aus DBPedia (Verzeichnis: $PROJECTDIR/machwas/linking/data/dbpedia/dbpedia_blocks) mit Hilfe von Limes verglichen werden - Ziel: Auffinden von owl:sameAs Verbindungen"
echo
echo




	




