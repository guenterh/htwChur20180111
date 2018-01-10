#!/usr/bin/env bash

#setze die Umgebungsvariablen so, damit sie zur Deiner lokalen Umgebung passen
source ../../setEnvironment.sh


java -jar genconfig-tool/genconfig-1.0-SNAPSHOT.jar \
                                limes \
                                data/swissbib/swissbib_blocks \
                                data/dbpedia/dbpedia_blocks \
                                linking/templates/swissbib-dbpedia_birthDate.xml.template \
                                linking/configs



