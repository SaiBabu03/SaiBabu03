import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/credit_bloc.dart';
import 'screens/text_to_video_screen.dart';

void main() {
  runApp(const TextToVideoApp());
}

class TextToVideoApp extends StatelessWidget {
  const TextToVideoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CreditBloc()),
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