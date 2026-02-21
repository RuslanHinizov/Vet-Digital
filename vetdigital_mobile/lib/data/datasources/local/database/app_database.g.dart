// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalUsersTable extends LocalUsers
    with TableInfo<$LocalUsersTable, LocalUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iinMeta = const VerificationMeta('iin');
  @override
  late final GeneratedColumn<String> iin = GeneratedColumn<String>(
      'iin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _organizationNameMeta =
      const VerificationMeta('organizationName');
  @override
  late final GeneratedColumn<String> organizationName = GeneratedColumn<String>(
      'organization_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _regionNameMeta =
      const VerificationMeta('regionName');
  @override
  late final GeneratedColumn<String> regionName = GeneratedColumn<String>(
      'region_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accessTokenMeta =
      const VerificationMeta('accessToken');
  @override
  late final GeneratedColumn<String> accessToken = GeneratedColumn<String>(
      'access_token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _refreshTokenMeta =
      const VerificationMeta('refreshToken');
  @override
  late final GeneratedColumn<String> refreshToken = GeneratedColumn<String>(
      'refresh_token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tokenExpiresAtMeta =
      const VerificationMeta('tokenExpiresAt');
  @override
  late final GeneratedColumn<DateTime> tokenExpiresAt =
      GeneratedColumn<DateTime>('token_expires_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastSyncAtMeta =
      const VerificationMeta('lastSyncAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncAt = GeneratedColumn<DateTime>(
      'last_sync_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        iin,
        fullName,
        role,
        organizationName,
        regionName,
        accessToken,
        refreshToken,
        tokenExpiresAt,
        lastSyncAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_users';
  @override
  VerificationContext validateIntegrity(Insertable<LocalUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('iin')) {
      context.handle(
          _iinMeta, iin.isAcceptableOrUnknown(data['iin']!, _iinMeta));
    } else if (isInserting) {
      context.missing(_iinMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('organization_name')) {
      context.handle(
          _organizationNameMeta,
          organizationName.isAcceptableOrUnknown(
              data['organization_name']!, _organizationNameMeta));
    }
    if (data.containsKey('region_name')) {
      context.handle(
          _regionNameMeta,
          regionName.isAcceptableOrUnknown(
              data['region_name']!, _regionNameMeta));
    }
    if (data.containsKey('access_token')) {
      context.handle(
          _accessTokenMeta,
          accessToken.isAcceptableOrUnknown(
              data['access_token']!, _accessTokenMeta));
    }
    if (data.containsKey('refresh_token')) {
      context.handle(
          _refreshTokenMeta,
          refreshToken.isAcceptableOrUnknown(
              data['refresh_token']!, _refreshTokenMeta));
    }
    if (data.containsKey('token_expires_at')) {
      context.handle(
          _tokenExpiresAtMeta,
          tokenExpiresAt.isAcceptableOrUnknown(
              data['token_expires_at']!, _tokenExpiresAtMeta));
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
          _lastSyncAtMeta,
          lastSyncAt.isAcceptableOrUnknown(
              data['last_sync_at']!, _lastSyncAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUser(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      iin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}iin'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      organizationName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}organization_name']),
      regionName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region_name']),
      accessToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}access_token']),
      refreshToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}refresh_token']),
      tokenExpiresAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}token_expires_at']),
      lastSyncAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync_at']),
    );
  }

  @override
  $LocalUsersTable createAlias(String alias) {
    return $LocalUsersTable(attachedDatabase, alias);
  }
}

class LocalUser extends DataClass implements Insertable<LocalUser> {
  final String id;
  final String iin;
  final String fullName;
  final String role;
  final String? organizationName;
  final String? regionName;
  final String? accessToken;
  final String? refreshToken;
  final DateTime? tokenExpiresAt;
  final DateTime? lastSyncAt;
  const LocalUser(
      {required this.id,
      required this.iin,
      required this.fullName,
      required this.role,
      this.organizationName,
      this.regionName,
      this.accessToken,
      this.refreshToken,
      this.tokenExpiresAt,
      this.lastSyncAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['iin'] = Variable<String>(iin);
    map['full_name'] = Variable<String>(fullName);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || organizationName != null) {
      map['organization_name'] = Variable<String>(organizationName);
    }
    if (!nullToAbsent || regionName != null) {
      map['region_name'] = Variable<String>(regionName);
    }
    if (!nullToAbsent || accessToken != null) {
      map['access_token'] = Variable<String>(accessToken);
    }
    if (!nullToAbsent || refreshToken != null) {
      map['refresh_token'] = Variable<String>(refreshToken);
    }
    if (!nullToAbsent || tokenExpiresAt != null) {
      map['token_expires_at'] = Variable<DateTime>(tokenExpiresAt);
    }
    if (!nullToAbsent || lastSyncAt != null) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt);
    }
    return map;
  }

  LocalUsersCompanion toCompanion(bool nullToAbsent) {
    return LocalUsersCompanion(
      id: Value(id),
      iin: Value(iin),
      fullName: Value(fullName),
      role: Value(role),
      organizationName: organizationName == null && nullToAbsent
          ? const Value.absent()
          : Value(organizationName),
      regionName: regionName == null && nullToAbsent
          ? const Value.absent()
          : Value(regionName),
      accessToken: accessToken == null && nullToAbsent
          ? const Value.absent()
          : Value(accessToken),
      refreshToken: refreshToken == null && nullToAbsent
          ? const Value.absent()
          : Value(refreshToken),
      tokenExpiresAt: tokenExpiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(tokenExpiresAt),
      lastSyncAt: lastSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAt),
    );
  }

  factory LocalUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUser(
      id: serializer.fromJson<String>(json['id']),
      iin: serializer.fromJson<String>(json['iin']),
      fullName: serializer.fromJson<String>(json['fullName']),
      role: serializer.fromJson<String>(json['role']),
      organizationName: serializer.fromJson<String?>(json['organizationName']),
      regionName: serializer.fromJson<String?>(json['regionName']),
      accessToken: serializer.fromJson<String?>(json['accessToken']),
      refreshToken: serializer.fromJson<String?>(json['refreshToken']),
      tokenExpiresAt: serializer.fromJson<DateTime?>(json['tokenExpiresAt']),
      lastSyncAt: serializer.fromJson<DateTime?>(json['lastSyncAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'iin': serializer.toJson<String>(iin),
      'fullName': serializer.toJson<String>(fullName),
      'role': serializer.toJson<String>(role),
      'organizationName': serializer.toJson<String?>(organizationName),
      'regionName': serializer.toJson<String?>(regionName),
      'accessToken': serializer.toJson<String?>(accessToken),
      'refreshToken': serializer.toJson<String?>(refreshToken),
      'tokenExpiresAt': serializer.toJson<DateTime?>(tokenExpiresAt),
      'lastSyncAt': serializer.toJson<DateTime?>(lastSyncAt),
    };
  }

  LocalUser copyWith(
          {String? id,
          String? iin,
          String? fullName,
          String? role,
          Value<String?> organizationName = const Value.absent(),
          Value<String?> regionName = const Value.absent(),
          Value<String?> accessToken = const Value.absent(),
          Value<String?> refreshToken = const Value.absent(),
          Value<DateTime?> tokenExpiresAt = const Value.absent(),
          Value<DateTime?> lastSyncAt = const Value.absent()}) =>
      LocalUser(
        id: id ?? this.id,
        iin: iin ?? this.iin,
        fullName: fullName ?? this.fullName,
        role: role ?? this.role,
        organizationName: organizationName.present
            ? organizationName.value
            : this.organizationName,
        regionName: regionName.present ? regionName.value : this.regionName,
        accessToken: accessToken.present ? accessToken.value : this.accessToken,
        refreshToken:
            refreshToken.present ? refreshToken.value : this.refreshToken,
        tokenExpiresAt:
            tokenExpiresAt.present ? tokenExpiresAt.value : this.tokenExpiresAt,
        lastSyncAt: lastSyncAt.present ? lastSyncAt.value : this.lastSyncAt,
      );
  LocalUser copyWithCompanion(LocalUsersCompanion data) {
    return LocalUser(
      id: data.id.present ? data.id.value : this.id,
      iin: data.iin.present ? data.iin.value : this.iin,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      role: data.role.present ? data.role.value : this.role,
      organizationName: data.organizationName.present
          ? data.organizationName.value
          : this.organizationName,
      regionName:
          data.regionName.present ? data.regionName.value : this.regionName,
      accessToken:
          data.accessToken.present ? data.accessToken.value : this.accessToken,
      refreshToken: data.refreshToken.present
          ? data.refreshToken.value
          : this.refreshToken,
      tokenExpiresAt: data.tokenExpiresAt.present
          ? data.tokenExpiresAt.value
          : this.tokenExpiresAt,
      lastSyncAt:
          data.lastSyncAt.present ? data.lastSyncAt.value : this.lastSyncAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUser(')
          ..write('id: $id, ')
          ..write('iin: $iin, ')
          ..write('fullName: $fullName, ')
          ..write('role: $role, ')
          ..write('organizationName: $organizationName, ')
          ..write('regionName: $regionName, ')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('tokenExpiresAt: $tokenExpiresAt, ')
          ..write('lastSyncAt: $lastSyncAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, iin, fullName, role, organizationName,
      regionName, accessToken, refreshToken, tokenExpiresAt, lastSyncAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUser &&
          other.id == this.id &&
          other.iin == this.iin &&
          other.fullName == this.fullName &&
          other.role == this.role &&
          other.organizationName == this.organizationName &&
          other.regionName == this.regionName &&
          other.accessToken == this.accessToken &&
          other.refreshToken == this.refreshToken &&
          other.tokenExpiresAt == this.tokenExpiresAt &&
          other.lastSyncAt == this.lastSyncAt);
}

class LocalUsersCompanion extends UpdateCompanion<LocalUser> {
  final Value<String> id;
  final Value<String> iin;
  final Value<String> fullName;
  final Value<String> role;
  final Value<String?> organizationName;
  final Value<String?> regionName;
  final Value<String?> accessToken;
  final Value<String?> refreshToken;
  final Value<DateTime?> tokenExpiresAt;
  final Value<DateTime?> lastSyncAt;
  final Value<int> rowid;
  const LocalUsersCompanion({
    this.id = const Value.absent(),
    this.iin = const Value.absent(),
    this.fullName = const Value.absent(),
    this.role = const Value.absent(),
    this.organizationName = const Value.absent(),
    this.regionName = const Value.absent(),
    this.accessToken = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.tokenExpiresAt = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUsersCompanion.insert({
    required String id,
    required String iin,
    required String fullName,
    required String role,
    this.organizationName = const Value.absent(),
    this.regionName = const Value.absent(),
    this.accessToken = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.tokenExpiresAt = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        iin = Value(iin),
        fullName = Value(fullName),
        role = Value(role);
  static Insertable<LocalUser> custom({
    Expression<String>? id,
    Expression<String>? iin,
    Expression<String>? fullName,
    Expression<String>? role,
    Expression<String>? organizationName,
    Expression<String>? regionName,
    Expression<String>? accessToken,
    Expression<String>? refreshToken,
    Expression<DateTime>? tokenExpiresAt,
    Expression<DateTime>? lastSyncAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (iin != null) 'iin': iin,
      if (fullName != null) 'full_name': fullName,
      if (role != null) 'role': role,
      if (organizationName != null) 'organization_name': organizationName,
      if (regionName != null) 'region_name': regionName,
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (tokenExpiresAt != null) 'token_expires_at': tokenExpiresAt,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? iin,
      Value<String>? fullName,
      Value<String>? role,
      Value<String?>? organizationName,
      Value<String?>? regionName,
      Value<String?>? accessToken,
      Value<String?>? refreshToken,
      Value<DateTime?>? tokenExpiresAt,
      Value<DateTime?>? lastSyncAt,
      Value<int>? rowid}) {
    return LocalUsersCompanion(
      id: id ?? this.id,
      iin: iin ?? this.iin,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      organizationName: organizationName ?? this.organizationName,
      regionName: regionName ?? this.regionName,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      tokenExpiresAt: tokenExpiresAt ?? this.tokenExpiresAt,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (iin.present) {
      map['iin'] = Variable<String>(iin.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (organizationName.present) {
      map['organization_name'] = Variable<String>(organizationName.value);
    }
    if (regionName.present) {
      map['region_name'] = Variable<String>(regionName.value);
    }
    if (accessToken.present) {
      map['access_token'] = Variable<String>(accessToken.value);
    }
    if (refreshToken.present) {
      map['refresh_token'] = Variable<String>(refreshToken.value);
    }
    if (tokenExpiresAt.present) {
      map['token_expires_at'] = Variable<DateTime>(tokenExpiresAt.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsersCompanion(')
          ..write('id: $id, ')
          ..write('iin: $iin, ')
          ..write('fullName: $fullName, ')
          ..write('role: $role, ')
          ..write('organizationName: $organizationName, ')
          ..write('regionName: $regionName, ')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('tokenExpiresAt: $tokenExpiresAt, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalAnimalsTable extends LocalAnimals
    with TableInfo<$LocalAnimalsTable, LocalAnimal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalAnimalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localIdMeta =
      const VerificationMeta('localId');
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
      'local_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _identificationNoMeta =
      const VerificationMeta('identificationNo');
  @override
  late final GeneratedColumn<String> identificationNo = GeneratedColumn<String>(
      'identification_no', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _microchipNoMeta =
      const VerificationMeta('microchipNo');
  @override
  late final GeneratedColumn<String> microchipNo = GeneratedColumn<String>(
      'microchip_no', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rfidTagNoMeta =
      const VerificationMeta('rfidTagNo');
  @override
  late final GeneratedColumn<String> rfidTagNo = GeneratedColumn<String>(
      'rfid_tag_no', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _speciesIdMeta =
      const VerificationMeta('speciesId');
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
      'species_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _speciesNameMeta =
      const VerificationMeta('speciesName');
  @override
  late final GeneratedColumn<String> speciesName = GeneratedColumn<String>(
      'species_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _breedNameMeta =
      const VerificationMeta('breedName');
  @override
  late final GeneratedColumn<String> breedName = GeneratedColumn<String>(
      'breed_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
      'sex', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _birthDateMeta =
      const VerificationMeta('birthDate');
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
      'birth_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _birthYearMeta =
      const VerificationMeta('birthYear');
  @override
  late final GeneratedColumn<int> birthYear = GeneratedColumn<int>(
      'birth_year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _ownerIdMeta =
      const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
      'owner_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ownerNameMeta =
      const VerificationMeta('ownerName');
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
      'owner_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ownerIinMeta =
      const VerificationMeta('ownerIin');
  @override
  late final GeneratedColumn<String> ownerIin = GeneratedColumn<String>(
      'owner_iin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _regionNameMeta =
      const VerificationMeta('regionName');
  @override
  late final GeneratedColumn<String> regionName = GeneratedColumn<String>(
      'region_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastLatitudeMeta =
      const VerificationMeta('lastLatitude');
  @override
  late final GeneratedColumn<double> lastLatitude = GeneratedColumn<double>(
      'last_latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _lastLongitudeMeta =
      const VerificationMeta('lastLongitude');
  @override
  late final GeneratedColumn<double> lastLongitude = GeneratedColumn<double>(
      'last_longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _lastSeenAtMeta =
      const VerificationMeta('lastSeenAt');
  @override
  late final GeneratedColumn<DateTime> lastSeenAt = GeneratedColumn<DateTime>(
      'last_seen_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        localId,
        identificationNo,
        microchipNo,
        rfidTagNo,
        speciesId,
        speciesName,
        breedName,
        sex,
        birthDate,
        birthYear,
        color,
        weightKg,
        status,
        ownerId,
        ownerName,
        ownerIin,
        regionName,
        lastLatitude,
        lastLongitude,
        lastSeenAt,
        isSynced,
        isDeleted,
        createdAt,
        updatedAt,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_animals';
  @override
  VerificationContext validateIntegrity(Insertable<LocalAnimal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    }
    if (data.containsKey('identification_no')) {
      context.handle(
          _identificationNoMeta,
          identificationNo.isAcceptableOrUnknown(
              data['identification_no']!, _identificationNoMeta));
    }
    if (data.containsKey('microchip_no')) {
      context.handle(
          _microchipNoMeta,
          microchipNo.isAcceptableOrUnknown(
              data['microchip_no']!, _microchipNoMeta));
    }
    if (data.containsKey('rfid_tag_no')) {
      context.handle(
          _rfidTagNoMeta,
          rfidTagNo.isAcceptableOrUnknown(
              data['rfid_tag_no']!, _rfidTagNoMeta));
    }
    if (data.containsKey('species_id')) {
      context.handle(_speciesIdMeta,
          speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta));
    }
    if (data.containsKey('species_name')) {
      context.handle(
          _speciesNameMeta,
          speciesName.isAcceptableOrUnknown(
              data['species_name']!, _speciesNameMeta));
    }
    if (data.containsKey('breed_name')) {
      context.handle(_breedNameMeta,
          breedName.isAcceptableOrUnknown(data['breed_name']!, _breedNameMeta));
    }
    if (data.containsKey('sex')) {
      context.handle(
          _sexMeta, sex.isAcceptableOrUnknown(data['sex']!, _sexMeta));
    }
    if (data.containsKey('birth_date')) {
      context.handle(_birthDateMeta,
          birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta));
    }
    if (data.containsKey('birth_year')) {
      context.handle(_birthYearMeta,
          birthYear.isAcceptableOrUnknown(data['birth_year']!, _birthYearMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    }
    if (data.containsKey('owner_name')) {
      context.handle(_ownerNameMeta,
          ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta));
    }
    if (data.containsKey('owner_iin')) {
      context.handle(_ownerIinMeta,
          ownerIin.isAcceptableOrUnknown(data['owner_iin']!, _ownerIinMeta));
    }
    if (data.containsKey('region_name')) {
      context.handle(
          _regionNameMeta,
          regionName.isAcceptableOrUnknown(
              data['region_name']!, _regionNameMeta));
    }
    if (data.containsKey('last_latitude')) {
      context.handle(
          _lastLatitudeMeta,
          lastLatitude.isAcceptableOrUnknown(
              data['last_latitude']!, _lastLatitudeMeta));
    }
    if (data.containsKey('last_longitude')) {
      context.handle(
          _lastLongitudeMeta,
          lastLongitude.isAcceptableOrUnknown(
              data['last_longitude']!, _lastLongitudeMeta));
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
          _lastSeenAtMeta,
          lastSeenAt.isAcceptableOrUnknown(
              data['last_seen_at']!, _lastSeenAtMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalAnimal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalAnimal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      localId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_id']),
      identificationNo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}identification_no']),
      microchipNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}microchip_no']),
      rfidTagNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rfid_tag_no']),
      speciesId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species_id']),
      speciesName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species_name']),
      breedName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}breed_name']),
      sex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sex']),
      birthDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birth_date']),
      birthYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}birth_year']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      ownerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id']),
      ownerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_name']),
      ownerIin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_iin']),
      regionName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region_name']),
      lastLatitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}last_latitude']),
      lastLongitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}last_longitude']),
      lastSeenAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_seen_at']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $LocalAnimalsTable createAlias(String alias) {
    return $LocalAnimalsTable(attachedDatabase, alias);
  }
}

class LocalAnimal extends DataClass implements Insertable<LocalAnimal> {
  final String id;
  final String? localId;
  final String? identificationNo;
  final String? microchipNo;
  final String? rfidTagNo;
  final String? speciesId;
  final String? speciesName;
  final String? breedName;
  final String? sex;
  final DateTime? birthDate;
  final int? birthYear;
  final String? color;
  final double? weightKg;
  final String status;
  final String? ownerId;
  final String? ownerName;
  final String? ownerIin;
  final String? regionName;
  final double? lastLatitude;
  final double? lastLongitude;
  final DateTime? lastSeenAt;
  final bool isSynced;
  final bool isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime cachedAt;
  const LocalAnimal(
      {required this.id,
      this.localId,
      this.identificationNo,
      this.microchipNo,
      this.rfidTagNo,
      this.speciesId,
      this.speciesName,
      this.breedName,
      this.sex,
      this.birthDate,
      this.birthYear,
      this.color,
      this.weightKg,
      required this.status,
      this.ownerId,
      this.ownerName,
      this.ownerIin,
      this.regionName,
      this.lastLatitude,
      this.lastLongitude,
      this.lastSeenAt,
      required this.isSynced,
      required this.isDeleted,
      this.createdAt,
      this.updatedAt,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || localId != null) {
      map['local_id'] = Variable<String>(localId);
    }
    if (!nullToAbsent || identificationNo != null) {
      map['identification_no'] = Variable<String>(identificationNo);
    }
    if (!nullToAbsent || microchipNo != null) {
      map['microchip_no'] = Variable<String>(microchipNo);
    }
    if (!nullToAbsent || rfidTagNo != null) {
      map['rfid_tag_no'] = Variable<String>(rfidTagNo);
    }
    if (!nullToAbsent || speciesId != null) {
      map['species_id'] = Variable<String>(speciesId);
    }
    if (!nullToAbsent || speciesName != null) {
      map['species_name'] = Variable<String>(speciesName);
    }
    if (!nullToAbsent || breedName != null) {
      map['breed_name'] = Variable<String>(breedName);
    }
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<String>(sex);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    if (!nullToAbsent || birthYear != null) {
      map['birth_year'] = Variable<int>(birthYear);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<String>(ownerId);
    }
    if (!nullToAbsent || ownerName != null) {
      map['owner_name'] = Variable<String>(ownerName);
    }
    if (!nullToAbsent || ownerIin != null) {
      map['owner_iin'] = Variable<String>(ownerIin);
    }
    if (!nullToAbsent || regionName != null) {
      map['region_name'] = Variable<String>(regionName);
    }
    if (!nullToAbsent || lastLatitude != null) {
      map['last_latitude'] = Variable<double>(lastLatitude);
    }
    if (!nullToAbsent || lastLongitude != null) {
      map['last_longitude'] = Variable<double>(lastLongitude);
    }
    if (!nullToAbsent || lastSeenAt != null) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  LocalAnimalsCompanion toCompanion(bool nullToAbsent) {
    return LocalAnimalsCompanion(
      id: Value(id),
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      identificationNo: identificationNo == null && nullToAbsent
          ? const Value.absent()
          : Value(identificationNo),
      microchipNo: microchipNo == null && nullToAbsent
          ? const Value.absent()
          : Value(microchipNo),
      rfidTagNo: rfidTagNo == null && nullToAbsent
          ? const Value.absent()
          : Value(rfidTagNo),
      speciesId: speciesId == null && nullToAbsent
          ? const Value.absent()
          : Value(speciesId),
      speciesName: speciesName == null && nullToAbsent
          ? const Value.absent()
          : Value(speciesName),
      breedName: breedName == null && nullToAbsent
          ? const Value.absent()
          : Value(breedName),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      birthYear: birthYear == null && nullToAbsent
          ? const Value.absent()
          : Value(birthYear),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      status: Value(status),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
      ownerName: ownerName == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerName),
      ownerIin: ownerIin == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerIin),
      regionName: regionName == null && nullToAbsent
          ? const Value.absent()
          : Value(regionName),
      lastLatitude: lastLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLatitude),
      lastLongitude: lastLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLongitude),
      lastSeenAt: lastSeenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeenAt),
      isSynced: Value(isSynced),
      isDeleted: Value(isDeleted),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      cachedAt: Value(cachedAt),
    );
  }

  factory LocalAnimal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalAnimal(
      id: serializer.fromJson<String>(json['id']),
      localId: serializer.fromJson<String?>(json['localId']),
      identificationNo: serializer.fromJson<String?>(json['identificationNo']),
      microchipNo: serializer.fromJson<String?>(json['microchipNo']),
      rfidTagNo: serializer.fromJson<String?>(json['rfidTagNo']),
      speciesId: serializer.fromJson<String?>(json['speciesId']),
      speciesName: serializer.fromJson<String?>(json['speciesName']),
      breedName: serializer.fromJson<String?>(json['breedName']),
      sex: serializer.fromJson<String?>(json['sex']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
      birthYear: serializer.fromJson<int?>(json['birthYear']),
      color: serializer.fromJson<String?>(json['color']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      status: serializer.fromJson<String>(json['status']),
      ownerId: serializer.fromJson<String?>(json['ownerId']),
      ownerName: serializer.fromJson<String?>(json['ownerName']),
      ownerIin: serializer.fromJson<String?>(json['ownerIin']),
      regionName: serializer.fromJson<String?>(json['regionName']),
      lastLatitude: serializer.fromJson<double?>(json['lastLatitude']),
      lastLongitude: serializer.fromJson<double?>(json['lastLongitude']),
      lastSeenAt: serializer.fromJson<DateTime?>(json['lastSeenAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'localId': serializer.toJson<String?>(localId),
      'identificationNo': serializer.toJson<String?>(identificationNo),
      'microchipNo': serializer.toJson<String?>(microchipNo),
      'rfidTagNo': serializer.toJson<String?>(rfidTagNo),
      'speciesId': serializer.toJson<String?>(speciesId),
      'speciesName': serializer.toJson<String?>(speciesName),
      'breedName': serializer.toJson<String?>(breedName),
      'sex': serializer.toJson<String?>(sex),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
      'birthYear': serializer.toJson<int?>(birthYear),
      'color': serializer.toJson<String?>(color),
      'weightKg': serializer.toJson<double?>(weightKg),
      'status': serializer.toJson<String>(status),
      'ownerId': serializer.toJson<String?>(ownerId),
      'ownerName': serializer.toJson<String?>(ownerName),
      'ownerIin': serializer.toJson<String?>(ownerIin),
      'regionName': serializer.toJson<String?>(regionName),
      'lastLatitude': serializer.toJson<double?>(lastLatitude),
      'lastLongitude': serializer.toJson<double?>(lastLongitude),
      'lastSeenAt': serializer.toJson<DateTime?>(lastSeenAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  LocalAnimal copyWith(
          {String? id,
          Value<String?> localId = const Value.absent(),
          Value<String?> identificationNo = const Value.absent(),
          Value<String?> microchipNo = const Value.absent(),
          Value<String?> rfidTagNo = const Value.absent(),
          Value<String?> speciesId = const Value.absent(),
          Value<String?> speciesName = const Value.absent(),
          Value<String?> breedName = const Value.absent(),
          Value<String?> sex = const Value.absent(),
          Value<DateTime?> birthDate = const Value.absent(),
          Value<int?> birthYear = const Value.absent(),
          Value<String?> color = const Value.absent(),
          Value<double?> weightKg = const Value.absent(),
          String? status,
          Value<String?> ownerId = const Value.absent(),
          Value<String?> ownerName = const Value.absent(),
          Value<String?> ownerIin = const Value.absent(),
          Value<String?> regionName = const Value.absent(),
          Value<double?> lastLatitude = const Value.absent(),
          Value<double?> lastLongitude = const Value.absent(),
          Value<DateTime?> lastSeenAt = const Value.absent(),
          bool? isSynced,
          bool? isDeleted,
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent(),
          DateTime? cachedAt}) =>
      LocalAnimal(
        id: id ?? this.id,
        localId: localId.present ? localId.value : this.localId,
        identificationNo: identificationNo.present
            ? identificationNo.value
            : this.identificationNo,
        microchipNo: microchipNo.present ? microchipNo.value : this.microchipNo,
        rfidTagNo: rfidTagNo.present ? rfidTagNo.value : this.rfidTagNo,
        speciesId: speciesId.present ? speciesId.value : this.speciesId,
        speciesName: speciesName.present ? speciesName.value : this.speciesName,
        breedName: breedName.present ? breedName.value : this.breedName,
        sex: sex.present ? sex.value : this.sex,
        birthDate: birthDate.present ? birthDate.value : this.birthDate,
        birthYear: birthYear.present ? birthYear.value : this.birthYear,
        color: color.present ? color.value : this.color,
        weightKg: weightKg.present ? weightKg.value : this.weightKg,
        status: status ?? this.status,
        ownerId: ownerId.present ? ownerId.value : this.ownerId,
        ownerName: ownerName.present ? ownerName.value : this.ownerName,
        ownerIin: ownerIin.present ? ownerIin.value : this.ownerIin,
        regionName: regionName.present ? regionName.value : this.regionName,
        lastLatitude:
            lastLatitude.present ? lastLatitude.value : this.lastLatitude,
        lastLongitude:
            lastLongitude.present ? lastLongitude.value : this.lastLongitude,
        lastSeenAt: lastSeenAt.present ? lastSeenAt.value : this.lastSeenAt,
        isSynced: isSynced ?? this.isSynced,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  LocalAnimal copyWithCompanion(LocalAnimalsCompanion data) {
    return LocalAnimal(
      id: data.id.present ? data.id.value : this.id,
      localId: data.localId.present ? data.localId.value : this.localId,
      identificationNo: data.identificationNo.present
          ? data.identificationNo.value
          : this.identificationNo,
      microchipNo:
          data.microchipNo.present ? data.microchipNo.value : this.microchipNo,
      rfidTagNo: data.rfidTagNo.present ? data.rfidTagNo.value : this.rfidTagNo,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      speciesName:
          data.speciesName.present ? data.speciesName.value : this.speciesName,
      breedName: data.breedName.present ? data.breedName.value : this.breedName,
      sex: data.sex.present ? data.sex.value : this.sex,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      birthYear: data.birthYear.present ? data.birthYear.value : this.birthYear,
      color: data.color.present ? data.color.value : this.color,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      status: data.status.present ? data.status.value : this.status,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      ownerIin: data.ownerIin.present ? data.ownerIin.value : this.ownerIin,
      regionName:
          data.regionName.present ? data.regionName.value : this.regionName,
      lastLatitude: data.lastLatitude.present
          ? data.lastLatitude.value
          : this.lastLatitude,
      lastLongitude: data.lastLongitude.present
          ? data.lastLongitude.value
          : this.lastLongitude,
      lastSeenAt:
          data.lastSeenAt.present ? data.lastSeenAt.value : this.lastSeenAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalAnimal(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('identificationNo: $identificationNo, ')
          ..write('microchipNo: $microchipNo, ')
          ..write('rfidTagNo: $rfidTagNo, ')
          ..write('speciesId: $speciesId, ')
          ..write('speciesName: $speciesName, ')
          ..write('breedName: $breedName, ')
          ..write('sex: $sex, ')
          ..write('birthDate: $birthDate, ')
          ..write('birthYear: $birthYear, ')
          ..write('color: $color, ')
          ..write('weightKg: $weightKg, ')
          ..write('status: $status, ')
          ..write('ownerId: $ownerId, ')
          ..write('ownerName: $ownerName, ')
          ..write('ownerIin: $ownerIin, ')
          ..write('regionName: $regionName, ')
          ..write('lastLatitude: $lastLatitude, ')
          ..write('lastLongitude: $lastLongitude, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        localId,
        identificationNo,
        microchipNo,
        rfidTagNo,
        speciesId,
        speciesName,
        breedName,
        sex,
        birthDate,
        birthYear,
        color,
        weightKg,
        status,
        ownerId,
        ownerName,
        ownerIin,
        regionName,
        lastLatitude,
        lastLongitude,
        lastSeenAt,
        isSynced,
        isDeleted,
        createdAt,
        updatedAt,
        cachedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalAnimal &&
          other.id == this.id &&
          other.localId == this.localId &&
          other.identificationNo == this.identificationNo &&
          other.microchipNo == this.microchipNo &&
          other.rfidTagNo == this.rfidTagNo &&
          other.speciesId == this.speciesId &&
          other.speciesName == this.speciesName &&
          other.breedName == this.breedName &&
          other.sex == this.sex &&
          other.birthDate == this.birthDate &&
          other.birthYear == this.birthYear &&
          other.color == this.color &&
          other.weightKg == this.weightKg &&
          other.status == this.status &&
          other.ownerId == this.ownerId &&
          other.ownerName == this.ownerName &&
          other.ownerIin == this.ownerIin &&
          other.regionName == this.regionName &&
          other.lastLatitude == this.lastLatitude &&
          other.lastLongitude == this.lastLongitude &&
          other.lastSeenAt == this.lastSeenAt &&
          other.isSynced == this.isSynced &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.cachedAt == this.cachedAt);
}

class LocalAnimalsCompanion extends UpdateCompanion<LocalAnimal> {
  final Value<String> id;
  final Value<String?> localId;
  final Value<String?> identificationNo;
  final Value<String?> microchipNo;
  final Value<String?> rfidTagNo;
  final Value<String?> speciesId;
  final Value<String?> speciesName;
  final Value<String?> breedName;
  final Value<String?> sex;
  final Value<DateTime?> birthDate;
  final Value<int?> birthYear;
  final Value<String?> color;
  final Value<double?> weightKg;
  final Value<String> status;
  final Value<String?> ownerId;
  final Value<String?> ownerName;
  final Value<String?> ownerIin;
  final Value<String?> regionName;
  final Value<double?> lastLatitude;
  final Value<double?> lastLongitude;
  final Value<DateTime?> lastSeenAt;
  final Value<bool> isSynced;
  final Value<bool> isDeleted;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const LocalAnimalsCompanion({
    this.id = const Value.absent(),
    this.localId = const Value.absent(),
    this.identificationNo = const Value.absent(),
    this.microchipNo = const Value.absent(),
    this.rfidTagNo = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.speciesName = const Value.absent(),
    this.breedName = const Value.absent(),
    this.sex = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.birthYear = const Value.absent(),
    this.color = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.status = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.ownerIin = const Value.absent(),
    this.regionName = const Value.absent(),
    this.lastLatitude = const Value.absent(),
    this.lastLongitude = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalAnimalsCompanion.insert({
    required String id,
    this.localId = const Value.absent(),
    this.identificationNo = const Value.absent(),
    this.microchipNo = const Value.absent(),
    this.rfidTagNo = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.speciesName = const Value.absent(),
    this.breedName = const Value.absent(),
    this.sex = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.birthYear = const Value.absent(),
    this.color = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.status = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.ownerIin = const Value.absent(),
    this.regionName = const Value.absent(),
    this.lastLatitude = const Value.absent(),
    this.lastLongitude = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<LocalAnimal> custom({
    Expression<String>? id,
    Expression<String>? localId,
    Expression<String>? identificationNo,
    Expression<String>? microchipNo,
    Expression<String>? rfidTagNo,
    Expression<String>? speciesId,
    Expression<String>? speciesName,
    Expression<String>? breedName,
    Expression<String>? sex,
    Expression<DateTime>? birthDate,
    Expression<int>? birthYear,
    Expression<String>? color,
    Expression<double>? weightKg,
    Expression<String>? status,
    Expression<String>? ownerId,
    Expression<String>? ownerName,
    Expression<String>? ownerIin,
    Expression<String>? regionName,
    Expression<double>? lastLatitude,
    Expression<double>? lastLongitude,
    Expression<DateTime>? lastSeenAt,
    Expression<bool>? isSynced,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localId != null) 'local_id': localId,
      if (identificationNo != null) 'identification_no': identificationNo,
      if (microchipNo != null) 'microchip_no': microchipNo,
      if (rfidTagNo != null) 'rfid_tag_no': rfidTagNo,
      if (speciesId != null) 'species_id': speciesId,
      if (speciesName != null) 'species_name': speciesName,
      if (breedName != null) 'breed_name': breedName,
      if (sex != null) 'sex': sex,
      if (birthDate != null) 'birth_date': birthDate,
      if (birthYear != null) 'birth_year': birthYear,
      if (color != null) 'color': color,
      if (weightKg != null) 'weight_kg': weightKg,
      if (status != null) 'status': status,
      if (ownerId != null) 'owner_id': ownerId,
      if (ownerName != null) 'owner_name': ownerName,
      if (ownerIin != null) 'owner_iin': ownerIin,
      if (regionName != null) 'region_name': regionName,
      if (lastLatitude != null) 'last_latitude': lastLatitude,
      if (lastLongitude != null) 'last_longitude': lastLongitude,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalAnimalsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? localId,
      Value<String?>? identificationNo,
      Value<String?>? microchipNo,
      Value<String?>? rfidTagNo,
      Value<String?>? speciesId,
      Value<String?>? speciesName,
      Value<String?>? breedName,
      Value<String?>? sex,
      Value<DateTime?>? birthDate,
      Value<int?>? birthYear,
      Value<String?>? color,
      Value<double?>? weightKg,
      Value<String>? status,
      Value<String?>? ownerId,
      Value<String?>? ownerName,
      Value<String?>? ownerIin,
      Value<String?>? regionName,
      Value<double?>? lastLatitude,
      Value<double?>? lastLongitude,
      Value<DateTime?>? lastSeenAt,
      Value<bool>? isSynced,
      Value<bool>? isDeleted,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return LocalAnimalsCompanion(
      id: id ?? this.id,
      localId: localId ?? this.localId,
      identificationNo: identificationNo ?? this.identificationNo,
      microchipNo: microchipNo ?? this.microchipNo,
      rfidTagNo: rfidTagNo ?? this.rfidTagNo,
      speciesId: speciesId ?? this.speciesId,
      speciesName: speciesName ?? this.speciesName,
      breedName: breedName ?? this.breedName,
      sex: sex ?? this.sex,
      birthDate: birthDate ?? this.birthDate,
      birthYear: birthYear ?? this.birthYear,
      color: color ?? this.color,
      weightKg: weightKg ?? this.weightKg,
      status: status ?? this.status,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      ownerIin: ownerIin ?? this.ownerIin,
      regionName: regionName ?? this.regionName,
      lastLatitude: lastLatitude ?? this.lastLatitude,
      lastLongitude: lastLongitude ?? this.lastLongitude,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (identificationNo.present) {
      map['identification_no'] = Variable<String>(identificationNo.value);
    }
    if (microchipNo.present) {
      map['microchip_no'] = Variable<String>(microchipNo.value);
    }
    if (rfidTagNo.present) {
      map['rfid_tag_no'] = Variable<String>(rfidTagNo.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (speciesName.present) {
      map['species_name'] = Variable<String>(speciesName.value);
    }
    if (breedName.present) {
      map['breed_name'] = Variable<String>(breedName.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (birthYear.present) {
      map['birth_year'] = Variable<int>(birthYear.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (ownerIin.present) {
      map['owner_iin'] = Variable<String>(ownerIin.value);
    }
    if (regionName.present) {
      map['region_name'] = Variable<String>(regionName.value);
    }
    if (lastLatitude.present) {
      map['last_latitude'] = Variable<double>(lastLatitude.value);
    }
    if (lastLongitude.present) {
      map['last_longitude'] = Variable<double>(lastLongitude.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalAnimalsCompanion(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('identificationNo: $identificationNo, ')
          ..write('microchipNo: $microchipNo, ')
          ..write('rfidTagNo: $rfidTagNo, ')
          ..write('speciesId: $speciesId, ')
          ..write('speciesName: $speciesName, ')
          ..write('breedName: $breedName, ')
          ..write('sex: $sex, ')
          ..write('birthDate: $birthDate, ')
          ..write('birthYear: $birthYear, ')
          ..write('color: $color, ')
          ..write('weightKg: $weightKg, ')
          ..write('status: $status, ')
          ..write('ownerId: $ownerId, ')
          ..write('ownerName: $ownerName, ')
          ..write('ownerIin: $ownerIin, ')
          ..write('regionName: $regionName, ')
          ..write('lastLatitude: $lastLatitude, ')
          ..write('lastLongitude: $lastLongitude, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalProcedureActsTable extends LocalProcedureActs
    with TableInfo<$LocalProcedureActsTable, LocalProcedureAct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalProcedureActsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localIdMeta =
      const VerificationMeta('localId');
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
      'local_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actNumberMeta =
      const VerificationMeta('actNumber');
  @override
  late final GeneratedColumn<String> actNumber = GeneratedColumn<String>(
      'act_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actDateMeta =
      const VerificationMeta('actDate');
  @override
  late final GeneratedColumn<DateTime> actDate = GeneratedColumn<DateTime>(
      'act_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _procedureTypeMeta =
      const VerificationMeta('procedureType');
  @override
  late final GeneratedColumn<String> procedureType = GeneratedColumn<String>(
      'procedure_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _diseaseNameMeta =
      const VerificationMeta('diseaseName');
  @override
  late final GeneratedColumn<String> diseaseName = GeneratedColumn<String>(
      'disease_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _settlementMeta =
      const VerificationMeta('settlement');
  @override
  late final GeneratedColumn<String> settlement = GeneratedColumn<String>(
      'settlement', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _specialistNameMeta =
      const VerificationMeta('specialistName');
  @override
  late final GeneratedColumn<String> specialistName = GeneratedColumn<String>(
      'specialist_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ownerIinMeta =
      const VerificationMeta('ownerIin');
  @override
  late final GeneratedColumn<String> ownerIin = GeneratedColumn<String>(
      'owner_iin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ownerNameMeta =
      const VerificationMeta('ownerName');
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
      'owner_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _speciesNameMeta =
      const VerificationMeta('speciesName');
  @override
  late final GeneratedColumn<String> speciesName = GeneratedColumn<String>(
      'species_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _maleCountMeta =
      const VerificationMeta('maleCount');
  @override
  late final GeneratedColumn<int> maleCount = GeneratedColumn<int>(
      'male_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _femaleCountMeta =
      const VerificationMeta('femaleCount');
  @override
  late final GeneratedColumn<int> femaleCount = GeneratedColumn<int>(
      'female_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _youngCountMeta =
      const VerificationMeta('youngCount');
  @override
  late final GeneratedColumn<int> youngCount = GeneratedColumn<int>(
      'young_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _totalVaccinatedMeta =
      const VerificationMeta('totalVaccinated');
  @override
  late final GeneratedColumn<int> totalVaccinated = GeneratedColumn<int>(
      'total_vaccinated', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _vaccineNameMeta =
      const VerificationMeta('vaccineName');
  @override
  late final GeneratedColumn<String> vaccineName = GeneratedColumn<String>(
      'vaccine_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _manufacturerMeta =
      const VerificationMeta('manufacturer');
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
      'manufacturer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _seriesMeta = const VerificationMeta('series');
  @override
  late final GeneratedColumn<String> series = GeneratedColumn<String>(
      'series', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('draft'));
  static const VerificationMeta _animalsJsonMeta =
      const VerificationMeta('animalsJson');
  @override
  late final GeneratedColumn<String> animalsJson = GeneratedColumn<String>(
      'animals_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        localId,
        actNumber,
        actDate,
        procedureType,
        diseaseName,
        settlement,
        specialistName,
        ownerIin,
        ownerName,
        speciesName,
        maleCount,
        femaleCount,
        youngCount,
        totalVaccinated,
        vaccineName,
        manufacturer,
        series,
        status,
        animalsJson,
        isSynced,
        createdAt,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_procedure_acts';
  @override
  VerificationContext validateIntegrity(Insertable<LocalProcedureAct> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    }
    if (data.containsKey('act_number')) {
      context.handle(_actNumberMeta,
          actNumber.isAcceptableOrUnknown(data['act_number']!, _actNumberMeta));
    } else if (isInserting) {
      context.missing(_actNumberMeta);
    }
    if (data.containsKey('act_date')) {
      context.handle(_actDateMeta,
          actDate.isAcceptableOrUnknown(data['act_date']!, _actDateMeta));
    } else if (isInserting) {
      context.missing(_actDateMeta);
    }
    if (data.containsKey('procedure_type')) {
      context.handle(
          _procedureTypeMeta,
          procedureType.isAcceptableOrUnknown(
              data['procedure_type']!, _procedureTypeMeta));
    } else if (isInserting) {
      context.missing(_procedureTypeMeta);
    }
    if (data.containsKey('disease_name')) {
      context.handle(
          _diseaseNameMeta,
          diseaseName.isAcceptableOrUnknown(
              data['disease_name']!, _diseaseNameMeta));
    }
    if (data.containsKey('settlement')) {
      context.handle(
          _settlementMeta,
          settlement.isAcceptableOrUnknown(
              data['settlement']!, _settlementMeta));
    }
    if (data.containsKey('specialist_name')) {
      context.handle(
          _specialistNameMeta,
          specialistName.isAcceptableOrUnknown(
              data['specialist_name']!, _specialistNameMeta));
    }
    if (data.containsKey('owner_iin')) {
      context.handle(_ownerIinMeta,
          ownerIin.isAcceptableOrUnknown(data['owner_iin']!, _ownerIinMeta));
    }
    if (data.containsKey('owner_name')) {
      context.handle(_ownerNameMeta,
          ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta));
    }
    if (data.containsKey('species_name')) {
      context.handle(
          _speciesNameMeta,
          speciesName.isAcceptableOrUnknown(
              data['species_name']!, _speciesNameMeta));
    }
    if (data.containsKey('male_count')) {
      context.handle(_maleCountMeta,
          maleCount.isAcceptableOrUnknown(data['male_count']!, _maleCountMeta));
    }
    if (data.containsKey('female_count')) {
      context.handle(
          _femaleCountMeta,
          femaleCount.isAcceptableOrUnknown(
              data['female_count']!, _femaleCountMeta));
    }
    if (data.containsKey('young_count')) {
      context.handle(
          _youngCountMeta,
          youngCount.isAcceptableOrUnknown(
              data['young_count']!, _youngCountMeta));
    }
    if (data.containsKey('total_vaccinated')) {
      context.handle(
          _totalVaccinatedMeta,
          totalVaccinated.isAcceptableOrUnknown(
              data['total_vaccinated']!, _totalVaccinatedMeta));
    }
    if (data.containsKey('vaccine_name')) {
      context.handle(
          _vaccineNameMeta,
          vaccineName.isAcceptableOrUnknown(
              data['vaccine_name']!, _vaccineNameMeta));
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
          _manufacturerMeta,
          manufacturer.isAcceptableOrUnknown(
              data['manufacturer']!, _manufacturerMeta));
    }
    if (data.containsKey('series')) {
      context.handle(_seriesMeta,
          series.isAcceptableOrUnknown(data['series']!, _seriesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('animals_json')) {
      context.handle(
          _animalsJsonMeta,
          animalsJson.isAcceptableOrUnknown(
              data['animals_json']!, _animalsJsonMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalProcedureAct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProcedureAct(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      localId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_id']),
      actNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}act_number'])!,
      actDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}act_date'])!,
      procedureType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}procedure_type'])!,
      diseaseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}disease_name']),
      settlement: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}settlement']),
      specialistName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specialist_name']),
      ownerIin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_iin']),
      ownerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_name']),
      speciesName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species_name']),
      maleCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}male_count']),
      femaleCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}female_count']),
      youngCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}young_count']),
      totalVaccinated: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_vaccinated']),
      vaccineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vaccine_name']),
      manufacturer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manufacturer']),
      series: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}series']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      animalsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}animals_json']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $LocalProcedureActsTable createAlias(String alias) {
    return $LocalProcedureActsTable(attachedDatabase, alias);
  }
}

class LocalProcedureAct extends DataClass
    implements Insertable<LocalProcedureAct> {
  final String id;
  final String? localId;
  final String actNumber;
  final DateTime actDate;
  final String procedureType;
  final String? diseaseName;
  final String? settlement;
  final String? specialistName;
  final String? ownerIin;
  final String? ownerName;
  final String? speciesName;
  final int? maleCount;
  final int? femaleCount;
  final int? youngCount;
  final int? totalVaccinated;
  final String? vaccineName;
  final String? manufacturer;
  final String? series;
  final String status;
  final String? animalsJson;
  final bool isSynced;
  final DateTime? createdAt;
  final DateTime cachedAt;
  const LocalProcedureAct(
      {required this.id,
      this.localId,
      required this.actNumber,
      required this.actDate,
      required this.procedureType,
      this.diseaseName,
      this.settlement,
      this.specialistName,
      this.ownerIin,
      this.ownerName,
      this.speciesName,
      this.maleCount,
      this.femaleCount,
      this.youngCount,
      this.totalVaccinated,
      this.vaccineName,
      this.manufacturer,
      this.series,
      required this.status,
      this.animalsJson,
      required this.isSynced,
      this.createdAt,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || localId != null) {
      map['local_id'] = Variable<String>(localId);
    }
    map['act_number'] = Variable<String>(actNumber);
    map['act_date'] = Variable<DateTime>(actDate);
    map['procedure_type'] = Variable<String>(procedureType);
    if (!nullToAbsent || diseaseName != null) {
      map['disease_name'] = Variable<String>(diseaseName);
    }
    if (!nullToAbsent || settlement != null) {
      map['settlement'] = Variable<String>(settlement);
    }
    if (!nullToAbsent || specialistName != null) {
      map['specialist_name'] = Variable<String>(specialistName);
    }
    if (!nullToAbsent || ownerIin != null) {
      map['owner_iin'] = Variable<String>(ownerIin);
    }
    if (!nullToAbsent || ownerName != null) {
      map['owner_name'] = Variable<String>(ownerName);
    }
    if (!nullToAbsent || speciesName != null) {
      map['species_name'] = Variable<String>(speciesName);
    }
    if (!nullToAbsent || maleCount != null) {
      map['male_count'] = Variable<int>(maleCount);
    }
    if (!nullToAbsent || femaleCount != null) {
      map['female_count'] = Variable<int>(femaleCount);
    }
    if (!nullToAbsent || youngCount != null) {
      map['young_count'] = Variable<int>(youngCount);
    }
    if (!nullToAbsent || totalVaccinated != null) {
      map['total_vaccinated'] = Variable<int>(totalVaccinated);
    }
    if (!nullToAbsent || vaccineName != null) {
      map['vaccine_name'] = Variable<String>(vaccineName);
    }
    if (!nullToAbsent || manufacturer != null) {
      map['manufacturer'] = Variable<String>(manufacturer);
    }
    if (!nullToAbsent || series != null) {
      map['series'] = Variable<String>(series);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || animalsJson != null) {
      map['animals_json'] = Variable<String>(animalsJson);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  LocalProcedureActsCompanion toCompanion(bool nullToAbsent) {
    return LocalProcedureActsCompanion(
      id: Value(id),
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      actNumber: Value(actNumber),
      actDate: Value(actDate),
      procedureType: Value(procedureType),
      diseaseName: diseaseName == null && nullToAbsent
          ? const Value.absent()
          : Value(diseaseName),
      settlement: settlement == null && nullToAbsent
          ? const Value.absent()
          : Value(settlement),
      specialistName: specialistName == null && nullToAbsent
          ? const Value.absent()
          : Value(specialistName),
      ownerIin: ownerIin == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerIin),
      ownerName: ownerName == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerName),
      speciesName: speciesName == null && nullToAbsent
          ? const Value.absent()
          : Value(speciesName),
      maleCount: maleCount == null && nullToAbsent
          ? const Value.absent()
          : Value(maleCount),
      femaleCount: femaleCount == null && nullToAbsent
          ? const Value.absent()
          : Value(femaleCount),
      youngCount: youngCount == null && nullToAbsent
          ? const Value.absent()
          : Value(youngCount),
      totalVaccinated: totalVaccinated == null && nullToAbsent
          ? const Value.absent()
          : Value(totalVaccinated),
      vaccineName: vaccineName == null && nullToAbsent
          ? const Value.absent()
          : Value(vaccineName),
      manufacturer: manufacturer == null && nullToAbsent
          ? const Value.absent()
          : Value(manufacturer),
      series:
          series == null && nullToAbsent ? const Value.absent() : Value(series),
      status: Value(status),
      animalsJson: animalsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(animalsJson),
      isSynced: Value(isSynced),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      cachedAt: Value(cachedAt),
    );
  }

  factory LocalProcedureAct.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalProcedureAct(
      id: serializer.fromJson<String>(json['id']),
      localId: serializer.fromJson<String?>(json['localId']),
      actNumber: serializer.fromJson<String>(json['actNumber']),
      actDate: serializer.fromJson<DateTime>(json['actDate']),
      procedureType: serializer.fromJson<String>(json['procedureType']),
      diseaseName: serializer.fromJson<String?>(json['diseaseName']),
      settlement: serializer.fromJson<String?>(json['settlement']),
      specialistName: serializer.fromJson<String?>(json['specialistName']),
      ownerIin: serializer.fromJson<String?>(json['ownerIin']),
      ownerName: serializer.fromJson<String?>(json['ownerName']),
      speciesName: serializer.fromJson<String?>(json['speciesName']),
      maleCount: serializer.fromJson<int?>(json['maleCount']),
      femaleCount: serializer.fromJson<int?>(json['femaleCount']),
      youngCount: serializer.fromJson<int?>(json['youngCount']),
      totalVaccinated: serializer.fromJson<int?>(json['totalVaccinated']),
      vaccineName: serializer.fromJson<String?>(json['vaccineName']),
      manufacturer: serializer.fromJson<String?>(json['manufacturer']),
      series: serializer.fromJson<String?>(json['series']),
      status: serializer.fromJson<String>(json['status']),
      animalsJson: serializer.fromJson<String?>(json['animalsJson']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'localId': serializer.toJson<String?>(localId),
      'actNumber': serializer.toJson<String>(actNumber),
      'actDate': serializer.toJson<DateTime>(actDate),
      'procedureType': serializer.toJson<String>(procedureType),
      'diseaseName': serializer.toJson<String?>(diseaseName),
      'settlement': serializer.toJson<String?>(settlement),
      'specialistName': serializer.toJson<String?>(specialistName),
      'ownerIin': serializer.toJson<String?>(ownerIin),
      'ownerName': serializer.toJson<String?>(ownerName),
      'speciesName': serializer.toJson<String?>(speciesName),
      'maleCount': serializer.toJson<int?>(maleCount),
      'femaleCount': serializer.toJson<int?>(femaleCount),
      'youngCount': serializer.toJson<int?>(youngCount),
      'totalVaccinated': serializer.toJson<int?>(totalVaccinated),
      'vaccineName': serializer.toJson<String?>(vaccineName),
      'manufacturer': serializer.toJson<String?>(manufacturer),
      'series': serializer.toJson<String?>(series),
      'status': serializer.toJson<String>(status),
      'animalsJson': serializer.toJson<String?>(animalsJson),
      'isSynced': serializer.toJson<bool>(isSynced),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  LocalProcedureAct copyWith(
          {String? id,
          Value<String?> localId = const Value.absent(),
          String? actNumber,
          DateTime? actDate,
          String? procedureType,
          Value<String?> diseaseName = const Value.absent(),
          Value<String?> settlement = const Value.absent(),
          Value<String?> specialistName = const Value.absent(),
          Value<String?> ownerIin = const Value.absent(),
          Value<String?> ownerName = const Value.absent(),
          Value<String?> speciesName = const Value.absent(),
          Value<int?> maleCount = const Value.absent(),
          Value<int?> femaleCount = const Value.absent(),
          Value<int?> youngCount = const Value.absent(),
          Value<int?> totalVaccinated = const Value.absent(),
          Value<String?> vaccineName = const Value.absent(),
          Value<String?> manufacturer = const Value.absent(),
          Value<String?> series = const Value.absent(),
          String? status,
          Value<String?> animalsJson = const Value.absent(),
          bool? isSynced,
          Value<DateTime?> createdAt = const Value.absent(),
          DateTime? cachedAt}) =>
      LocalProcedureAct(
        id: id ?? this.id,
        localId: localId.present ? localId.value : this.localId,
        actNumber: actNumber ?? this.actNumber,
        actDate: actDate ?? this.actDate,
        procedureType: procedureType ?? this.procedureType,
        diseaseName: diseaseName.present ? diseaseName.value : this.diseaseName,
        settlement: settlement.present ? settlement.value : this.settlement,
        specialistName:
            specialistName.present ? specialistName.value : this.specialistName,
        ownerIin: ownerIin.present ? ownerIin.value : this.ownerIin,
        ownerName: ownerName.present ? ownerName.value : this.ownerName,
        speciesName: speciesName.present ? speciesName.value : this.speciesName,
        maleCount: maleCount.present ? maleCount.value : this.maleCount,
        femaleCount: femaleCount.present ? femaleCount.value : this.femaleCount,
        youngCount: youngCount.present ? youngCount.value : this.youngCount,
        totalVaccinated: totalVaccinated.present
            ? totalVaccinated.value
            : this.totalVaccinated,
        vaccineName: vaccineName.present ? vaccineName.value : this.vaccineName,
        manufacturer:
            manufacturer.present ? manufacturer.value : this.manufacturer,
        series: series.present ? series.value : this.series,
        status: status ?? this.status,
        animalsJson: animalsJson.present ? animalsJson.value : this.animalsJson,
        isSynced: isSynced ?? this.isSynced,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  LocalProcedureAct copyWithCompanion(LocalProcedureActsCompanion data) {
    return LocalProcedureAct(
      id: data.id.present ? data.id.value : this.id,
      localId: data.localId.present ? data.localId.value : this.localId,
      actNumber: data.actNumber.present ? data.actNumber.value : this.actNumber,
      actDate: data.actDate.present ? data.actDate.value : this.actDate,
      procedureType: data.procedureType.present
          ? data.procedureType.value
          : this.procedureType,
      diseaseName:
          data.diseaseName.present ? data.diseaseName.value : this.diseaseName,
      settlement:
          data.settlement.present ? data.settlement.value : this.settlement,
      specialistName: data.specialistName.present
          ? data.specialistName.value
          : this.specialistName,
      ownerIin: data.ownerIin.present ? data.ownerIin.value : this.ownerIin,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      speciesName:
          data.speciesName.present ? data.speciesName.value : this.speciesName,
      maleCount: data.maleCount.present ? data.maleCount.value : this.maleCount,
      femaleCount:
          data.femaleCount.present ? data.femaleCount.value : this.femaleCount,
      youngCount:
          data.youngCount.present ? data.youngCount.value : this.youngCount,
      totalVaccinated: data.totalVaccinated.present
          ? data.totalVaccinated.value
          : this.totalVaccinated,
      vaccineName:
          data.vaccineName.present ? data.vaccineName.value : this.vaccineName,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      series: data.series.present ? data.series.value : this.series,
      status: data.status.present ? data.status.value : this.status,
      animalsJson:
          data.animalsJson.present ? data.animalsJson.value : this.animalsJson,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalProcedureAct(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('actNumber: $actNumber, ')
          ..write('actDate: $actDate, ')
          ..write('procedureType: $procedureType, ')
          ..write('diseaseName: $diseaseName, ')
          ..write('settlement: $settlement, ')
          ..write('specialistName: $specialistName, ')
          ..write('ownerIin: $ownerIin, ')
          ..write('ownerName: $ownerName, ')
          ..write('speciesName: $speciesName, ')
          ..write('maleCount: $maleCount, ')
          ..write('femaleCount: $femaleCount, ')
          ..write('youngCount: $youngCount, ')
          ..write('totalVaccinated: $totalVaccinated, ')
          ..write('vaccineName: $vaccineName, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('series: $series, ')
          ..write('status: $status, ')
          ..write('animalsJson: $animalsJson, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        localId,
        actNumber,
        actDate,
        procedureType,
        diseaseName,
        settlement,
        specialistName,
        ownerIin,
        ownerName,
        speciesName,
        maleCount,
        femaleCount,
        youngCount,
        totalVaccinated,
        vaccineName,
        manufacturer,
        series,
        status,
        animalsJson,
        isSynced,
        createdAt,
        cachedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalProcedureAct &&
          other.id == this.id &&
          other.localId == this.localId &&
          other.actNumber == this.actNumber &&
          other.actDate == this.actDate &&
          other.procedureType == this.procedureType &&
          other.diseaseName == this.diseaseName &&
          other.settlement == this.settlement &&
          other.specialistName == this.specialistName &&
          other.ownerIin == this.ownerIin &&
          other.ownerName == this.ownerName &&
          other.speciesName == this.speciesName &&
          other.maleCount == this.maleCount &&
          other.femaleCount == this.femaleCount &&
          other.youngCount == this.youngCount &&
          other.totalVaccinated == this.totalVaccinated &&
          other.vaccineName == this.vaccineName &&
          other.manufacturer == this.manufacturer &&
          other.series == this.series &&
          other.status == this.status &&
          other.animalsJson == this.animalsJson &&
          other.isSynced == this.isSynced &&
          other.createdAt == this.createdAt &&
          other.cachedAt == this.cachedAt);
}

class LocalProcedureActsCompanion extends UpdateCompanion<LocalProcedureAct> {
  final Value<String> id;
  final Value<String?> localId;
  final Value<String> actNumber;
  final Value<DateTime> actDate;
  final Value<String> procedureType;
  final Value<String?> diseaseName;
  final Value<String?> settlement;
  final Value<String?> specialistName;
  final Value<String?> ownerIin;
  final Value<String?> ownerName;
  final Value<String?> speciesName;
  final Value<int?> maleCount;
  final Value<int?> femaleCount;
  final Value<int?> youngCount;
  final Value<int?> totalVaccinated;
  final Value<String?> vaccineName;
  final Value<String?> manufacturer;
  final Value<String?> series;
  final Value<String> status;
  final Value<String?> animalsJson;
  final Value<bool> isSynced;
  final Value<DateTime?> createdAt;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const LocalProcedureActsCompanion({
    this.id = const Value.absent(),
    this.localId = const Value.absent(),
    this.actNumber = const Value.absent(),
    this.actDate = const Value.absent(),
    this.procedureType = const Value.absent(),
    this.diseaseName = const Value.absent(),
    this.settlement = const Value.absent(),
    this.specialistName = const Value.absent(),
    this.ownerIin = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.speciesName = const Value.absent(),
    this.maleCount = const Value.absent(),
    this.femaleCount = const Value.absent(),
    this.youngCount = const Value.absent(),
    this.totalVaccinated = const Value.absent(),
    this.vaccineName = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.series = const Value.absent(),
    this.status = const Value.absent(),
    this.animalsJson = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalProcedureActsCompanion.insert({
    required String id,
    this.localId = const Value.absent(),
    required String actNumber,
    required DateTime actDate,
    required String procedureType,
    this.diseaseName = const Value.absent(),
    this.settlement = const Value.absent(),
    this.specialistName = const Value.absent(),
    this.ownerIin = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.speciesName = const Value.absent(),
    this.maleCount = const Value.absent(),
    this.femaleCount = const Value.absent(),
    this.youngCount = const Value.absent(),
    this.totalVaccinated = const Value.absent(),
    this.vaccineName = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.series = const Value.absent(),
    this.status = const Value.absent(),
    this.animalsJson = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        actNumber = Value(actNumber),
        actDate = Value(actDate),
        procedureType = Value(procedureType);
  static Insertable<LocalProcedureAct> custom({
    Expression<String>? id,
    Expression<String>? localId,
    Expression<String>? actNumber,
    Expression<DateTime>? actDate,
    Expression<String>? procedureType,
    Expression<String>? diseaseName,
    Expression<String>? settlement,
    Expression<String>? specialistName,
    Expression<String>? ownerIin,
    Expression<String>? ownerName,
    Expression<String>? speciesName,
    Expression<int>? maleCount,
    Expression<int>? femaleCount,
    Expression<int>? youngCount,
    Expression<int>? totalVaccinated,
    Expression<String>? vaccineName,
    Expression<String>? manufacturer,
    Expression<String>? series,
    Expression<String>? status,
    Expression<String>? animalsJson,
    Expression<bool>? isSynced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localId != null) 'local_id': localId,
      if (actNumber != null) 'act_number': actNumber,
      if (actDate != null) 'act_date': actDate,
      if (procedureType != null) 'procedure_type': procedureType,
      if (diseaseName != null) 'disease_name': diseaseName,
      if (settlement != null) 'settlement': settlement,
      if (specialistName != null) 'specialist_name': specialistName,
      if (ownerIin != null) 'owner_iin': ownerIin,
      if (ownerName != null) 'owner_name': ownerName,
      if (speciesName != null) 'species_name': speciesName,
      if (maleCount != null) 'male_count': maleCount,
      if (femaleCount != null) 'female_count': femaleCount,
      if (youngCount != null) 'young_count': youngCount,
      if (totalVaccinated != null) 'total_vaccinated': totalVaccinated,
      if (vaccineName != null) 'vaccine_name': vaccineName,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (series != null) 'series': series,
      if (status != null) 'status': status,
      if (animalsJson != null) 'animals_json': animalsJson,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdAt != null) 'created_at': createdAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalProcedureActsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? localId,
      Value<String>? actNumber,
      Value<DateTime>? actDate,
      Value<String>? procedureType,
      Value<String?>? diseaseName,
      Value<String?>? settlement,
      Value<String?>? specialistName,
      Value<String?>? ownerIin,
      Value<String?>? ownerName,
      Value<String?>? speciesName,
      Value<int?>? maleCount,
      Value<int?>? femaleCount,
      Value<int?>? youngCount,
      Value<int?>? totalVaccinated,
      Value<String?>? vaccineName,
      Value<String?>? manufacturer,
      Value<String?>? series,
      Value<String>? status,
      Value<String?>? animalsJson,
      Value<bool>? isSynced,
      Value<DateTime?>? createdAt,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return LocalProcedureActsCompanion(
      id: id ?? this.id,
      localId: localId ?? this.localId,
      actNumber: actNumber ?? this.actNumber,
      actDate: actDate ?? this.actDate,
      procedureType: procedureType ?? this.procedureType,
      diseaseName: diseaseName ?? this.diseaseName,
      settlement: settlement ?? this.settlement,
      specialistName: specialistName ?? this.specialistName,
      ownerIin: ownerIin ?? this.ownerIin,
      ownerName: ownerName ?? this.ownerName,
      speciesName: speciesName ?? this.speciesName,
      maleCount: maleCount ?? this.maleCount,
      femaleCount: femaleCount ?? this.femaleCount,
      youngCount: youngCount ?? this.youngCount,
      totalVaccinated: totalVaccinated ?? this.totalVaccinated,
      vaccineName: vaccineName ?? this.vaccineName,
      manufacturer: manufacturer ?? this.manufacturer,
      series: series ?? this.series,
      status: status ?? this.status,
      animalsJson: animalsJson ?? this.animalsJson,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (actNumber.present) {
      map['act_number'] = Variable<String>(actNumber.value);
    }
    if (actDate.present) {
      map['act_date'] = Variable<DateTime>(actDate.value);
    }
    if (procedureType.present) {
      map['procedure_type'] = Variable<String>(procedureType.value);
    }
    if (diseaseName.present) {
      map['disease_name'] = Variable<String>(diseaseName.value);
    }
    if (settlement.present) {
      map['settlement'] = Variable<String>(settlement.value);
    }
    if (specialistName.present) {
      map['specialist_name'] = Variable<String>(specialistName.value);
    }
    if (ownerIin.present) {
      map['owner_iin'] = Variable<String>(ownerIin.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (speciesName.present) {
      map['species_name'] = Variable<String>(speciesName.value);
    }
    if (maleCount.present) {
      map['male_count'] = Variable<int>(maleCount.value);
    }
    if (femaleCount.present) {
      map['female_count'] = Variable<int>(femaleCount.value);
    }
    if (youngCount.present) {
      map['young_count'] = Variable<int>(youngCount.value);
    }
    if (totalVaccinated.present) {
      map['total_vaccinated'] = Variable<int>(totalVaccinated.value);
    }
    if (vaccineName.present) {
      map['vaccine_name'] = Variable<String>(vaccineName.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (series.present) {
      map['series'] = Variable<String>(series.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (animalsJson.present) {
      map['animals_json'] = Variable<String>(animalsJson.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalProcedureActsCompanion(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('actNumber: $actNumber, ')
          ..write('actDate: $actDate, ')
          ..write('procedureType: $procedureType, ')
          ..write('diseaseName: $diseaseName, ')
          ..write('settlement: $settlement, ')
          ..write('specialistName: $specialistName, ')
          ..write('ownerIin: $ownerIin, ')
          ..write('ownerName: $ownerName, ')
          ..write('speciesName: $speciesName, ')
          ..write('maleCount: $maleCount, ')
          ..write('femaleCount: $femaleCount, ')
          ..write('youngCount: $youngCount, ')
          ..write('totalVaccinated: $totalVaccinated, ')
          ..write('vaccineName: $vaccineName, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('series: $series, ')
          ..write('status: $status, ')
          ..write('animalsJson: $animalsJson, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalGeofencesTable extends LocalGeofences
    with TableInfo<$LocalGeofencesTable, LocalGeofence> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalGeofencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _geofenceTypeMeta =
      const VerificationMeta('geofenceType');
  @override
  late final GeneratedColumn<String> geofenceType = GeneratedColumn<String>(
      'geofence_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _boundaryGeoJsonMeta =
      const VerificationMeta('boundaryGeoJson');
  @override
  late final GeneratedColumn<String> boundaryGeoJson = GeneratedColumn<String>(
      'boundary_geo_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _regionNameMeta =
      const VerificationMeta('regionName');
  @override
  late final GeneratedColumn<String> regionName = GeneratedColumn<String>(
      'region_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, geofenceType, boundaryGeoJson, regionName, isActive, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_geofences';
  @override
  VerificationContext validateIntegrity(Insertable<LocalGeofence> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('geofence_type')) {
      context.handle(
          _geofenceTypeMeta,
          geofenceType.isAcceptableOrUnknown(
              data['geofence_type']!, _geofenceTypeMeta));
    } else if (isInserting) {
      context.missing(_geofenceTypeMeta);
    }
    if (data.containsKey('boundary_geo_json')) {
      context.handle(
          _boundaryGeoJsonMeta,
          boundaryGeoJson.isAcceptableOrUnknown(
              data['boundary_geo_json']!, _boundaryGeoJsonMeta));
    } else if (isInserting) {
      context.missing(_boundaryGeoJsonMeta);
    }
    if (data.containsKey('region_name')) {
      context.handle(
          _regionNameMeta,
          regionName.isAcceptableOrUnknown(
              data['region_name']!, _regionNameMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalGeofence map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalGeofence(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      geofenceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}geofence_type'])!,
      boundaryGeoJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}boundary_geo_json'])!,
      regionName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region_name']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $LocalGeofencesTable createAlias(String alias) {
    return $LocalGeofencesTable(attachedDatabase, alias);
  }
}

class LocalGeofence extends DataClass implements Insertable<LocalGeofence> {
  final String id;
  final String name;
  final String geofenceType;
  final String boundaryGeoJson;
  final String? regionName;
  final bool isActive;
  final DateTime cachedAt;
  const LocalGeofence(
      {required this.id,
      required this.name,
      required this.geofenceType,
      required this.boundaryGeoJson,
      this.regionName,
      required this.isActive,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['geofence_type'] = Variable<String>(geofenceType);
    map['boundary_geo_json'] = Variable<String>(boundaryGeoJson);
    if (!nullToAbsent || regionName != null) {
      map['region_name'] = Variable<String>(regionName);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  LocalGeofencesCompanion toCompanion(bool nullToAbsent) {
    return LocalGeofencesCompanion(
      id: Value(id),
      name: Value(name),
      geofenceType: Value(geofenceType),
      boundaryGeoJson: Value(boundaryGeoJson),
      regionName: regionName == null && nullToAbsent
          ? const Value.absent()
          : Value(regionName),
      isActive: Value(isActive),
      cachedAt: Value(cachedAt),
    );
  }

  factory LocalGeofence.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalGeofence(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      geofenceType: serializer.fromJson<String>(json['geofenceType']),
      boundaryGeoJson: serializer.fromJson<String>(json['boundaryGeoJson']),
      regionName: serializer.fromJson<String?>(json['regionName']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'geofenceType': serializer.toJson<String>(geofenceType),
      'boundaryGeoJson': serializer.toJson<String>(boundaryGeoJson),
      'regionName': serializer.toJson<String?>(regionName),
      'isActive': serializer.toJson<bool>(isActive),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  LocalGeofence copyWith(
          {String? id,
          String? name,
          String? geofenceType,
          String? boundaryGeoJson,
          Value<String?> regionName = const Value.absent(),
          bool? isActive,
          DateTime? cachedAt}) =>
      LocalGeofence(
        id: id ?? this.id,
        name: name ?? this.name,
        geofenceType: geofenceType ?? this.geofenceType,
        boundaryGeoJson: boundaryGeoJson ?? this.boundaryGeoJson,
        regionName: regionName.present ? regionName.value : this.regionName,
        isActive: isActive ?? this.isActive,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  LocalGeofence copyWithCompanion(LocalGeofencesCompanion data) {
    return LocalGeofence(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      geofenceType: data.geofenceType.present
          ? data.geofenceType.value
          : this.geofenceType,
      boundaryGeoJson: data.boundaryGeoJson.present
          ? data.boundaryGeoJson.value
          : this.boundaryGeoJson,
      regionName:
          data.regionName.present ? data.regionName.value : this.regionName,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalGeofence(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('geofenceType: $geofenceType, ')
          ..write('boundaryGeoJson: $boundaryGeoJson, ')
          ..write('regionName: $regionName, ')
          ..write('isActive: $isActive, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, geofenceType, boundaryGeoJson, regionName, isActive, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalGeofence &&
          other.id == this.id &&
          other.name == this.name &&
          other.geofenceType == this.geofenceType &&
          other.boundaryGeoJson == this.boundaryGeoJson &&
          other.regionName == this.regionName &&
          other.isActive == this.isActive &&
          other.cachedAt == this.cachedAt);
}

class LocalGeofencesCompanion extends UpdateCompanion<LocalGeofence> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> geofenceType;
  final Value<String> boundaryGeoJson;
  final Value<String?> regionName;
  final Value<bool> isActive;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const LocalGeofencesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.geofenceType = const Value.absent(),
    this.boundaryGeoJson = const Value.absent(),
    this.regionName = const Value.absent(),
    this.isActive = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalGeofencesCompanion.insert({
    required String id,
    required String name,
    required String geofenceType,
    required String boundaryGeoJson,
    this.regionName = const Value.absent(),
    this.isActive = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        geofenceType = Value(geofenceType),
        boundaryGeoJson = Value(boundaryGeoJson);
  static Insertable<LocalGeofence> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? geofenceType,
    Expression<String>? boundaryGeoJson,
    Expression<String>? regionName,
    Expression<bool>? isActive,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (geofenceType != null) 'geofence_type': geofenceType,
      if (boundaryGeoJson != null) 'boundary_geo_json': boundaryGeoJson,
      if (regionName != null) 'region_name': regionName,
      if (isActive != null) 'is_active': isActive,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalGeofencesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? geofenceType,
      Value<String>? boundaryGeoJson,
      Value<String?>? regionName,
      Value<bool>? isActive,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return LocalGeofencesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      geofenceType: geofenceType ?? this.geofenceType,
      boundaryGeoJson: boundaryGeoJson ?? this.boundaryGeoJson,
      regionName: regionName ?? this.regionName,
      isActive: isActive ?? this.isActive,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (geofenceType.present) {
      map['geofence_type'] = Variable<String>(geofenceType.value);
    }
    if (boundaryGeoJson.present) {
      map['boundary_geo_json'] = Variable<String>(boundaryGeoJson.value);
    }
    if (regionName.present) {
      map['region_name'] = Variable<String>(regionName.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalGeofencesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('geofenceType: $geofenceType, ')
          ..write('boundaryGeoJson: $boundaryGeoJson, ')
          ..write('regionName: $regionName, ')
          ..write('isActive: $isActive, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalGpsReadingsTable extends LocalGpsReadings
    with TableInfo<$LocalGpsReadingsTable, LocalGpsReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalGpsReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _animalIdMeta =
      const VerificationMeta('animalId');
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
      'animal_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _altitudeMeta =
      const VerificationMeta('altitude');
  @override
  late final GeneratedColumn<double> altitude = GeneratedColumn<double>(
      'altitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _speedKmhMeta =
      const VerificationMeta('speedKmh');
  @override
  late final GeneratedColumn<double> speedKmh = GeneratedColumn<double>(
      'speed_kmh', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _batteryLevelMeta =
      const VerificationMeta('batteryLevel');
  @override
  late final GeneratedColumn<double> batteryLevel = GeneratedColumn<double>(
      'battery_level', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        deviceId,
        animalId,
        latitude,
        longitude,
        altitude,
        speedKmh,
        batteryLevel,
        timestamp
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_gps_readings';
  @override
  VerificationContext validateIntegrity(Insertable<LocalGpsReading> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(_animalIdMeta,
          animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('altitude')) {
      context.handle(_altitudeMeta,
          altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta));
    }
    if (data.containsKey('speed_kmh')) {
      context.handle(_speedKmhMeta,
          speedKmh.isAcceptableOrUnknown(data['speed_kmh']!, _speedKmhMeta));
    }
    if (data.containsKey('battery_level')) {
      context.handle(
          _batteryLevelMeta,
          batteryLevel.isAcceptableOrUnknown(
              data['battery_level']!, _batteryLevelMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalGpsReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalGpsReading(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id'])!,
      animalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}animal_id']),
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      altitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}altitude']),
      speedKmh: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}speed_kmh']),
      batteryLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}battery_level']),
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $LocalGpsReadingsTable createAlias(String alias) {
    return $LocalGpsReadingsTable(attachedDatabase, alias);
  }
}

class LocalGpsReading extends DataClass implements Insertable<LocalGpsReading> {
  final String id;
  final String deviceId;
  final String? animalId;
  final double latitude;
  final double longitude;
  final double? altitude;
  final double? speedKmh;
  final double? batteryLevel;
  final DateTime timestamp;
  const LocalGpsReading(
      {required this.id,
      required this.deviceId,
      this.animalId,
      required this.latitude,
      required this.longitude,
      this.altitude,
      this.speedKmh,
      this.batteryLevel,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['device_id'] = Variable<String>(deviceId);
    if (!nullToAbsent || animalId != null) {
      map['animal_id'] = Variable<String>(animalId);
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || altitude != null) {
      map['altitude'] = Variable<double>(altitude);
    }
    if (!nullToAbsent || speedKmh != null) {
      map['speed_kmh'] = Variable<double>(speedKmh);
    }
    if (!nullToAbsent || batteryLevel != null) {
      map['battery_level'] = Variable<double>(batteryLevel);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  LocalGpsReadingsCompanion toCompanion(bool nullToAbsent) {
    return LocalGpsReadingsCompanion(
      id: Value(id),
      deviceId: Value(deviceId),
      animalId: animalId == null && nullToAbsent
          ? const Value.absent()
          : Value(animalId),
      latitude: Value(latitude),
      longitude: Value(longitude),
      altitude: altitude == null && nullToAbsent
          ? const Value.absent()
          : Value(altitude),
      speedKmh: speedKmh == null && nullToAbsent
          ? const Value.absent()
          : Value(speedKmh),
      batteryLevel: batteryLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(batteryLevel),
      timestamp: Value(timestamp),
    );
  }

  factory LocalGpsReading.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalGpsReading(
      id: serializer.fromJson<String>(json['id']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      animalId: serializer.fromJson<String?>(json['animalId']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      altitude: serializer.fromJson<double?>(json['altitude']),
      speedKmh: serializer.fromJson<double?>(json['speedKmh']),
      batteryLevel: serializer.fromJson<double?>(json['batteryLevel']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'deviceId': serializer.toJson<String>(deviceId),
      'animalId': serializer.toJson<String?>(animalId),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'altitude': serializer.toJson<double?>(altitude),
      'speedKmh': serializer.toJson<double?>(speedKmh),
      'batteryLevel': serializer.toJson<double?>(batteryLevel),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  LocalGpsReading copyWith(
          {String? id,
          String? deviceId,
          Value<String?> animalId = const Value.absent(),
          double? latitude,
          double? longitude,
          Value<double?> altitude = const Value.absent(),
          Value<double?> speedKmh = const Value.absent(),
          Value<double?> batteryLevel = const Value.absent(),
          DateTime? timestamp}) =>
      LocalGpsReading(
        id: id ?? this.id,
        deviceId: deviceId ?? this.deviceId,
        animalId: animalId.present ? animalId.value : this.animalId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        altitude: altitude.present ? altitude.value : this.altitude,
        speedKmh: speedKmh.present ? speedKmh.value : this.speedKmh,
        batteryLevel:
            batteryLevel.present ? batteryLevel.value : this.batteryLevel,
        timestamp: timestamp ?? this.timestamp,
      );
  LocalGpsReading copyWithCompanion(LocalGpsReadingsCompanion data) {
    return LocalGpsReading(
      id: data.id.present ? data.id.value : this.id,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      speedKmh: data.speedKmh.present ? data.speedKmh.value : this.speedKmh,
      batteryLevel: data.batteryLevel.present
          ? data.batteryLevel.value
          : this.batteryLevel,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalGpsReading(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('animalId: $animalId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitude: $altitude, ')
          ..write('speedKmh: $speedKmh, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, deviceId, animalId, latitude, longitude,
      altitude, speedKmh, batteryLevel, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalGpsReading &&
          other.id == this.id &&
          other.deviceId == this.deviceId &&
          other.animalId == this.animalId &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.altitude == this.altitude &&
          other.speedKmh == this.speedKmh &&
          other.batteryLevel == this.batteryLevel &&
          other.timestamp == this.timestamp);
}

class LocalGpsReadingsCompanion extends UpdateCompanion<LocalGpsReading> {
  final Value<String> id;
  final Value<String> deviceId;
  final Value<String?> animalId;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double?> altitude;
  final Value<double?> speedKmh;
  final Value<double?> batteryLevel;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const LocalGpsReadingsCompanion({
    this.id = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.animalId = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.altitude = const Value.absent(),
    this.speedKmh = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalGpsReadingsCompanion.insert({
    required String id,
    required String deviceId,
    this.animalId = const Value.absent(),
    required double latitude,
    required double longitude,
    this.altitude = const Value.absent(),
    this.speedKmh = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    required DateTime timestamp,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        deviceId = Value(deviceId),
        latitude = Value(latitude),
        longitude = Value(longitude),
        timestamp = Value(timestamp);
  static Insertable<LocalGpsReading> custom({
    Expression<String>? id,
    Expression<String>? deviceId,
    Expression<String>? animalId,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? altitude,
    Expression<double>? speedKmh,
    Expression<double>? batteryLevel,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deviceId != null) 'device_id': deviceId,
      if (animalId != null) 'animal_id': animalId,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (altitude != null) 'altitude': altitude,
      if (speedKmh != null) 'speed_kmh': speedKmh,
      if (batteryLevel != null) 'battery_level': batteryLevel,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalGpsReadingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? deviceId,
      Value<String?>? animalId,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<double?>? altitude,
      Value<double?>? speedKmh,
      Value<double?>? batteryLevel,
      Value<DateTime>? timestamp,
      Value<int>? rowid}) {
    return LocalGpsReadingsCompanion(
      id: id ?? this.id,
      deviceId: deviceId ?? this.deviceId,
      animalId: animalId ?? this.animalId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitude: altitude ?? this.altitude,
      speedKmh: speedKmh ?? this.speedKmh,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double>(altitude.value);
    }
    if (speedKmh.present) {
      map['speed_kmh'] = Variable<double>(speedKmh.value);
    }
    if (batteryLevel.present) {
      map['battery_level'] = Variable<double>(batteryLevel.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalGpsReadingsCompanion(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('animalId: $animalId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitude: $altitude, ')
          ..write('speedKmh: $speedKmh, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalInventoryItemsTable extends LocalInventoryItems
    with TableInfo<$LocalInventoryItemsTable, LocalInventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalInventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _minQuantityMeta =
      const VerificationMeta('minQuantity');
  @override
  late final GeneratedColumn<int> minQuantity = GeneratedColumn<int>(
      'min_quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _seriesMeta = const VerificationMeta('series');
  @override
  late final GeneratedColumn<String> series = GeneratedColumn<String>(
      'series', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _expiryDateMeta =
      const VerificationMeta('expiryDate');
  @override
  late final GeneratedColumn<String> expiryDate = GeneratedColumn<String>(
      'expiry_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        category,
        unit,
        quantity,
        minQuantity,
        series,
        expiryDate,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_inventory_items';
  @override
  VerificationContext validateIntegrity(Insertable<LocalInventoryItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('min_quantity')) {
      context.handle(
          _minQuantityMeta,
          minQuantity.isAcceptableOrUnknown(
              data['min_quantity']!, _minQuantityMeta));
    } else if (isInserting) {
      context.missing(_minQuantityMeta);
    }
    if (data.containsKey('series')) {
      context.handle(_seriesMeta,
          series.isAcceptableOrUnknown(data['series']!, _seriesMeta));
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
          _expiryDateMeta,
          expiryDate.isAcceptableOrUnknown(
              data['expiry_date']!, _expiryDateMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalInventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalInventoryItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      minQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_quantity'])!,
      series: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}series']),
      expiryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}expiry_date']),
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $LocalInventoryItemsTable createAlias(String alias) {
    return $LocalInventoryItemsTable(attachedDatabase, alias);
  }
}

class LocalInventoryItem extends DataClass
    implements Insertable<LocalInventoryItem> {
  final String id;
  final String name;
  final String category;
  final String unit;
  final int quantity;
  final int minQuantity;
  final String? series;
  final String? expiryDate;
  final DateTime cachedAt;
  const LocalInventoryItem(
      {required this.id,
      required this.name,
      required this.category,
      required this.unit,
      required this.quantity,
      required this.minQuantity,
      this.series,
      this.expiryDate,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['unit'] = Variable<String>(unit);
    map['quantity'] = Variable<int>(quantity);
    map['min_quantity'] = Variable<int>(minQuantity);
    if (!nullToAbsent || series != null) {
      map['series'] = Variable<String>(series);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<String>(expiryDate);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  LocalInventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return LocalInventoryItemsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      unit: Value(unit),
      quantity: Value(quantity),
      minQuantity: Value(minQuantity),
      series:
          series == null && nullToAbsent ? const Value.absent() : Value(series),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
      cachedAt: Value(cachedAt),
    );
  }

  factory LocalInventoryItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalInventoryItem(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      unit: serializer.fromJson<String>(json['unit']),
      quantity: serializer.fromJson<int>(json['quantity']),
      minQuantity: serializer.fromJson<int>(json['minQuantity']),
      series: serializer.fromJson<String?>(json['series']),
      expiryDate: serializer.fromJson<String?>(json['expiryDate']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'unit': serializer.toJson<String>(unit),
      'quantity': serializer.toJson<int>(quantity),
      'minQuantity': serializer.toJson<int>(minQuantity),
      'series': serializer.toJson<String?>(series),
      'expiryDate': serializer.toJson<String?>(expiryDate),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  LocalInventoryItem copyWith(
          {String? id,
          String? name,
          String? category,
          String? unit,
          int? quantity,
          int? minQuantity,
          Value<String?> series = const Value.absent(),
          Value<String?> expiryDate = const Value.absent(),
          DateTime? cachedAt}) =>
      LocalInventoryItem(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        unit: unit ?? this.unit,
        quantity: quantity ?? this.quantity,
        minQuantity: minQuantity ?? this.minQuantity,
        series: series.present ? series.value : this.series,
        expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  LocalInventoryItem copyWithCompanion(LocalInventoryItemsCompanion data) {
    return LocalInventoryItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      unit: data.unit.present ? data.unit.value : this.unit,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      minQuantity:
          data.minQuantity.present ? data.minQuantity.value : this.minQuantity,
      series: data.series.present ? data.series.value : this.series,
      expiryDate:
          data.expiryDate.present ? data.expiryDate.value : this.expiryDate,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalInventoryItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('quantity: $quantity, ')
          ..write('minQuantity: $minQuantity, ')
          ..write('series: $series, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, category, unit, quantity,
      minQuantity, series, expiryDate, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalInventoryItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.unit == this.unit &&
          other.quantity == this.quantity &&
          other.minQuantity == this.minQuantity &&
          other.series == this.series &&
          other.expiryDate == this.expiryDate &&
          other.cachedAt == this.cachedAt);
}

class LocalInventoryItemsCompanion extends UpdateCompanion<LocalInventoryItem> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> unit;
  final Value<int> quantity;
  final Value<int> minQuantity;
  final Value<String?> series;
  final Value<String?> expiryDate;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const LocalInventoryItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.unit = const Value.absent(),
    this.quantity = const Value.absent(),
    this.minQuantity = const Value.absent(),
    this.series = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalInventoryItemsCompanion.insert({
    required String id,
    required String name,
    required String category,
    required String unit,
    required int quantity,
    required int minQuantity,
    this.series = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        category = Value(category),
        unit = Value(unit),
        quantity = Value(quantity),
        minQuantity = Value(minQuantity);
  static Insertable<LocalInventoryItem> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? unit,
    Expression<int>? quantity,
    Expression<int>? minQuantity,
    Expression<String>? series,
    Expression<String>? expiryDate,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (unit != null) 'unit': unit,
      if (quantity != null) 'quantity': quantity,
      if (minQuantity != null) 'min_quantity': minQuantity,
      if (series != null) 'series': series,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalInventoryItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? category,
      Value<String>? unit,
      Value<int>? quantity,
      Value<int>? minQuantity,
      Value<String?>? series,
      Value<String?>? expiryDate,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return LocalInventoryItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      minQuantity: minQuantity ?? this.minQuantity,
      series: series ?? this.series,
      expiryDate: expiryDate ?? this.expiryDate,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (minQuantity.present) {
      map['min_quantity'] = Variable<int>(minQuantity.value);
    }
    if (series.present) {
      map['series'] = Variable<String>(series.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<String>(expiryDate.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalInventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('quantity: $quantity, ')
          ..write('minQuantity: $minQuantity, ')
          ..write('series: $series, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _lastAttemptAtMeta =
      const VerificationMeta('lastAttemptAt');
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>('last_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        entityType,
        entityId,
        operation,
        payload,
        retryCount,
        createdAt,
        lastAttemptAt,
        errorMessage
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
          _lastAttemptAtMeta,
          lastAttemptAt.isAcceptableOrUnknown(
              data['last_attempt_at']!, _lastAttemptAtMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_attempt_at']),
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final String id;
  final String entityType;
  final String entityId;
  final String operation;
  final String payload;
  final int retryCount;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  final String? errorMessage;
  const SyncQueueData(
      {required this.id,
      required this.entityType,
      required this.entityId,
      required this.operation,
      required this.payload,
      required this.retryCount,
      required this.createdAt,
      this.lastAttemptAt,
      this.errorMessage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payload: Value(payload),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  SyncQueueData copyWith(
          {String? id,
          String? entityType,
          String? entityId,
          String? operation,
          String? payload,
          int? retryCount,
          DateTime? createdAt,
          Value<DateTime?> lastAttemptAt = const Value.absent(),
          Value<String?> errorMessage = const Value.absent()}) =>
      SyncQueueData(
        id: id ?? this.id,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        operation: operation ?? this.operation,
        payload: payload ?? this.payload,
        retryCount: retryCount ?? this.retryCount,
        createdAt: createdAt ?? this.createdAt,
        lastAttemptAt:
            lastAttemptAt.present ? lastAttemptAt.value : this.lastAttemptAt,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entityType, entityId, operation, payload,
      retryCount, createdAt, lastAttemptAt, errorMessage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.errorMessage == this.errorMessage);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<String?> errorMessage;
  final Value<int> rowid;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    required String id,
    required String entityType,
    required String entityId,
    required String operation,
    required String payload,
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        entityType = Value(entityType),
        entityId = Value(entityId),
        operation = Value(operation),
        payload = Value(payload);
  static Insertable<SyncQueueData> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<String>? errorMessage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (errorMessage != null) 'error_message': errorMessage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<String>? id,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? operation,
      Value<String>? payload,
      Value<int>? retryCount,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastAttemptAt,
      Value<String?>? errorMessage,
      Value<int>? rowid}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      errorMessage: errorMessage ?? this.errorMessage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalUsersTable localUsers = $LocalUsersTable(this);
  late final $LocalAnimalsTable localAnimals = $LocalAnimalsTable(this);
  late final $LocalProcedureActsTable localProcedureActs =
      $LocalProcedureActsTable(this);
  late final $LocalGeofencesTable localGeofences = $LocalGeofencesTable(this);
  late final $LocalGpsReadingsTable localGpsReadings =
      $LocalGpsReadingsTable(this);
  late final $LocalInventoryItemsTable localInventoryItems =
      $LocalInventoryItemsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        localUsers,
        localAnimals,
        localProcedureActs,
        localGeofences,
        localGpsReadings,
        localInventoryItems,
        syncQueue
      ];
}

typedef $$LocalUsersTableCreateCompanionBuilder = LocalUsersCompanion Function({
  required String id,
  required String iin,
  required String fullName,
  required String role,
  Value<String?> organizationName,
  Value<String?> regionName,
  Value<String?> accessToken,
  Value<String?> refreshToken,
  Value<DateTime?> tokenExpiresAt,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});
typedef $$LocalUsersTableUpdateCompanionBuilder = LocalUsersCompanion Function({
  Value<String> id,
  Value<String> iin,
  Value<String> fullName,
  Value<String> role,
  Value<String?> organizationName,
  Value<String?> regionName,
  Value<String?> accessToken,
  Value<String?> refreshToken,
  Value<DateTime?> tokenExpiresAt,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});

class $$LocalUsersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iin => $composableBuilder(
      column: $table.iin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get organizationName => $composableBuilder(
      column: $table.organizationName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get regionName => $composableBuilder(
      column: $table.regionName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accessToken => $composableBuilder(
      column: $table.accessToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get refreshToken => $composableBuilder(
      column: $table.refreshToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get tokenExpiresAt => $composableBuilder(
      column: $table.tokenExpiresAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnFilters(column));
}

class $$LocalUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iin => $composableBuilder(
      column: $table.iin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get organizationName => $composableBuilder(
      column: $table.organizationName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get regionName => $composableBuilder(
      column: $table.regionName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accessToken => $composableBuilder(
      column: $table.accessToken, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get refreshToken => $composableBuilder(
      column: $table.refreshToken,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get tokenExpiresAt => $composableBuilder(
      column: $table.tokenExpiresAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get iin =>
      $composableBuilder(column: $table.iin, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get organizationName => $composableBuilder(
      column: $table.organizationName, builder: (column) => column);

  GeneratedColumn<String> get regionName => $composableBuilder(
      column: $table.regionName, builder: (column) => column);

  GeneratedColumn<String> get accessToken => $composableBuilder(
      column: $table.accessToken, builder: (column) => column);

  GeneratedColumn<String> get refreshToken => $composableBuilder(
      column: $table.refreshToken, builder: (column) => column);

  GeneratedColumn<DateTime> get tokenExpiresAt => $composableBuilder(
      column: $table.tokenExpiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => column);
}

class $$LocalUsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalUsersTable,
    LocalUser,
    $$LocalUsersTableFilterComposer,
    $$LocalUsersTableOrderingComposer,
    $$LocalUsersTableAnnotationComposer,
    $$LocalUsersTableCreateCompanionBuilder,
    $$LocalUsersTableUpdateCompanionBuilder,
    (LocalUser, BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser>),
    LocalUser,
    PrefetchHooks Function()> {
  $$LocalUsersTableTableManager(_$AppDatabase db, $LocalUsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> iin = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String?> organizationName = const Value.absent(),
            Value<String?> regionName = const Value.absent(),
            Value<String?> accessToken = const Value.absent(),
            Value<String?> refreshToken = const Value.absent(),
            Value<DateTime?> tokenExpiresAt = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUsersCompanion(
            id: id,
            iin: iin,
            fullName: fullName,
            role: role,
            organizationName: organizationName,
            regionName: regionName,
            accessToken: accessToken,
            refreshToken: refreshToken,
            tokenExpiresAt: tokenExpiresAt,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String iin,
            required String fullName,
            required String role,
            Value<String?> organizationName = const Value.absent(),
            Value<String?> regionName = const Value.absent(),
            Value<String?> accessToken = const Value.absent(),
            Value<String?> refreshToken = const Value.absent(),
            Value<DateTime?> tokenExpiresAt = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUsersCompanion.insert(
            id: id,
            iin: iin,
            fullName: fullName,
            role: role,
            organizationName: organizationName,
            regionName: regionName,
            accessToken: accessToken,
            refreshToken: refreshToken,
            tokenExpiresAt: tokenExpiresAt,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalUsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalUsersTable,
    LocalUser,
    $$LocalUsersTableFilterComposer,
    $$LocalUsersTableOrderingComposer,
    $$LocalUsersTableAnnotationComposer,
    $$LocalUsersTableCreateCompanionBuilder,
    $$LocalUsersTableUpdateCompanionBuilder,
    (LocalUser, BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser>),
    LocalUser,
    PrefetchHooks Function()>;
typedef $$LocalAnimalsTableCreateCompanionBuilder = LocalAnimalsCompanion
    Function({
  required String id,
  Value<String?> localId,
  Value<String?> identificationNo,
  Value<String?> microchipNo,
  Value<String?> rfidTagNo,
  Value<String?> speciesId,
  Value<String?> speciesName,
  Value<String?> breedName,
  Value<String?> sex,
  Value<DateTime?> birthDate,
  Value<int?> birthYear,
  Value<String?> color,
  Value<double?> weightKg,
  Value<String> status,
  Value<String?> ownerId,
  Value<String?> ownerName,
  Value<String?> ownerIin,
  Value<String?> regionName,
  Value<double?> lastLatitude,
  Value<double?> lastLongitude,
  Value<DateTime?> lastSeenAt,
  Value<bool> isSynced,
  Value<bool> isDeleted,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});
typedef $$LocalAnimalsTableUpdateCompanionBuilder = LocalAnimalsCompanion
    Function({
  Value<String> id,
  Value<String?> localId,
  Value<String?> identificationNo,
  Value<String?> microchipNo,
  Value<String?> rfidTagNo,
  Value<String?> speciesId,
  Value<String?> speciesName,
  Value<String?> breedName,
  Value<String?> sex,
  Value<DateTime?> birthDate,
  Value<int?> birthYear,
  Value<String?> color,
  Value<double?> weightKg,
  Value<String> status,
  Value<String?> ownerId,
  Value<String?> ownerName,
  Value<String?> ownerIin,
  Value<String?> regionName,
  Value<double?> lastLatitude,
  Value<double?> lastLongitude,
  Value<DateTime?> lastSeenAt,
  Value<bool> isSynced,
  Value<bool> isDeleted,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$LocalAnimalsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalAnimalsTable> {
  $$LocalAnimalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get identificationNo => $composableBuilder(
      column: $table.identificationNo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get microchipNo => $composableBuilder(
      column: $table.microchipNo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rfidTagNo => $composableBuilder(
      column: $table.rfidTagNo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get speciesId => $composableBuilder(
      column: $table.speciesId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get speciesName => $composableBuilder(
      column: $table.speciesName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get breedName => $composableBuilder(
      column: $table.breedName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sex => $composableBuilder(
      column: $table.sex, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get birthYear => $composableBuilder(
      column: $table.birthYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerId => $composableBuilder(
      column: $table.ownerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerIin => $composableBuilder(
      column: $table.ownerIin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get regionName => $composableBuilder(
      column: $table.regionName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lastLatitude => $composableBuilder(
      column: $table.lastLatitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lastLongitude => $composableBuilder(
      column: $table.lastLongitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSeenAt => $composableBuilder(
      column: $table.lastSeenAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalAnimalsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalAnimalsTable> {
  $$LocalAnimalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get identificationNo => $composableBuilder(
      column: $table.identificationNo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get microchipNo => $composableBuilder(
      column: $table.microchipNo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rfidTagNo => $composableBuilder(
      column: $table.rfidTagNo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get speciesId => $composableBuilder(
      column: $table.speciesId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get speciesName => $composableBuilder(
      column: $table.speciesName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get breedName => $composableBuilder(
      column: $table.breedName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sex => $composableBuilder(
      column: $table.sex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get birthYear => $composableBuilder(
      column: $table.birthYear, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerId => $composableBuilder(
      column: $table.ownerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerIin => $composableBuilder(
      column: $table.ownerIin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get regionName => $composableBuilder(
      column: $table.regionName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lastLatitude => $composableBuilder(
      column: $table.lastLatitude,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lastLongitude => $composableBuilder(
      column: $table.lastLongitude,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSeenAt => $composableBuilder(
      column: $table.lastSeenAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalAnimalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalAnimalsTable> {
  $$LocalAnimalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get identificationNo => $composableBuilder(
      column: $table.identificationNo, builder: (column) => column);

  GeneratedColumn<String> get microchipNo => $composableBuilder(
      column: $table.microchipNo, builder: (column) => column);

  GeneratedColumn<String> get rfidTagNo =>
      $composableBuilder(column: $table.rfidTagNo, builder: (column) => column);

  GeneratedColumn<String> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<String> get speciesName => $composableBuilder(
      column: $table.speciesName, builder: (column) => column);

  GeneratedColumn<String> get breedName =>
      $composableBuilder(column: $table.breedName, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<int> get birthYear =>
      $composableBuilder(column: $table.birthYear, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get ownerIin =>
      $composableBuilder(column: $table.ownerIin, builder: (column) => column);

  GeneratedColumn<String> get regionName => $composableBuilder(
      column: $table.regionName, builder: (column) => column);

  GeneratedColumn<double> get lastLatitude => $composableBuilder(
      column: $table.lastLatitude, builder: (column) => column);

  GeneratedColumn<double> get lastLongitude => $composableBuilder(
      column: $table.lastLongitude, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeenAt => $composableBuilder(
      column: $table.lastSeenAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$LocalAnimalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalAnimalsTable,
    LocalAnimal,
    $$LocalAnimalsTableFilterComposer,
    $$LocalAnimalsTableOrderingComposer,
    $$LocalAnimalsTableAnnotationComposer,
    $$LocalAnimalsTableCreateCompanionBuilder,
    $$LocalAnimalsTableUpdateCompanionBuilder,
    (
      LocalAnimal,
      BaseReferences<_$AppDatabase, $LocalAnimalsTable, LocalAnimal>
    ),
    LocalAnimal,
    PrefetchHooks Function()> {
  $$LocalAnimalsTableTableManager(_$AppDatabase db, $LocalAnimalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalAnimalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalAnimalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalAnimalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> localId = const Value.absent(),
            Value<String?> identificationNo = const Value.absent(),
            Value<String?> microchipNo = const Value.absent(),
            Value<String?> rfidTagNo = const Value.absent(),
            Value<String?> speciesId = const Value.absent(),
            Value<String?> speciesName = const Value.absent(),
            Value<String?> breedName = const Value.absent(),
            Value<String?> sex = const Value.absent(),
            Value<DateTime?> birthDate = const Value.absent(),
            Value<int?> birthYear = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> ownerId = const Value.absent(),
            Value<String?> ownerName = const Value.absent(),
            Value<String?> ownerIin = const Value.absent(),
            Value<String?> regionName = const Value.absent(),
            Value<double?> lastLatitude = const Value.absent(),
            Value<double?> lastLongitude = const Value.absent(),
            Value<DateTime?> lastSeenAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalAnimalsCompanion(
            id: id,
            localId: localId,
            identificationNo: identificationNo,
            microchipNo: microchipNo,
            rfidTagNo: rfidTagNo,
            speciesId: speciesId,
            speciesName: speciesName,
            breedName: breedName,
            sex: sex,
            birthDate: birthDate,
            birthYear: birthYear,
            color: color,
            weightKg: weightKg,
            status: status,
            ownerId: ownerId,
            ownerName: ownerName,
            ownerIin: ownerIin,
            regionName: regionName,
            lastLatitude: lastLatitude,
            lastLongitude: lastLongitude,
            lastSeenAt: lastSeenAt,
            isSynced: isSynced,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> localId = const Value.absent(),
            Value<String?> identificationNo = const Value.absent(),
            Value<String?> microchipNo = const Value.absent(),
            Value<String?> rfidTagNo = const Value.absent(),
            Value<String?> speciesId = const Value.absent(),
            Value<String?> speciesName = const Value.absent(),
            Value<String?> breedName = const Value.absent(),
            Value<String?> sex = const Value.absent(),
            Value<DateTime?> birthDate = const Value.absent(),
            Value<int?> birthYear = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> ownerId = const Value.absent(),
            Value<String?> ownerName = const Value.absent(),
            Value<String?> ownerIin = const Value.absent(),
            Value<String?> regionName = const Value.absent(),
            Value<double?> lastLatitude = const Value.absent(),
            Value<double?> lastLongitude = const Value.absent(),
            Value<DateTime?> lastSeenAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalAnimalsCompanion.insert(
            id: id,
            localId: localId,
            identificationNo: identificationNo,
            microchipNo: microchipNo,
            rfidTagNo: rfidTagNo,
            speciesId: speciesId,
            speciesName: speciesName,
            breedName: breedName,
            sex: sex,
            birthDate: birthDate,
            birthYear: birthYear,
            color: color,
            weightKg: weightKg,
            status: status,
            ownerId: ownerId,
            ownerName: ownerName,
            ownerIin: ownerIin,
            regionName: regionName,
            lastLatitude: lastLatitude,
            lastLongitude: lastLongitude,
            lastSeenAt: lastSeenAt,
            isSynced: isSynced,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalAnimalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalAnimalsTable,
    LocalAnimal,
    $$LocalAnimalsTableFilterComposer,
    $$LocalAnimalsTableOrderingComposer,
    $$LocalAnimalsTableAnnotationComposer,
    $$LocalAnimalsTableCreateCompanionBuilder,
    $$LocalAnimalsTableUpdateCompanionBuilder,
    (
      LocalAnimal,
      BaseReferences<_$AppDatabase, $LocalAnimalsTable, LocalAnimal>
    ),
    LocalAnimal,
    PrefetchHooks Function()>;
typedef $$LocalProcedureActsTableCreateCompanionBuilder
    = LocalProcedureActsCompanion Function({
  required String id,
  Value<String?> localId,
  required String actNumber,
  required DateTime actDate,
  required String procedureType,
  Value<String?> diseaseName,
  Value<String?> settlement,
  Value<String?> specialistName,
  Value<String?> ownerIin,
  Value<String?> ownerName,
  Value<String?> speciesName,
  Value<int?> maleCount,
  Value<int?> femaleCount,
  Value<int?> youngCount,
  Value<int?> totalVaccinated,
  Value<String?> vaccineName,
  Value<String?> manufacturer,
  Value<String?> series,
  Value<String> status,
  Value<String?> animalsJson,
  Value<bool> isSynced,
  Value<DateTime?> createdAt,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});
typedef $$LocalProcedureActsTableUpdateCompanionBuilder
    = LocalProcedureActsCompanion Function({
  Value<String> id,
  Value<String?> localId,
  Value<String> actNumber,
  Value<DateTime> actDate,
  Value<String> procedureType,
  Value<String?> diseaseName,
  Value<String?> settlement,
  Value<String?> specialistName,
  Value<String?> ownerIin,
  Value<String?> ownerName,
  Value<String?> speciesName,
  Value<int?> maleCount,
  Value<int?> femaleCount,
  Value<int?> youngCount,
  Value<int?> totalVaccinated,
  Value<String?> vaccineName,
  Value<String?> manufacturer,
  Value<String?> series,
  Value<String> status,
  Value<String?> animalsJson,
  Value<bool> isSynced,
  Value<DateTime?> createdAt,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$LocalProcedureActsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalProcedureActsTable> {
  $$LocalProcedureActsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actNumber => $composableBuilder(
      column: $table.actNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get actDate => $composableBuilder(
      column: $table.actDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get procedureType => $composableBuilder(
      column: $table.procedureType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get diseaseName => $composableBuilder(
      column: $table.diseaseName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get settlement => $composableBuilder(
      column: $table.settlement, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specialistName => $composableBuilder(
      column: $table.specialistName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerIin => $composableBuilder(
      column: $table.ownerIin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get speciesName => $composableBuilder(
      column: $table.speciesName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maleCount => $composableBuilder(
      column: $table.maleCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get femaleCount => $composableBuilder(
      column: $table.femaleCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get youngCount => $composableBuilder(
      column: $table.youngCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalVaccinated => $composableBuilder(
      column: $table.totalVaccinated,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vaccineName => $composableBuilder(
      column: $table.vaccineName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get series => $composableBuilder(
      column: $table.series, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get animalsJson => $composableBuilder(
      column: $table.animalsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalProcedureActsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalProcedureActsTable> {
  $$LocalProcedureActsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actNumber => $composableBuilder(
      column: $table.actNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get actDate => $composableBuilder(
      column: $table.actDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get procedureType => $composableBuilder(
      column: $table.procedureType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get diseaseName => $composableBuilder(
      column: $table.diseaseName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get settlement => $composableBuilder(
      column: $table.settlement, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specialistName => $composableBuilder(
      column: $table.specialistName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerIin => $composableBuilder(
      column: $table.ownerIin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get speciesName => $composableBuilder(
      column: $table.speciesName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maleCount => $composableBuilder(
      column: $table.maleCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get femaleCount => $composableBuilder(
      column: $table.femaleCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get youngCount => $composableBuilder(
      column: $table.youngCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalVaccinated => $composableBuilder(
      column: $table.totalVaccinated,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vaccineName => $composableBuilder(
      column: $table.vaccineName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get series => $composableBuilder(
      column: $table.series, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get animalsJson => $composableBuilder(
      column: $table.animalsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalProcedureActsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalProcedureActsTable> {
  $$LocalProcedureActsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get actNumber =>
      $composableBuilder(column: $table.actNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get actDate =>
      $composableBuilder(column: $table.actDate, builder: (column) => column);

  GeneratedColumn<String> get procedureType => $composableBuilder(
      column: $table.procedureType, builder: (column) => column);

  GeneratedColumn<String> get diseaseName => $composableBuilder(
      column: $table.diseaseName, builder: (column) => column);

  GeneratedColumn<String> get settlement => $composableBuilder(
      column: $table.settlement, builder: (column) => column);

  GeneratedColumn<String> get specialistName => $composableBuilder(
      column: $table.specialistName, builder: (column) => column);

  GeneratedColumn<String> get ownerIin =>
      $composableBuilder(column: $table.ownerIin, builder: (column) => column);

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get speciesName => $composableBuilder(
      column: $table.speciesName, builder: (column) => column);

  GeneratedColumn<int> get maleCount =>
      $composableBuilder(column: $table.maleCount, builder: (column) => column);

  GeneratedColumn<int> get femaleCount => $composableBuilder(
      column: $table.femaleCount, builder: (column) => column);

  GeneratedColumn<int> get youngCount => $composableBuilder(
      column: $table.youngCount, builder: (column) => column);

  GeneratedColumn<int> get totalVaccinated => $composableBuilder(
      column: $table.totalVaccinated, builder: (column) => column);

  GeneratedColumn<String> get vaccineName => $composableBuilder(
      column: $table.vaccineName, builder: (column) => column);

  GeneratedColumn<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => column);

  GeneratedColumn<String> get series =>
      $composableBuilder(column: $table.series, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get animalsJson => $composableBuilder(
      column: $table.animalsJson, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$LocalProcedureActsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalProcedureActsTable,
    LocalProcedureAct,
    $$LocalProcedureActsTableFilterComposer,
    $$LocalProcedureActsTableOrderingComposer,
    $$LocalProcedureActsTableAnnotationComposer,
    $$LocalProcedureActsTableCreateCompanionBuilder,
    $$LocalProcedureActsTableUpdateCompanionBuilder,
    (
      LocalProcedureAct,
      BaseReferences<_$AppDatabase, $LocalProcedureActsTable, LocalProcedureAct>
    ),
    LocalProcedureAct,
    PrefetchHooks Function()> {
  $$LocalProcedureActsTableTableManager(
      _$AppDatabase db, $LocalProcedureActsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProcedureActsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProcedureActsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalProcedureActsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> localId = const Value.absent(),
            Value<String> actNumber = const Value.absent(),
            Value<DateTime> actDate = const Value.absent(),
            Value<String> procedureType = const Value.absent(),
            Value<String?> diseaseName = const Value.absent(),
            Value<String?> settlement = const Value.absent(),
            Value<String?> specialistName = const Value.absent(),
            Value<String?> ownerIin = const Value.absent(),
            Value<String?> ownerName = const Value.absent(),
            Value<String?> speciesName = const Value.absent(),
            Value<int?> maleCount = const Value.absent(),
            Value<int?> femaleCount = const Value.absent(),
            Value<int?> youngCount = const Value.absent(),
            Value<int?> totalVaccinated = const Value.absent(),
            Value<String?> vaccineName = const Value.absent(),
            Value<String?> manufacturer = const Value.absent(),
            Value<String?> series = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> animalsJson = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalProcedureActsCompanion(
            id: id,
            localId: localId,
            actNumber: actNumber,
            actDate: actDate,
            procedureType: procedureType,
            diseaseName: diseaseName,
            settlement: settlement,
            specialistName: specialistName,
            ownerIin: ownerIin,
            ownerName: ownerName,
            speciesName: speciesName,
            maleCount: maleCount,
            femaleCount: femaleCount,
            youngCount: youngCount,
            totalVaccinated: totalVaccinated,
            vaccineName: vaccineName,
            manufacturer: manufacturer,
            series: series,
            status: status,
            animalsJson: animalsJson,
            isSynced: isSynced,
            createdAt: createdAt,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> localId = const Value.absent(),
            required String actNumber,
            required DateTime actDate,
            required String procedureType,
            Value<String?> diseaseName = const Value.absent(),
            Value<String?> settlement = const Value.absent(),
            Value<String?> specialistName = const Value.absent(),
            Value<String?> ownerIin = const Value.absent(),
            Value<String?> ownerName = const Value.absent(),
            Value<String?> speciesName = const Value.absent(),
            Value<int?> maleCount = const Value.absent(),
            Value<int?> femaleCount = const Value.absent(),
            Value<int?> youngCount = const Value.absent(),
            Value<int?> totalVaccinated = const Value.absent(),
            Value<String?> vaccineName = const Value.absent(),
            Value<String?> manufacturer = const Value.absent(),
            Value<String?> series = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> animalsJson = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalProcedureActsCompanion.insert(
            id: id,
            localId: localId,
            actNumber: actNumber,
            actDate: actDate,
            procedureType: procedureType,
            diseaseName: diseaseName,
            settlement: settlement,
            specialistName: specialistName,
            ownerIin: ownerIin,
            ownerName: ownerName,
            speciesName: speciesName,
            maleCount: maleCount,
            femaleCount: femaleCount,
            youngCount: youngCount,
            totalVaccinated: totalVaccinated,
            vaccineName: vaccineName,
            manufacturer: manufacturer,
            series: series,
            status: status,
            animalsJson: animalsJson,
            isSynced: isSynced,
            createdAt: createdAt,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalProcedureActsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalProcedureActsTable,
    LocalProcedureAct,
    $$LocalProcedureActsTableFilterComposer,
    $$LocalProcedureActsTableOrderingComposer,
    $$LocalProcedureActsTableAnnotationComposer,
    $$LocalProcedureActsTableCreateCompanionBuilder,
    $$LocalProcedureActsTableUpdateCompanionBuilder,
    (
      LocalProcedureAct,
      BaseReferences<_$AppDatabase, $LocalProcedureActsTable, LocalProcedureAct>
    ),
    LocalProcedureAct,
    PrefetchHooks Function()>;
typedef $$LocalGeofencesTableCreateCompanionBuilder = LocalGeofencesCompanion
    Function({
  required String id,
  required String name,
  required String geofenceType,
  required String boundaryGeoJson,
  Value<String?> regionName,
  Value<bool> isActive,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});
typedef $$LocalGeofencesTableUpdateCompanionBuilder = LocalGeofencesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> geofenceType,
  Value<String> boundaryGeoJson,
  Value<String?> regionName,
  Value<bool> isActive,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$LocalGeofencesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalGeofencesTable> {
  $$LocalGeofencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get geofenceType => $composableBuilder(
      column: $table.geofenceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get boundaryGeoJson => $composableBuilder(
      column: $table.boundaryGeoJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get regionName => $composableBuilder(
      column: $table.regionName, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalGeofencesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalGeofencesTable> {
  $$LocalGeofencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get geofenceType => $composableBuilder(
      column: $table.geofenceType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get boundaryGeoJson => $composableBuilder(
      column: $table.boundaryGeoJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get regionName => $composableBuilder(
      column: $table.regionName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalGeofencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalGeofencesTable> {
  $$LocalGeofencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get geofenceType => $composableBuilder(
      column: $table.geofenceType, builder: (column) => column);

  GeneratedColumn<String> get boundaryGeoJson => $composableBuilder(
      column: $table.boundaryGeoJson, builder: (column) => column);

  GeneratedColumn<String> get regionName => $composableBuilder(
      column: $table.regionName, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$LocalGeofencesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalGeofencesTable,
    LocalGeofence,
    $$LocalGeofencesTableFilterComposer,
    $$LocalGeofencesTableOrderingComposer,
    $$LocalGeofencesTableAnnotationComposer,
    $$LocalGeofencesTableCreateCompanionBuilder,
    $$LocalGeofencesTableUpdateCompanionBuilder,
    (
      LocalGeofence,
      BaseReferences<_$AppDatabase, $LocalGeofencesTable, LocalGeofence>
    ),
    LocalGeofence,
    PrefetchHooks Function()> {
  $$LocalGeofencesTableTableManager(
      _$AppDatabase db, $LocalGeofencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalGeofencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalGeofencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalGeofencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> geofenceType = const Value.absent(),
            Value<String> boundaryGeoJson = const Value.absent(),
            Value<String?> regionName = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalGeofencesCompanion(
            id: id,
            name: name,
            geofenceType: geofenceType,
            boundaryGeoJson: boundaryGeoJson,
            regionName: regionName,
            isActive: isActive,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String geofenceType,
            required String boundaryGeoJson,
            Value<String?> regionName = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalGeofencesCompanion.insert(
            id: id,
            name: name,
            geofenceType: geofenceType,
            boundaryGeoJson: boundaryGeoJson,
            regionName: regionName,
            isActive: isActive,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalGeofencesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalGeofencesTable,
    LocalGeofence,
    $$LocalGeofencesTableFilterComposer,
    $$LocalGeofencesTableOrderingComposer,
    $$LocalGeofencesTableAnnotationComposer,
    $$LocalGeofencesTableCreateCompanionBuilder,
    $$LocalGeofencesTableUpdateCompanionBuilder,
    (
      LocalGeofence,
      BaseReferences<_$AppDatabase, $LocalGeofencesTable, LocalGeofence>
    ),
    LocalGeofence,
    PrefetchHooks Function()>;
typedef $$LocalGpsReadingsTableCreateCompanionBuilder
    = LocalGpsReadingsCompanion Function({
  required String id,
  required String deviceId,
  Value<String?> animalId,
  required double latitude,
  required double longitude,
  Value<double?> altitude,
  Value<double?> speedKmh,
  Value<double?> batteryLevel,
  required DateTime timestamp,
  Value<int> rowid,
});
typedef $$LocalGpsReadingsTableUpdateCompanionBuilder
    = LocalGpsReadingsCompanion Function({
  Value<String> id,
  Value<String> deviceId,
  Value<String?> animalId,
  Value<double> latitude,
  Value<double> longitude,
  Value<double?> altitude,
  Value<double?> speedKmh,
  Value<double?> batteryLevel,
  Value<DateTime> timestamp,
  Value<int> rowid,
});

class $$LocalGpsReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalGpsReadingsTable> {
  $$LocalGpsReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get animalId => $composableBuilder(
      column: $table.animalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get altitude => $composableBuilder(
      column: $table.altitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get speedKmh => $composableBuilder(
      column: $table.speedKmh, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get batteryLevel => $composableBuilder(
      column: $table.batteryLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$LocalGpsReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalGpsReadingsTable> {
  $$LocalGpsReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get animalId => $composableBuilder(
      column: $table.animalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get altitude => $composableBuilder(
      column: $table.altitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get speedKmh => $composableBuilder(
      column: $table.speedKmh, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get batteryLevel => $composableBuilder(
      column: $table.batteryLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$LocalGpsReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalGpsReadingsTable> {
  $$LocalGpsReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get animalId =>
      $composableBuilder(column: $table.animalId, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get altitude =>
      $composableBuilder(column: $table.altitude, builder: (column) => column);

  GeneratedColumn<double> get speedKmh =>
      $composableBuilder(column: $table.speedKmh, builder: (column) => column);

  GeneratedColumn<double> get batteryLevel => $composableBuilder(
      column: $table.batteryLevel, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$LocalGpsReadingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalGpsReadingsTable,
    LocalGpsReading,
    $$LocalGpsReadingsTableFilterComposer,
    $$LocalGpsReadingsTableOrderingComposer,
    $$LocalGpsReadingsTableAnnotationComposer,
    $$LocalGpsReadingsTableCreateCompanionBuilder,
    $$LocalGpsReadingsTableUpdateCompanionBuilder,
    (
      LocalGpsReading,
      BaseReferences<_$AppDatabase, $LocalGpsReadingsTable, LocalGpsReading>
    ),
    LocalGpsReading,
    PrefetchHooks Function()> {
  $$LocalGpsReadingsTableTableManager(
      _$AppDatabase db, $LocalGpsReadingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalGpsReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalGpsReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalGpsReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> deviceId = const Value.absent(),
            Value<String?> animalId = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<double?> altitude = const Value.absent(),
            Value<double?> speedKmh = const Value.absent(),
            Value<double?> batteryLevel = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalGpsReadingsCompanion(
            id: id,
            deviceId: deviceId,
            animalId: animalId,
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            speedKmh: speedKmh,
            batteryLevel: batteryLevel,
            timestamp: timestamp,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String deviceId,
            Value<String?> animalId = const Value.absent(),
            required double latitude,
            required double longitude,
            Value<double?> altitude = const Value.absent(),
            Value<double?> speedKmh = const Value.absent(),
            Value<double?> batteryLevel = const Value.absent(),
            required DateTime timestamp,
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalGpsReadingsCompanion.insert(
            id: id,
            deviceId: deviceId,
            animalId: animalId,
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            speedKmh: speedKmh,
            batteryLevel: batteryLevel,
            timestamp: timestamp,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalGpsReadingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalGpsReadingsTable,
    LocalGpsReading,
    $$LocalGpsReadingsTableFilterComposer,
    $$LocalGpsReadingsTableOrderingComposer,
    $$LocalGpsReadingsTableAnnotationComposer,
    $$LocalGpsReadingsTableCreateCompanionBuilder,
    $$LocalGpsReadingsTableUpdateCompanionBuilder,
    (
      LocalGpsReading,
      BaseReferences<_$AppDatabase, $LocalGpsReadingsTable, LocalGpsReading>
    ),
    LocalGpsReading,
    PrefetchHooks Function()>;
typedef $$LocalInventoryItemsTableCreateCompanionBuilder
    = LocalInventoryItemsCompanion Function({
  required String id,
  required String name,
  required String category,
  required String unit,
  required int quantity,
  required int minQuantity,
  Value<String?> series,
  Value<String?> expiryDate,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});
typedef $$LocalInventoryItemsTableUpdateCompanionBuilder
    = LocalInventoryItemsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> category,
  Value<String> unit,
  Value<int> quantity,
  Value<int> minQuantity,
  Value<String?> series,
  Value<String?> expiryDate,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$LocalInventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalInventoryItemsTable> {
  $$LocalInventoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minQuantity => $composableBuilder(
      column: $table.minQuantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get series => $composableBuilder(
      column: $table.series, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalInventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalInventoryItemsTable> {
  $$LocalInventoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minQuantity => $composableBuilder(
      column: $table.minQuantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get series => $composableBuilder(
      column: $table.series, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalInventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalInventoryItemsTable> {
  $$LocalInventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get minQuantity => $composableBuilder(
      column: $table.minQuantity, builder: (column) => column);

  GeneratedColumn<String> get series =>
      $composableBuilder(column: $table.series, builder: (column) => column);

  GeneratedColumn<String> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$LocalInventoryItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalInventoryItemsTable,
    LocalInventoryItem,
    $$LocalInventoryItemsTableFilterComposer,
    $$LocalInventoryItemsTableOrderingComposer,
    $$LocalInventoryItemsTableAnnotationComposer,
    $$LocalInventoryItemsTableCreateCompanionBuilder,
    $$LocalInventoryItemsTableUpdateCompanionBuilder,
    (
      LocalInventoryItem,
      BaseReferences<_$AppDatabase, $LocalInventoryItemsTable,
          LocalInventoryItem>
    ),
    LocalInventoryItem,
    PrefetchHooks Function()> {
  $$LocalInventoryItemsTableTableManager(
      _$AppDatabase db, $LocalInventoryItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalInventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalInventoryItemsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalInventoryItemsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<int> minQuantity = const Value.absent(),
            Value<String?> series = const Value.absent(),
            Value<String?> expiryDate = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalInventoryItemsCompanion(
            id: id,
            name: name,
            category: category,
            unit: unit,
            quantity: quantity,
            minQuantity: minQuantity,
            series: series,
            expiryDate: expiryDate,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String category,
            required String unit,
            required int quantity,
            required int minQuantity,
            Value<String?> series = const Value.absent(),
            Value<String?> expiryDate = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalInventoryItemsCompanion.insert(
            id: id,
            name: name,
            category: category,
            unit: unit,
            quantity: quantity,
            minQuantity: minQuantity,
            series: series,
            expiryDate: expiryDate,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalInventoryItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalInventoryItemsTable,
    LocalInventoryItem,
    $$LocalInventoryItemsTableFilterComposer,
    $$LocalInventoryItemsTableOrderingComposer,
    $$LocalInventoryItemsTableAnnotationComposer,
    $$LocalInventoryItemsTableCreateCompanionBuilder,
    $$LocalInventoryItemsTableUpdateCompanionBuilder,
    (
      LocalInventoryItem,
      BaseReferences<_$AppDatabase, $LocalInventoryItemsTable,
          LocalInventoryItem>
    ),
    LocalInventoryItem,
    PrefetchHooks Function()>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  required String id,
  required String entityType,
  required String entityId,
  required String operation,
  required String payload,
  Value<int> retryCount,
  Value<DateTime> createdAt,
  Value<DateTime?> lastAttemptAt,
  Value<String?> errorMessage,
  Value<int> rowid,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<String> id,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> operation,
  Value<String> payload,
  Value<int> retryCount,
  Value<DateTime> createdAt,
  Value<DateTime?> lastAttemptAt,
  Value<String?> errorMessage,
  Value<int> rowid,
});

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            retryCount: retryCount,
            createdAt: createdAt,
            lastAttemptAt: lastAttemptAt,
            errorMessage: errorMessage,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String entityType,
            required String entityId,
            required String operation,
            required String payload,
            Value<int> retryCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            retryCount: retryCount,
            createdAt: createdAt,
            lastAttemptAt: lastAttemptAt,
            errorMessage: errorMessage,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalUsersTableTableManager get localUsers =>
      $$LocalUsersTableTableManager(_db, _db.localUsers);
  $$LocalAnimalsTableTableManager get localAnimals =>
      $$LocalAnimalsTableTableManager(_db, _db.localAnimals);
  $$LocalProcedureActsTableTableManager get localProcedureActs =>
      $$LocalProcedureActsTableTableManager(_db, _db.localProcedureActs);
  $$LocalGeofencesTableTableManager get localGeofences =>
      $$LocalGeofencesTableTableManager(_db, _db.localGeofences);
  $$LocalGpsReadingsTableTableManager get localGpsReadings =>
      $$LocalGpsReadingsTableTableManager(_db, _db.localGpsReadings);
  $$LocalInventoryItemsTableTableManager get localInventoryItems =>
      $$LocalInventoryItemsTableTableManager(_db, _db.localInventoryItems);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
}
