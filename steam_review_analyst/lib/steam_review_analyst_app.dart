import 'package:flutter/material.dart';
import 'package:steam_review_analyst/ui/main/main_screen.dart';
import 'package:steam_review_analyst/ui/result/result_screen.dart';
import 'package:steam_review_analyst/ui/type/analysis_result.dart';
import 'package:steam_review_analyst/ui/type/app_route.dart';

class SteamReviewAnalystApp extends StatelessWidget {
  const SteamReviewAnalystApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steam Review Analyst',
      theme: ThemeData(colorSchemeSeed: Color(0xFF171D25)),
      initialRoute: AppRoute.main.path,
      routes: {
        AppRoute.main.path: (context) => MainScreen(),
        AppRoute.result.path:
            (context) => ResultScreen(
              result:
                  ModalRoute.of(context)?.settings.arguments as AnalysisResult,
            ),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
