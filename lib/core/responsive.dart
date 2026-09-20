import 'package:flutter/widgets.dart';

abstract final class Breakpoints {
  static const mobile = 700.0;
  static const desktop = 1100.0;
  static const maxContent = 1180.0;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  bool get isMobile => screenWidth < Breakpoints.mobile;
  bool get isTablet => screenWidth >= Breakpoints.mobile && screenWidth < Breakpoints.desktop;
  bool get isDesktop => screenWidth >= Breakpoints.desktop;
  double get horizontalPadding => isMobile ? 20 : (isTablet ? 40 : 48);
}
