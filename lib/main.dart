import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/credit_provider.dart';
import 'screens/text_to_video_screen.dart';

void main() {
  runApp(const TextToVideoApp());
}

class TextToVideoApp extends StatelessWidget {
  const TextToVideoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CreditProvider()),
      ],
      child: MaterialApp(
        title: 'AI Text-to-Video',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const TextToVideoScreen(),
      ),
    );
  }
}