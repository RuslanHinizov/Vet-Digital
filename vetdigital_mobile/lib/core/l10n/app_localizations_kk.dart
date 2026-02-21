// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appTitle => 'VetDigital';

  @override
  String get login => 'Кіру';

  @override
  String get loginTitle => 'Жүйеге кіру';

  @override
  String get iin => 'ЖСН';

  @override
  String get iinHint => 'ЖСН енгізіңіз (12 сан)';

  @override
  String get password => 'Құпия сөз';

  @override
  String get passwordHint => 'Құпия сөзді енгізіңіз';

  @override
  String get loginWithEds => 'ЭЦҚ арқылы кіру';

  @override
  String get logout => 'Шығу';

  @override
  String get home => 'Басты бет';

  @override
  String get animals => 'Жануарлар';

  @override
  String get map => 'Карта';

  @override
  String get procedures => 'Шаралар';

  @override
  String get profile => 'Профиль';

  @override
  String get dashboard => 'Бақылау тақтасы';

  @override
  String get inventory => 'Жабдықтар';

  @override
  String get animalList => 'Жануарлар тізімі';

  @override
  String get addAnimal => 'Жануар қосу';

  @override
  String get scanRfid => 'RFID сканерлеу';

  @override
  String get identificationNo => 'Бірдейлендіру нөмірі';

  @override
  String get microchipNo => 'Микрочип нөмірі';

  @override
  String get rfidTagNo => 'RFID белгі нөмірі';

  @override
  String get species => 'Жануар түрі';

  @override
  String get breed => 'Тұқымы';

  @override
  String get sex => 'Жынысы';

  @override
  String get male => 'Еркек';

  @override
  String get female => 'Ұрғашы';

  @override
  String get birthDate => 'Туған күні';

  @override
  String get color => 'Түсі';

  @override
  String get weight => 'Салмағы (кг)';

  @override
  String get owner => 'Иесі';

  @override
  String get region => 'Аймақ';

  @override
  String get status => 'Мәртебесі';

  @override
  String get active => 'Белсенді';

  @override
  String get deceased => 'Қайтыс болды';

  @override
  String get sold => 'Сатылды';

  @override
  String get lost => 'Жоғалды';

  @override
  String get createProcedure => 'Акт жасау';

  @override
  String get vaccination => 'Егу';

  @override
  String get allergyTest => 'Аллергиялық зерттеу';

  @override
  String get deworming => 'Гельминттерге қарсы';

  @override
  String get treatment => 'Ем';

  @override
  String get actNumber => 'Акт нөмірі';

  @override
  String get actDate => 'Өткізілген күні';

  @override
  String get veterinarian => 'Ветеринар маман';

  @override
  String get diseaseName => 'Аурудың атауы';

  @override
  String get vaccineName => 'Вакцина/аллерген атауы';

  @override
  String get manufacturer => 'Өндіруші зауыт';

  @override
  String get series => 'Сериясы';

  @override
  String get dose => 'Дозасы';

  @override
  String get sign => 'ЭЦҚ қол қою';

  @override
  String get signed => 'Қол қойылған';

  @override
  String get draft => 'Жоба';

  @override
  String get geofence => 'Геоқоршау';

  @override
  String get geofences => 'Геоқоршаулар';

  @override
  String get createGeofence => 'Геоқоршау жасау';

  @override
  String get geofenceAlert => 'Геоқоршау бұзылды';

  @override
  String get animalExited => 'Жануар геоқоршаудан шықты';

  @override
  String get liveMap => 'Карта (онлайн)';

  @override
  String get offline => 'Желісіз';

  @override
  String get syncing => 'Синхрондалуда...';

  @override
  String get syncComplete => 'Синхрондау аяқталды';

  @override
  String pendingChanges(int count) {
    return '$count синхрондалмаған өзгерістер';
  }

  @override
  String get totalAnimals => 'Жануарлардың жалпы саны';

  @override
  String get vaccinationCoverage => 'Егу қамту';

  @override
  String get loading => 'Жүктелуде...';

  @override
  String get error => 'Қате';

  @override
  String get retry => 'Қайталау';

  @override
  String get cancel => 'Бас тарту';

  @override
  String get save => 'Сақтау';

  @override
  String get delete => 'Жою';

  @override
  String get confirm => 'Растау';

  @override
  String get language => 'Тіл';

  @override
  String get russian => 'Орысша';

  @override
  String get kazakh => 'Қазақша';

  @override
  String get english => 'Ағылшынша';

  @override
  String get cattle => 'Ірі қара мал (ІҚМ)';

  @override
  String get sheep => 'Қой (ұсақ мал)';

  @override
  String get goat => 'Ешкі (ұсақ мал)';

  @override
  String get horse => 'Жылқы';

  @override
  String get camel => 'Түйе';

  @override
  String get deer => 'Маралдар';

  @override
  String get poultry => 'Құстар';

  @override
  String get dog => 'Иттер';

  @override
  String get cat => 'Мысықтар';

  @override
  String get noAnimals => 'Жануарлар табылмады';

  @override
  String get noGeofences => 'Геоқоршаулар табылмады';

  @override
  String get connectionError => 'Сервермен байланыс қатесі';

  @override
  String get invalidIin => 'ЖСН форматы қате';

  @override
  String get required => 'Міндетті өріс';
}
