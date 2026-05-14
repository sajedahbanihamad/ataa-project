class RecentDonationModel {
  final int id;
  final String charity;
  final String category;
  final String items;
  final String date;
  final String status;

  RecentDonationModel({
    required this.id,
    required this.charity,
    required this.category,
    required this.items,
    required this.date,
    required this.status,
  });

  factory RecentDonationModel.fromJson(Map<String, dynamic> json) {
    return RecentDonationModel(
      id: json['id'],
      charity: json['charity'],
      category: json['category'],
      items: json['items'],
      date: json['date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'charity': charity,
      'category': category,
      'items': items,
      'date': date,
      'status': status,
    };
  }
}
