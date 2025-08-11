import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/credit_bloc.dart';
import 'video_preview_screen.dart';

class TextToVideoScreen extends StatefulWidget {
  const TextToVideoScreen({super.key});

  @override
  State<TextToVideoScreen> createState() => _TextToVideoScreenState();
}

class _TextToVideoScreenState extends State<TextToVideoScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isGenerating = false;

  Future<void> _generateVideo() async {
    final creditBloc = context.read<CreditBloc>();
    if (_isGenerating) return;

    if (creditBloc.state.credits <= 0) {
      _showPurchaseDialog();
      return;
    }

    final prompt = _controller.text.trim();
    if (prompt.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a prompt.')),
      );
      return;
    }

    // Deduct credit
    creditBloc.add(const SpendCredit());

    setState(() => _isGenerating = true);

    // Show loading animation
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Lottie.network(
            'https://assets10.lottiefiles.com/private_files/lf30_m6j5igxb.json',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );

    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 5));

    if (mounted) Navigator.of(context).pop(); // Close animation dialog

    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => VideoPreviewScreen(prompt: prompt)),
      );
    }

    setState(() => _isGenerating = false);
  }

  void _showPurchaseDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _PurchaseSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final creditCount = context.select((CreditBloc bloc) => bloc.state.credits);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Text-to-Video'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: _showPurchaseDialog,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Describe the video you want...',
                border: OutlineInputBorder(),
              ),
              minLines: 1,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Credits: $creditCount', style: Theme.of(context).textTheme.titleMedium),
                ElevatedButton.icon(
                  onPressed: _isGenerating ? null : _generateVideo,
                  icon: const Icon(Icons.smart_display),
                  label: const Text('Generate Video'),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'Each generation costs 1 credit',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _PurchaseSheet extends StatelessWidget {
  const _PurchaseSheet();

  @override
  Widget build(BuildContext context) {
    final creditBloc = context.read<CreditBloc>();

    void purchase(int amount) {
      creditBloc.add(AddCredits(amount: amount));
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchased $amount credits!')),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Buy More Credits', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _CreditPack(amount: 10, price: 2.99, onTap: purchase),
              _CreditPack(amount: 25, price: 5.99, onTap: purchase),
              _CreditPack(amount: 60, price: 9.99, onTap: purchase),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _CreditPack extends StatelessWidget {
  final int amount;
  final double price;
  final void Function(int) onTap;

  const _CreditPack({
    required this.amount,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(amount),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.deepPurple.shade200),
        ),
        child: Column(
          children: [
            Text('$amount', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('credits'),
            const SizedBox(height: 8),
            Text('\$${price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}