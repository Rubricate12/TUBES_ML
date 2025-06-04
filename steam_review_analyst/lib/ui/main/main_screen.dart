import 'package:flutter/material.dart';
import 'package:steam_review_analyst/data/api_service.dart';
import 'package:steam_review_analyst/ui/type/app_route.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _inputController = TextEditingController();
  bool isAnalyzeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(48),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Steam Review Analyst',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: 24),
                        TextField(
                          controller: _inputController,
                          decoration: InputDecoration(
                            label: Text('Enter a review'),
                            border: OutlineInputBorder(),
                          ),
                          minLines: 5,
                          maxLines: 5,
                          onChanged: (text) {
                            setState(() {
                              isAnalyzeEnabled = text.isNotEmpty;
                            });
                          },
                        ),
                        SizedBox(height: 24),
                        FilledButton(
                          onPressed:
                              _inputController.text.isNotEmpty
                                  ? () async {
                                    var result = await ApiService.analyzeReview(_inputController.text);
                                    Navigator.pushNamed(
                                      context,
                                      AppRoute.result.path,
                                      arguments: result,
                                    );
                                  }
                                  : null,
                          child: Text('Analyze'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
