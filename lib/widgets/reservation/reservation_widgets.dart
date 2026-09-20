import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/reservation_data.dart';

class ReservationStep extends StatelessWidget {
  const ReservationStep({
    required this.number,
    required this.title,
    required this.child,
    super.key,
  });

  final String number;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STEP $number',
            style: const TextStyle(
              color: AppColors.accent,
              fontSize: 11,
              letterSpacing: 2.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 26),
          child,
        ],
      ),
    );
  }
}

class MenuChoiceCard extends StatelessWidget {
  const MenuChoiceCard({
    required this.menu,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final ReservationMenu menu;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: selected ? AppColors.sand : AppColors.white,
            border: Border.all(
              color: selected ? AppColors.charcoal : AppColors.border,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      menu.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Icon(
                    selected ? Icons.check_circle : Icons.circle_outlined,
                    size: 19,
                    color: selected ? AppColors.charcoal : AppColors.greige,
                  ),
                ],
              ),
              const Spacer(),
              Text(menu.price, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              Text(menu.duration, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({
    required this.label,
    required this.selected,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: selected ? AppColors.charcoal : AppColors.white,
          foregroundColor: selected ? AppColors.white : AppColors.charcoal,
          side: BorderSide(
            color: selected ? AppColors.charcoal : AppColors.border,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class ReservationCalendar extends StatelessWidget {
  const ReservationCalendar({
    required this.displayedMonth,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onPreviousMonth,
    required this.onNextMonth,
    super.key,
  });

  final DateTime displayedMonth;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback? onPreviousMonth;
  final VoidCallback onNextMonth;

  @override
  Widget build(BuildContext context) {
    final first = DateTime(displayedMonth.year, displayedMonth.month);
    final days = DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;
    final leading = first.weekday % 7;
    final today = DateUtils.dateOnly(DateTime.now());

    return Container(
      constraints: const BoxConstraints(maxWidth: 620),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onPreviousMonth,
                tooltip: '前の月',
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Text(
                  '${displayedMonth.year}年 ${displayedMonth.month}月',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, letterSpacing: 1),
                ),
              ),
              IconButton(
                onPressed: onNextMonth,
                tooltip: '次の月',
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (final day in ['日', '月', '火', '水', '木', '金', '土'])
                Expanded(child: Center(child: Text(day))),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.15,
            ),
            itemCount: leading + days,
            itemBuilder: (context, index) {
              if (index < leading) return const SizedBox.shrink();
              final date = DateTime(
                displayedMonth.year,
                displayedMonth.month,
                index - leading + 1,
              );
              final enabled = !date.isBefore(today);
              final selected = selectedDate != null &&
                  DateUtils.isSameDay(date, selectedDate);
              return Padding(
                padding: const EdgeInsets.all(2),
                child: TextButton(
                  onPressed: enabled ? () => onDateSelected(date) : null,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor:
                        selected ? AppColors.charcoal : Colors.transparent,
                    foregroundColor:
                        selected ? AppColors.white : AppColors.charcoal,
                    disabledForegroundColor: AppColors.border,
                    shape: const CircleBorder(),
                  ),
                  child: Text('${date.day}'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
