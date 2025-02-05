import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meuappflutter/ui/themes/app_theme.dart';

extension IconExtension on Icon {
  Icon autoDirection() {
    if (AppTheme.textDirection == TextDirection.ltr) return this;
    if (this.icon == FontAwesomeIcons.chevronRight) {
      return Icon(
        FontAwesomeIcons.chevronLeft,
        color: this.color,
        textDirection: this.textDirection,
        size: this.size,
        key: this.key,
        semanticLabel: this.semanticLabel,
      );
    } else if (this.icon == FontAwesomeIcons.chevronLeft) {
      return Icon(
        FontAwesomeIcons.chevronRight,
        color: this.color,
        textDirection: this.textDirection,
        size: this.size,
        key: this.key,
        semanticLabel: this.semanticLabel,
      );
    } else if (this.icon == FontAwesomeIcons.chevronLeft) {
      return Icon(
        FontAwesomeIcons.chevronRight,
        color: this.color,
        textDirection: this.textDirection,
        size: this.size,
        key: this.key,
        semanticLabel: this.semanticLabel,
      );
    } else if (this.icon == FontAwesomeIcons.chevronRight) {
      return Icon(
        FontAwesomeIcons.chevronLeft,
        color: this.color,
        textDirection: this.textDirection,
        size: this.size,
        key: this.key,
        semanticLabel: this.semanticLabel,
      );
    }
    return this;
  }
}
