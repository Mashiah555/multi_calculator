import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_calculator/l10n/generated/l10n.dart';
import 'package:multi_calculator/screens/calculators/basic_calculator.dart';
import 'package:multi_calculator/widgets/menu_sheet.dart';

class AppNavIndexNotifier extends Notifier<int> {
  @override
  int build() {
    return 0; // Initial state (first option)
  }

  void setIndex(int index) {
    state = index;
  }
}

final appNavIndexProvider = NotifierProvider<AppNavIndexNotifier, int>(() {
  return AppNavIndexNotifier();
});

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentIndex = ref.watch(appNavIndexProvider);

    // Helper method to map the current index to the correct title
    String getCurrentTitle() {
      switch (currentIndex) {
        case 0:
          return l10n.placeholder;
        case 1:
          return l10n.placeholder;
        default:
          return '';
      }
    }

    // The screens for each tab.
    final List<Widget> screens = [
      const BasicCalculator(),
      const BasicCalculator(),
    ];

    return Scaffold(
      // The universal AppBar that stays consistent across all screens
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
        centerTitle: true,
        title: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            // Open the pre-programmed bottom sheet
            showModalBottomSheet(
              context: context,
              builder: (context) => MenuSheet(
                theme: Theme.of(context).colorScheme,
                items: <MenuItem>[
                  MenuItem(id: 'basic', title: 'Basic Calculator'),
                  MenuItem(id: 'advanced', title: 'Advanced Calculator'),
                ],
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize
                  .min, // Keeps the InkWell wrapped tightly around the text
              children: [
                Text(
                  getCurrentTitle(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                ), // Visual cue that it's a dropdown
              ],
            ),
          ),
        ),
      ),
      // Only the body changes, the AppBar remains fixed
      body: IndexedStack(index: currentIndex, children: screens),
    );
  }
}
