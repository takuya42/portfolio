import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
    this.number,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? number;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(color: Color(0x0D123C49), blurRadius: 24, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.paleBlue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: AppColors.primary, size: 27),
              ),
              if (number != null)
                Text(
                  number!,
                  style: const TextStyle(
                    color: Color(0xFFCAE7ED),
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 22),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
