import 'package:flutter/material.dart';

import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/faq_section.dart';
import '../sections/hero_section.dart';
import '../sections/services_section.dart';
import '../sections/stats_section.dart';
import '../sections/team_section.dart';
import '../sections/testimonials_section.dart';
import '../theme/app_colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/app_footer.dart';
import '../widgets/app_header.dart';

/// Poora single-page layout.
///
/// Har section ke aage ek GlobalKey hai, jisse nav click par us section tak
/// smooth scroll ho jaata hai.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Index 0..4 - header aur drawer dono isi order ko use karte hain.
  final _sectionKeys = List.generate(5, (_) => GlobalKey());

  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Header ka background tabhi solid karo jab hero se neeche aa jayein.
    final scrolled = _scrollController.offset > 40;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _scrollTo(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOutCubic,
      alignment: 0.02, // header ke neeche thoda gap
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.offWhite,
      drawer: AppDrawer(onNavTap: _scrollTo),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(onExploreTap: () => _scrollTo(0)),
                Container(key: _sectionKeys[0], child: const ServicesSection()),
                Container(key: _sectionKeys[1], child: const AboutSection()),
                const StatsSection(),
                Container(key: _sectionKeys[2], child: const TeamSection()),
                const TestimonialsSection(),
                Container(key: _sectionKeys[3], child: const FaqSection()),
                Container(key: _sectionKeys[4], child: const ContactSection()),
                const AppFooter(),
              ],
            ),
          ),
          // Header hamesha upar - scroll ke saath sirf color badalta hai.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppHeader(
              scrolled: _scrolled,
              onNavTap: _scrollTo,
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}
