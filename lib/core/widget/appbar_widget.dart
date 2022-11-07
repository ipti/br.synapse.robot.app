import 'package:flutter/material.dart';
import 'package:tag_ui/tag_ui.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  const AppBarWidget({Key? key, this.title}) : super(key: key);

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    const IconThemeData iconTheme = IconThemeData(
      color: Color.fromARGB(255, 255, 255, 255),
      size: 24,
    );

    return AppBar(
      toolbarHeight: TagSizes.heightServiceLogoMedium + 28,
      iconTheme: iconTheme,
      elevation: 0,
      centerTitle: true,
      title: title,
      backgroundColor: Color.fromARGB(255, 19, 19, 20),
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize =>
      const Size.fromHeight(TagSizes.heightServiceLogoMedium + 28);
}
