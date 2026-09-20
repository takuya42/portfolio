import 'package:flutter/material.dart';

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
  final _aboutKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _firstVisitKey = GlobalKey();
  final _staffKey = GlobalKey();
  final _accessKey = GlobalKey();
  final _contactKey = GlobalKey();

  Future<void> _scrollTo(GlobalKey key) async {
    final targetContext = key.currentContext;
    if (targetContext == null) return;
    await Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 600),
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
        slivers: [
          Header(
            onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            onNavigate: _onNavigate,
          ),
          SliverList.list(
            children: [
              HeroSection(onContactTap: () => _scrollTo(_contactKey)),
              ConcernsSection(sectionKey: _aboutKey),
              const FeaturesSection(),
              ServicesSection(sectionKey: _servicesKey),
              FirstVisitSection(sectionKey: _firstVisitKey),
              DirectorSection(sectionKey: _staffKey),
              const BusinessHoursSection(),
              AccessSection(sectionKey: _accessKey),
              ContactSection(sectionKey: _contactKey),
              const Footer(),
            ],
          ),
        ],
      ),
    );
  }
}
