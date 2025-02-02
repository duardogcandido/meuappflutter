import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meuappflutter/ui/pages/config/controller/config_controller.dart';
import 'package:meuappflutter/ui/themes/app_theme.dart';
import 'package:meuappflutter/ui/themes/theme_type.dart';
import 'package:rive/rive.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> with TickerProviderStateMixin {
  late ThemeData theme;
  late ConfigController controller;
  Artboard? _switchArtboard;
  SMITrigger? trigger;
  StateMachineController? stateMachineController;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    controller = FxControllerStore.putOrFind(ConfigController(this));
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

          setState(() => _switchArtboard = artboard);
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

          setState(() => _switchArtboard = artboard);
        },
      );
    }
  }

  void switchBright() {
    controller.scaleController.forward();
    trigger?.fire();
  }

  @override
  void dispose() {
    controller.dispose();
    FxControllerStore.delete(controller);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ConfigController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: FxText.titleMedium("Theme Animation"),
              elevation: 0,
              centerTitle: true,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(FontAwesomeIcons.chevronLeft),
              ),
            ),
            body: Center(
              child: GestureDetector(
                onTap: () {
                  switchBright();
                },
                child: Rive(artboard: _switchArtboard!),
              ),
            ),
          );
        });
  }
}
