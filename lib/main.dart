import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'data/app_info.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const RahishConsultancyApp());

class RahishConsultancyApp extends StatelessWidget {
  const RahishConsultancyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppInfo.name,
      debugShowCheckedModeBanner: false,
      // Theme yahin build hoti hai taaki typography screen size par react kare.
      builder: (context, child) => Theme(
        data: AppTheme.build(context),
        child: child!,
      ),
      scrollBehavior: const _AppScrollBehavior(),
      home: const HomeScreen(),
    );
  }
}

/// Web/desktop par mouse se drag karke scroll karna enable karta hai.
/// Default mein Flutter sirf touch allow karta hai.
class _AppScrollBehavior extends MaterialScrollBehavior {
  const _AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}
