import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meuappflutter/ui/pages/config/controller/config_controller.dart';
import 'package:meuappflutter/ui/themes/app_theme.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late ConfigController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    controller = FxControllerStore.putOrFind(ConfigController(this));
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: controller.scaleAnimation,
                    builder: (context, child) => Transform.scale(
                      scale: controller.scaleAnimation.value,
                      child: FxContainer.rounded(
                        paddingAll: 1,
                        child: Container(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.scaleController.forward();
                    },
                    child: const FxContainer.rounded(
                      child: Icon(
                        Icons.wb_sunny_sharp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
