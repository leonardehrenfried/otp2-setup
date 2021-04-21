WGET:=curl -\#

download: otp.jar

berlin/osm.pbf:
	mkdir -p berlin
	${WGET} http://download.geofabrik.de/europe/germany/brandenburg-latest.osm.pbf -o $@

berlin/gtfs.zip:
	${WGET} https://transitfeeds.com/p/verkehrsverbund-berlin-brandenburg/213/latest/download -o $@

stuttgart/osm.pbf:
	mkdir -p stuttgart
	${WGET} http://download.geofabrik.de/europe/germany/baden-wuerttemberg/stuttgart-regbez-latest.osm.pbf -o $@

stuttgart/gtfs.zip:
	mkdir -p stuttgart
	${WGET} https://www.openvvs.de/dataset/e66f03e4-79f2-41d0-90f1-166ca609e491/resource/bfbb59c7-767c-4bca-bbb2-d8d32a3e0378/download/google_transit.zip -o $@

norway/osm.pbf:
	mkdir -p norway
	${WGET} http://download.geofabrik.de/europe/norway-latest.osm.pbf -o $@

norway/gtfs.zip:
	echo "No Norway GTFS yet!"

oxford/osm.pbf:
	mkdir -p oxford
	${WGET} http://download.geofabrik.de/europe/great-britain/england/oxfordshire-latest.osm.pbf -o $@

oxford/gtfs.zip:
	echo "No Oxford GTFS yet!"

otp.jar:
	${WGET} https://leonard.io/otp-2-shaded-2.1.0-SNAPSHOT.jar -o $@

build-%: otp.jar %/osm.pbf %/gtfs.zip
	java -Xmx12G -jar otp.jar --build --save $*

run-%: otp.jar
	java -jar otp.jar --load --serve $*

debug-%: otp.jar
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -jar otp.jar --load --serve $*

clean:
	find . -name osm.pbf -printf '%p\n' -exec rm {} \;
	find . -name gtfs.zip -printf '%p\n' -exec rm {} \;
	find . -name graph.obj -printf '%p\n' -exec rm {} \;
	rm -f otp.jar
