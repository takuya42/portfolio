import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marumaru_clinic_portfolio/app.dart';

void main() {
  testWidgets('トップページの主要コンテンツを表示する', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1000));
    await tester.pumpWidget(const ClinicApp());

    expect(find.text('〇〇接骨院'), findsWidgets);
    expect(find.textContaining('地域の皆さまの'), findsOneWidget);
    expect(find.text('このようなお悩みはありませんか？'), findsOneWidget);
    expect(find.text('画像を配置予定'), findsOneWidget);
  });

  testWidgets('スマートフォン幅ではメニューボタンを表示する', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(const ClinicApp());

    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
