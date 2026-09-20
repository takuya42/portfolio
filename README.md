# 〇〇 SALON｜Flutter Web Portfolio

架空の美容室を想定した、Flutter Web製のレスポンシブなブランドサイトです。

> 当サイトはポートフォリオ用に制作した架空の美容室サイトです。

## Features

- アイボリー、ベージュ、チャコールを基調にしたジェンダーニュートラルなデザイン
- PC・タブレット・スマートフォン対応とモバイルナビゲーション
- Hero、Concept、Menu、Style、Staff、Access、Contact、Footerのセクション構成
- スクロールリビール、時間差表示、ホバー、スムーズスクロール
- 写真未設定時はコード製プレースホルダーを表示

## カスタマイズ

店舗名、住所、営業時間、メニュー、スタッフ情報は `lib/core/salon_data.dart` で一元管理しています。
写真は `assets/images/` に追加し、`lib/core/app_assets.dart` の対応する `null` を画像パスへ変更してください。

```bash
flutter pub get
flutter run -d chrome
flutter build web --release
```
