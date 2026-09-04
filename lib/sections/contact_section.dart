import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';
import '../widgets/fade_in.dart';
import '../widgets/gold_button.dart';
import '../widgets/section_title.dart';
import '../widgets/section_wrapper.dart';

/// Contact form. Abhi kahin submit nahi hota - sirf validation aur ek
/// success animation chalti hai.
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _message = TextEditingController();

  String? _service;
  bool _sending = false;
  bool _sent = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _sending = true);
    // Abhi API nahi hai - sirf thoda delay taaki loading state dikh sake.
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;

    setState(() {
      _sending = false;
      _sent = true;
    });

    _formKey.currentState!.reset();
    for (final c in [_name, _email, _phone, _message]) {
      c.clear();
    }
    _service = null;

    // 4 second baad wapas form dikha do.
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _sent = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      background: AppColors.surface,
      child: Column(
        children: [
          const SectionTitle(
            eyebrow: 'Get in touch',
            title: 'Book a Consultation',
            subtitle:
                'Tell us about your matter. The first 30-minute consultation is '
                'free, and we reply within one working day.',
          ),
          const SizedBox(height: AppTheme.xxl),
          FadeIn(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Container(
                padding: EdgeInsets.all(
                  context.isMobile ? AppTheme.lg : AppTheme.xl,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radius),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.navy.withValues(alpha: 0.06),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                // Form aur success message ke beech smooth swap.
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 420),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween(begin: 0.94, end: 1.0).animate(animation),
                      child: child,
                    ),
                  ),
                  child: _sent ? const _SuccessMessage() : _buildForm(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _Field(
            controller: _name,
            label: 'Full name',
            icon: Icons.person_outline_rounded,
            validator: (v) => (v == null || v.trim().length < 2)
                ? 'Please enter your full name'
                : null,
          ),
          const SizedBox(height: AppTheme.md),
          Row(
            children: [
              Expanded(
                child: _Field(
                  controller: _email,
                  label: 'Email',
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || !v.contains('@') || !v.contains('.')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: AppTheme.md),
              Expanded(
                child: _Field(
                  controller: _phone,
                  label: 'Phone',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    final digits = (v ?? '').replaceAll(RegExp(r'\D'), '');
                    return digits.length < 10 ? 'Enter a 10-digit number' : null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.md),
          // Service dropdown - form ko route karna aasaan ho jaata hai.
          DropdownButtonFormField<String>(
            initialValue: _service,
            isExpanded: true,
            style: context.text.body,
            decoration: _decoration(
              context,
              label: 'What do you need help with?',
              icon: Icons.category_outlined,
            ),
            items: [
              for (final option in MockData.serviceOptions)
                DropdownMenuItem(value: option, child: Text(option)),
            ],
            onChanged: (v) => setState(() => _service = v),
            validator: (v) => v == null ? 'Please choose a service' : null,
          ),
          const SizedBox(height: AppTheme.md),
          _Field(
            controller: _message,
            label: 'Briefly describe your matter',
            icon: Icons.chat_bubble_outline_rounded,
            maxLines: 4,
            validator: (v) => (v == null || v.trim().length < 10)
                ? 'Please add a little more detail'
                : null,
          ),
          const SizedBox(height: AppTheme.lg),
          SizedBox(
            width: double.infinity,
            child: GoldButton(
              label: _sending ? 'Sending...' : 'Request Consultation',
              icon: _sending ? null : Icons.send_rounded,
              expand: true,
              onPressed: _sending ? null : _submit,
            ),
          ),
        ],
      ),
    );
  }
}

/// Form fields ka common decoration - dropdown aur text field dono use karte
/// hain, taaki dono bilkul same dikhein.
InputDecoration _decoration(
  BuildContext context, {
  required String label,
  required IconData icon,
  bool showIcon = true,
}) {
  return InputDecoration(
    labelText: label,
    labelStyle: context.text.bodySmall,
    prefixIcon:
        showIcon ? Icon(icon, size: 19, color: AppColors.textMuted) : null,
    filled: true,
    fillColor: AppColors.offWhite,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.gold, width: 1.6),
    ),
  );
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: context.text.body,
      decoration: _decoration(
        context,
        label: label,
        icon: icon,
        showIcon: maxLines == 1,
      ),
    );
  }
}

/// Submit ke baad ka confirmation - tick scale hoke aata hai.
class _SuccessMessage extends StatelessWidget {
  const _SuccessMessage();

  @override
  Widget build(BuildContext context) {
    final t = context.text;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.xl),
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            builder: (context, value, child) =>
                Transform.scale(scale: value, child: child),
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded,
                  size: 36, color: AppColors.success),
            ),
          ),
          const SizedBox(height: AppTheme.md),
          Text('Thank you - we have your enquiry', style: t.cardTitle),
          const SizedBox(height: 4),
          Text(
            'One of our advocates will get back to you within one working day.',
            style: t.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
