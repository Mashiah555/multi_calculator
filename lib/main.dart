import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multi_calculator/providers/settings_provider.dart';
import 'package:multi_calculator/screens/main_screen.dart';
import 'package:multi_calculator/services/preferences_service.dart';
import 'package:multi_calculator/l10n/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load SharedPreferences before the app starts
  await PreferencesService.instance.init();
  final prefs = PreferencesService.instance.prefs;
  final bool? isOnboardingDone = prefs.getBool('onboarding_done');

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: MultiCalculatorApp(isOnboardingDone: isOnboardingDone ?? false),
    ),
  );
}

class MultiCalculatorApp extends ConsumerWidget {
  final bool isOnboardingDone;

  const MultiCalculatorApp({super.key, required this.isOnboardingDone});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current theme and locale
    final currentTheme = ref.watch(themeModeProvider);
    final currentLocale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'Multi Calculator',
      themeMode: currentTheme,
      // This is the theme of your application.
      //
      // TRY THIS: Try running your application with "flutter run". You'll see
      // the application has a purple toolbar. Then, without quitting the app,
      // try changing the seedColor in the colorScheme below to Colors.green
      // and then invoke "hot reload" (save your changes or press the "hot
      // reload" button in a Flutter-supported IDE, or press "r" if you used
      // the command line to start the app).
      //
      // Notice that the counter didn't reset back to zero; the application
      // state is not lost during the reload. To reset the state, use hot
      // restart instead.
      //
      // This works for code too, not just values: Most code changes can be
      // tested with just a hot reload.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan.shade900,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        useSystemColors: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan.shade700,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      // -- LOCALIZATION SETUP --
      locale: currentLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('he'), // Hebrew
      ],

      //home: isOnboardingDone ? const MainScreen() : const OnboardingScreen(),
      home: const MainScreen(),
    );
  }
}
