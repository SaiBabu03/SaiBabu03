import 'package:flutter/material.dart';

class VideoPreviewScreen extends StatelessWidget {
  final String prompt;

  const VideoPreviewScreen({super.key, required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Preview')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.movie_creation_outlined, size: 120, color: Colors.deepPurple),
            const SizedBox(height: 20),
            Text(
              'Your AI-generated video based on:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '"$prompt"',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Generate Another'),
            ),
          ],
        ),
      ),
    );
  }
}