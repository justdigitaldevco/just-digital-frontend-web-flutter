import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final VoidCallback? onMenuPressed;
  final String iconAssetPath;
  final double iconSizeMultiplier;

  const CustomAppBar({
    super.key,
    this.actions,
    this.onMenuPressed,
    this.iconAssetPath = 'assets/icons/app_icon_white.png',
    this.iconSizeMultiplier = 1.2,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF005451),
      foregroundColor: Colors.white,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleIcon(context),
          const SizedBox(width: 8),
          SelectableText("JUST DIGITAL"), // Uses theme font automatically
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: onMenuPressed ?? () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: actions,
    );
  }

  Widget _buildTitleIcon(BuildContext context) {
    final textStyle = Theme.of(context).appBarTheme.titleTextStyle ??
        const TextStyle(fontSize: 200, fontWeight: FontWeight.w900);

    return SizedBox(
      height: textStyle.fontSize! * iconSizeMultiplier,
      width: textStyle.fontSize! * iconSizeMultiplier,
      child: Image.asset(
        iconAssetPath,
        fit: BoxFit.contain,
        color: Colors.white,
      ),
    );
  }
}