import 'package:flutter/material.dart';

import '../data/app_info.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';

/// Mobile ka side menu.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.onNavTap});

  final void Function(int index) onNavTap;

  @override
  Widget build(BuildContext context) {
    final t = context.text;

    return Drawer(
      backgroundColor: AppColors.navy,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: AppTheme.lg),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.lg),
              child: Row(
                children: [
                  const Icon(Icons.balance_rounded,
                      color: AppColors.gold, size: 20),
                  const SizedBox(width: AppTheme.xs),
                  Flexible(
                    child: Text(
                      AppInfo.wordmark,
                      style: t.wordmark,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.lg),
            _tile(context, 'Services', 0),
            _tile(context, 'About Us', 1),
            _tile(context, 'Our Team', 2),
            _tile(context, 'FAQ', 3),
            _tile(context, 'Book a Consultation', 4),
            const Divider(color: Colors.white24, indent: 24, endIndent: 24),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppTheme.lg, AppTheme.md, AppTheme.lg, AppTheme.xs),
              child: Text('PRACTICE AREAS', style: t.eyebrow),
            ),
            for (final s in MockData.services)
              ListTile(
                dense: true,
                leading: Icon(s.icon, color: AppColors.goldLight, size: 18),
                title: Text(
                  s.title,
                  style: t.bodySmall.copyWith(color: AppColors.textOnDarkMuted),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  onNavTap(0);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, String label, int index) {
    return ListTile(
      title: Text(
        label,
        style: context.text.body.copyWith(color: AppColors.textOnDark),
      ),
      onTap: () {
        Navigator.of(context).pop();
        onNavTap(index);
      },
    );
  }
}
