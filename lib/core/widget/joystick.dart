// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class _JoystickState extends State<Joystick> {
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
                        : AnimetedArrow(
                            onTap: () {
                              widget.onUpPressed!();
                            },
                            icon: Icon(
                              Icons.arrow_upward,
                              color: widget.iconColor ?? Colors.black,
                              size: widget.sizeIcon,
                            ),
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
                        : AnimetedArrow(
                            onTap: () {
                              widget.onLeftPressed!();
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_left,
                              color: widget.iconColor ?? Colors.black,
                              size: widget.sizeIcon,
                            ),
                          ),
                  ),
                  Expanded(
                    child: GestureDetector(
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
                        : AnimetedArrow(
                            onTap: () {
                              widget.onRightPressed!();
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: widget.iconColor ?? Colors.black,
                              size: widget.sizeIcon,
                            ),
                          ),
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
                        : AnimetedArrow(
                            onTap: () {
                              widget.onDownPressed!();
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: widget.iconColor ?? Colors.black,
                              size: widget.sizeIcon,
                            ),
                          ),
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

class AnimetedArrow extends StatefulWidget {
  const AnimetedArrow({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final Icon icon;
  final void Function() onTap;

  @override
  State<AnimetedArrow> createState() => _AnimetedArrowState();
}

class _AnimetedArrowState extends State<AnimetedArrow>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final _sizeTween = Tween<double>(begin: 0, end: -20);

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
      // reverseCurve: Curves.easeInBack
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {}
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ArrowButton(
      onTap: () {
        controller.forward();
        widget.onTap();
      },
      icon: widget.icon,
      animation: animation,
    );
  }
}

class ArrowButton extends AnimatedWidget {
  ArrowButton({
    super.key,
    required this.icon,
    required this.onTap,
    required Animation<double> animation,
  }) : super(listenable: animation);

  final Icon icon;
  final void Function() onTap;
  final _sizeTween = Tween<double>(begin: 0, end: -20);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    if (icon.icon == Icons.keyboard_arrow_down) {
      return IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(Icons.keyboard_arrow_down,
            color: icon.color,
            size: icon.size! + _sizeTween.evaluate(animation)),
        onPressed: onTap,
      );
    } else if (icon.icon == Icons.keyboard_arrow_left) {
      return IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(Icons.keyboard_arrow_left,
            color: icon.color,
            size: icon.size! + _sizeTween.evaluate(animation)),
        onPressed: onTap,
      );
    } else if (icon.icon == Icons.keyboard_arrow_right) {
      return IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(Icons.keyboard_arrow_right,
            color: icon.color,
            size: icon.size! + _sizeTween.evaluate(animation)),
        onPressed: onTap,
      );
    } else {
      return IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(Icons.keyboard_arrow_up,
            color: icon.color,
            size: icon.size! + _sizeTween.evaluate(animation)),
        onPressed: onTap,
      );
    }
  }
}
