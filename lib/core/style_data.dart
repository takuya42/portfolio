import 'app_assets.dart';

class HairStyle {
  const HairStyle({
    required this.number,
    required this.name,
    required this.japaneseName,
    required this.assetPath,
  });

  final String number;
  final String name;
  final String japaneseName;
  final String? assetPath;
}

abstract final class StyleData {
  static const styles = [
    HairStyle(
      number: '01',
      name: 'Natural Bob',
      japaneseName: 'ナチュラルボブ',
      assetPath: AppAssets.style01,
    ),
    HairStyle(
      number: '02',
      name: 'Layer Medium',
      japaneseName: 'レイヤーミディアム',
      assetPath: AppAssets.style02,
    ),
    HairStyle(
      number: '03',
      name: 'Soft Wave',
      japaneseName: 'ソフトウェーブ',
      assetPath: AppAssets.style03,
    ),
    HairStyle(
      number: '04',
      name: 'Short Bob',
      japaneseName: 'ショートボブ',
      assetPath: AppAssets.style04,
    ),
    HairStyle(
      number: '05',
      name: 'Long Layer',
      japaneseName: 'ロングレイヤー',
      assetPath: AppAssets.style05,
    ),
    HairStyle(
      number: '06',
      name: 'Natural Color',
      japaneseName: 'ナチュラルカラー',
      assetPath: AppAssets.style06,
    ),
  ];
}
