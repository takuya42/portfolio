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
    expect(
      find.image(const AssetImage('assets/images/hero_background.png')),
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

  testWidgets('ヘッダーから予約ページへ遷移して戻れる', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1000));
    await tester.pumpWidget(const SalonApp());

    await tester.tap(find.text('RESERVATION'));
    await tester.pump();

    expect(find.text('ご予約'), findsOneWidget);
    expect(find.text('メニューを選択'), findsOneWidget);
    expect(find.text('カット＋カラー'), findsOneWidget);

    await tester.pageBack();
    await tester.pump();

    expect(find.textContaining('毎日に、'), findsOneWidget);
  });

  testWidgets('Heroの予約ボタンから予約ページへ遷移する', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(const SalonApp());

    await tester.tap(find.text('ご予約はこちら'));
    await tester.pump();

    expect(find.text('ご希望のメニュー・日時をお選びください。'), findsOneWidget);
    expect(find.text('予約内容を確認する'), findsOneWidget);
  });

  testWidgets('STYLEギャラリーに6種類のスタイルを表示する', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1000));
    await tester.pumpWidget(const SalonApp());

    await tester.scrollUntilVisible(
      find.text('Natural Bob'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    for (final styleName in [
      'Natural Bob',
      'Layer Medium',
      'Soft Wave',
      'Short Bob',
      'Long Layer',
      'Natural Color',
    ]) {
      expect(find.text(styleName), findsOneWidget);
    }
    expect(find.text('VIEW ALL STYLES'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
