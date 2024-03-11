import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../models/position.dart';
import '../../../../../services/position_service.dart';
import '../../../../../utils/pool_util.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../password_page/password_page.dart';

class PositionWidgetController extends GetxController {
  Position? position;
  final PositionService positionService = Get.find<PositionService>();

  Future<void> collectFees(Position position) async {
    this.position = position;
    await Get.to<Widget>(
      () => PasswordPage(
        'Password required'.tr,
        'To proceed with the swap, please enter your password. Your password ensures transaction security.'
            .tr,
        'Confirm'.tr,
        submit: _collectFees,
      ),
    );
  }

  Future<void> _collectFees(String password) async {
    Get.close(1);
    unawaited(
      Get.dialog<Widget>(const LoadingWidget(), barrierDismissible: false),
    );
    final BigInt positionId = position!.id;
    await positionService.collect(password, positionId, onlyFees: true);
    Get.close(1);
  }

  Future<void> removePosition(Position position) async {
    this.position = position;
    await Get.to<Widget>(
      () => PasswordPage(
        'Password required'.tr,
        'To proceed with the swap, please enter your password. Your password ensures transaction security.'
            .tr,
        'Confirm'.tr,
        submit: _removePosition,
      ),
    );
  }

  Future<void> _removePosition(String password) async {
    Get.close(1);
    unawaited(
      Get.dialog<Widget>(const LoadingWidget(), barrierDismissible: false),
    );
    final BigInt positionId = position!.id;
    final String txId = await positionService.collect(
      password,
      positionId,
    );
    await waitForTxReceipt(txId);
    await positionService.burnPosition(
      password,
      positionId,
    );
    Get.close(1);
  }
}
