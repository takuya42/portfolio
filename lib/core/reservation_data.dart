class ReservationMenu {
  const ReservationMenu({
    required this.name,
    required this.price,
    required this.duration,
  });

  final String name;
  final String price;
  final String duration;
}

abstract final class ReservationData {
  static const menus = [
    ReservationMenu(name: 'カット', price: '¥5,500', duration: '60分'),
    ReservationMenu(name: 'カラー', price: '¥7,700', duration: '90分'),
    ReservationMenu(name: 'カット＋カラー', price: '¥12,100', duration: '120分'),
    ReservationMenu(name: 'トリートメント', price: '¥4,400', duration: '45分'),
  ];

  static const staff = ['指名なし', '加藤 葵', '佐藤 蓮', '田中 美緒'];
  static const times = [
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
  ];
}
