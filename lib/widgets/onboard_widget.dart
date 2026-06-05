import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_calculator/models/onboard_item.dart';

class OnboardWidget extends StatelessWidget {
  const OnboardWidget({super.key, required this.item});

  final OnboardItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          item.lottieUrl,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('Error loading Lottie asset: $error');
            return const Icon(
              Icons.broken_image,
              size: 150,
              color: Colors.grey,
            );
          },
        ),
        const SizedBox(height: 30),
        Text(
          item.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          item.subTitle,
          style: theme.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
