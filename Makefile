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
	${WGET} https://gtfs.mfdz.de/hbg5.merged.with_flex.gtfs.zip -o $@

norway/osm.pbf:
	mkdir -p norway
	${WGET} http://download.geofabrik.de/europe/norway-latest.osm.pbf -o $@

norway/gtfs.zip:
	echo "No Norway GTFS yet!"

drammen/osm.pbf: norway/osm.pbf
	osmium extract norway/osm.pbf --polygon drammen/drammen.geojson -o $@

drammen/gtfs.zip:
	echo "No Drammen GTFS yet!"

oxford/osm.pbf:
	mkdir -p oxford
	${WGET} http://download.geofabrik.de/europe/great-britain/england/oxfordshire-latest.osm.pbf -o $@

oxford/gtfs.zip:
	echo "No Oxford GTFS yet!"

otp.jar:
	${WGET} https://leonard.io/stadtnavi/otp-2.jar -o $@

build-%: otp.jar %/osm.pbf %/gtfs.zip
	java -Xmx12G -jar otp.jar --build --save $*

run-%: otp.jar
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -jar otp.jar --load --serve $*

clean:
	find . -name osm.pbf -printf '%p\n' -exec rm {} \;
	find . -name gtfs.zip -printf '%p\n' -exec rm {} \;
	find . -name graph.obj -printf '%p\n' -exec rm {} \;
	rm -f otp.jar
