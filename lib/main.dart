import 'dart:ffi';
import 'dart:ui';

import 'package:calculat_mbi/drop_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:share/share.dart';
import 'dart:math';
import 'CustomDialogBox.dart';
import 'UnitDropDown.dart';

import 'package:package_info/package_info.dart';

void main() {
  runApp(CalBMI());
}

OptionItem dropdownValue = OptionItem(id: '1', title: 'feet & inches');
OptionItem dropdownValue2 = OptionItem(id: '1', title: 'Pounds');
final FeetController = TextEditingController();
final Inchesontroller = TextEditingController();
final CentimetresController = TextEditingController();
final PoundsController = TextEditingController();
final KilogramController = TextEditingController();
final StonesController = TextEditingController();
bool visibilityFeet = true;
bool visibilityCen = false;
bool visibilityStone = false;
double m = 0;
// ignore: non_constant_identifier_names
double Bmi;
int step = 0;
double _size;



class CalBMI extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Calculate BMI",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            canvasColor: Colors.transparent,
            bottomSheetTheme:
                BottomSheetThemeData(backgroundColor: Colors.black54)),
        home: MainBody());
  }
}

class MainBody extends StatefulWidget {
  @override
  MainBodyWidget createState() => MainBodyWidget();
}

class MainBodyWidget extends State {
  List<OptionItem> spinnerItems = <OptionItem>[
    OptionItem(id: '1', title: 'feet & inches'),
    OptionItem(id: '2', title: 'Centimetres'),
  ];
  List<OptionItem> spinnerItems2 = <OptionItem>[
    OptionItem(id: '1', title: 'Pounds'),
    OptionItem(id: '2', title: 'Kilogram'),
    OptionItem(id: '3', title: 'Stones'),
  ];
  bool pressed = false;
  Color Bgcolor;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey btnKey2 = GlobalKey();
  PackageInfo _packageInfo = PackageInfo(
    packageName: 'com.cal.calculat_mbi',

  );
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    _size = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text(
            "Calculate MBI",
            style: TextStyle(fontSize: 22),
          ),
          elevation: 0,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh_rounded),
                onPressed: () {
                  _resetAll();
                }),
            PopupMenuButton(
              itemBuilder: (BuildContext bc) => [
                PopupMenuItem(
                    child: Text(
                      "Share this app",
                      style: TextStyle(
                        color: Color(0xFF307DF1),
                      ),
                    ),
                    value: 1),
                PopupMenuItem(
                    child: Text(
                      "more",
                      style: TextStyle(
                        color: Color(0xFF307DF1),
                      ),
                    ),
                    value: 2),
              ],
              onSelected: (route) {
                if (route == 1) {
                  Share.share("https://play.google.com/store/apps/details?id="+_packageInfo.packageName);
                }
                if (route == 2) {
                  print("more");
                  // Navigator.pushNamed(context, route);
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey, //assigning key to form

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Height:",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: visibilityFeet,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5.0, top: 8.0, right: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: 5.0, left: 8.0, right: 8.0),
                                    width: _size * 0.25,
                                    height: 60,
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: Colors.white30,
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: FeetController,
                                      validator: (value) {
                                        if (value.isEmpty && visibilityFeet ||
                                            visibilityStone) {
                                          return 'Please enter feet!';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Feet",
                                        labelStyle: TextStyle(
                                          color: Colors.white54,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white54),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white54),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white54),
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      cursorColor: Colors.white54,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5.0, top: 8.0, right: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: 5.0, left: 8.0, right: 8.0),
                                    width: _size * 0.25,
                                    height: 60,
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: Colors.white30,
                                    ),
                                    child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: Inchesontroller,
                                        validator: (value) {
                                          if (value.isEmpty &&
                                                  visibilityFeet &&
                                                  FeetController
                                                      .text.isNotEmpty ||
                                              visibilityStone) {
                                            return 'Please enter Inches!';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Inches",
                                          labelStyle: TextStyle(
                                            color: Colors.white54,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white54),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white54),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white54),
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        cursorColor: Colors.white54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: visibilityCen,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5.0, top: 8.0, right: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: 5.0, left: 8.0, right: 8.0),
                                    width: _size * 0.33,
                                    height: 60,
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: Colors.white30,
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: CentimetresController,
                                      validator: (value) {
                                        if (value.isEmpty && visibilityCen) {
                                          return 'Please enter Inches!';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Centimetres",
                                        labelStyle: TextStyle(
                                          color: Colors.white54,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white54),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white54),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white54),
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      cursorColor: Colors.white54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0, top: 8.0),
                                child: Container(
                                    width: _size * 0.33,
                                    child: UnitDropDown(
                                      dropdownValue,
                                      DropListModel(spinnerItems),
                                      (optionItem) {
                                        setState(() {
                                          dropdownValue = optionItem;
                                          if (optionItem.title ==
                                              'feet & inches') {
                                            visibilityFeet = true;
                                            visibilityCen = false;
                                            visibilityStone = false;
                                            dropdownValue2 = OptionItem(
                                                id: '1', title: 'Pounds');
                                          }
                                          if (optionItem.title ==
                                              "Centimetres") {
                                            visibilityFeet = false;
                                            visibilityCen = true;
                                            visibilityStone = false;
                                            dropdownValue2 = OptionItem(
                                                id: '2', title: 'Kilogram');
                                          }
                                        });
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 8.0),
                            child: Text(
                              "Weight:",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Visibility(
                                visible: visibilityFeet,
                                child: Row(
                                  children: [
                                    Visibility(
                                      visible: visibilityStone,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: 5.0,
                                                left: 8.0,
                                                right: 8.0),
                                            width: _size * 0.25,
                                            height: 60,
                                            decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10)),
                                              color: Colors.white30,
                                            ),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: StonesController,
                                              validator: (value) {
                                                if (value.isEmpty &&
                                                    visibilityFeet &&
                                                    visibilityStone) {
                                                  return 'Please enter Stone!';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: "Stones",
                                                labelStyle: TextStyle(
                                                  color: Colors.white54,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white54),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white54),
                                                ),
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white54),
                                                ),
                                              ),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              cursorColor: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: visibilityStone
                                          ? EdgeInsets.only(left: 8.0)
                                          : EdgeInsets.only(left: 0.0),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: 5.0, left: 8.0, right: 8.0),
                                        width: visibilityStone
                                            ? _size * 0.25
                                            : _size * 0.33,
                                        height: 60,
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          color: Colors.white30,
                                        ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: PoundsController,
                                          validator: (value) {
                                            if (value.isEmpty &&
                                                    visibilityFeet ||
                                                visibilityStone) {
                                              return 'Please enter Pounds!';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Pounds",
                                            labelStyle: TextStyle(
                                              color: Colors.white54,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white54),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white54),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white54),
                                            ),
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          cursorColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Visibility(
                                visible: visibilityCen,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: 5.0, left: 8.0, right: 8.0),
                                      width: _size * 0.33,
                                      height: 60,
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        color: Colors.white30,
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: KilogramController,
                                        validator: (value) {
                                          if (value.isEmpty && visibilityCen) {
                                            return 'Please enter Kilogram!';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Kilogram",
                                          labelStyle: TextStyle(
                                            color: Colors.white54,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white54),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white54),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white54),
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        cursorColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  width: _size * 0.33,
                                  child: Center(
                                      child: UnitDropDown(
                                    dropdownValue2,
                                    DropListModel(spinnerItems2),
                                    (optionItem) {
                                      setState(() {
                                        dropdownValue2 = optionItem;
                                        if (optionItem.title
                                            .contains('Kilogram')) {
                                          dropdownValue = OptionItem(
                                              id: '2', title: 'Centimetres');
                                          visibilityCen = true;
                                          visibilityFeet = false;
                                          visibilityStone = false;
                                        }
                                        if (optionItem.title
                                            .contains("Pounds")) {
                                          dropdownValue = OptionItem(
                                              id: '1', title: 'feet & inches');
                                          visibilityFeet = true;
                                          visibilityCen = false;
                                          visibilityStone = false;
                                        }
                                        if (optionItem.title
                                            .contains('Stones')) {
                                          dropdownValue = OptionItem(
                                              id: '1', title: 'feet & inches');
                                          visibilityFeet = true;
                                          visibilityCen = false;
                                          visibilityStone = true;
                                        }
                                      });
                                    },
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                shape: StadiumBorder(),
                                color: Colors.white,
                                elevation: 0,
                                onPressed: () {
                                  setState(() {
                                    pressed = true;
                                    if (_formKey.currentState.validate()) {
                                      if (visibilityFeet && !visibilityStone) {
                                        m = (double.parse(FeetController.text) *
                                                12.000) +
                                            (double.parse(
                                                Inchesontroller.text));
                                        Bmi = 703 *
                                            (double.parse(
                                                    PoundsController.text) /
                                                pow(m, 2));
                                        Bmi = roundDouble(Bmi, 1);
                                      }
                                      if (!visibilityFeet && !visibilityStone) {
                                        m = (double.parse(
                                                CentimetresController.text) *
                                            0.39360);
                                        Bmi = 703 *
                                            ((double.parse(KilogramController
                                                        .text) /
                                                    0.45359237) /
                                                (m * m));
                                        Bmi = roundDouble(Bmi, 1);
                                      }
                                      if (visibilityFeet && visibilityStone) {
                                        m = (double.parse(FeetController.text) *
                                                12.000) +
                                            (double.parse(
                                                Inchesontroller.text));
                                        Bmi = 703 *
                                            ((double.parse(
                                                        PoundsController.text) +
                                                    (double.parse(
                                                            StonesController
                                                                .text) *
                                                        14.000)) /
                                                pow(m, 2));
                                        Bmi = roundDouble(Bmi, 1);
                                      }
                                      if (Bmi < 18.60) {
                                        Bgcolor = Colors.lightBlue.shade200;
                                      }
                                      if (Bmi >= 18.60 && Bmi <= 24.99) {
                                        Bgcolor =
                                            Colors.lightGreenAccent.shade200;
                                      }
                                      if (Bmi >= 25.00 && Bmi <= 29.99) {
                                        Bgcolor = Colors.orange.shade200;
                                      }
                                      if (Bmi >= 33.00 && Bmi <= 34.99) {
                                        Bgcolor = Colors.redAccent.shade100;
                                      }
                                      if (Bmi >= 35.00 && Bmi <= 39.99) {
                                        Bgcolor = Colors.redAccent.shade100;
                                      }
                                      if (Bmi >= 40.00 && Bmi <= 100) {
                                        Bgcolor = Colors.redAccent.shade100;
                                      }
                                      _modalBottomSheetMenu(Bmi, Bgcolor);
                                    } else {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Please fill all Value")));
                                    }
                                  });
                                },
                                textColor: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "CALCULATE BMI",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void _modalBottomSheetMenu(double bmi, Color color) {
    double _bmi;
    _bmi = bmi;
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        context: context,
        isDismissible: true,
        builder: (builder) {
          return new Container(
            height: 250.0,
            color: Colors.transparent,
            //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                      ),
                    ],
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(15.0),
                        topRight: const Radius.circular(15.0))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      AppBar(
                        title: Text(
                          "Your BMI score",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        actions: <Widget>[
                          IconButton(
                              icon: Icon(Icons.share_rounded),
                              color: Colors.black54,
                              onPressed: () {
                                Share.share("My BMI is $_bmi" + ".");
                              }),
                          IconButton(
                              icon: Icon(Icons.info_outline_rounded),
                              color: Colors.black54,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialogBox(
                                        title: 'Info',
                                        descriptions:
                                            "BMI is a useful measurement for most people over 20 years.The result is an estimate and should be considered as a rough guide only as it dose not take into account age, gender, ethnicity or body composition.",
                                        text: "Ok",
                                      );
                                    });
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: new Container(
                              width: _size * 0.3,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: color,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    '$_bmi',
                                    style: TextStyle(
                                        fontSize: 40, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Your category:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  if (_bmi < 18.60)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 5.0),
                                      child: Row(
                                        children: [
                                          CustomPaint(
                                            painter: OpenPainter(color),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 25.0),
                                            child: Text(
                                              "Underweight",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (_bmi >= 18.60 && _bmi <= 24.99)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 5.0),
                                      child: Row(
                                        children: [
                                          CustomPaint(
                                            painter: OpenPainter(color),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 25.0),
                                            child: Text(
                                              "Normal",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (_bmi >= 25.00 && _bmi <= 29.99)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 5.0),
                                      child: Row(
                                        children: [
                                          CustomPaint(
                                            painter: OpenPainter(color),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 25.0),
                                            child: Text(
                                              "Overweight",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (_bmi >= 33.00 && _bmi <= 34.99)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 5.0),
                                      child: Row(
                                        children: [
                                          CustomPaint(
                                            painter: OpenPainter(color),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 25.0),
                                            child: Text(
                                              "Obesity class 1",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (_bmi >= 35.00 && _bmi <= 39.99)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 5.0),
                                      child: Row(
                                        children: [
                                          CustomPaint(
                                            painter: OpenPainter(color),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 25.0),
                                            child: Text(
                                              "Obesity class 2",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (_bmi >= 40.00 && _bmi <= 100)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 5.0),
                                      child: Row(
                                        children: [
                                          CustomPaint(
                                            painter: OpenPainter(color),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 25.0),
                                            child: Text(
                                              "Obesity class 3",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (_bmi < 18.60)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: _size * 0.88,
                                child: Column(
                                  children: [
                                    Text(
                                      "Your BMI of less then 18.5 indicates that you are underweight, so you may need to put on some weight.Your are recommended to ask your doctor or dietitian for advice.",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (_bmi >= 18.60 && _bmi <= 24.99)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: _size * 0.88,
                                child: Column(
                                  children: [
                                    Text(
                                      "Congratulation! Your BMI indicates that you are at healty weight. By maintaining ahealth weight,you lower your risk of developing serious health problems.",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (_bmi >= 25.00 && _bmi <= 29.99)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: _size * 0.88,
                                child: Column(
                                  children: [
                                    Text(
                                      "Your BMI of 25-29.9 indicates that you are slightly overweight. Your may be advice to lose some weight for health reasons.You are recommended to ask your doctor or dietitian for advice.",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (_bmi >= 33.00 && _bmi <= 34.99)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: _size * 0.88,
                                child: Column(
                                  children: [
                                    Text(
                                      "Your BMI of over 30 indicates that you are heavily overweight. Your health may be at risk if you do not lose weight.You are recommended to ask your doctor or dietitian for advice.",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (_bmi >= 35.00 && _bmi <= 39.99)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: _size * 0.88,
                                child: Column(
                                  children: [
                                    Text(
                                      "Your BMI of over 30 indicates that you are heavily overweight. Your health may be at risk if you do not lose weight.You are recommended to ask your doctor or dietitian for advice.",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (_bmi >= 40.00 && _bmi <= 100)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: _size * 0.88,
                                child: Column(
                                  children: [
                                    Text(
                                      "Your BMI of over 30 indicates that you are heavily overweight. Your health may be at risk if you do not lose weight.You are recommended to ask your doctor or dietitian for advice.",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

void _resetAll() {
  FeetController.clear();
  Inchesontroller.clear();
  CentimetresController.clear();
  PoundsController.clear();
  KilogramController.clear();
  StonesController.clear();
}

class OpenPainter extends CustomPainter {
  Color color;

  OpenPainter(Color color) {
    this.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(Offset(13, 0), 5, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
