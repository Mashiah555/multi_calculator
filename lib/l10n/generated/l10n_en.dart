// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get placeholder => '--TBD--';

  @override
  String get settings => 'Settings';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get light => 'Light';

  @override
  String get dark => 'dark';

  @override
  String get system => 'As System';

  @override
  String get language => 'Language';

  @override
  String calculator(String adjective) {
    return '$adjective Calculator';
  }

  @override
  String converter(String adjective) {
    return '$adjective Converter';
  }

  @override
  String get basic => 'Basic';

  @override
  String get advanced => 'Advanced';

  @override
  String get length => 'Length';

  @override
  String get mass => 'Mass';

  @override
  String get area => 'Area';

  @override
  String get volume => 'Volume';

  @override
  String get time => 'Time';

  @override
  String get data => 'Data';

  @override
  String get speed => 'Speed';

  @override
  String get temperature => 'Temperature';
}
