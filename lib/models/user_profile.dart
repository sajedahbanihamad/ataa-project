class UserProfile {
  final int userId;
  final String email;
  final String role;
  final int mealsDonated;
  final int foodSaved;
  final int rating;
  final int totalRatings;

  UserProfile({
    required this.userId,
    required this.email,
    required this.role,
    required this.mealsDonated,
    required this.foodSaved,
    required this.rating,
    required this.totalRatings,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'],
      email: json['email'],
      role: json['role'],
      mealsDonated: json['mealsDonated'],
      foodSaved: json['foodSaved'],
      rating: json['rating'],
      totalRatings: json['totalRatings'],
    );
  }
}
