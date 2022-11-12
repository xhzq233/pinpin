import 'package:flutter/material.dart';

class SlideAnimation extends StatelessWidget {

  final String path;

  const SlideAnimation({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Center(
          child: SlideVerify(
            sliderImage: path,
            successText: null,
            initText: null,
          ),
        ),
      );
  }
}

class SlideVerify extends StatefulWidget {
  final double height;
  final double width;
  final Color borderColor;
  final Color bgColor;
  final Color moveColor;
  final String? successText;
  final String? sliderImage;
  final String? initText;
  final String? initImage;
  final TextStyle successTextStyle;
  final TextStyle initTextStyle;
  final VoidCallback? successListener;

  const SlideVerify(
      {Key? key,
        this.height = 40,
        this.width = 70,
        this.successText,
        this.initText,
        this.sliderImage,
        this.initImage,
        this.successTextStyle =
        const TextStyle(fontSize: 14, color: Colors.white),
        this.initTextStyle = const TextStyle(fontSize: 14, color: Colors.black12),
        this.bgColor = Colors.grey,
        this.moveColor = Colors.blue,
        this.borderColor = Colors.blueAccent,
        this.successListener})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SlideVerifyState();
  }
}

class SlideVerifyState extends State<SlideVerify>
    with TickerProviderStateMixin {
  AnimationController? _animController;
  Animation? _curve;
  double initX = 0.0;
  double height = 0;
  double width = 0;
  double moveDistance = 0;

  double sliderWidth = 0;

  bool verifySuccess = false;

  bool enable = true;

  bool end = false;

  void _init() {
    sliderWidth = widget.height - 4;
    _animController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    _curve = CurvedAnimation(parent: _animController!, curve: Curves.linear);
    _curve?.addListener(() {
      setState(() {
        moveDistance = moveDistance - moveDistance * _curve!.value;
        print("hello, world, ${_curve!.value}");
        if (moveDistance <= 0) {
          moveDistance = 0;
        }
      });
    });
    _animController?.addStatusListener((status) {
      print("hello, ${status}");
      if (status == AnimationStatus.completed) {
        enable = true;
        end = false;
        _animController?.reset();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.width = widget.width;
    this.height = widget.height;
    _init();
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        if(end){
          _animController?.forward();
          return;
        }
        if (!enable) {
          return;
        }
        initX = details.globalPosition.dx;
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (!enable) {
          return;
        }
        moveDistance = details.globalPosition.dx - initX;
        if (moveDistance < 0) {
          moveDistance = 0;
        }

        if (moveDistance > width - sliderWidth) {
          moveDistance = width - sliderWidth;
          enable = false;
          end = true;
          verifySuccess = true;
          if (widget.successListener != null) {
            widget.successListener?.call();
          }
        }
        setState(() {});
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (enable) {
          enable = false;
          _animController?.forward(); // 启动动画, 归零
          print(_curve?.value);
        }
        if(end){
          enable = true;
        }
      },
      child: Container(
        height: height,
        width: width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: widget.bgColor,
            border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.all(new Radius.circular(height))),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: height - 2,
                width: moveDistance < 1 ? 0 : moveDistance + sliderWidth / 2,
                decoration: BoxDecoration(
                  color: widget.moveColor,
                ),
              ),
            ),
            Center(
              child: Text(
                verifySuccess
                    ? widget.successText ?? ""
                    : widget.initText ?? "",
                style: verifySuccess
                    ? widget.successTextStyle
                    : widget.initTextStyle,
              ),
            ),
            Positioned(
              top: 1,
              left:
              moveDistance > sliderWidth ? moveDistance - 2 : moveDistance,
              child: Container(
                width: sliderWidth,
                height: sliderWidth,
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    new Radius.circular(sliderWidth),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (widget.sliderImage != null)
                      Image.asset(
                        widget.sliderImage!,
                        height: sliderWidth,
                        width: sliderWidth,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
