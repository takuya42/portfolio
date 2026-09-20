import 'package:flutter/material.dart';

import '../widgets/common/motion.dart';
import '../widgets/sections/access_section.dart';
import '../widgets/sections/concept_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/footer.dart';
import '../widgets/sections/header.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/menu_section.dart';
import '../widgets/sections/staff_section.dart';
import '../widgets/sections/style_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    for (final id in [
      'home',
      'concept',
      'menu',
      'style',
      'staff',
      'access',
      'contact',
    ])
      id: GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _navigateToSection(String id) async {
    Navigator.of(context).maybePop();
    final sectionContext = _sectionKeys[id]?.currentContext;

    if (sectionContext != null) {
      await Scrollable.ensureVisible(
        sectionContext,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 750),
        curve: Curves.easeInOutCubic,
        alignment: .02,
      );
    }
  }

  void _openReservation() {
    Navigator.of(context).pushNamed('/reservation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SalonDrawer(
        onNavigate: _navigateToSection,
        onReservationPressed: _openReservation,
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          Header(
            scrollController: _scrollController,
            onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            onNavigate: _navigateToSection,
            onReservationPressed: _openReservation,
          ),
          // This is a short, finite marketing page. Keeping its sections in a
          // single box sliver gives the viewport a stable scroll extent while
          // reveal animations rebuild. In particular, this avoids lazy sliver
          // layout changing the boundary while reversing a wheel gesture at
          // the bottom of the page.
          SliverToBoxAdapter(
            child: Column(
              children: [
                KeyedSubtree(
                  key: _sectionKeys['home'],
                  child: HeroSection(
                    onContactTap: _openReservation,
                  ),
                ),
                RevealOnScroll(
                  child: ConceptSection(
                    sectionKey: _sectionKeys['concept']!,
                  ),
                ),
                RevealOnScroll(
                  child: MenuSection(sectionKey: _sectionKeys['menu']!),
                ),
                RevealOnScroll(
                  child: StyleSection(sectionKey: _sectionKeys['style']!),
                ),
                RevealOnScroll(
                  child: StaffSection(sectionKey: _sectionKeys['staff']!),
                ),
                RevealOnScroll(
                  child: AccessSection(sectionKey: _sectionKeys['access']!),
                ),
                RevealOnScroll(
                  child: ContactSection(sectionKey: _sectionKeys['contact']!),
                ),
                Footer(onNavigate: _navigateToSection),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
