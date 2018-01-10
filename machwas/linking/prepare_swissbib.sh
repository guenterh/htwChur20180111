#!/usr/bin/env bash


source ../../setEnvironment.sh

export swissbib_data_input_dir=$PROJECTDIR/machwas/linking/data/swissbib/person
export swissbib_data_dir=$PROJECTDIR/machwas/linking/data/swissbib
export dbp_data_dir=$PROJECTDIR/machwas/linking/data/dbpedia


export context_dir=$swissbib_data_dir/contexts
context_prefix=https://resources.swissbib.ch
reshaperdf ntriplify $swissbib_data_dir swissbib.nt $context_prefix/document/context.jsonld $context_dir/document/context.jsonld $context_prefix/item/context.jsonld $context_dir/item/context.jsonld $context_prefix/organisation/context.jsonld $context_dir/organisation/context.jsonld $context_prefix/person/context.jsonld $context_dir/person/context.jsonld $context_prefix/resource/context.jsonld $context_dir/resource/context.jsonld $context_prefix/work/context.jsonld $context_dir/work/context.jsonld &>import.log


