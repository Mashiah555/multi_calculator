import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_he.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('he'),
  ];

  /// Generic placeholder text for undefined or empty values
  ///
  /// In en, this message translates to:
  /// **'--TBD--'**
  String get placeholder;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Theme mode setting title
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// Light option for the theme mode setting
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Dark option for the theme mode setting
  ///
  /// In en, this message translates to:
  /// **'dark'**
  String get dark;

  /// Default system option for the theme mode setting
  ///
  /// In en, this message translates to:
  /// **'As System'**
  String get system;

  /// Language setting title
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// The title and name of the different calculators
  ///
  /// In en, this message translates to:
  /// **'{adjective} Calculator'**
  String calculator(String adjective);

  /// The title and name of the different converters
  ///
  /// In en, this message translates to:
  /// **'{adjective} Converter'**
  String converter(String adjective);

  /// The adjective 'Basic'
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get basic;

  /// The adjective 'Advanced'
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// The adjective 'Length'
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get length;

  /// The adjective 'Mass'
  ///
  /// In en, this message translates to:
  /// **'Mass'**
  String get mass;

  /// The adjective 'Area'
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// The adjective 'Volume'
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// The adjective 'Time'
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// The adjective 'Data'
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// The adjective 'Speed'
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// The adjective 'Temperature'
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// The distance unit 'Meter'
  ///
  /// In en, this message translates to:
  /// **'Meter'**
  String get meter;

  /// The distance unit 'Meter' code value
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get meterCode;

  /// The distance unit 'Kilometer'
  ///
  /// In en, this message translates to:
  /// **'Kilometer'**
  String get kilometer;

  /// The distance unit 'Meter' code value
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get kilometerCode;

  /// The distance unit 'Centimeter'
  ///
  /// In en, this message translates to:
  /// **'Centimeter'**
  String get centimeter;

  /// The distance unit 'Centimeter' code value
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get centimeterCode;

  /// The distance unit 'Millimeter'
  ///
  /// In en, this message translates to:
  /// **'Millimeter'**
  String get millimeter;

  /// The distance unit 'Millimeter' code value
  ///
  /// In en, this message translates to:
  /// **'mm'**
  String get millimeterCode;

  /// The distance unit 'Mile'
  ///
  /// In en, this message translates to:
  /// **'Mile'**
  String get mile;

  /// The distance unit 'Mile' code value
  ///
  /// In en, this message translates to:
  /// **'mi'**
  String get mileCode;

  /// The distance unit 'Yard'
  ///
  /// In en, this message translates to:
  /// **'Yard'**
  String get yard;

  /// The distance unit 'Yard' code value
  ///
  /// In en, this message translates to:
  /// **'yd'**
  String get yardCode;

  /// The distance unit 'Foot'
  ///
  /// In en, this message translates to:
  /// **'Foot'**
  String get foot;

  /// The distance unit 'Foot' code value
  ///
  /// In en, this message translates to:
  /// **'ft'**
  String get footCode;

  /// The distance unit 'Inch'
  ///
  /// In en, this message translates to:
  /// **'Inch'**
  String get inch;

  /// The distance unit 'Inch' code value
  ///
  /// In en, this message translates to:
  /// **'in'**
  String get inchCode;

  /// The distance unit 'Light Year'
  ///
  /// In en, this message translates to:
  /// **'Light Year'**
  String get lightYear;

  /// The distance unit 'Light Year' code value
  ///
  /// In en, this message translates to:
  /// **'ly'**
  String get lightYearCode;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'he'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'he':
      return AppLocalizationsHe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
