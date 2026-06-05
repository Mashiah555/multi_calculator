import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_calculator/l10n/generated/l10n.dart';

class BasicCalculator extends ConsumerStatefulWidget {
  const BasicCalculator({super.key});

  @override
  ConsumerState<BasicCalculator> createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends ConsumerState<BasicCalculator> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  void dispose() {
    // TODO: implement dispose, as needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: const Text('100 + 83 = 183', style: TextStyle(fontSize: 60)),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
