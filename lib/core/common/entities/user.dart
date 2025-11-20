class User {
  final String id;
  final String matriculeNumber;
  final String department;
  final int level;
  final String subscriptionStatus;
  final DateTime? trialStartDate;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.matriculeNumber,
    required this.department,
    required this.level,
    required this.subscriptionStatus,
    this.trialStartDate,
    required this.createdAt,
  });

  bool get isTrialActive {
    if (trialStartDate == null) return false;
    final now = DateTime.now();
    final daysSinceStart = now.difference(trialStartDate!).inDays;
    return daysSinceStart < 5;
  }

  bool get hasActiveSubscription {
    return subscriptionStatus == 'active' || isTrialActive;
  }

  User copyWith({
    String? id,
    String? matriculeNumber,
    String? department,
    int? level,
    String? subscriptionStatus,
    DateTime? trialStartDate,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      matriculeNumber: matriculeNumber ?? this.matriculeNumber,
      department: department ?? this.department,
      level: level ?? this.level,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      trialStartDate: trialStartDate ?? this.trialStartDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
