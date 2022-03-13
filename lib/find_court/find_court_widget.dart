import '../add_court/add_court_widget.dart';
import '../backend/backend.dart';
import '../court_details/court_details_widget.dart';
import '../flutter_flow/flutter_flow_google_map.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class FindCourtWidget extends StatefulWidget {
  const FindCourtWidget({Key key}) : super(key: key);

  @override
  _FindCourtWidgetState createState() => _FindCourtWidgetState();
}

class _FindCourtWidgetState extends State<FindCourtWidget> {
  LatLng currentUserLocationValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng googleMapsCenter;
  Completer<GoogleMapController> googleMapsController;
  List<CourtsRecord> algoliaSearchResults1 = [];
  TextEditingController courtSearchFieldController;
  List<CourtsRecord> algoliaSearchResults2 = [];

  @override
  void initState() {
    super.initState();
    courtSearchFieldController = TextEditingController();
    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserLocationValue == null) {
      return Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: SpinKitFadingCircle(
            color: FlutterFlowTheme.of(context).primaryColor,
            size: 50,
          ),
        ),
      );
    }
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        elevation: 8,
        child: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          buttonSize: 48,
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                duration: Duration(milliseconds: 250),
                reverseDuration: Duration(milliseconds: 250),
                child: AddCourtWidget(),
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          FlutterFlowGoogleMap(
            controller: googleMapsController,
            onCameraIdle: (latLng) => googleMapsCenter = latLng,
            initialLocation: googleMapsCenter ??=
                functions.getInitialMapLocation(currentUserLocationValue),
            markers: (algoliaSearchResults1 ?? [])
                .map(
                  (algoliaSearchResults1Item) => FlutterFlowMarker(
                    algoliaSearchResults1Item.reference.path,
                    algoliaSearchResults1Item.location,
                    () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 300),
                          reverseDuration: Duration(milliseconds: 300),
                          child: CourtDetailsWidget(
                            court: algoliaSearchResults1Item,
                          ),
                        ),
                      );
                    },
                  ),
                )
                .toList(),
            markerColor: GoogleMarkerColor.violet,
            mapType: MapType.normal,
            style: GoogleMapStyle.standard,
            initialZoom: 14,
            allowInteraction: true,
            allowZoom: true,
            showZoomControls: false,
            showLocation: true,
            showCompass: false,
            showMapToolbar: false,
            showTraffic: false,
            centerMapOnMarkerTap: true,
          ),
          Align(
            alignment: AlignmentDirectional(-1, -1),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    FlutterFlowTheme.of(context).white,
                    Color(0x00FFFFFF)
                  ],
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, -1),
                  end: AlignmentDirectional(0, 1),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, -0.8),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x34000000),
                      offset: Offset(0, 1),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).grayLines,
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, -0.3),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: TextFormField(
                      onFieldSubmitted: (_) async {
                        currentUserLocationValue = await getCurrentUserLocation(
                            defaultLocation: LatLng(0.0, 0.0));
                        setState(() => algoliaSearchResults1 = null);
                        await CourtsRecord.search(
                          term: valueOrDefault<String>(
                            courtSearchFieldController.text,
                            '*',
                          ),
                          location: getCurrentUserLocation(
                              defaultLocation:
                                  LatLng(37.4298229, -122.1735655)),
                        )
                            .then((r) => algoliaSearchResults1 = r)
                            .onError((_, __) => algoliaSearchResults1 = [])
                            .whenComplete(() => setState(() {}));
                      },
                      controller: courtSearchFieldController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Search for courts...',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).subtitle2.override(
                            fontFamily: 'Overpass',
                            color: FlutterFlowTheme.of(context).iconGray,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.75, -0.92),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 8),
              child: Text(
                'Find a Court',
                style: FlutterFlowTheme.of(context).title2,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.89, -0.77),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.search_outlined,
                color: FlutterFlowTheme.of(context).primaryColor,
                size: 30,
              ),
              onPressed: () async {
                setState(() => algoliaSearchResults2 = null);
                await CourtsRecord.search(
                  term: courtSearchFieldController.text,
                )
                    .then((r) => algoliaSearchResults2 = r)
                    .onError((_, __) => algoliaSearchResults2 = [])
                    .whenComplete(() => setState(() {}));
              },
            ),
          ),
        ],
      ),
    );
  }
}
