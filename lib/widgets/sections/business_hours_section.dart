import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../common/section_container.dart';
import '../common/section_heading.dart';

class BusinessHoursSection extends StatelessWidget {
  const BusinessHoursSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      backgroundColor: AppColors.softBlue,
      child: Column(
        children: [
          const SectionHeading(eyebrow: 'Hours', title: '受付時間'),
          const SizedBox(height: 38),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(context.isMobile ? 16 : 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: context.isMobile ? 660 : 850,
                    child: const _HoursTable(),
                  ),
                ),
                const SizedBox(height: 22),
                const Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 22,
                  runSpacing: 8,
                  children: [
                    Text('● 通常受付', style: TextStyle(color: AppColors.body)),
                    Text('△ 14:00〜17:00', style: TextStyle(color: AppColors.body)),
                    Text('休診日：日曜・祝日', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HoursTable extends StatelessWidget {
  const _HoursTable();

  @override
  Widget build(BuildContext context) {
    const headers = ['受付時間', '月', '火', '水', '木', '金', '土', '日・祝'];
    const rows = [
      ['9:00〜12:30', '●', '●', '●', '●', '●', '●', '休'],
      ['15:00〜19:30', '●', '●', '●', '●', '●', '△', '休'],
    ];
    return Table(
      columnWidths: const {0: FlexColumnWidth(2.3)},
      border: const TableBorder(horizontalInside: BorderSide(color: AppColors.border), bottom: BorderSide(color: AppColors.border)),
      children: [
        TableRow(
          decoration: const BoxDecoration(color: AppColors.primary),
          children: headers.map((text) => _cell(text, color: Colors.white, bold: true)).toList(),
        ),
        for (final row in rows)
          TableRow(children: row.map((text) => _cell(text, bold: text == row.first || text == '休')).toList()),
      ],
    );
  }

  static Widget _cell(String text, {Color color = AppColors.ink, bool bold = false}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 17),
        child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: color, fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
      );
}
