WGET:=wget -nv --show-progress --progress=bar:force:noscroll

download: otp.jar

berlin/osm.pbf:
	mkdir -p berlin
	${WGET} http://download.geofabrik.de/europe/germany/brandenburg-latest.osm.pbf -O $@

berlin/gtfs.zip:
	${WGET} https://transitfeeds.com/p/verkehrsverbund-berlin-brandenburg/213/latest/download -O $@

stuttgart/osm.pbf:
	mkdir -p stuttgart
	${WGET} http://download.geofabrik.de/europe/germany/baden-wuerttemberg/stuttgart-regbez-latest.osm.pbf -O $@

stuttgart/gtfs.zip:
	mkdir -p stuttgart
	${WGET} https://www.openvvs.de/dataset/e66f03e4-79f2-41d0-90f1-166ca609e491/resource/bfbb59c7-767c-4bca-bbb2-d8d32a3e0378/download/google_transit.zip -O $@

norway/osm.pbf:
	mkdir -p norway
	${WGET} http://download.geofabrik.de/europe/norway-latest.osm.pbf -O $@

norway/gtfs.zip:
	echo "No Norway GTFS yet!"

oxford/osm.pbf:
	mkdir -p oxford
	${WGET} http://download.geofabrik.de/europe/great-britain/england/oxfordshire-latest.osm.pbf -O $@

oxford/gtfs.zip:
	echo "No Oxford GTFS yet!"

otp.jar:
	${WGET} https://leonard.io/otp-2-shaded-2.1.0-SNAPSHOT.jar -O $@

build-%: otp.jar %/osm.pbf %/gtfs.zip
	java -Xmx12G -jar otp.jar --build --save $*

run-%: otp.jar
	java -jar otp.jar --load --serve $*

debug-%: otp.jar
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -jar otp.jar --load --serve $*

clean:
	rm -rf berlin/*.obj
	rm -rf stuttgart/*.obj
