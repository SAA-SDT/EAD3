INCELIM="rng-incelim-1.2/incelim"
TRANG="trang.jar"
DTD_FLATTEN="dtdflatten/dtd-flatten-3.2.9.jar"


$INCELIM -saxon ead3_undeprecated-driver.rng

mv ead3_undeprecated-driver-compiled.rng ead3_undeprecated.rng 


$INCELIM -saxon ead3_undeprecated_dtd.rng

java -jar  $TRANG ead3_undeprecated_dtd-compiled.rng  ead3_undeprecated_dtd-compiled.dtd

java -jar  $DTD_FLATTEN ead3_undeprecated_dtd-compiled.dtd > ead3_undeprecated.dtd

#xmlstarlet sel -t -v //h1 -v //*[@class = contentdesc] elem-*.html  | sed 's/&gt;/> /' | sed 's/&lt;/</'
