class MenuItemData {
  const MenuItemData(this.name, this.detail, this.price);
  final String name;
  final String detail;
  final String price;
}

class StaffData {
  const StaffData(this.name, this.role, this.bio);
  final String name;
  final String role;
  final String bio;
}

/// 店舗固有の文言はここを変更するだけでサイト全体に反映されます。
abstract final class SalonData {
  static const name = '〇〇 SALON';
  static const tagline = 'Everyday, a little more special.';
  static const phone = '03-0000-0000';
  static const address = '東京都渋谷区〇〇 1-2-3 〇〇ビル 2F';
  static const access = '〇〇駅 南口より徒歩4分';
  static const hours = '平日 10:00–20:00 / 土日祝 9:00–19:00';
  static const closed = '毎週火曜日・第2月曜日';

  static const menu = [
    MenuItemData('CUT', 'シャンプー・ブロー込み', '¥6,600〜'),
    MenuItemData('COLOR', '肌色と髪質に合わせたカラー', '¥8,800〜'),
    MenuItemData('PERM', 'やわらかな質感と自然な動き', '¥9,900〜'),
    MenuItemData('TREATMENT', '髪の状態に合わせた集中ケア', '¥4,400〜'),
  ];

  static const staff = [
    StaffData('AOI KATO', 'Top Stylist', '自然体で扱いやすいボブと、透明感のあるカラーが得意です。'),
    StaffData('REN SATO', 'Stylist', '骨格を生かしたショートとメンズスタイルをご提案します。'),
    StaffData('MIO TANAKA', 'Colorist', '肌になじむニュアンスカラーで、さりげない変化を叶えます。'),
  ];
}
