import 'package:Ataa/pages/presentation/donor_screens/home/model/donation_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<RecentDonationModel> recentDonations = [
    RecentDonationModel(
      id: 1,
      charity: "Food Bank Central",
      category: "Food",
      items: "10 meal boxes",
      date: "Apr 25",
      status: "Delivered",
    ),
    RecentDonationModel(
      id: 2,
      charity: "Clothes for Hope",
      category: "Clothing",
      items: "3 bags",
      date: "Apr 20",
      status: "In Transit",
    ),
    RecentDonationModel(
      id: 3,
      charity: "Books for Kids",
      category: "Books",
      items: "15 books",
      date: "Apr 15",
      status: "Delivered",
    ),
  ];
}
