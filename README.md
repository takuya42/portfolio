# 〇〇接骨院｜Flutter Web Portfolio

地域密着型の架空の接骨院を想定した、Flutter Web製のレスポンシブなトップページです。

> 当サイトはポートフォリオ用に制作した架空の接骨院サイトです。実在する施設・人物とは関係ありません。

## Features

- Material 3をベースにした清潔感と親しみやすさのあるUI
- PC・タブレット・スマートフォンに最適化したレスポンシブレイアウト
- セクション単位で分割した保守しやすいWidget構成
- コード製プレースホルダーから`assets/images/`の実画像へ切り替えやすい画像コンポーネント
- セマンティクス、十分なタップ領域、横スクロールを抑えたアクセシブルな設計

## Getting Started

Flutter SDK（stable channel）をインストールし、Webサポートを有効にしてください。

```bash
flutter config --enable-web
flutter pub get
flutter run -d chrome
```

任意のWebサーバーで確認する場合：

```bash
flutter run -d web-server --web-port 8080
```

本番向けビルド：

```bash
flutter build web --release
```

## Project Structure

```text
lib/
├── main.dart
├── app.dart
├── core/
│   ├── app_assets.dart
│   ├── app_colors.dart
│   ├── app_theme.dart
│   └── responsive.dart
├── pages/
│   └── home_page.dart
└── widgets/
    ├── common/
    └── sections/
assets/
└── images/
```

## Notes

- ヘッダーナビゲーションは、現段階ではトップページ内の各セクションへスクロールします。
- 住所・電話番号・院長名などはすべてダミー情報です。
- 下層ページおよび実際のフォーム送信機能は今回の実装範囲に含まれていません。
- 現在はバイナリ画像を含まず、画像箇所にはコード製プレースホルダーを表示します。
