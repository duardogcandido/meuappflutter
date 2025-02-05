import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:meuappflutter/ui/themes/app_notifier.dart';
import 'package:meuappflutter/ui/themes/app_theme.dart';
import 'package:meuappflutter/ui/themes/theme_type.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class ConfigController extends FxController {
  TickerProvider ticker;
  Artboard? switchArtboard;
  SMITrigger? trigger;
  StateMachineController? stateMachineController;
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;
  bool uiLoading = true,
       showNotification = true,
       allowIcon = true,
       showLock = false,
       reaction = true,
       sound = true,
       pushTip = true,
       appSound = false,
       appBanner = true,
       appTip = false;

  ConfigController(this.ticker);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async{
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
    if(AppTheme.themeType == ThemeType.dark){
      rootBundle.load('assets/animations/rive/mode_switch_dark_init.riv').then(
            (data) {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          stateMachineController =
              StateMachineController.fromArtboard(artboard, "State Machine 1");
          if (stateMachineController != null) {
            artboard.addController(stateMachineController!);
            trigger = stateMachineController!.findSMI('Click');
            trigger = stateMachineController!.inputs.first as SMITrigger;
          }
          switchArtboard = artboard;
          uiLoading = false;
          update();
        },
      );
    }else{
      rootBundle.load('assets/animations/rive/mode_switch_light_init.riv').then(
            (data) {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          stateMachineController =
              StateMachineController.fromArtboard(artboard, "State Machine 1");
          if (stateMachineController != null) {
            artboard.addController(stateMachineController!);
            trigger = stateMachineController!.findSMI('Click');
            trigger = stateMachineController!.inputs.first as SMITrigger;
          }
          switchArtboard = artboard;
          uiLoading = false;
          update();
        },
      );
    }
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

  void switchBright() {
    scaleController.forward();
    trigger?.fire();
  }

  @override
  void dispose() {
    FxControllerStore.delete(this);
    super.dispose();
  }

  @override
  String getTag() {
    return "config_controller";
  }
}
