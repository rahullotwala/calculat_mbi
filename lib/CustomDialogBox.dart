import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  const CustomDialogBox(
      {Key key, this.title, this.descriptions, this.text, this.img})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPaint(
                    painter: OpenPainter(Colors.lightBlue.shade200),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Underweight",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                  new Expanded(
                    child: Text(
                      "<18",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPaint(
                    painter: OpenPainter(Colors.lightGreenAccent.shade200),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Healthy weight",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                  new Expanded(
                    child: Text(
                      "18.25-24.9",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPaint(
                    painter: OpenPainter(Colors.orange.shade200),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Pre-obesity",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                  new Expanded(
                    child: Text(
                      "25.0-29.9",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPaint(
                    painter: OpenPainter(Colors.redAccent.shade100),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Obesity class |",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                  new Expanded(
                    child: Text(
                      "30.0-34.9",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPaint(
                    painter: OpenPainter(Colors.redAccent.shade100),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Obesity class ||",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                  new Expanded(
                    child: Text(
                      "35.0-39.9",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPaint(
                    painter: OpenPainter(Colors.redAccent.shade100),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Obesity class |||",
                      softWrap: true,
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                  new Expanded(
                    child: Text(
                      "> 40.0",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                    )),
              ),
            ],
          ),
        ), // bottom part
        // top part
      ],
    );
  }
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
    canvas.drawCircle(Offset(8, 0), 5, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
