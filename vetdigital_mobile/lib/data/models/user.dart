import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String iin,
    required String fullName,
    required String role,
    String? phone,
    String? email,
    String? organizationId,
    String? organizationName,
    String? regionKato,
    String? regionName,
    String? edsCertSerial,
    DateTime? edsCertExpiry,
    String? language,
    @Default(true) bool isActive,
    DateTime? createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Auth token response
@freezed
class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required int expiresIn,
    required UserModel user,
  }) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);
}

/// Role constants matching backend RBAC
class UserRole {
  static const String admin = 'admin';
  static const String veterinarian = 'veterinarian';
  static const String farmer = 'farmer';
  static const String inspector = 'inspector';
  static const String lab = 'lab';
  static const String supplier = 'supplier';
}
