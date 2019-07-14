
import 'package:flutter/material.dart';

class LabeledIcon extends StatefulWidget {
  
  final String text;
  final IconData icon;
  final double iconSize;
  final TextStyle style;
  final int index;
  int _currentIndex = -1;

  LabeledIcon({
    @required this.index,
    this.text,
    @required this.icon,
    this.iconSize,
    this.style,
  });

  void setCurrentIndex(int curIndex){
    _currentIndex = curIndex;
  }

  @override
  _LabeledIconState createState() => _LabeledIconState();
}

class _LabeledIconState extends State<LabeledIcon> {

  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,      
      children: <Widget>[
        Icon(widget.icon, size: widget.iconSize,),
        
        widget.index != widget._currentIndex
        ? Text(widget.text, style: widget.style,)
        : IgnorePointer(),
      ],
    );
  }
}