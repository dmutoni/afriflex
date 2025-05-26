import 'package:afriflex/models/dto/common_dto.dart';
import 'package:afriflex/models/role_model.dart';

class User extends Serializable {
  final String id;
  final String emailAddress;
  final String phoneNumber;
  final String gender;
  final List<Role> roles;
  final String status;
  final String name;
  final String firstName;
  final String lastName;
  final bool employeeAccount;
  final bool deletedFlag;
  final DateTime credentialsExpiryDate;
  final DateTime? lockedAt;
  final bool firstLogin;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final DateTime? resetAllowedUntil;
  final int? loginFailureCount;
  final String activationCode;
  // final dynamic signature;
  final bool accountExpired;
  final bool credentialsExpired;
  final bool accountEnabled;
  final bool accountLocked;

  User({
    required this.id,
    required this.emailAddress,
    required this.phoneNumber,
    required this.gender,
    required this.roles,
    required this.status,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.employeeAccount,
    required this.deletedFlag,
    required this.credentialsExpiryDate,
    this.lockedAt,
    required this.firstLogin,
    required this.createdAt,
    this.lastLogin,
    this.resetAllowedUntil,
    this.loginFailureCount,
    required this.activationCode,
    // this.signature,
    required this.accountExpired,
    required this.credentialsExpired,
    required this.accountEnabled,
    required this.accountLocked,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      emailAddress: json['emailAddress'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as String,
      roles: (json['roles'] as List<dynamic>)
          .map((role) => Role.fromJson(role as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      name: json['name'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      employeeAccount: json['employeeAccount'] as bool,
      deletedFlag: json['deletedFlag'] as bool,
      credentialsExpiryDate: DateTime.parse(json['credentialsExpiryDate']),
      lockedAt: json['lockedAt'] != null
          ? DateTime.parse(json['lockedAt'])
          : null,
      firstLogin: json['firstLogin'] as bool,
      createdAt: DateTime.parse(json['createdAt']),
      lastLogin: json['lastLogin'] != null
          ? DateTime.parse(json['lastLogin'])
          : null,
      resetAllowedUntil: json['resetAllowedUntil'] != null
          ? DateTime.parse(json['resetAllowedUntil'])
          : null,
      loginFailureCount: json['loginFailureCount'] as int?,
      activationCode: json['activationCode'] as String,
      // signature: json['signature'] as String?,
      accountExpired: json['accountExpired'] as bool,
      credentialsExpired: json['credentialsExpired'] as bool,
      accountEnabled: json['accountEnabled'] as bool,
      accountLocked: json['accountLocked'] as bool,
    );
  }

  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'roles': roles.map((role) => role.toJson()).toList(),
      'status': status,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'employeeAccount': employeeAccount,
      'deletedFlag': deletedFlag,
      'credentialsExpiryDate': credentialsExpiryDate.toIso8601String(),
      'lockedAt': lockedAt?.toIso8601String(),
      'firstLogin': firstLogin,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'resetAllowedUntil': resetAllowedUntil?.toIso8601String(),
      'loginFailureCount': loginFailureCount,
      'activationCode': activationCode,
      // 'signature': signature,
      'accountExpired': accountExpired,
      'credentialsExpired': credentialsExpired,
      'accountEnabled': accountEnabled,
      'accountLocked': accountLocked,
    };
  }
}