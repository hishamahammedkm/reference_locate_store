import '../backend/backend.dart';
import '../components/rate_court_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CourtDetailsWidget extends StatefulWidget {
  const CourtDetailsWidget({
    Key key,
    this.court,
  }) : super(key: key);

  final CourtsRecord court;

  @override
  _CourtDetailsWidgetState createState() => _CourtDetailsWidgetState();
}

class _CourtDetailsWidgetState extends State<CourtDetailsWidget> {
  PageController pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CommentsRecord>>(
      stream: queryCommentsRecord(
        queryBuilder: (commentsRecord) =>
            commentsRecord.where('court', isEqualTo: widget.court.reference),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
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
        List<CommentsRecord> courtDetailsCommentsRecordList = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).white,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).background,
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: Image.asset(
                                  'assets/images/classHero.jpg',
                                ).image,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 44, 0, 0),
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0xB2111417),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      buttonSize: 46,
                                      icon: Icon(
                                        Icons.arrow_back_rounded,
                                        color:
                                            FlutterFlowTheme.of(context).white,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  valueOrDefault<String>(
                                    widget.court.name,
                                    'Unnamed Court',
                                  ),
                                  style: FlutterFlowTheme.of(context).title2,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Overall',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 4, 0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              functions.getAverageRating(
                                                  courtDetailsCommentsRecordList
                                                      .toList()),
                                              '-',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .title3,
                                          ),
                                        ),
                                        Icon(
                                          Icons.sports_basketball_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      valueOrDefault<String>(
                                        widget.court.description,
                                        'The best of all 3 worlds, Row & Flow offers high intensity rowing and strength intervals followed by athletic based yoga sure to enhance flexible and clear the mind. Yoga mats are provided but bringing your own yoga mat is highly encouraged.',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.96,
                          height: 200,
                          decoration: BoxDecoration(),
                          child: Builder(
                            builder: (context) {
                              final comments =
                                  courtDetailsCommentsRecordList?.toList() ??
                                      [];
                              if (comments.isEmpty) {
                                return Image.asset(
                                  'assets/images/emptyReviews@3x.png',
                                );
                              }
                              return Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 1,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: PageView.builder(
                                        controller: pageViewController ??=
                                            PageController(
                                                initialPage: min(
                                                    0, comments.length - 1)),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: comments.length,
                                        itemBuilder: (context, commentsIndex) {
                                          final commentsItem =
                                              comments[commentsIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4, 4, 4, 4),
                                            child: StreamBuilder<UsersRecord>(
                                              stream: UsersRecord.getDocument(
                                                  commentsItem.user),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child:
                                                          SpinKitFadingCircle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        size: 50,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final ratingUsersRecord =
                                                    snapshot.data;
                                                return Container(
                                                  width: 100,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 3,
                                                        color:
                                                            Color(0x2E000000),
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .grayLines,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(12,
                                                                    12, 12, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          8,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFEEEEEE),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .person,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .grayDark,
                                                                      size: 24,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    ratingUsersRecord
                                                                        .displayName,
                                                                    'Guest',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle2,
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  'Overall',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1,
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              4,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        commentsItem
                                                                            .courtQualityRating
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .title3,
                                                                      ),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .sports_basketball_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      size: 20,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(12, 0,
                                                                    12, 8),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  AutoSizeText(
                                                                commentsItem
                                                                    .text,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 1),
                                      child: SmoothPageIndicator(
                                        controller: pageViewController ??=
                                            PageController(
                                                initialPage: min(
                                                    0, comments.length - 1)),
                                        count: comments.length,
                                        axisDirection: Axis.horizontal,
                                        onDotClicked: (i) {
                                          pageViewController.animateToPage(
                                            i,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        },
                                        effect: ExpandingDotsEffect(
                                          expansionFactor: 2,
                                          spacing: 8,
                                          radius: 16,
                                          dotWidth: 16,
                                          dotHeight: 4,
                                          dotColor: FlutterFlowTheme.of(context)
                                              .grayLines,
                                          activeDotColor:
                                              FlutterFlowTheme.of(context)
                                                  .grayDark,
                                          paintStyle: PaintingStyle.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x29000000),
                          offset: Offset(0, -1),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                    height: 584,
                                    child: RateCourtWidget(
                                      court: widget.court,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          text: 'Rate Court',
                          icon: Icon(
                            Icons.star_rate_rounded,
                            size: 15,
                          ),
                          options: FFButtonOptions(
                            width: 150,
                            height: 50,
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Overpass',
                                      color: FlutterFlowTheme.of(context).white,
                                      fontWeight: FontWeight.bold,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            await launchURL(
                                functions.getMapUrl(widget.court.location));
                          },
                          text: 'Go Play',
                          icon: Icon(
                            Icons.sports_basketball,
                            size: 15,
                          ),
                          options: FFButtonOptions(
                            width: 150,
                            height: 50,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Overpass',
                                      color: FlutterFlowTheme.of(context).white,
                                      fontWeight: FontWeight.bold,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
