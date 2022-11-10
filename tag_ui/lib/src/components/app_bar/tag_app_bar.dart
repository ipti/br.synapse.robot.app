import 'package:flutter/material.dart';
import 'package:tag_ui/tag_ui.dart';

class TagAppBar extends StatelessWidget implements PreferredSize {
  const TagAppBar({Key? key, this.title}) : super(key: key);

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    const IconThemeData iconTheme = IconThemeData(
      color: TagColors.colorBaseProductDark,
      size: 24,
    );

    final Widget leading = IconButton(
      icon: const Icon(
        Icons.menu,
        size: 24.0,
      ),
      onPressed: () => Scaffold.of(context).openDrawer(),
    );

    final Widget centerTitle = Container(
      width: 54,
      margin: const EdgeInsets.all(14),
      height: TagSizes.heightServiceLogoMedium,
      child: Center(
        child: title ?? const TagLogo(alignment: Alignment.centerLeft),
      ),
    );

    return AppBar(
      toolbarHeight: TagSizes.heightServiceLogoMedium + 28,
      iconTheme: iconTheme,
      elevation: 0,
      centerTitle: true,
      title: centerTitle,
      leading: leading,
      backgroundColor: TagColors.colorBaseWhiteNormal,
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize =>
      const Size.fromHeight(TagSizes.heightServiceLogoMedium + 28);
}
