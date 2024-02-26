import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/globals.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (devMode)
            Obx(
              () {
                return Text(
                  'Debug messages: \n ${prodDebugMessage.value}',
                  style: const TextStyle(color: Colors.red),
                );
              },
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
