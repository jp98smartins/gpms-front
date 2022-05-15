import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gpms/app/modules/splash/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SplashPage());
  }
}

void main() {
  group(
    "SplashPage -",
    () {
      testWidgets(
        "Rendering the App Icon in SplashPage",
        (WidgetTester tester) async {
          await tester.pumpWidget(const MyApp());

          expect(find.byType(Scaffold), findsOneWidget);
          expect(find.byKey(const Key("AppIcon")), findsOneWidget);
        },
      );
    },
  );
}
