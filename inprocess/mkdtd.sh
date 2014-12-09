INCELIM="rng-incelim-1.2/incelim"
TRANG="trang.jar"
DTD_FLATTEN="dtdflatten/dtd-flatten-3.2.9.jar"


$INCELIM -saxon ../ead3-driver.rng

$INCELIM -saxon ead3_dtd.rng

java -jar  $TRANG ead3_dtd-compiled.rng  ead3-compiled.dtd

java -jar  $DTD_FLATTEN ead3-compiled.dtd > ../ead3.dtd

cp ead3-driver-compiled.rng > ../ead3.rng
