import 'package:flutter/material.dart';
import 'package:instagramclone/responsive/mobile_screen_layout.dart';
import 'package:instagramclone/responsive/web_screen_layout.dart';
import 'package:instagramclone/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget? webScrenLayout;
  final Widget? mobileScreenLayout;
  const ResponsiveLayout({
    super.key,
    this.mobileScreenLayout,
    this.webScrenLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenWidth) {
          return WebScreenLayout();
        } else {
          return MobileScreenLayout();
        }
      },
    );
  }
}
