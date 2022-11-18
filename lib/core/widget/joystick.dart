import 'package:flutter/material.dart';

enum Directions { up, down, right, left }

enum JoystickModes { all, horizontal, vertical }

class Joystick extends StatefulWidget {
  final Color? backgroundColor;
  final double sizeIcon;
  final Color? iconColor;
  final double? opacity;
  final double size;
  final bool? isDraggable;
  final JoystickModes? joystickMode;
  // callbacks
  final VoidCallback? onUpPressed;
  final VoidCallback? onDownPressed;
  final VoidCallback? onRightPressed;
  final VoidCallback? onLeftPressed;
  final Function(Directions)? onPressed;
  //
  const Joystick(
      {super.key,
      this.sizeIcon = 50,
      this.backgroundColor,
      this.iconColor,
      this.opacity,
      this.isDraggable,
      required this.size,
      this.joystickMode,
      this.onUpPressed,
      this.onDownPressed,
      this.onLeftPressed,
      this.onRightPressed,
      this.onPressed})
      : assert(isDraggable != null);
  @override
  // ignore: library_private_types_in_public_api
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {}
      });
    // controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(88, 6, 162, 100),
                  Color.fromRGBO(146, 32, 205, 100)
                ]),
            color: widget.backgroundColor?.withOpacity(widget.opacity ?? 1) ??
                Colors.grey.withOpacity(widget.opacity ?? 1),
            // border: Border.all(),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 12, 11, 11),
                  blurRadius: 8,
                  offset: Offset(0, 0))
            ],
          ),
          child: Column(children: [
            // up
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    child: (widget.joystickMode == JoystickModes.horizontal)
                        ? const SizedBox()
                        : ArrowButton(
                            icon: Icons.arrow_upward,
                            onTap: () {
                              controller.forward();
                              widget.onUpPressed!();
                            },
                            animation: animation,
                            sizeIcon: 50,
                          ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  )
                ],
              ),
            ),
            // middle
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: (widget.joystickMode == JoystickModes.vertical)
                        ? const SizedBox()
                        : ArrowButton(
                            icon: Icons.keyboard_arrow_left,
                            onTap: () {
                              controller.forward();
                              widget.onLeftPressed!();
                            },
                            animation: animation,
                            sizeIcon: 50,
                          ),
                    // : IconButton(
                    //     padding: const EdgeInsets.all(0),
                    //     icon: Icon(
                    //       Icons.keyboard_arrow_left,
                    //       color: widget.iconColor ?? Colors.black,
                    //       size: widget.sizeIcon,
                    //     ),
                    //     onPressed: () {
                    //       if (widget.onLeftPressed != null) {
                    //         widget.onLeftPressed!();
                    //       }
                    //       if (widget.onPressed != null) {
                    //         widget.onPressed!(Directions.left);
                    //       }
                    //     },
                    //   ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      // child: Icon(
                      //   Icons.start,
                      //   color: widget.iconColor ?? Colors.black,
                      // ),
                      onPanUpdate: (values) {
                        if (widget.isDraggable == true) {
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: (widget.joystickMode == JoystickModes.vertical)
                        ? const SizedBox()
                        : ArrowButton(
                            icon: Icons.keyboard_arrow_right,
                            onTap: () {
                              controller.forward();
                              widget.onRightPressed!();
                            },
                            animation: animation,
                            sizeIcon: 50,
                          ),
                    // : IconButton(
                    //     padding: const EdgeInsets.all(0),
                    //     icon: Icon(
                    //       Icons.keyboard_arrow_right,
                    //       color: widget.iconColor ?? Colors.black,
                    //       size: widget.sizeIcon,
                    //     ),
                    //     onPressed: () {
                    //       if (widget.onRightPressed != null) {
                    //         widget.onRightPressed!();
                    //       }
                    //       if (widget.onPressed != null) {
                    //         widget.onPressed!(Directions.right);
                    //       }
                    //     },
                    //   ),
                  )
                ],
              ),
            ),
            // down
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    child: (widget.joystickMode == JoystickModes.horizontal)
                        ? const SizedBox()
                        : ArrowButton(
                            icon: Icons.keyboard_arrow_down,
                            onTap: () {
                              controller.forward();
                              widget.onDownPressed!();
                            },
                            animation: animation,
                            sizeIcon: 50,
                          ),
                    // : IconButton(
                    //     padding: const EdgeInsets.all(0),
                    //     icon: Icon(
                    //       Icons.keyboard_arrow_down,
                    //       color: widget.iconColor ?? Colors.black,
                    //       size: widget.sizeIcon,
                    //     ),
                    //     onPressed: () {
                    //       if (widget.onDownPressed != null) {
                    //         widget.onDownPressed!();
                    //       }
                    //       if (widget.onPressed != null) {
                    //         widget.onPressed!(Directions.down);
                    //       }
                    //     },
                    //   ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  )
                ],
              ),
            ),
          ]),
        )
      ],
    );
  }
}

class ArrowButton extends AnimatedWidget {
  ArrowButton({
    super.key,
    required this.icon,
    required this.sizeIcon,
    this.iconColor,
    required this.onTap,
    required Animation<double> animation,
  }) : super(listenable: animation);

  final IconData icon;
  final double sizeIcon;
  final Color? iconColor;
  final void Function() onTap;
  final _sizeTween = Tween<double>(begin: 0, end: 10);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    if (icon == Icons.keyboard_arrow_down) {
      return IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: iconColor ?? const Color.fromARGB(255, 255, 255, 255),
          size: sizeIcon + _sizeTween.evaluate(animation),
        ),
        onPressed: onTap,
      );
    } else if (icon == Icons.keyboard_arrow_left) {
      return IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(
          Icons.keyboard_arrow_left,
          color: iconColor ?? const Color.fromARGB(255, 255, 255, 255),
          size: sizeIcon + _sizeTween.evaluate(animation),
        ),
        onPressed: onTap,
      );
    } else if (icon == Icons.keyboard_arrow_right) {
      return IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(
          Icons.keyboard_arrow_right,
          color: iconColor ?? const Color.fromARGB(255, 255, 255, 255),
          size: sizeIcon + _sizeTween.evaluate(animation),
        ),
        onPressed: onTap,
      );
    } else {
      return IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(
          Icons.keyboard_arrow_up,
          color: iconColor ?? const Color.fromARGB(255, 255, 255, 255),
          size: sizeIcon + _sizeTween.evaluate(animation),
        ),
        onPressed: onTap,
      );
    }
  }
}
