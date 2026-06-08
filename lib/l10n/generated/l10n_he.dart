// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get placeholder => '--TBD_HE--';

  @override
  String get settings => 'הגדרות';

  @override
  String get themeMode => 'מצב עיצוב';

  @override
  String get light => 'בהיר';

  @override
  String get dark => 'מוחשך';

  @override
  String get system => 'הגדרות מערכת';

  @override
  String get language => 'שפה';

  @override
  String calculator(String adjective) {
    return 'מחשבון $adjective';
  }

  @override
  String converter(String adjective) {
    return 'המרת $adjective';
  }

  @override
  String get basic => 'פשוט';

  @override
  String get advanced => 'מתקדם';

  @override
  String get length => 'אורך';

  @override
  String get mass => 'משקל';

  @override
  String get area => 'שטח';

  @override
  String get volume => 'נפח';

  @override
  String get time => 'זמן';

  @override
  String get data => 'דאטה';

  @override
  String get speed => 'מהירות';

  @override
  String get temperature => 'טמפרטורה';
}
