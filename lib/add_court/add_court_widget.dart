import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../court_added_success/court_added_success_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_place_picker.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/place.dart';
import '../flutter_flow/upload_media.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCourtWidget extends StatefulWidget {
  const AddCourtWidget({Key key}) : super(key: key);

  @override
  _AddCourtWidgetState createState() => _AddCourtWidgetState();
}

class _AddCourtWidgetState extends State<AddCourtWidget> {
  String uploadedFileUrl = '';
  TextEditingController textController1;
  TextEditingController textController2;
  var placePickerValue = FFPlace();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          buttonSize: 48,
          icon: Icon(
            Icons.chevron_left_rounded,
            color: FlutterFlowTheme.of(context).darkBG,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Court',
          style: FlutterFlowTheme.of(context).title3,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).background,
                    ),
                    child: InkWell(
                      onTap: () async {
                        final selectedMedia =
                            await selectMediaWithSourceBottomSheet(
                          context: context,
                          allowPhoto: true,
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryColor,
                          textColor: FlutterFlowTheme.of(context).primaryColor,
                          pickerFontFamily: 'Overpass',
                        );
                        if (selectedMedia != null &&
                            validateFileFormat(
                                selectedMedia.storagePath, context)) {
                          showUploadMessage(
                            context,
                            'Uploading file...',
                            showLoading: true,
                          );
                          final downloadUrl = await uploadData(
                              selectedMedia.storagePath, selectedMedia.bytes);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          if (downloadUrl != null) {
                            setState(() => uploadedFileUrl = downloadUrl);
                            showUploadMessage(
                              context,
                              'Success!',
                            );
                          } else {
                            showUploadMessage(
                              context,
                              'Failed to upload media',
                            );
                            return;
                          }
                        }
                      },
                      child: Image.asset(
                        'assets/images/coverEmpty@3x.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                      child: TextFormField(
                        controller: textController1,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Court Name',
                          labelStyle: FlutterFlowTheme.of(context)
                              .title3
                              .override(
                                fontFamily: 'Overpass',
                                color: FlutterFlowTheme.of(context).iconGray,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                          hintText: 'Court Name...',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).grayLines,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).grayLines,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).title3.override(
                              fontFamily: 'Overpass',
                              color: FlutterFlowTheme.of(context).darkBG,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                      child: TextFormField(
                        controller: textController2,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Overpass',
                                color: FlutterFlowTheme.of(context).iconGray,
                                fontSize: 15,
                              ),
                          hintText: 'Saturdays at noon',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).grayLines,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).grayLines,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Overpass',
                              color: FlutterFlowTheme.of(context).darkBG,
                              fontSize: 15,
                            ),
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).white,
                        boxShadow: [
                          BoxShadow(
                            color: FlutterFlowTheme.of(context).grayLines,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 30),
                            child: FlutterFlowPlacePicker(
                              iOSGoogleMapsApiKey:
                                  'AIzaSyB_XCmOYrcxXJuHAhV1_Wa7-dZPKeWLOSU',
                              androidGoogleMapsApiKey:
                                  'AIzaSyBSISpWvgysJZiy7swSX4iMW2ZzhEnX_jc',
                              webGoogleMapsApiKey:
                                  'AIzaSyA1ueZZk3yFiGnH65c_oJ_GwbPV7ERnmWw',
                              onSelect: (place) =>
                                  setState(() => placePickerValue = place),
                              defaultText: 'Set Location',
                              icon: Icon(
                                Icons.place,
                                color: FlutterFlowTheme.of(context).iconGray,
                                size: 24,
                              ),
                              buttonOptions: FFButtonOptions(
                                width: 240,
                                height: 50,
                                color: FlutterFlowTheme.of(context).background,
                                textStyle: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Overpass',
                                      color:
                                          FlutterFlowTheme.of(context).iconGray,
                                      fontWeight: FontWeight.normal,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: FFButtonWidget(
                        onPressed: () async {
                          final courtsCreateData = createCourtsRecordData(
                            name: textController1.text,
                            location: placePickerValue.latLng,
                            createdAt: getCurrentTimestamp,
                            user: currentUserReference,
                            description: textController2.text,
                            likes: 0,
                            imageUrl: uploadedFileUrl,
                          );
                          await CourtsRecord.collection
                              .doc()
                              .set(courtsCreateData);
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourtAddedSuccessWidget(),
                            ),
                          );
                        },
                        text: 'Add Court',
                        icon: Icon(
                          Icons.sports_basketball_outlined,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          width: 290,
                          height: 50,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).title3.override(
                                    fontFamily: 'Overpass',
                                    color: FlutterFlowTheme.of(context).white,
                                  ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
