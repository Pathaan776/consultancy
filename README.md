# Rahish Consultancy — Flutter App

Ek hi Flutter app jo **Web, Android aur iOS** teeno par chalti hai.
Abhi koi API nahi — saara content `lib/data/mock_data.dart` mein static hai.
Focus poora **UI + animations** par hai.

## Chalane ke liye

```sh
flutter pub get

flutter run -d chrome     # Web
flutter run -d android    # Android
flutter run -d ios        # iOS
```

## Structure

```
lib/
├── main.dart                  app entry + scroll behaviour
├── theme/
│   ├── app_colors.dart        saare colors
│   ├── app_text.dart          reusable typography (responsive)
│   └── app_theme.dart         Material theme + spacing scale
├── data/
│   ├── app_info.dart          brand naam, tagline, contact — naam badalna ho to sirf yahan
│   └── mock_data.dart         saara content — API aane par sirf yeh badlegi
├── widgets/                   reusable pieces
│   ├── fade_in.dart           scroll reveal
│   ├── hover_card.dart        hover lift + shadow
│   ├── marquee_strip.dart     infinite scrolling strip
│   ├── animated_counter.dart  0 se ginne wala counter
│   ├── gold_button.dart       app ka ek hi button
│   ├── section_title.dart     heading + gold underline
│   ├── section_wrapper.dart   section ka spacing + max width
│   ├── app_header.dart        sticky header
│   ├── app_drawer.dart        mobile menu
│   └── app_footer.dart        footer
├── sections/                  homepage ke hisse
│   ├── hero_section.dart
│   ├── services_section.dart
│   ├── about_section.dart
│   ├── stats_section.dart
│   ├── team_section.dart
│   ├── testimonials_section.dart
│   ├── faq_section.dart
│   └── contact_section.dart
└── screens/
    ├── home_screen.dart       sab sections + nav scroll
    └── service_detail_screen.dart
```

## Typography — reusable

Widget mein kabhi `fontSize: 24` mat likhna. Har style ka naam hai:

```dart
Text('Our Services', style: context.text.sectionTitle)
Text(item.quote,     style: context.text.quote)
```

`AppText.of(context)` screen width dekh kar **poori scale** ek saath chhoti
kar deta hai (mobile 0.72x, tablet 0.86x, desktop 1x) — isliye proportions
kabhi nahi bigadte aur kisi widget mein `if (isMobile)` likhne ki zarurat nahi.

3 fonts: **Cinzel** (brand/headings), **Cormorant Garamond** (quotes),
**Plus Jakarta Sans** (body/UI).

## Animations

| Kahan | Kya |
|---|---|
| Hero background | 3 gold orbs `CustomPainter` se dheere ghoomte hain (18s loop) |
| Hero content | Staggered entry — eyebrow → title → divider → text → buttons |
| Hero bottom | Infinite marquee strip, hover par rukti hai |
| Scroll cue | Upar-neeche bounce loop |
| Sab sections | `FadeIn` — scroll par fade + slide up, grid mein row-wise stagger |
| Service cards | Hover par 12px lift + shadow, curve `Cubic(0.175, 0.885, 0.32, 1.275)` |
| Stats | Counter 0 se target tak, `easeOutExpo` |
| About panel | Float karta gold badge |
| Testimonials | Auto-play carousel (5s), swipe karte hi band + animated dots |
| FAQ | Accordion — icon `+` se `×` rotate, height smooth expand |
| Contact form | Submit par form → success tick (`elasticOut`) swap |
| Detail screen | Slide + fade page transition, collapsing SliverAppBar |
| Header | Scroll par transparent se navy, nav links par growing underline |

Sab kuch built-in Flutter animations se hai — koi animation package nahi.

## Dependencies

Sirf ek: `google_fonts`. Baaki sab Flutter built-in.

## Brand naam badalna ho

`lib/data/app_info.dart` mein `name` aur `wordmark` badal dijiye — poori app,
header, hero, footer, page title sab update ho jaayega.

Platform-level naam alag files mein hain (ek baar ka kaam):

| Kahan | File |
|---|---|
| Android launcher | `android/app/src/main/AndroidManifest.xml` → `android:label` |
| iOS app name | `ios/Runner/Info.plist` → `CFBundleDisplayName` |
| Browser tab | `web/index.html` → `<title>` |
| PWA install name | `web/manifest.json` → `name` / `short_name` |

## Content

All copy lives in `lib/data/mock_data.dart` — 9 services (with pricing,
timelines and bullet points), 6 team members, 8 FAQs, 5 testimonials and 4
stats. Replace the strings there with your real content; no other file needs
to change.

## Scroll reveal — important note

`FadeIn` and `AnimatedCounter` detect visibility through
`ScrollNotificationObserver`. Two other approaches were tried first and **both
left every section below the fold permanently invisible**:

1. `NotificationListener<ScrollNotification>` inside the widget — scroll
   notifications bubble *upward* from the scroll view, so they never reach a
   descendant.
2. `Scrollable.maybeOf(context)` — returns the *nearest* scrollable. Inside a
   `GridView` that is the grid's own scrollable, which has
   `NeverScrollableScrollPhysics` and never moves.

If you add a new reveal-style widget, use `ScrollNotificationObserver` too.

## Verify

```
flutter analyze                         → No issues found!
flutter test                            → All tests passed! (3 tests)
flutter build web --release             → ✓
flutter build apk --debug               → ✓
flutter build ios --debug --no-codesign → ✓
```

`test/widget_test.dart` has three tests:

1. Hero renders on load.
2. **Regression test** — scrolls to the services grid and asserts the card is
   actually at `opacity: 1`. This is the test that would have caught the
   empty-sections bug.
3. **Small-screen layout test** — scrolls the whole page at 375×812 and fails on
   any overflow. The brand name is long, so this guards the header, hero and
   footer.

## API baad mein jodni ho

`lib/data/mock_data.dart` ko API call se replace kar dena. Baaki koi file
haath lagane ki zarurat nahi — widgets sirf model classes par depend karte hain.
