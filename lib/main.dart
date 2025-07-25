import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:isolation_test/ui/post_page.dart';
import 'package:isolation_test/ui/shop_screen.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(AppMain());
}

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        EasyLoading.instance
          ..maskType = EasyLoadingMaskType.clear
          ..loadingStyle = EasyLoadingStyle.custom
          ..maskColor = Colors.white.withOpacity(0.5)
          ..indicatorColor = Colors.indigo
          ..textColor = Colors.indigo
          ..backgroundColor = Colors.red
          ..contentPadding = EdgeInsets.all(0)
          ..textPadding = EdgeInsets.all(0)
          ..indicatorWidget = Lottie.asset("assets/loading-paper.json");
        return FlutterEasyLoading(child: child);
      },
      home: ShopScreen(),
    );
  }
}
