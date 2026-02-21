// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'VetDigital';

  @override
  String get login => 'Войти';

  @override
  String get loginTitle => 'Вход в систему';

  @override
  String get iin => 'ИИН';

  @override
  String get iinHint => 'Введите ИИН (12 цифр)';

  @override
  String get password => 'Пароль';

  @override
  String get passwordHint => 'Введите пароль';

  @override
  String get loginWithEds => 'Войти с ЭЦП';

  @override
  String get logout => 'Выйти';

  @override
  String get home => 'Главная';

  @override
  String get animals => 'Животные';

  @override
  String get map => 'Карта';

  @override
  String get procedures => 'Процедуры';

  @override
  String get profile => 'Профиль';

  @override
  String get dashboard => 'Дашборд';

  @override
  String get inventory => 'Инвентарь';

  @override
  String get animalList => 'Список животных';

  @override
  String get addAnimal => 'Добавить животное';

  @override
  String get scanRfid => 'Сканировать RFID';

  @override
  String get identificationNo => 'Идентификационный номер';

  @override
  String get microchipNo => 'Номер микрочипа';

  @override
  String get rfidTagNo => 'Номер RFID метки';

  @override
  String get species => 'Вид животного';

  @override
  String get breed => 'Порода';

  @override
  String get sex => 'Пол';

  @override
  String get male => 'Самец (erkek)';

  @override
  String get female => 'Самка (urgashi)';

  @override
  String get birthDate => 'Дата рождения';

  @override
  String get color => 'Масть';

  @override
  String get weight => 'Вес (кг)';

  @override
  String get owner => 'Владелец';

  @override
  String get region => 'Регион';

  @override
  String get status => 'Статус';

  @override
  String get active => 'Активный';

  @override
  String get deceased => 'Погиб';

  @override
  String get sold => 'Продан';

  @override
  String get lost => 'Потерян';

  @override
  String get createProcedure => 'Создать акт';

  @override
  String get vaccination => 'Вакцинация';

  @override
  String get allergyTest => 'Аллергическое исследование';

  @override
  String get deworming => 'Дегельминтизация';

  @override
  String get treatment => 'Лечение';

  @override
  String get actNumber => 'Номер акта';

  @override
  String get actDate => 'Дата проведения';

  @override
  String get veterinarian => 'Ветеринарный врач';

  @override
  String get diseaseName => 'Наименование заболевания';

  @override
  String get vaccineName => 'Наименование вакцины/аллергена';

  @override
  String get manufacturer => 'Завод-изготовитель';

  @override
  String get series => 'Серия';

  @override
  String get dose => 'Доза';

  @override
  String get sign => 'Подписать ЭЦП';

  @override
  String get signed => 'Подписан';

  @override
  String get draft => 'Черновик';

  @override
  String get geofence => 'Геозона';

  @override
  String get geofences => 'Геозоны';

  @override
  String get createGeofence => 'Создать геозону';

  @override
  String get geofenceAlert => 'Нарушение геозоны';

  @override
  String get animalExited => 'Животное вышло за пределы геозоны';

  @override
  String get liveMap => 'Карта (онлайн)';

  @override
  String get offline => 'Оффлайн';

  @override
  String get syncing => 'Синхронизация...';

  @override
  String get syncComplete => 'Синхронизация завершена';

  @override
  String pendingChanges(int count) {
    return '$count несинхронизированных изменений';
  }

  @override
  String get totalAnimals => 'Всего животных';

  @override
  String get vaccinationCoverage => 'Охват вакцинацией';

  @override
  String get loading => 'Загрузка...';

  @override
  String get error => 'Ошибка';

  @override
  String get retry => 'Повторить';

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get delete => 'Удалить';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get language => 'Язык';

  @override
  String get russian => 'Русский';

  @override
  String get kazakh => 'Қазақ тілі';

  @override
  String get english => 'English';

  @override
  String get cattle => 'Крупный рогатый скот (КРС)';

  @override
  String get sheep => 'Овцы (МРС)';

  @override
  String get goat => 'Козы (МРС)';

  @override
  String get horse => 'Лошади';

  @override
  String get camel => 'Верблюды';

  @override
  String get deer => 'Маралы';

  @override
  String get poultry => 'Птицы';

  @override
  String get dog => 'Собаки';

  @override
  String get cat => 'Кошки';

  @override
  String get noAnimals => 'Животные не найдены';

  @override
  String get noGeofences => 'Геозоны не найдены';

  @override
  String get connectionError => 'Ошибка подключения к серверу';

  @override
  String get invalidIin => 'Неверный формат ИИН';

  @override
  String get required => 'Обязательное поле';
}
