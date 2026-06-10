import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_calculator/l10n/generated/l10n.dart';
import 'package:multi_calculator/screens/calculators/advanced_calculator.dart';
import 'package:multi_calculator/screens/calculators/basic_calculator.dart';
import 'package:multi_calculator/screens/calculators/length_converter.dart';
import 'package:multi_calculator/screens/settings_screen.dart';
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

    // The screens for each calculator.
    final screens = [
      MenuItem(
        id: 'basic',
        title: l10n.calculator(l10n.basic),
        isSelected: true,
      ),
      MenuItem(id: 'advanced', title: l10n.calculator(l10n.advanced)),
      MenuItem(
        id: 'length',
        title: l10n.converter(l10n.length),
        icon: Icons.expand_rounded,
      ),
      MenuItem(
        id: 'mass',
        title: l10n.converter(l10n.mass),
        icon: Icons.scale_rounded,
      ),
      MenuItem(
        id: 'area',
        title: l10n.converter(l10n.area),
        icon: Icons.fullscreen_rounded,
      ),
      MenuItem(
        id: 'volume',
        title: l10n.converter(l10n.volume),
        icon: Icons.fullscreen_exit_rounded,
      ),
      MenuItem(
        id: 'time',
        title: l10n.converter(l10n.time),
        icon: Icons.access_time_rounded,
      ),
      MenuItem(
        id: 'speed',
        title: l10n.converter(l10n.speed),
        icon: Icons.timer_rounded,
      ),
      MenuItem(
        id: 'data',
        title: l10n.converter(l10n.data),
        icon: Icons.storage_rounded,
      ),
      MenuItem(
        id: 'temperature',
        title: l10n.converter(l10n.temperature),
        icon: Icons.thermostat_rounded,
      ),
    ];
    String activeTitle = screens[0].title;

    // Helper method to map the current index to the correct title
    Widget getCurrentScreen(int? index) {
      switch (screens[(index ?? currentIndex)].id) {
        case 'basic':
          return const BasicCalculator();
        case 'advanced':
          return const AdvancedCalculator();
        case 'length':
          return const LengthConverter();
        default:
          return const BasicCalculator();
      }
    }

    return Scaffold(
      // The universal AppBar that stays consistent across all screens
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            ),
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
        centerTitle: true,
        title: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () async {
            // Open the pre-programmed bottom sheet
            final selection = await showModalBottomSheet(
              context: context,
              builder: (context) => MenuSheet(
                theme: Theme.of(context).colorScheme,
                items: screens,
                defaultIcon: Icons.calculate_rounded,
              ),
            );

            if (selection != null) {
              final selectedItem =
                  screens.where((s) => s.id == selection).firstOrNull ??
                  screens[0];
              activeTitle = selectedItem.title;
              ref
                  .read(appNavIndexProvider.notifier)
                  .setIndex(screens.indexOf(selectedItem));
            }
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
                  activeTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ),
      ),
      // Only the body changes, the AppBar remains fixed
      body: IndexedStack(
        index: currentIndex,
        children: List.generate(
          screens.length,
          (index) => getCurrentScreen(index),
        ),
      ),
    );
  }
}
