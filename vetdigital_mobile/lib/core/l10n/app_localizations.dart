import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('kk'),
    Locale('ru')
  ];

  /// No description provided for @appTitle.
  ///
  /// In ru, this message translates to:
  /// **'VetDigital'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get login;

  /// No description provided for @loginTitle.
  ///
  /// In ru, this message translates to:
  /// **'Вход в систему'**
  String get loginTitle;

  /// No description provided for @iin.
  ///
  /// In ru, this message translates to:
  /// **'ИИН'**
  String get iin;

  /// No description provided for @iinHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите ИИН (12 цифр)'**
  String get iinHint;

  /// No description provided for @password.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите пароль'**
  String get passwordHint;

  /// No description provided for @loginWithEds.
  ///
  /// In ru, this message translates to:
  /// **'Войти с ЭЦП'**
  String get loginWithEds;

  /// No description provided for @logout.
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get logout;

  /// No description provided for @home.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get home;

  /// No description provided for @animals.
  ///
  /// In ru, this message translates to:
  /// **'Животные'**
  String get animals;

  /// No description provided for @map.
  ///
  /// In ru, this message translates to:
  /// **'Карта'**
  String get map;

  /// No description provided for @procedures.
  ///
  /// In ru, this message translates to:
  /// **'Процедуры'**
  String get procedures;

  /// No description provided for @profile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profile;

  /// No description provided for @dashboard.
  ///
  /// In ru, this message translates to:
  /// **'Дашборд'**
  String get dashboard;

  /// No description provided for @inventory.
  ///
  /// In ru, this message translates to:
  /// **'Инвентарь'**
  String get inventory;

  /// No description provided for @animalList.
  ///
  /// In ru, this message translates to:
  /// **'Список животных'**
  String get animalList;

  /// No description provided for @addAnimal.
  ///
  /// In ru, this message translates to:
  /// **'Добавить животное'**
  String get addAnimal;

  /// No description provided for @scanRfid.
  ///
  /// In ru, this message translates to:
  /// **'Сканировать RFID'**
  String get scanRfid;

  /// No description provided for @identificationNo.
  ///
  /// In ru, this message translates to:
  /// **'Идентификационный номер'**
  String get identificationNo;

  /// No description provided for @microchipNo.
  ///
  /// In ru, this message translates to:
  /// **'Номер микрочипа'**
  String get microchipNo;

  /// No description provided for @rfidTagNo.
  ///
  /// In ru, this message translates to:
  /// **'Номер RFID метки'**
  String get rfidTagNo;

  /// No description provided for @species.
  ///
  /// In ru, this message translates to:
  /// **'Вид животного'**
  String get species;

  /// No description provided for @breed.
  ///
  /// In ru, this message translates to:
  /// **'Порода'**
  String get breed;

  /// No description provided for @sex.
  ///
  /// In ru, this message translates to:
  /// **'Пол'**
  String get sex;

  /// No description provided for @male.
  ///
  /// In ru, this message translates to:
  /// **'Самец (erkek)'**
  String get male;

  /// No description provided for @female.
  ///
  /// In ru, this message translates to:
  /// **'Самка (urgashi)'**
  String get female;

  /// No description provided for @birthDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get birthDate;

  /// No description provided for @color.
  ///
  /// In ru, this message translates to:
  /// **'Масть'**
  String get color;

  /// No description provided for @weight.
  ///
  /// In ru, this message translates to:
  /// **'Вес (кг)'**
  String get weight;

  /// No description provided for @owner.
  ///
  /// In ru, this message translates to:
  /// **'Владелец'**
  String get owner;

  /// No description provided for @region.
  ///
  /// In ru, this message translates to:
  /// **'Регион'**
  String get region;

  /// No description provided for @status.
  ///
  /// In ru, this message translates to:
  /// **'Статус'**
  String get status;

  /// No description provided for @active.
  ///
  /// In ru, this message translates to:
  /// **'Активный'**
  String get active;

  /// No description provided for @deceased.
  ///
  /// In ru, this message translates to:
  /// **'Погиб'**
  String get deceased;

  /// No description provided for @sold.
  ///
  /// In ru, this message translates to:
  /// **'Продан'**
  String get sold;

  /// No description provided for @lost.
  ///
  /// In ru, this message translates to:
  /// **'Потерян'**
  String get lost;

  /// No description provided for @createProcedure.
  ///
  /// In ru, this message translates to:
  /// **'Создать акт'**
  String get createProcedure;

  /// No description provided for @vaccination.
  ///
  /// In ru, this message translates to:
  /// **'Вакцинация'**
  String get vaccination;

  /// No description provided for @allergyTest.
  ///
  /// In ru, this message translates to:
  /// **'Аллергическое исследование'**
  String get allergyTest;

  /// No description provided for @deworming.
  ///
  /// In ru, this message translates to:
  /// **'Дегельминтизация'**
  String get deworming;

  /// No description provided for @treatment.
  ///
  /// In ru, this message translates to:
  /// **'Лечение'**
  String get treatment;

  /// No description provided for @actNumber.
  ///
  /// In ru, this message translates to:
  /// **'Номер акта'**
  String get actNumber;

  /// No description provided for @actDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата проведения'**
  String get actDate;

  /// No description provided for @veterinarian.
  ///
  /// In ru, this message translates to:
  /// **'Ветеринарный врач'**
  String get veterinarian;

  /// No description provided for @diseaseName.
  ///
  /// In ru, this message translates to:
  /// **'Наименование заболевания'**
  String get diseaseName;

  /// No description provided for @vaccineName.
  ///
  /// In ru, this message translates to:
  /// **'Наименование вакцины/аллергена'**
  String get vaccineName;

  /// No description provided for @manufacturer.
  ///
  /// In ru, this message translates to:
  /// **'Завод-изготовитель'**
  String get manufacturer;

  /// No description provided for @series.
  ///
  /// In ru, this message translates to:
  /// **'Серия'**
  String get series;

  /// No description provided for @dose.
  ///
  /// In ru, this message translates to:
  /// **'Доза'**
  String get dose;

  /// No description provided for @sign.
  ///
  /// In ru, this message translates to:
  /// **'Подписать ЭЦП'**
  String get sign;

  /// No description provided for @signed.
  ///
  /// In ru, this message translates to:
  /// **'Подписан'**
  String get signed;

  /// No description provided for @draft.
  ///
  /// In ru, this message translates to:
  /// **'Черновик'**
  String get draft;

  /// No description provided for @geofence.
  ///
  /// In ru, this message translates to:
  /// **'Геозона'**
  String get geofence;

  /// No description provided for @geofences.
  ///
  /// In ru, this message translates to:
  /// **'Геозоны'**
  String get geofences;

  /// No description provided for @createGeofence.
  ///
  /// In ru, this message translates to:
  /// **'Создать геозону'**
  String get createGeofence;

  /// No description provided for @geofenceAlert.
  ///
  /// In ru, this message translates to:
  /// **'Нарушение геозоны'**
  String get geofenceAlert;

  /// No description provided for @animalExited.
  ///
  /// In ru, this message translates to:
  /// **'Животное вышло за пределы геозоны'**
  String get animalExited;

  /// No description provided for @liveMap.
  ///
  /// In ru, this message translates to:
  /// **'Карта (онлайн)'**
  String get liveMap;

  /// No description provided for @offline.
  ///
  /// In ru, this message translates to:
  /// **'Оффлайн'**
  String get offline;

  /// No description provided for @syncing.
  ///
  /// In ru, this message translates to:
  /// **'Синхронизация...'**
  String get syncing;

  /// No description provided for @syncComplete.
  ///
  /// In ru, this message translates to:
  /// **'Синхронизация завершена'**
  String get syncComplete;

  /// No description provided for @pendingChanges.
  ///
  /// In ru, this message translates to:
  /// **'{count} несинхронизированных изменений'**
  String pendingChanges(int count);

  /// No description provided for @totalAnimals.
  ///
  /// In ru, this message translates to:
  /// **'Всего животных'**
  String get totalAnimals;

  /// No description provided for @vaccinationCoverage.
  ///
  /// In ru, this message translates to:
  /// **'Охват вакцинацией'**
  String get vaccinationCoverage;

  /// No description provided for @loading.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get error;

  /// No description provided for @retry.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @confirm.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердить'**
  String get confirm;

  /// No description provided for @language.
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get language;

  /// No description provided for @russian.
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get russian;

  /// No description provided for @kazakh.
  ///
  /// In ru, this message translates to:
  /// **'Қазақ тілі'**
  String get kazakh;

  /// No description provided for @english.
  ///
  /// In ru, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @cattle.
  ///
  /// In ru, this message translates to:
  /// **'Крупный рогатый скот (КРС)'**
  String get cattle;

  /// No description provided for @sheep.
  ///
  /// In ru, this message translates to:
  /// **'Овцы (МРС)'**
  String get sheep;

  /// No description provided for @goat.
  ///
  /// In ru, this message translates to:
  /// **'Козы (МРС)'**
  String get goat;

  /// No description provided for @horse.
  ///
  /// In ru, this message translates to:
  /// **'Лошади'**
  String get horse;

  /// No description provided for @camel.
  ///
  /// In ru, this message translates to:
  /// **'Верблюды'**
  String get camel;

  /// No description provided for @deer.
  ///
  /// In ru, this message translates to:
  /// **'Маралы'**
  String get deer;

  /// No description provided for @poultry.
  ///
  /// In ru, this message translates to:
  /// **'Птицы'**
  String get poultry;

  /// No description provided for @dog.
  ///
  /// In ru, this message translates to:
  /// **'Собаки'**
  String get dog;

  /// No description provided for @cat.
  ///
  /// In ru, this message translates to:
  /// **'Кошки'**
  String get cat;

  /// No description provided for @noAnimals.
  ///
  /// In ru, this message translates to:
  /// **'Животные не найдены'**
  String get noAnimals;

  /// No description provided for @noGeofences.
  ///
  /// In ru, this message translates to:
  /// **'Геозоны не найдены'**
  String get noGeofences;

  /// No description provided for @connectionError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка подключения к серверу'**
  String get connectionError;

  /// No description provided for @invalidIin.
  ///
  /// In ru, this message translates to:
  /// **'Неверный формат ИИН'**
  String get invalidIin;

  /// No description provided for @required.
  ///
  /// In ru, this message translates to:
  /// **'Обязательное поле'**
  String get required;
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
      <String>['kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'kk':
      return AppLocalizationsKk();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
