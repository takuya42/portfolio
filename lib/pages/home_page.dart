import 'package:flutter/material.dart';

import '../widgets/common/motion.dart';
import '../widgets/sections/access_section.dart';
import '../widgets/sections/business_hours_section.dart';
import '../widgets/sections/concerns_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/director_section.dart';
import '../widgets/sections/features_section.dart';
import '../widgets/sections/first_visit_section.dart';
import '../widgets/sections/footer.dart';
import '../widgets/sections/header.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/services_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  final _aboutKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _firstVisitKey = GlobalKey();
  final _staffKey = GlobalKey();
  final _accessKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final targetContext = key.currentContext;
    if (targetContext == null) return;
    await Scrollable.ensureVisible(
      targetContext,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      alignment: .05,
    );
  }

  void _onNavigate(String destination) {
    Navigator.of(context).maybePop();
    final keys = <String, GlobalKey>{
      'about': _aboutKey,
      'services': _servicesKey,
      'first': _firstVisitKey,
      'staff': _staffKey,
      'access': _accessKey,
      'contact': _contactKey,
    };
    final key = keys[destination];
    if (key != null) _scrollTo(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: ClinicDrawer(onNavigate: _onNavigate),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          Header(
            scrollController: _scrollController,
            onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            onNavigate: _onNavigate,
          ),
          SliverList.list(
            children: [
              HeroSection(onContactTap: () => _scrollTo(_contactKey)),
              RevealOnScroll(child: ConcernsSection(sectionKey: _aboutKey)),
              const RevealOnScroll(child: FeaturesSection()),
              RevealOnScroll(child: ServicesSection(sectionKey: _servicesKey)),
              RevealOnScroll(child: FirstVisitSection(sectionKey: _firstVisitKey)),
              RevealOnScroll(child: DirectorSection(sectionKey: _staffKey)),
              const RevealOnScroll(child: BusinessHoursSection()),
              RevealOnScroll(child: AccessSection(sectionKey: _accessKey)),
              RevealOnScroll(child: ContactSection(sectionKey: _contactKey)),
              const Footer(),
            ],
          ),
        ],
      ),
    );
  }
}
