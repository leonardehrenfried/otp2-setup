.PRECIOUS: %/streetGraph.obj
CURL:=curl -L -\# --fail --create-dirs
current_dir = $(shell pwd)

download: otp.jar

berlin/osm.pbf:
	mkdir -p berlin
	${CURL} http://download.geofabrik.de/europe/germany/brandenburg-latest.osm.pbf -o $@

berlin/gtfs.zip:
	${CURL} https://www.vbb.de/fileadmin/user_upload/VBB/Dokumente/API-Datensaetze/gtfs-mastscharf/GTFS.zip -o $@

herzberg/osm.pbf: berlin/osm.pbf
	mkdir -p berlin
	osmium extract berlin/osm.pbf --polygon herzberg/herzberg.geojson -o $@

herzberg/gtfs.zip:
	#${CURL} https://www.vbb.de/fileadmin/user_upload/VBB/Dokumente/API-Datensaetze/gtfs-mastscharf/GTFS.zip -o $@

hamburg/osm.pbf:
	mkdir -p hamburg
	${CURL} https://download.geofabrik.de/europe/germany/hamburg-latest.osm.pbf -o $@

hamburg/gtfs.zip:
	mkdir -p hamburg
	${CURL} https://gtfs.mfdz.de/HVV.with_bikes_allowed.gtfs.zip -o $@

karlsruhe/gtfs.zip:
	${CURL} https://gtfs.mfdz.de/KVV.with_shapes.gtfs.zip -o $@

karlsruhe/osm.pbf:
	${CURL} https://download.geofabrik.de/europe/germany/baden-wuerttemberg/karlsruhe-regbez-latest.osm.pbf -o $@

stuttgart/gtfs.zip:
	mkdir -p stuttgart
	${CURL} https://gtfs.mfdz.de/hbg5.merged.with_flex.gtfs.zip -o $@

stuttgart/osm.pbf:
	mkdir -p stuttgart
	${CURL} https://download.geofabrik.de/europe/germany/baden-wuerttemberg/stuttgart-regbez-latest.osm.pbf -o $@

reutlingen/gtfs.zip:
	echo "none"

reutlingen/osm.pbf:
	mkdir -p reutlingen
	${CURL} https://download.geofabrik.de/europe/germany/baden-wuerttemberg/tuebingen-regbez-latest.osm.pbf -o $@

norway/osm.pbf:
	mkdir -p norway
	${CURL} http://download.geofabrik.de/europe/norway-latest.osm.pbf -o $@

norway/rb_norway-aggregated-netex.zip:
	${CURL} https://storage.googleapis.com/marduk-production/outbound/netex/rb_norway-aggregated-netex.zip -o $@

norway/gtfs.zip: norway/rb_norway-aggregated-netex.zip
	echo "No GTFS, but Netex instead."

germany/gtfs.zip:
	echo "No GTFS, but Netex instead."

germany/osm.pbf:
	mkdir -p germany
	${CURL} https://download.geofabrik.de/europe/germany/hamburg-latest.osm.pbf -o $@

drammen/osm.pbf: norway/osm.pbf
	osmium extract norway/osm.pbf --polygon drammen/drammen.geojson -o $@

drammen/rb_bra_aggregate-netex.zip:
	${CURL} https://storage.googleapis.com/marduk-production/outbound/netex/rb_bra-aggregated-netex.zip -o $@

drammen/gtfs.zip: drammen/rb_bra_aggregate-netex.zip
	echo "No GTFS"

oslo/osm.pbf: norway/osm.pbf
	osmium extract norway/osm.pbf --polygon oslo/oslo.geojson -o $@

oslo/gtfs.zip:
	echo "No GTFS yet!"

oxford/osm.pbf:
	mkdir -p oxford
	${CURL} http://download.geofabrik.de/europe/great-britain/england/oxfordshire-latest.osm.pbf -o $@

oxford/gtfs.zip:
	echo "No Oxford GTFS yet!"

finland/osm.pbf:
	${CURL} https://download.geofabrik.de/europe/finland-latest.osm.pbf -o $@

helsinki/gtfs.zip:
	${CURL} https://api.digitransit.fi/routing-data/v2/hsl/HSL.zip -o $@

helsinki/osm.pbf: finland/osm.pbf
	osmium extract finland/osm.pbf --polygon helsinki/helsinki.geojson -o $@

## America

massachusetts/osm.pbf:
	mkdir -p massachusetts
	${CURL} https://download.geofabrik.de/north-america/us/massachusetts-latest.osm.pbf -o $@

georgia/osm.pbf:
	mkdir -p georgia
	${CURL} https://download.geofabrik.de/north-america/us/georgia-latest.osm.pbf -o $@

colorado/osm.pbf:
	mkdir -p colorado
	${CURL} https://download.geofabrik.de/north-america/us/colorado-latest.osm.pbf -o $@

aspen/osm.pbf: colorado/osm.pbf
	osmium extract colorado/osm.pbf --polygon aspen/aspen.geojson -o $@

aspen/gtfs.zip: aspen/osm.pbf
	${CURL} https://raw.githubusercontent.com/MobilityData/gtfs-flex/master/spec/FlexExample--on-demand-service.zip -o $@

cripple-creek/osm.pbf: colorado/osm.pbf
	osmium extract colorado/osm.pbf --polygon cripple-creek/cripple-creek.geojson -o $@

cripple-creek/gtfs.zip: cripple-creek/osm.pbf
	${CURL} https://raw.githubusercontent.com/MobilityData/gtfs-flex/master/spec/FlexExample--same-day-service.zip -o $@

brockton/osm.pbf: massachusetts/osm.pbf
	osmium extract massachusetts/osm.pbf --polygon brockton/brockton.geojson -o $@

brockton/mtba.gtfs.zip:
	${CURL} https://transitfeeds.com/p/mbta/64/latest/download -o $@

brockton/gtfs.zip: brockton/mtba.gtfs.zip brockton/osm.pbf
	${CURL} https://raw.githubusercontent.com/MobilityData/gtfs-flex/master/spec/FlexExample--various.zip -o $@

cobb/osm.pbf: georgia/osm.pbf
	osmium extract georgia/osm.pbf --polygon cobb/cobb-county.geojson -o $@

cobb/cobblinc.gtfs.zip:
	${CURL} https://www.arcgis.com/sharing/rest/content/items/1ce8e370a12c41b5854d8baa21f8451c/data -o $@

cobb/gtfs.zip: cobb/osm.pbf cobb/cobblinc.gtfs.zip
	${CURL} https://leonard.io/ibi/cobblinc-flex-with-farezones.zip -o $@

atlanta/osm.pbf: georgia/osm.pbf
	osmium extract georgia/osm.pbf --polygon atlanta/atlanta.geojson -o $@

atlanta/cobblinc.gtfs.zip:
	${CURL} https://www.arcgis.com/sharing/rest/content/items/1ce8e370a12c41b5854d8baa21f8451c/data -o $@

atlanta/cobblinc-flex.gtfs.zip:
	${CURL} https://leonard.io/ibi/cobblinc-flex-with-farezones.zip -o $@

atlanta/gtfs.zip: atlanta/osm.pbf atlanta/cobblinc.gtfs.zip atlanta/cobblinc-flex.gtfs.zip
	${CURL} https://itsmarta.com/google_transit_feed/google_transit.zip -o $@

otp.jar:
	${CURL} https://otp.leonard.io/snapshots/2.1-SNAPSHOT/otp-2.1.0-SNAPSHOT-shaded-latest.jar -o $@

%/streetGraph.obj:
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -Xmx12G -jar otp.jar --buildStreet --save $*

build-%: otp.jar %/osm.pbf %/streetGraph.obj %/gtfs.zip
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -Xmx12G -jar otp.jar --loadStreet --save $*

run-%: otp.jar
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -Dlogback.configurationFile=${current_dir}/logback.xml -jar otp.jar --load --serve $*

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

