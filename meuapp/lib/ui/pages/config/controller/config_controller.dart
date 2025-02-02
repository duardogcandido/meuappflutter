import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:meuappflutter/ui/themes/app_notifier.dart';
import 'package:meuappflutter/ui/themes/app_theme.dart';
import 'package:meuappflutter/ui/themes/theme_type.dart';
import 'package:provider/provider.dart';

class ConfigController extends FxController {
  TickerProvider ticker;
  ConfigController(this.ticker);
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    scaleController =
        AnimationController(vsync: ticker, duration: Duration(seconds: 1));
    scaleAnimation =
    Tween<double>(begin: 0.0, end: 800.0).animate(scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          changeTheme();
          scaleController.reset();
        }
      });
  }

  void changeTheme() {
    if (AppTheme.themeType == ThemeType.light) {
      Provider.of<AppNotifier>(context, listen: false)
          .updateTheme(ThemeType.dark);
    } else {
      Provider.of<AppNotifier>(context, listen: false)
          .updateTheme(ThemeType.light);
    }
    update();
  }

  @override
  void dispose() {
    FxControllerStore.delete(this);
    super.dispose();
  }

  @override
  String getTag() {
    return "theme_changer_controller";
  }
}
