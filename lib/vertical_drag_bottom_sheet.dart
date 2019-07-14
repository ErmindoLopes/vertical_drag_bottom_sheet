import 'package:flutter/material.dart';



class VerticalDragBottomSheet extends StatefulWidget {

  final Widget outerContent;
  final Widget innerContent;
  final Widget bottomBar;
  final Color backGroundColor;
  final Color headerColor;


  VerticalDragBottomSheet({    
    this.backGroundColor = const Color(0xffdedede),
    this.headerColor = const Color(0xffdedede),
    this.bottomBar = const IgnorePointer(),
    this.innerContent = const IgnorePointer(),
    this.outerContent = const IgnorePointer(),
    });

  @override
  _VerticalDragBottomSheetState createState() => _VerticalDragBottomSheetState();
}


class _VerticalDragBottomSheetState extends State<VerticalDragBottomSheet> with SingleTickerProviderStateMixin {
  
  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  double collapsedHeightFactor = 0.91; //
  double expandedHeightFactor = 0.3;
  bool isAnimationCompleted = false;
  double screenHeight = 0;
  double screenWidth = 0;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    collapsedHeightFactor = MediaQuery.of(context).size.height <= 592 
      ? 0.91 
      : 0.95;

    _controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _heightFactorAnimation = new Tween<double>(begin: collapsedHeightFactor, end: expandedHeightFactor).animate(_controller);

  }
  

  @override
  void dispose() { 
    _controller.dispose();
    super.dispose();
  }
  

  void onBottomPartTap(){
    setState(() {
     if(isAnimationCompleted) {
       _controller.reverse();       
     }
     else{
       _controller.forward();       
     }
     isAnimationCompleted = !isAnimationCompleted;
    });
  }


  void _handleVerticalUpdate(DragUpdateDetails  updateDetails){
    double fractionDragged = updateDetails.primaryDelta / screenHeight;
    _controller.value = _controller.value - ((expandedHeightFactor * 5.6666) * fractionDragged); // 0,3 x = 1.7 -> x = 5.6666
  }


  void _handleVerticalEnd(DragEndDetails endDetails){
    if (_controller.value >= 0.5){
      _controller.fling(velocity: 1);
    }
    else{
      _controller.fling(velocity: -1);
    }

  }


  Widget getWidget(){
    
    MediaQueryData mediaQuery = MediaQuery.of(context);
    screenHeight = mediaQuery.size.height;
    screenWidth = mediaQuery.size.width;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[

        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: _heightFactorAnimation.value,
          child: widget.outerContent,
        ),

        GestureDetector(
          onVerticalDragUpdate: _handleVerticalUpdate,
          onVerticalDragEnd: _handleVerticalEnd,
          child: FractionallySizedBox(            
            alignment: Alignment.bottomCenter,
            heightFactor: 1.05 - _heightFactorAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  
                  //header
                  GestureDetector(
                    onTap: onBottomPartTap,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.headerColor,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20)),
                      ),                    
                      height: 20,
                      width: screenWidth,
                      child: Center(
                        child: Icon(
                          _controller.value >= 0.99 ? Icons.arrow_drop_down  :Icons.arrow_drop_up ,
                          color: Colors.black26,),
                      ),
                    ),
                  ),
                  
                  //body
                  Expanded(
                    child: Container(
                      color: widget.backGroundColor,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        fit: StackFit.expand,
                        children: <Widget>[

                          widget.innerContent,

                          Opacity(
                            opacity:  (-1 + _controller.value).abs(),
                            child: IgnorePointer(
                              ignoring: _controller.value == 1,
                              child: widget.bottomBar,
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
               
                ],
              ),
            ),
          ),

        ),

      ],
    );

  }


  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget widget) {
        return getWidget();
      },
    );

  }


}