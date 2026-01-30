class UserProfile {
  final String nickname;
  final DateTime? birthDate;
  final String avatar;
  final String? email;

  UserProfile({
    required this.nickname,
    this.birthDate,
    required this.avatar,
    this.email,
});

  Map<String, dynamic> toMap() => {
    'nickname': nickname,
    'birthDate': birthDate?.toIso8601String(),
    'avatar': avatar,
    'email': email,
  };

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      nickname: map['nickname'] ?? '',
      birthDate: map['birthDate'] != null
          ? DateTime.tryParse(map['birthDate']) : null,
      avatar: map['avatar'] ?? 'assets/avatars/avatar_start.png',
      email: map['email'],
    );
  }
}