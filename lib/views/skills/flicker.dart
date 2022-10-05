import 'package:flutter/material.dart';

class FlickerAnimation extends StatefulWidget {
  final Widget iconPath;

  const FlickerAnimation({required this.iconPath});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FlickerAnimation();
  }
}

class _FlickerAnimation extends State<FlickerAnimation>
    with TickerProviderStateMixin {
  late AnimationController popcontroller;
  late Animation<double> scenesize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    popcontroller =  AnimationController(
        duration:const Duration(milliseconds: 250), vsync: this);

    scenesize = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: popcontroller.view,
        curve:const Interval(
          0,
          1,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    scenesize.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        popcontroller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        popcontroller.forward();
      }
    });
    popcontroller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    popcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return onActivityCreate(context);
  }

  onActivityCreate(BuildContext context) {
    // TODO: implement onActivityCreate
    return AnimatedBuilder(
        builder: _buildAnimation, animation: popcontroller);
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return
      AnimatedBuilder(
          animation: popcontroller,
          builder: ((BuildContext context, Widget? child) {
            return Stack(alignment: Alignment.center, children: [
              ScaleTransition(
                  scale: scenesize,
                  child: Image.asset("assets/images/UI/qrscanner.png",width: 180,height: 180,fit: BoxFit.cover,)
              ),
              widget.iconPath
            ]);
          }));
  }
}
