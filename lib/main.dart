import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_colors.dart';
import 'features/auth/screens/auth_gate.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) => options.dsn = AppConstants.sentryDsn,
    appRunner: () async {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Civicly',
      theme: ThemeData(scaffoldBackgroundColor: AppColors.background, fontFamily: 'Inter'),
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
      home: const AuthGate(),
    );
  }
}
