import 'package:flutter/material.dart';
import 'package:sovawallet/ui/theme/style/icons_style.dart';
import 'package:sovawallet/ui/theme/style/text_style.dart';

Widget buildListTile(IconData iconData, String title, VoidCallback onClick) {
  return ListTile(
    leading: Icon(iconData),
    title: Text(title, style: AppTextStyles.infoItemTitle),
    onTap: onClick,
  );
}
Widget buildListTileSvg(String iconData, String title, VoidCallback onClick, {bool enabled = true}) {
  return ListTile(
    enabled: enabled,
    leading: AppIconsStyle.icon3x2(iconData),
    title: Text(title, style: AppTextStyles.infoItemTitle),
    onTap: onClick,
  );
}


