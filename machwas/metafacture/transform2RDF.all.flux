filesize            = "10000";
records             = "20000";
compress            = "false";
extension           = "jsonld";
outdirbib           = FLUX_DIR + "data.out";
outdirdoc           = FLUX_DIR + "data.out";
outdiritem          = FLUX_DIR + "data.out";
outdirorganisation  = FLUX_DIR + "data.out";
outdirperson        = FLUX_DIR + "data.out";
indir               = FLUX_DIR + "data.in";



indir |
read-dir|
//open-gzip|
open-file|
catch-object-exception|
decode-xml|
handle-marcxml|
filter(FLUX_DIR + "morph/245aFilter.xml")|
stream-tee| {
    change-id("245*.a")|
    morph(FLUX_DIR + "morph/resourceMorph.xml")|
    change-id|
    encode-esbulk(escapeChars="true", header="false")|
    write-esbulk(jsonCompliant="true", compress=compress, baseOutDir=outdirbib, type="bibliographicResource", extension=extension)
}{

    morph(FLUX_DIR + "morph/documentMorph.xml")|
    change-id|
    encode-esbulk(escapeChars="true", header="false")|
    write-esbulk(jsonCompliant="true", compress=compress, baseOutDir=outdirdoc, type="document", extension=extension)

}{
    morph(FLUX_DIR + "morph/itemMorph.xml")|
    split-entities|
    change-id|
    encode-esbulk(escapeChars="true", header="false")|
    write-esbulk(jsonCompliant="true", compress=compress, baseOutDir=outdiritem, type="item", extension=extension)
}{
    morph(FLUX_DIR + "morph/organisationMorph.xml")|
    split-entities|
    change-id|
    encode-esbulk(escapeChars="true", header="false")|
    write-esbulk(baseOutDir=outdirorganisation, fileSize=filesize, jsonCompliant="true", type="organisation", compress=compress, extension=extension)
}{
    change-id("245*.a")|
    morph(FLUX_DIR + "morph/personMorph.xml")|
    split-entities|
    change-id|
    encode-esbulk(escapeChars="true", header="false")|
    write-esbulk(baseOutDir=outdirperson, fileSize=filesize, jsonCompliant="true", type="person", compress=compress, extension=extension)
};
