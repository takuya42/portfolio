import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marumaru_salon_portfolio/app.dart';

void main() {
  testWidgets('美容室トップページの主要コンテンツを表示する', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1000));
    await tester.pumpWidget(const SalonApp());

    expect(find.text('〇〇 SALON'), findsWidgets);
    expect(find.textContaining('毎日に、'), findsOneWidget);
    expect(find.text('CONCEPT'), findsOneWidget);
    expect(
      find.image(const AssetImage('assets/images/Image.png')),
      findsOneWidget,
    );
    expect(find.text('HERO PHOTO'), findsNothing);
    expect(find.text('PHOTO PLACEHOLDER'), findsNothing);
    expect(find.byIcon(Icons.menu_rounded), findsNothing);
  });

  testWidgets('スマートフォン幅ではメニューボタンを表示する', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(const SalonApp());

    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
