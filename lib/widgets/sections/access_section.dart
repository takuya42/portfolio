import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../core/salon_data.dart';
import '../common/section_container.dart';
import '../common/section_heading.dart';

class AccessSection extends StatelessWidget {
  const AccessSection({required this.sectionKey, super.key});

  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            eyebrow: 'SALON / ACCESS',
            title: '訪れる時間も、心地よく。',
            align: TextAlign.left,
          ),
          const SizedBox(height: 48),
          context.isMobile
              ? Column(
                  children: [
                    _buildSalonInformation(context),
                    const SizedBox(height: 32),
                    _buildMapPlaceholder(),
                  ],
                )
              : SizedBox(
                  // A Column inside the page's SliverToBoxAdapter measures its
                  // children with an unbounded height. Give this side-by-side
                  // layout the map's intended height so the Row can safely
                  // stretch both panels without changing their alignment.
                  height: 330,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _buildSalonInformation(context)),
                      const SizedBox(width: 55),
                      Expanded(child: _buildMapPlaceholder()),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildSalonInformation(BuildContext context) {
    const informationRows = [
      ('ADDRESS', SalonData.address),
      ('ACCESS', SalonData.access),
      ('OPEN', SalonData.hours),
      ('CLOSED', SalonData.closed),
      ('TEL', SalonData.phone),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          SalonData.name,
          style: TextStyle(fontSize: 24, letterSpacing: 2),
        ),
        const SizedBox(height: 26),
        for (final row in informationRows)
          Padding(
            padding: const EdgeInsets.only(bottom: 17),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 82,
                  child: Text(
                    row.$1,
                    style: const TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.5,
                      color: AppColors.greige,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    row.$2,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      height: 330,
      color: AppColors.sand,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColors.taupe,
              size: 32,
            ),
            SizedBox(height: 12),
            Text(
              'MAP SPACE',
              style: TextStyle(color: AppColors.taupe, letterSpacing: 2),
            ),
            SizedBox(height: 5),
            Text(
              '地図を埋め込むスペース',
              style: TextStyle(color: AppColors.greige, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
