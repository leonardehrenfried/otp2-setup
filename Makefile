.PRECIOUS: %/streetGraph.obj
CURL:=curl -L -\# --fail --create-dirs
current_dir = $(shell pwd)

download: otp.jar

berlin/osm.pbf:
	${CURL} http://download.geofabrik.de/europe/germany/brandenburg-latest.osm.pbf -o $@

berlin/gtfs.zip:
	${CURL} https://www.vbb.de/fileadmin/user_upload/VBB/Dokumente/API-Datensaetze/gtfs-mastscharf/GTFS.zip -o $@

brandenburg/osm.pbf:
	${CURL} http://download.geofabrik.de/europe/germany/brandenburg-latest.osm.pbf -o $@

brandenburg/gtfs.zip:
	echo "no GTFS"

brandenburg/flex.gtfs.zip:
	${CURL} https://github.com/bbnavi/gtfs-flex/releases/download/2022-01-25/gtfs-flex.zip -o $@

herzberg/osm.pbf: berlin/osm.pbf
	mkdir -p berlin
	osmium extract berlin/osm.pbf --polygon herzberg/herzberg.geojson -o $@

herzberg/gtfs.zip:
	#${CURL} https://www.vbb.de/fileadmin/user_upload/VBB/Dokumente/API-Datensaetze/gtfs-mastscharf/GTFS.zip -o $@

angermuende/osm.pbf: berlin/osm.pbf
	osmium extract berlin/osm.pbf --polygon angermuende/angermuende.geojson -o $@

angermuende/gtfs.zip:
	${CURL} https://github.com/bbnavi/gtfs-flex/releases/download/2022-01-25/gtfs-flex.zip -o $@

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
	${CURL} https://gtfs.mfdz.de/hbg6.merged.with_flex.gtfs.zip -o $@

stuttgart/osm.pbf:
	mkdir -p stuttgart
	${CURL} https://download.geofabrik.de/europe/germany/baden-wuerttemberg/stuttgart-regbez-latest.osm.pbf -o $@

reutlingen/gtfs.zip:
	echo "none"

reutlingen/osm.pbf:
	mkdir -p reutlingen
	${CURL} https://download.geofabrik.de/europe/germany/baden-wuerttemberg/tuebingen-regbez-latest.osm.pbf -o $@

bawue/gtfs.zip:
	${CURL} https://leonard.io/otp/bwgesamt.tidy.gtfs.zip -o $@

bawue/osm.pbf:
	${CURL} https://download.geofabrik.de/europe/germany/baden-wuerttemberg-latest.osm.pbf -o $@

bedford/gtfs.zip:
	${CURL} https://leonard.io/trillium/stagecoach-midlands-2022-08-30.gtfs.zip -o $@

bedford/osm.pbf:
	${CURL} https://download.geofabrik.de/europe/great-britain/england/bedfordshire-latest.osm.pbf -o $@

slovenia/osm.pbf:
	echo "none"

slovenia/gtfs.zip:
	echo "none"de

norway/osm.pbf:
	mkdir -p norway
	${CURL} https://download.geofabrik.de/europe/norway-latest.osm.pbf -o $@

norway/rb_norway-aggregated-netex.zip:
	${CURL} https://storage.googleapis.com/marduk-production/outbound/netex/rb_norway-aggregated-netex.zip -o $@

norway/gtfs.zip: norway/rb_norway-aggregated-netex.zip
	echo "No GTFS, but Netex instead."

germany/gtfs.zip:
	echo "No GTFS, but Netex instead."

germany/osm.pbf:
	mkdir -p germany
	${CURL} https://download.geofabrik.de/europe/germany/hamburg-latest.osm.pbf -o $@

britain/osm.pbf:
	${CURL} https://download.geofabrik.de/europe/great-britain-latest.osm.pbf -o $@

britain/gtfs.zip:
	echo "No GTFS."

drammen/osm.pbf: norway/osm.pbf
	osmium extract norway/osm.pbf --polygon drammen/drammen.geojson -o $@

drammen/rb_bra_aggregate-netex.zip:
	#${CURL} https://storage.googleapis.com/marduk-production/outbound/netex/rb_bra-aggregated-netex.zip -o $@

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
	${CURL} https://dev-api.digitransit.fi/routing-data/v3/hsl/HSL-gtfs.zip -o $@

helsinki/osm.pbf: finland/osm.pbf
	osmium extract finland/osm.pbf --polygon helsinki/helsinki.geojson -o $@

tampere/gtfs.zip:
	echo "no gtfs"

tampere/osm.pbf: finland/osm.pbf
	osmium extract finland/osm.pbf --polygon tampere/tampere.geojson -o $@

northumberland/gtfs.zip:
	echo "no gtfs"

northumberland/osm.pbf:
	echo "no OSM"

## America

massachusetts/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/us/massachusetts-latest.osm.pbf -o $@

georgia/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/us/georgia-latest.osm.pbf -o $@

colorado/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/us/colorado-latest.osm.pbf -o $@

texas/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/us/texas-latest.osm.pbf -o $@

california/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/us/california-latest.osm.pbf -o $@

pennsylvania/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/us/pennsylvania-latest.osm.pbf -o $@

oregon/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/us/oregon-latest.osm.pbf -o $@

maryland/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/us/maryland-latest.osm.pbf -o $@

washington/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/us/washington-latest.osm.pbf -o $@

minnesota/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/us/minnesota-latest.osm.pbf -o $@

aspen/osm.pbf: colorado/osm.pbf
	osmium extract colorado/osm.pbf --polygon aspen/aspen.geojson -o $@

aspen/gtfs.zip: aspen/osm.pbf
	${CURL} https://raw.githubusercontent.com/MobilityData/gtfs-flex/master/spec/FlexExample--on-demand-service.zip -o $@

cripple-creek/osm.pbf: colorado/osm.pbf
	osmium extract colorado/osm.pbf --polygon cripple-creek/cripple-creek.geojson -o $@

cripple-creek/gtfs.zip: cripple-creek/osm.pbf
	${CURL} https://raw.githubusercontent.com/MobilityData/gtfs-flex/master/spec/FlexExample--same-day-service.zip -o $@

boston/osm.pbf: massachusetts/osm.pbf
	osmium extract massachusetts/osm.pbf --polygon boston/boston.geojson -o $@

boston/mtba.gtfs.zip:
	${CURL} https://cdn.mbta.com/MBTA_GTFS.zip -o $@
	zip -d $@ facilities_properties.txt
	zip -d $@ facilities.txt

boston/gtfs.zip: boston/mtba.gtfs.zip boston/osm.pbf
	${CURL} https://raw.githubusercontent.com/MobilityData/gtfs-flex/master/spec/FlexExample--various.zip -o $@

houston/osm.pbf: texas/osm.pbf
	osmium extract texas/osm.pbf --polygon houston/houston.geojson -o $@

houston/gtfs.zip:
	${CURL} https://ridemetro-api.ibi-transit.com/download/liveGTFS.zip -o $@

cobb/osm.pbf: georgia/osm.pbf
	osmium extract georgia/osm.pbf --polygon cobb/cobb-county.geojson -o $@

cobb/osm.filtered.pbf: cobb/osm.pbf
	osmium tags-filter cobb/osm.pbf w/highway w/public_transport=platform w/railway=platform w/park_ride=yes r/type=restriction r/type=route -o $@ -f pbf,add_metadata=false --overwrite

cobb/cobblinc.gtfs.zip:
	${CURL} https://www.arcgis.com/sharing/rest/content/items/1ce8e370a12c41b5854d8baa21f8451c/data -o $@

cobb/gtfs.zip: cobb/osm.pbf cobb/cobblinc.gtfs.zip
	${CURL} https://leonard.io/ibi/cobblinc-flex-with-farezones.zip -o $@

atlanta/osm.pbf: georgia/osm.pbf
	osmium extract georgia/osm.pbf --polygon atlanta/atlanta.geojson -o $@

atlanta/gtfs.zip:
	echo "nothing"

seattle/gtfs.zip:
	${CURL} "https://picsapi.commtrans.org/download/liveGTFS.zip" -o $@

seattle/osm.pbf: washington/osm.pbf
	osmium extract washington/osm.pbf --polygon seattle/seattle.geojson -o $@

hopelink/gtfs.zip:
	echo "none"

hopelink/osm.pbf: washington/osm.pbf
	osmium extract washington/osm.pbf --polygon hopelink/hopelink.geojson -o $@

snow-goose/gtfs.zip:
	echo "Downloaded by OTP"

snow-goose/osm.pbf: washington/osm.pbf
	osmium extract washington/osm.pbf --polygon snow-goose/tiny.geojson -o $@

noco/gtfs.zip:
	${CURL} https://leonard.io/ibi/ride-noco.gtfs.zip -o $@

noco/osm.pbf: washington/osm.pbf
	osmium extract washington/osm.pbf --polygon seattle/seattle.geojson -o $@

denver/easyride.gtfs.zip:
	${CURL} https://data.trilliumtransit.com/gtfs/broomfield-co-us/broomfield-co-us--flex-v2.zip -o $@

denver/gtfs.zip: denver/easyride.gtfs.zip
	${CURL} https://www.rtd-denver.com/files/gtfs/google_transit.zip -o $@

denver/osm.pbf: colorado/osm.pbf
	osmium extract colorado/osm.pbf --polygon denver/denver.geojson -o $@

mexico/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/mexico-latest.osm.pbf -o $@

san-joaquin/gtfs.zip:
	echo ""

san-joaquin/osm.pbf: california/osm.pbf
	osmium extract california/osm.pbf --polygon san-joaquin/turlock.geojson -o $@

baltimore/gtfs.zip:
	${CURL} https://mdotmta-gtfs.s3.amazonaws.com/mdotmta_gtfs_metro.zip -o $@

baltimore/osm.pbf: maryland/osm.pbf
	osmium extract maryland/osm.pbf --polygon baltimore/baltimore.geojson -o $@

minneapolis/gtfs.zip:
	${CURL} https://leonard.io/ibi/minneapolis-flex.gtfs.zip -o $@

minneapolis/osm.pbf: minnesota/osm.pbf
	osmium extract minnesota/osm.pbf --polygon minneapolis/minneapolis.geojson -o $@

septa/gtfs.zip:
	echo "none"

septa/osm.pbf: pennsylvania/osm.pbf
	osmium extract pennsylvania/osm.pbf --polygon septa/septa.geojson -o $@

oklahoma-city/gtfs.zip:
	echo "no gtfs"

oklahoma-city/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/us/oklahoma-latest.osm.pbf -o $@

portland/gtfs.zip:
	echo "none"

portland/osm.pbf: oregon/osm.pbf
	osmium extract oregon/osm.pbf --polygon portland/portland.geojson -o $@

pierce-county/gtfs.zip:
	echo "none"

pierce-county/osm.pbf:
	echo "none"

pierce-county/osm.pbf:
	echo "none"

british-columbia/osm.pbf:
	${CURL} https://download.geofabrik.de/north-america/canada/british-columbia-latest.osm.pbf -o $@

vancouver/gtfs.zip:
	echo "none"

vancouver/osm.pbf: british-columbia/osm.pbf
	osmium extract british-columbia/osm.pbf --polygon vancouver/vancouver.geojson -o $@

mexico-city/gtfs.zip:
	${CURL} https://datos.cdmx.gob.mx/dataset/75538d96-3ade-4bc5-ae7d-d85595e4522d/resource/32ed1b6b-41cd-49b3-b7f0-b57acb0eb819/download/gtfs.zip -o $@

mexico-city/osm.pbf: mexico/osm.pbf mexico-city/gtfs.zip
	osmium extract mexico/osm.pbf --polygon mexico-city/mexico-city.geojson -o $@

australia/osm.pbf:
	${CURL} https://download.geofabrik.de/australia-oceania/australia-latest.osm.pbf -o $@

sydney/gtfs.zip:
	${CURL} https://leonard.io/otp/full_greater_sydney_gtfs_static.zip -o $@
	zip -d $@ notes.txt

sydney/osm.pbf: australia/osm.pbf sydney/gtfs.zip
	osmium extract australia/osm.pbf --polygon sydney/new-south-wales.geojson -o $@

otp.jar:
	${CURL} https://otp.leonard.io/snapshots/2.5.0-SNAPSHOT/otp-2.5.0-SNAPSHOT-shaded-latest.jar -o $@

%/streetGraph.obj: %/osm.pbf
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -Xmx36G -jar otp.jar --buildStreet --save $*

build-%: otp.jar %/streetGraph.obj %/gtfs.zip
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -Dlogback.configurationFile=${current_dir}/logback.xml -Xmx50G -jar otp.jar --loadStreet --save $*

run-%: otp.jar
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -XX:+HeapDumpOnOutOfMemoryError -Xmx10G -Dlogback.configurationFile=${current_dir}/logback.xml -jar otp.jar --load --serve $*

build-nogtfs-%: otp.jar
	java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -Xmx36G -jar otp.jar --build --save $*

build-otp:
	cd ../OpenTripPlanner/ && \
		mvn clean package -Dmaven.test.skip -P prettierSkip && cp target/otp-*-SNAPSHOT-shaded.jar ../otp2-setup/otp.jar

clean-all:
	find . -name osm.pbf -print -exec rm {} \;
	find . -name gtfs.zip -print -exec rm {} \;
	find . -name graph.obj -print -exec rm {} \;
	find . -name streetGraph.obj -print -exec rm {} \;
	rm -f otp.jar

clean-%:
	find $* -name *gtfs.zip -print -exec rm {} \;
	find $* -name graph.obj -print -exec rm {} \;
	find $* -name streetGraph.obj -print -exec rm {} \;
	find $* -name osm.pbf -print -exec rm {} \;
	find $* -name *netex.zip -print -exec rm {} \;

