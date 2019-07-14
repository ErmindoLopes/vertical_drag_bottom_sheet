import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vertical_drag_bottom_sheet/vertical_drag_bottom_sheet.dart';

import 'Library/custom_curved_navigation_bar/custom_curved_navigation_bar.dart';
import 'Library/custom_curved_navigation_bar/src/labeled_icon.dart';






class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    
    

    return Scaffold(  
      backgroundColor: Colors.transparent,      
      body: VerticalDragBottomSheet(
        headerColor: Color(0xffcecece),
        bottomBar: bottomBar(),
        innerContent: innerContent(),
        outerContent: outerContent(),
      ),
    );

  }


  Widget bottomBar(){

    return CustomCurvedNavigationBar(
        //key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <LabeledIcon>[
          LabeledIcon(index:0, icon:Icons.home, text: "Home", iconSize: 30, style: TextStyle(fontSize: 10),),
          LabeledIcon(index:1, icon:Icons.layers, text: "Categorias", iconSize: 30, style: TextStyle(fontSize: 10),),
          LabeledIcon(index:2, icon:Icons.chat, text: "Contato", iconSize: 30, style: TextStyle(fontSize: 10),),
          LabeledIcon(index:3, icon:Icons.person, text: "Conta", iconSize: 30, style: TextStyle(fontSize: 10),),
          LabeledIcon(index:4, icon:Icons.shopping_cart, text: "Carrinho", iconSize: 30, style: TextStyle(fontSize: 10),),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Color(0xffcecece), //Color(0xffD0E4E3),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          
        },

      );
  }

  Widget innerContent(){

    return Container(
      color: Colors.amber.withOpacity(0.2),
      margin: EdgeInsets.all(10),
    );
  }

  Widget outerContent(){
    return Image.asset(
      "assets/images/bg3.jpg",
      fit: BoxFit.cover,
      colorBlendMode: BlendMode.darken,
      color: Colors.black38,
    );
  }

}