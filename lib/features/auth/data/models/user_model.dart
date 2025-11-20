import 'package:ub_t/core/common/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.matriculeNumber,
    required super.department,
    required super.level,
    required super.subscriptionStatus,
    super.trialStartDate,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      matriculeNumber: json['matricule'] ?? '',
      department: json['department'] ?? '',
      level: json['level'] ?? 0,
      subscriptionStatus: json['subscription_status'] ?? 'inactive',
      trialStartDate: json['trial_start_date'] != null
          ? DateTime.parse(json['trial_start_date'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matricule': matriculeNumber,
      'department': department,
      'level': level,
      'subscription_status': subscriptionStatus,
      'trial_start_date': trialStartDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  User toEntity() {
    return User(
      id: id,
      matriculeNumber: matriculeNumber,
      department: department,
      level: level,
      subscriptionStatus: subscriptionStatus,
      trialStartDate: trialStartDate,
      createdAt: createdAt,
    );
  }
}
