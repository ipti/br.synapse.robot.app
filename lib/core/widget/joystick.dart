import 'package:flutter/material.dart';

enum Directions { up, down, right, left }

enum JoystickModes { all, horizontal, vertical }

class Joystick extends StatefulWidget {
  final double? sizeIcon;
  final Color? backgroundColor;
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
      this.sizeIcon,
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
                        : IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: Icon(
                              Icons.keyboard_arrow_up,
                              color: widget.iconColor ?? Colors.black,
                              size: widget.sizeIcon,
                            ),
                            onPressed: () {
                              if (widget.onUpPressed != null) {
                                widget.onUpPressed!();
                              }
                              if (widget.onPressed != null) {
                                widget.onPressed!(Directions.up);
                              }
                            },
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
                        : IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: Icon(
                              Icons.keyboard_arrow_left,
                              color: widget.iconColor ?? Colors.black,
                              size: widget.sizeIcon,
                            ),
                            onPressed: () {
                              if (widget.onLeftPressed != null) {
                                widget.onLeftPressed!();
                              }
                              if (widget.onPressed != null) {
                                widget.onPressed!(Directions.left);
                              }
                            },
                          ),
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
                        : IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: widget.iconColor ?? Colors.black,
                              size: widget.sizeIcon,
                            ),
                            onPressed: () {
                              if (widget.onRightPressed != null) {
                                widget.onRightPressed!();
                              }
                              if (widget.onPressed != null) {
                                widget.onPressed!(Directions.right);
                              }
                            },
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
                        : IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: widget.iconColor ?? Colors.black,
                              size: widget.sizeIcon,
                            ),
                            onPressed: () {
                              if (widget.onDownPressed != null) {
                                widget.onDownPressed!();
                              }
                              if (widget.onPressed != null) {
                                widget.onPressed!(Directions.down);
                              }
                            },
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
