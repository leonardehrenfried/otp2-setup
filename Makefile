.PRECIOUS: %/streetGraph.obj
WGET:=curl -L -\# --fail

download: otp.jar

berlin/osm.pbf:
	mkdir -p berlin
	${WGET} http://download.geofabrik.de/europe/germany/brandenburg-latest.osm.pbf -o $@

berlin/gtfs.zip:
	${WGET} https://transitfeeds.com/p/verkehrsverbund-berlin-brandenburg/213/latest/download -o $@

hamburg/osm.pbf:
	mkdir -p hamburg
	${WGET} https://download.geofabrik.de/europe/germany/hamburg-latest.osm.pbf -o $@

hamburg/gtfs.zip:
	mkdir -p hamburg
	${WGET} https://gtfs.mfdz.de/HVV.with_bikes_allowed.gtfs.zip -o $@

stuttgart/osm.pbf:
	mkdir -p stuttgart
	${WGET} https://download.geofabrik.de/europe/germany/baden-wuerttemberg/stuttgart-regbez-latest.osm.pbf -o $@

stuttgart/gtfs.zip:
	mkdir -p stuttgart
	${WGET} https://gtfs.mfdz.de/hbg5.merged.with_flex.gtfs.zip -o $@

norway/osm.pbf:
	mkdir -p norway
	${WGET} http://download.geofabrik.de/europe/norway-latest.osm.pbf -o $@

norway/rb_norway-aggregated-netex.zip:
	${WGET} https://storage.googleapis.com/marduk-production/outbound/netex/rb_norway-aggregated-netex.zip -o $@

norway/gtfs.zip: norway/rb_norway-aggregated-netex.zip
	echo "No GTFS, but Netex instead."

germany/gtfs.zip:
	echo "No GTFS, but Netex instead."

germany/osm.pbf:
	mkdir -p germany
	${WGET} https://download.geofabrik.de/europe/germany/hamburg-latest.osm.pbf -o $@

drammen/osm.pbf: norway/osm.pbf
	osmium extract norway/osm.pbf --polygon drammen/drammen.geojson -o $@

drammen/rb_bra_aggregate-netex.zip:
	${WGET} https://storage.googleapis.com/marduk-production/outbound/netex/rb_bra-aggregated-netex.zip -o $@

drammen/gtfs.zip: drammen/rb_bra_aggregate-netex.zip
	echo "No GTFS"

oslo/osm.pbf: norway/osm.pbf
	osmium extract norway/osm.pbf --polygon oslo/oslo.geojson -o $@

oslo/gtfs.zip:
	echo "No GTFS yet!"

oxford/osm.pbf:
	mkdir -p oxford
	${WGET} http://download.geofabrik.de/europe/great-britain/england/oxfordshire-latest.osm.pbf -o $@

oxford/gtfs.zip:
	echo "No Oxford GTFS yet!"

## flex example feeds

massachusetts/osm.pbf:
	mkdir -p massachusetts
	${WGET} https://download.geofabrik.de/north-america/us/massachusetts-latest.osm.pbf -o $@

colorado/osm.pbf:
	mkdir -p colorado
	${WGET} https://download.geofabrik.de/north-america/us/colorado-latest.osm.pbf -o $@

aspen/osm.pbf: colorado/osm.pbf
	osmium extract colorado/osm.pbf --polygon aspen/aspen.geojson -o $@

aspen/gtfs.zip: aspen/osm.pbf
	${WGET} https://raw.githubusercontent.com/MobilityData/gtfs-flex/master/spec/FlexExample--on-demand-service.zip -o $@

cripple-creek/osm.pbf: colorado/osm.pbf
	osmium extract colorado/osm.pbf --polygon cripple-creek/cripple-creek.geojson -o $@

cripple-creek/gtfs.zip: cripple-creek/osm.pbf
	${WGET} https://raw.githubusercontent.com/MobilityData/gtfs-flex/master/spec/FlexExample--same-day-service.zip -o $@

brockton/osm.pbf: massachusetts/osm.pbf
	osmium extract massachusetts/osm.pbf --polygon brockton/brockton.geojson -o $@

brockton/mtba.gtfs.zip:
	${WGET} https://transitfeeds.com/p/mbta/64/latest/download -o $@

brockton/gtfs.zip: brockton/mtba.gtfs.zip brockton/osm.pbf
	${WGET} https://raw.githubusercontent.com/MobilityData/gtfs-flex/master/spec/FlexExample--various.zip -o $@

otp.jar:
	${WGET} https://otp.leonard.io/snapshots/2.1-SNAPSHOT/otp-2.1.0-SNAPSHOT-shaded-latest.jar -o $@

%/streetGraph.obj:
	java -Xmx12G -jar otp.jar --buildStreet --save $*

build-%: otp.jar %/osm.pbf %/streetGraph.obj %/gtfs.zip
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -Xmx12G -jar otp.jar --loadStreet --save $*

run-%: otp.jar
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -jar otp.jar --load --serve $*

clean-all:
	find . -name osm.pbf -printf '%p\n' -exec rm {} \;
	find . -name gtfs.zip -printf '%p\n' -exec rm {} \;
	find . -name graph.obj -printf '%p\n' -exec rm {} \;
	find . -name streetGraph.obj -printf '%p\n' -exec rm {} \;
	rm -f otp.jar

clean-%:
	find $* -name *gtfs.zip -printf '%p\n' -exec rm {} \;
	find $* -name graph.obj -printf '%p\n' -exec rm {} \;
	find $* -name streetGraph.obj -printf '%p\n' -exec rm {} \;
	find $* -name osm.pbf -printf '%p\n' -exec rm {} \;

