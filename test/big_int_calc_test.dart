// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:fondue_swap/utils/util.dart';

void main() {
  test('test bigint encode/decode', () {
    final BigInt bigInt = BigInt.parse('5602277097478613991869082763264');
    const double doubleValue = 0.25;
    final BigInt result = multiplyBigintWithDouble(bigInt, doubleValue);

    expect(result, BigInt.parse('1400569274369653497967270690816'));
  });
}
