import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meuappflutter/extensions/string.dart';
import 'package:meuappflutter/ui/pages/config/controller/config_controller.dart';
import 'package:meuappflutter/ui/themes/app_theme.dart';
import 'package:meuappflutter/ui/widgets/select_language_dialog.dart';
import 'package:rive/rive.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> with TickerProviderStateMixin {
  late ThemeData theme;
  late ConfigController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;
    controller = FxControllerStore.putOrFind(ConfigController(this));
  }

  @override
  void dispose() {
    controller.dispose();
    FxControllerStore.delete(controller);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  FxBuilder<ConfigController>(
        controller: controller,
        builder: (controller) {
          return _buildBody(context);
        });
  }

  Widget _buildBody(BuildContext context) {
    if(controller.uiLoading){
      return Scaffold(
        body: Center(child: RiveAnimation.asset('assets/animations/rive/loading.riv')),
      );
    }else{
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                size: 20,
                color: theme.colorScheme.onBackground,
              ),
            ),
            centerTitle: true,
            title: FxText.titleMedium("Notifications", fontWeight: 600),
          ),
          body: ListView(
            padding: FxSpacing.nTop(20),
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child:
                    FxText.titleMedium("Trocar tema", fontWeight: 600),
                  ),
                  SizedBox(
                    width: 80,
                    height: 100,
                    child: GestureDetector(
                      onTap: () {
                        controller.switchBright();
                      },
                      child: Rive(artboard: controller.switchArtboard!),
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          SelectLanguageDialog());
                },
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      child: FxText.titleMedium(
                        'language'.tr(), fontWeight: 600
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        FontAwesomeIcons.chevronRight,
                        size: 18,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: FxText.bodySmall("Push notification".toUpperCase(),
                    fontWeight: 600,
                    color: theme.colorScheme.onBackground.withAlpha(200),
                    letterSpacing: 0.3),
              ),
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 4),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FxText.bodyLarge("Show on Lock Screen",
                                fontWeight: 600),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: FxText.bodySmall(
                                    "Show notification when mobile is locked",
                                    fontWeight: 400,
                                    letterSpacing: 0,
                                    height: 1)),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: theme.dividerColor,
                        thickness: 1.2,
                      ),
                      Switch(
                        onChanged: (bool value) {
                          setState(() {
                            controller.showLock = value;
                          });
                        },
                        value: controller.showLock,
                        activeColor: theme.colorScheme.primary,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 4),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FxText.bodyLarge("Reactions", fontWeight: 600),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: FxText.bodySmall(
                                    "Receive notification when someone react to your message",
                                    fontWeight: 400,
                                    letterSpacing: 0,
                                    height: 1)),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: theme.dividerColor,
                        thickness: 1.2,
                      ),
                      Switch(
                        onChanged: (bool value) {
                          setState(() {
                            controller.reaction = value;
                          });
                        },
                        value: controller.reaction,
                        activeColor: theme.colorScheme.primary,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FxText.bodyLarge("Sounds", fontWeight: 600),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: FxText.bodySmall(
                                    "Play sound for new message",
                                    fontWeight: 400,
                                    letterSpacing: 0,
                                    height: 1)),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: theme.dividerColor,
                        thickness: 1.2,
                      ),
                      Switch(
                        onChanged: (bool value) {
                          setState(() {
                            controller.sound = value;
                          });
                        },
                        value: controller.sound,
                        activeColor: theme.colorScheme.primary,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FxText.bodyLarge("Tips \& Tricks", fontWeight: 600),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: FxText.bodySmall(
                                    "Receive notification when new product feature",
                                    fontWeight: 400,
                                    letterSpacing: 0,
                                    height: 1)),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: theme.dividerColor,
                        thickness: 1.2,
                      ),
                      Switch(
                        onChanged: (bool value) {
                          setState(() {
                            controller.pushTip = value;
                          });
                        },
                        value: controller.pushTip,
                        activeColor: theme.colorScheme.primary,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: theme.dividerColor,
                thickness: 1,
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: FxText.bodySmall("In-app notification".toUpperCase(),
                    fontWeight: 600,
                    color: theme.colorScheme.onBackground.withAlpha(200),
                    letterSpacing: 0.3),
              ),
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 4),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FxText.bodyLarge("In-app sounds", fontWeight: 600),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: FxText.bodySmall(
                                    "Play notification sound when using app",
                                    fontWeight: 400,
                                    letterSpacing: 0,
                                    height: 1)),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: theme.dividerColor,
                        thickness: 1.2,
                      ),
                      Switch(
                        onChanged: (bool value) {
                          setState(() {
                            controller.appSound = value;
                          });
                        },
                        value: controller.appSound,
                        activeColor: theme.colorScheme.primary,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FxText.bodyLarge("Chat Banner Notification",
                                fontWeight: 600),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: FxText.bodySmall(
                                    "Show banner notification when new message arrive",
                                    fontWeight: 400,
                                    letterSpacing: 0,
                                    height: 1)),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: theme.dividerColor,
                        thickness: 1.2,
                      ),
                      Switch(
                        onChanged: (bool value) {
                          setState(() {
                            controller.appBanner = value;
                          });
                        },
                        value: controller.appBanner,
                        activeColor: theme.colorScheme.primary,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FxText.bodyLarge("Tips \& Tricks", fontWeight: 600),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: FxText.bodySmall(
                                    "Receive notification when new product feature",
                                    fontWeight: 400,
                                    letterSpacing: 0,
                                    height: 1)),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: theme.dividerColor,
                        thickness: 1.2,
                      ),
                      Switch(
                        onChanged: (bool value) {
                          setState(() {
                            controller.appTip = value;
                          });
                        },
                        value: controller.appTip,
                        activeColor: theme.colorScheme.primary,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ));
    }
  }
}
