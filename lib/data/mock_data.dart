import 'package:flutter/material.dart';

/// All content lives here as static data - no API calls yet.
/// When the backend is ready, only this file needs to change.

class Service {
  const Service({
    required this.title,
    required this.summary,
    required this.description,
    required this.icon,
    this.points = const [],
    this.startingPrice,
    this.timeline,
  });

  final String title;

  /// Short line shown on the card.
  final String summary;

  /// Longer copy shown on the detail screen.
  final String description;

  final IconData icon;
  final List<String> points;
  final String? startingPrice;
  final String? timeline;
}

class TeamMember {
  const TeamMember({
    required this.name,
    required this.role,
    required this.initials,
    required this.expertise,
    required this.experience,
  });

  final String name;
  final String role;
  final String initials;
  final String expertise;
  final String experience;
}

class Testimonial {
  const Testimonial({
    required this.quote,
    required this.author,
    required this.role,
    this.rating = 5,
  });

  final String quote;
  final String author;
  final String role;
  final int rating;
}

class Faq {
  const Faq({required this.question, required this.answer});

  final String question;
  final String answer;
}

class Stat {
  const Stat({required this.value, required this.label, this.suffix = '+'});

  final int value;
  final String label;
  final String suffix;
}

class MockData {
  MockData._();

  // ---------------------------------------------------------------- SERVICES

  static const List<Service> services = [
    Service(
      title: 'Corporate Legal Advisory',
      summary:
          'Structuring, agreements and board-level advice so your company is '
          'built on solid ground.',
      description:
          'From choosing the right entity to drafting the agreements that hold '
          'your business together, we help founders and directors make legally '
          'sound decisions early - when they are still cheap to make. Our '
          'advisory covers incorporation, capital structure, governance and the '
          'day-to-day questions that come up as you grow.',
      icon: Icons.corporate_fare_rounded,
      startingPrice: 'From Rs. 15,000',
      timeline: '7-15 working days',
      points: [
        'Private limited, LLP and OPC incorporation',
        'Founder, shareholder and vesting agreements',
        'Board resolutions, minutes and statutory registers',
        'Due diligence support for funding rounds',
        'Ongoing retainership for day-to-day queries',
      ],
    ),
    Service(
      title: 'Intellectual Property & Trademark',
      summary:
          'Protect your brand, content and inventions - from search to '
          'registration certificate.',
      description:
          'Your brand name, logo and original work are assets, and unprotected '
          'assets are easy to lose. We handle the full lifecycle: a thorough '
          'clearance search before you commit, correct classification at filing, '
          'and firm replies to examination reports and oppositions.',
      icon: Icons.workspace_premium_rounded,
      startingPrice: 'From Rs. 8,000',
      timeline: 'Filing in 2-3 days',
      points: [
        'Trademark clearance search and class selection',
        'Trademark filing, prosecution and renewal',
        'Copyright registration for content and software',
        'Design registration and patent advisory',
        'Opposition, rectification and infringement notices',
      ],
    ),
    Service(
      title: 'HR, Labour & Employment Law',
      summary:
          'Employment contracts, workplace policies and labour compliance that '
          'actually hold up.',
      description:
          'Most employment disputes trace back to a vague contract or a policy '
          'nobody implemented. We draft employment documentation that is clear '
          'and enforceable, set up the statutory registrations you are required '
          'to hold, and advise on exits so they close cleanly.',
      icon: Icons.groups_rounded,
      startingPrice: 'From Rs. 12,000',
      timeline: '5-10 working days',
      points: [
        'Employment contracts, offer letters and NDAs',
        'POSH policy drafting and committee constitution',
        'PF, ESI, gratuity and shops & establishment compliance',
        'Employee handbooks and disciplinary procedures',
        'Termination, settlement and full-and-final advisory',
      ],
    ),
    Service(
      title: 'Property & Real Estate',
      summary:
          'Title verification and documentation so you know exactly what you '
          'are buying.',
      description:
          'A property transaction is only as safe as the title behind it. We '
          'trace ownership through the revenue records, flag encumbrances and '
          'pending litigation, and draft the deed so the terms you agreed are '
          'the terms that get registered.',
      icon: Icons.home_work_rounded,
      startingPrice: 'From Rs. 10,000',
      timeline: '10-20 working days',
      points: [
        'Title search and 30-year chain verification',
        'Encumbrance certificate and litigation check',
        'Sale deed, gift deed and agreement to sell drafting',
        'RERA compliance and builder agreement review',
        'Lease, rent and tenancy agreements',
      ],
    ),
    Service(
      title: 'Litigation & Court Representation',
      summary:
          'Case strategy, drafting and representation across courts and '
          'tribunals.',
      description:
          'When a matter has to go to court, preparation decides the outcome. '
          'We assess the merits honestly before filing, build the documentary '
          'record properly, and keep you informed at every hearing rather than '
          'only when a date is missed.',
      icon: Icons.gavel_rounded,
      startingPrice: 'On assessment',
      timeline: 'Varies by forum',
      points: [
        'Civil suits, recovery and injunction matters',
        'Criminal complaints, bail and quashing petitions',
        'Writ petitions and appeals before the High Court',
        'Consumer forum and tribunal representation',
        'Case tracking with regular status updates',
      ],
    ),
    Service(
      title: 'Cyber Crime & Digital Law',
      summary:
          'Online fraud, data privacy and creator contracts - the newer legal '
          'questions.',
      description:
          'Digital matters move fast and evidence disappears quickly. We help '
          'you act in the first 48 hours - preserving evidence, filing the right '
          'complaint with the right authority, and pursuing takedowns where '
          'content is defamatory or infringing.',
      icon: Icons.security_rounded,
      startingPrice: 'From Rs. 7,500',
      timeline: '48-hour first response',
      points: [
        'Cyber crime complaints and FIR assistance',
        'Online financial fraud and recovery follow-up',
        'DPDP Act and data privacy compliance',
        'Influencer, creator and brand collaboration contracts',
        'Defamation notices and content takedown requests',
      ],
    ),
    Service(
      title: 'Tax & Regulatory Compliance',
      summary:
          'GST, ROC and statutory filings tracked so no deadline is ever '
          'missed.',
      description:
          'Compliance failures are expensive and entirely avoidable. We put a '
          'calendar in place, file on time, and handle notices when they arrive '
          'so a routine query does not turn into a penalty.',
      icon: Icons.receipt_long_rounded,
      startingPrice: 'From Rs. 5,000/month',
      timeline: 'Ongoing',
      points: [
        'GST registration, returns and annual reconciliation',
        'Annual ROC filings and director KYC',
        'Income tax notices and departmental representation',
        'Compliance calendar with deadline reminders',
        'MSME, IEC and other statutory registrations',
      ],
    ),
    Service(
      title: 'Documentation & Drafting',
      summary:
          'Agreements, notices and undertakings drafted to be clear and '
          'enforceable.',
      description:
          'A contract is only useful if it survives a dispute. We draft in plain '
          'language, close the gaps that cause arguments later, and review '
          'documents you have been handed before you sign them.',
      icon: Icons.description_rounded,
      startingPrice: 'From Rs. 3,500',
      timeline: '2-5 working days',
      points: [
        'Commercial contracts, MOUs and NDAs',
        'Legal notices and replies to notices',
        'Affidavits, undertakings and declarations',
        'Vendor, service and franchise agreements',
        'Contract review and risk vetting',
      ],
    ),
    Service(
      title: 'Succession & Estate Planning',
      summary:
          'Wills, succession certificates and family settlements - clarity for '
          'your family.',
      description:
          'Succession disputes are among the longest-running cases in Indian '
          'courts, and almost all of them start with an unclear or unregistered '
          'document. We help families put their intentions on record properly, '
          'while everyone is still in agreement.',
      icon: Icons.family_restroom_rounded,
      startingPrice: 'From Rs. 9,000',
      timeline: '7-15 working days',
      points: [
        'Will drafting, execution and registration',
        'Succession and legal heir certificates',
        'Family settlement and partition deeds',
        'Probate and letters of administration',
        'Trust formation and estate structuring',
      ],
    ),
  ];

  /// Items for the scrolling strip under the hero.
  static const List<String> marqueeItems = [
    'Corporate Advisory',
    'Trademark & IP',
    'Labour Law',
    'Property Verification',
    'Contract Drafting',
    'Cyber Crime',
    'Tax Compliance',
    'Litigation Support',
    'Succession Planning',
    'Consumer Matters',
    'Startup Legal',
    'Due Diligence',
  ];

  // ------------------------------------------------------------------- STATS

  static const List<Stat> stats = [
    Stat(value: 1200, label: 'Matters Handled'),
    Stat(value: 850, label: 'Clients Advised'),
    Stat(value: 15, label: 'Years of Practice'),
    Stat(value: 36, label: 'Practice Areas'),
  ];

  // -------------------------------------------------------------------- TEAM

  static const List<TeamMember> team = [
    TeamMember(
      name: 'Adv. Rahish Khan',
      role: 'Founder & Managing Partner',
      initials: 'RK',
      expertise: 'Corporate Advisory, Commercial Litigation',
      experience: '15+ years',
    ),
    TeamMember(
      name: 'Adv. Neha Verma',
      role: 'Partner - Corporate & Compliance',
      initials: 'NV',
      expertise: 'Company Law, Regulatory Compliance',
      experience: '11 years',
    ),
    TeamMember(
      name: 'Adv. Sandeep Mishra',
      role: 'Head of Litigation',
      initials: 'SM',
      expertise: 'Civil & Criminal Litigation, Writs',
      experience: '13 years',
    ),
    TeamMember(
      name: 'Adv. Ananya Singh',
      role: 'Counsel - Intellectual Property',
      initials: 'AS',
      expertise: 'Trademarks, Copyright, Design',
      experience: '8 years',
    ),
    TeamMember(
      name: 'Adv. Kartik Rao',
      role: 'Counsel - Property & Real Estate',
      initials: 'KR',
      expertise: 'Title Verification, RERA, Conveyancing',
      experience: '9 years',
    ),
    TeamMember(
      name: 'Adv. Pooja Tiwari',
      role: 'Associate - Labour & Employment',
      initials: 'PT',
      expertise: 'Employment Law, POSH, Industrial Relations',
      experience: '6 years',
    ),
  ];

  // ------------------------------------------------------------ TESTIMONIALS

  static const List<Testimonial> testimonials = [
    Testimonial(
      quote:
          'They handled everything from our company incorporation through to '
          'trademark registration. What stood out was the communication - we '
          'always knew exactly which stage we were at and what came next.',
      author: 'Ankit Agarwal',
      role: 'Founder, Kashi Textiles',
    ),
    Testimonial(
      quote:
          'Their title search turned up a pending litigation the seller had not '
          'disclosed. We walked away from that deal. That single piece of due '
          'diligence saved us a very expensive mistake.',
      author: 'Meera Joshi',
      role: 'Real Estate Investor',
    ),
    Testimonial(
      quote:
          'We were constantly behind on labour compliance. They set up a proper '
          'calendar, cleaned up our historical filings and now everything goes '
          'out on time without us chasing it.',
      author: 'Rajesh Gupta',
      role: 'Director, Ganga Industries',
    ),
    Testimonial(
      quote:
          'We received a legal notice on a Friday evening and had a well-drafted '
          'reply ready by Monday. Genuinely responsive, and the drafting was '
          'thorough rather than rushed.',
      author: 'Priya Nair',
      role: 'Co-founder, Fintech Startup',
    ),
    Testimonial(
      quote:
          'The fee was quoted up front with a clear scope and it did not move. '
          'After some bad experiences elsewhere, that transparency mattered more '
          'to us than anything else.',
      author: 'Vikram Deshmukh',
      role: 'Managing Partner, Deshmukh & Sons',
    ),
  ];

  // --------------------------------------------------------------------- FAQ

  static const List<Faq> faqs = [
    Faq(
      question: 'How do I book a consultation?',
      answer:
          'Fill in the enquiry form on this page or call us directly. In the '
          'first consultation we listen to your matter, tell you honestly '
          'whether you need a lawyer at all, and give you a written scope with '
          'a fixed fee estimate before any work begins.',
    ),
    Faq(
      question: 'What does the first consultation cost?',
      answer:
          'The initial 30-minute consultation is free. It is meant for us to '
          'understand your matter and for you to decide whether we are the right '
          'fit. Detailed opinions and document review are billed separately, and '
          'we will tell you the cost before starting.',
    ),
    Faq(
      question: 'Do you work with clients outside Varanasi?',
      answer:
          'Yes. Advisory, drafting, registrations and compliance work is handled '
          'remotely for clients across India, with documents exchanged securely '
          'online. For matters requiring court appearance we work through our '
          'associate network in other states.',
    ),
    Faq(
      question: 'How long does trademark registration take?',
      answer:
          'We file within 2 to 3 working days and you receive your application '
          'number immediately, which lets you start using the TM symbol. The '
          'registration certificate typically takes 12 to 18 months, assuming no '
          'objection or opposition is raised along the way.',
    ),
    Faq(
      question: 'How does the retainership model work?',
      answer:
          'A monthly retainer gives you a dedicated point of contact, unlimited '
          'advisory calls, a set number of document reviews each month and '
          'compliance deadline tracking. Litigation and registration work is '
          'quoted separately as it arises.',
    ),
    Faq(
      question: 'Is it safe to share my documents with you?',
      answer:
          'Yes. Client confidentiality is a professional obligation and is '
          'legally protected. We use encrypted channels for document exchange, '
          'and we are happy to sign an NDA before you share anything sensitive.',
    ),
    Faq(
      question: 'How are your fees structured?',
      answer:
          'Most work is quoted as a fixed fee for a defined scope, so you know '
          'the cost before we begin. Litigation is billed per stage or per '
          'hearing. Retainerships are monthly. We do not bill for time spent on '
          'clarifying your own instructions.',
    ),
    Faq(
      question: 'Will I be able to reach the lawyer handling my matter?',
      answer:
          'Yes. Every matter is assigned to a named advocate who is your direct '
          'point of contact, not a call centre. You get their email and phone '
          'number, and we commit to responding within one working day.',
    ),
  ];

  /// Dropdown options in the contact form.
  static List<String> get serviceOptions => [
        for (final s in services) s.title,
        'Something else',
      ];

  static const List<String> achievements = [
    'Certificate of Research Publication - International Law Journal',
    'Best Emerging Legal Consultancy, Purvanchal 2024',
    'Registered Trademark Attorney - IP India',
    'MSME Legal Advisory Empanelment',
  ];
}
