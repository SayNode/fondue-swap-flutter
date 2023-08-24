import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';

class LoadingPage {
  static show() {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return SimpleDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.all(30),
              backgroundColor: theme.graphite,
              children: <Widget>[
                Center(
                    child: CircularProgressIndicator(
                  color: theme.goldenSunset,
                ))
              ]);
        });
  }
}
