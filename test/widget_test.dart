import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lexsphere/data/app_info.dart';
import 'package:lexsphere/main.dart';

void main() {
  testWidgets('Hero renders on first load', (tester) async {
    await tester.pumpWidget(const RahishConsultancyApp());
    await tester.pump(const Duration(seconds: 3));

    expect(find.text(AppInfo.wordmark), findsWidgets);
    expect(find.text('Book a Consultation'), findsWidgets);
  });

  // Yeh test us bug ko pakadta hai jahan FadeIn ka content permanently
  // opacity 0 par atak jaata tha, kyunki ScrollNotification ancestor scroll
  // view se aati hai aur neeche bubble nahi hoti. Us waqt Services, Team,
  // FAQ aur contact form sab khaali dikhte the.
  testWidgets('Sections below the fold become visible after scrolling',
      (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const RahishConsultancyApp());
    await tester.pump(const Duration(seconds: 3));

    // scrollUntilVisible yahan use nahi kar sakte: SingleChildScrollView +
    // shrinkWrap grid saare items turant build kar dete hain, to finder ko
    // widget offset 0 par hi mil jaata hai aur scroll hota hi nahi - jabki
    // card actually screen ke bahar hota hai. Isliye seedha drag.
    await tester.drag(
      find.byType(Scrollable).first,
      const Offset(0, -1400),
      warnIfMissed: false,
    );
    await tester.pump();

    // pumpAndSettle kaam nahi karega - hero ke orbs, bounce aur marquee
    // infinite loop hain, wo kabhi settle nahi hote. Isliye fixed pump.
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pump(const Duration(milliseconds: 300));

    // Card sirf mila nahi - actually dikhna bhi chahiye.
    // Sabse paas wala AnimatedOpacity = FadeIn ka apna.
    final opacities = tester.widgetList<AnimatedOpacity>(
      find.ancestor(
        of: find.text('Corporate Legal Advisory').first,
        matching: find.byType(AnimatedOpacity),
      ),
    );

    expect(opacities, isNotEmpty);
    expect(
      opacities.first.opacity,
      1.0,
      reason: 'FadeIn content ko scroll ke baad visible hona chahiye',
    );
  });

  // Brand naam lamba hai ("RAHISH CONSULTANCY"), isliye chhoti screens par
  // layout tootne ka risk rehta hai - header, hero title aur footer teeno.
  testWidgets('Layout holds on a small phone screen', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const RahishConsultancyApp());
    await tester.pump(const Duration(seconds: 3));

    expect(tester.takeException(), isNull);

    // Poore page par scroll karo - har section ka layout check ho jaaye.
    for (var i = 0; i < 12; i++) {
      await tester.drag(
        find.byType(Scrollable).first,
        const Offset(0, -600),
        warnIfMissed: false,
      );
      await tester.pump(const Duration(milliseconds: 200));
      expect(tester.takeException(), isNull, reason: 'scroll step $i');
    }
  });
}
