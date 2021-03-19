import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'drop_list_model.dart';

class UnitDropDown extends StatefulWidget {
  final OptionItem itemSelected;
  final DropListModel dropListModel;
  final Function(OptionItem optionItem) onOptionSelected;

  UnitDropDown(this.itemSelected, this.dropListModel, this.onOptionSelected);

  @override
  UnitDropDownState createState() =>
      UnitDropDownState(itemSelected, dropListModel);
}

class UnitDropDownState extends State<UnitDropDown>
    with SingleTickerProviderStateMixin {
  OverlayEntry _overlayEntry;
  GlobalObjectKey _globalObjectKey = GlobalObjectKey(
      ValueKey('a_key_that_different_from_any_other')); // ADD THIS LINE
  bool isShow = false;
  final LayerLink _layerLink = LayerLink();
  OptionItem optionItemSelected;
  final DropListModel dropListModel;
  AnimationController expandController;
  Animation<double> animation;

  UnitDropDownState(this.optionItemSelected, this.dropListModel);

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox =
        _globalObjectKey.currentContext?.findRenderObject(); //EDIT THIS LINE
    var buttonSize = renderBox.size;
    var buttonPosition = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
        builder: (context) => Positioned(
            top: buttonPosition.dy + buttonSize.height,
            left: buttonPosition.dx,
            width: buttonSize.width,
            child: SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: animation,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color: Colors.black26,
                            offset: Offset(0, 5))
                      ],
                    ),
                    child: _buildDropListOptions(
                        dropListModel.listOptionItems, context),
                  ),
                ),
              ),
            )));
  }

  @override
  void initState() {
    super.initState();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    expandController.dispose();
    Overlay.of(context).dispose();
    super.dispose();
  }

  void _runExpandCheck() {
    if (isShow && this._overlayEntry != null) {
      this._overlayEntry.remove();
      expandController.reverse();
    } else {
      if (this._overlayEntry == null) {
        this._overlayEntry = this._createOverlayEntry();
      }
      Overlay.of(context).insert(this._overlayEntry);
      expandController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        child: Column(children: [
          Container(
            key: _globalObjectKey,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white30,
            ),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      optionItemSelected.title,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(1, 0),
                  child: Icon(
                    isShow ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.white54,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ]),
        onTap: () {
          setState(() {
            this.isShow = !this.isShow;
            _runExpandCheck();
          });

        });
  }

  Column _buildDropListOptions(List<OptionItem> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context) {
    return GestureDetector(
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey[200], width: 1)),
                 ),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xFF307DF1),
                                fontWeight: FontWeight.w500,fontSize: 14,decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                ],
              ),
            )),

      onTap: () {
        setState(() {
          this.isShow = !this.isShow;
          _runExpandCheck();
        });
        this.optionItemSelected = item;

        expandController.forward();
        widget.onOptionSelected(item);
      },
    );
  }
}
