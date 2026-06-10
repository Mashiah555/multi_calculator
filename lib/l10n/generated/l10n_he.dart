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

  @override
  String get meter => 'מטר';

  @override
  String get meterCode => 'מ\'';

  @override
  String get kilometer => 'קילומטר';

  @override
  String get kilometerCode => 'ק\"מ';

  @override
  String get centimeter => 'סנטימטר';

  @override
  String get centimeterCode => 'ס\"מ';

  @override
  String get millimeter => 'מילימטר';

  @override
  String get millimeterCode => 'מ\"מ';

  @override
  String get mile => 'מייל';

  @override
  String get mileCode => '';

  @override
  String get yard => 'יארד';

  @override
  String get yardCode => '';

  @override
  String get foot => 'רגל';

  @override
  String get footCode => '';

  @override
  String get inch => 'אינץ\'';

  @override
  String get inchCode => '';

  @override
  String get lightYear => 'שנות אור';

  @override
  String get lightYearCode => '';
}
