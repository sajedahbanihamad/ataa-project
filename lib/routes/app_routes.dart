import 'package:flutter/material.dart';

import '../pages/presentation/login_screen/login_screen.dart';
import '../pages/presentation/registration_screen/registration_screen.dart';
import '../pages/presentation/splash_screen/splash1.dart';
import '../pages/presentation/splash_screen/splash2.dart';
import '../pages/presentation/app_navigation_screen/app_navigation_screen.dart';
import '../pages/presentation/donor_screens/home/view/home_screen.dart';
import '../pages/presentation/donor_screens/create_donation_screen.dart';
import '../pages/presentation/donor_screens/notifications_screen.dart';
import '../pages/presentation/donor_screens/profile_screen.dart';
import '../pages/presentation/donor_screens/history_screen.dart';
import '../pages/presentation/donor_screens/choosecharity_screen.dart';
import '../pages/presentation/donor_screens/Ai_match_screen.dart';
import '../pages/presentation/donor_screens/donationdetails_screen.dart';
import '../pages/presentation/donor_screens/confirmation_screen.dart';
import '../pages/presentation/main_donorscreen.dart';
import '../pages/presentation/charity_screens/dashboard_screen.dart';
import '../pages/presentation/charity_screens/notifications_screen2.dart';
import '../pages/presentation/charity_screens/profile_screen2.dart';
import '../pages/presentation/charity_screens/donations_screen2.dart';
import '../pages/presentation/charity_screens/history_screen2.dart';
import '../pages/presentation/charity_screens/ratedonor_screen.dart';
import '../pages/presentation/main_charityscreen.dart';
import '../pages/presentation/admin_screens/admin_dashboard.dart';
import '../pages/presentation/admin_screens/admin_donationdetails.dart';
import '../pages/presentation/admin_screens/admin_donations.dart';
import '../pages/presentation/admin_screens/admin_notifications.dart';
import '../pages/presentation/admin_screens/admin_profile.dart';
import '../pages/presentation/admin_screens/report_screen.dart';
import '../pages/presentation/admin_screens/user_details.dart';
import '../pages/presentation/admin_screens/users_screen.dart';
import '../pages/presentation/main_adminscreen.dart';

class AppRoutes {
  static const String splashScreen = '/splash1';
  static const String secondSplash = '/splash2';
  static const String loginScreen = '/login_screen';
  static const String maindonorScreen = '/main_donorscreen';
  static const String registrationScreen = '/registration_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/splash1';
  static const String homeScreen = '/home_screen';
  static const String createDonationScreen = '/create_donation_screen';
  static const String notificationsScreen = '/notifications_screen';
  static const String profileScreen = '/profile_screen';
  static const String historyScreen = '/history_screen';
  static const String donationdetailsScreen = '/donationdetails_screen';
  static const String choosecharityScreen = '/choosecharity_screen';
  static const String aiMatchScreen = '/Ai_match_screen';
  static const String confirmationScreen = '/confirmation_screen';
  static const String dashboardScreen = '/dashboard_screen';
  static const String notificationsScreen2 = '/notifications_screen2';
  static const String profileScreen2 = '/profile_screen2';
  static const String donationsScreen2 = '/donations_screen2';
  static const String historyScreen2 = '/history_screen2';
  static const String ratedonorScreen = '/ratedonor_screen';
  static const String maincharityScreen = '/main_charityscreen';
  static const String adminDashboard = '/admin_dashboard';
  static const String admindonationDetails = '/admin_donationdetails';
  static const String adminDonations = '/admin_donations';
  static const String adminNotifications = '/admin_notifications';
  static const String adminProfile = '/admin_Profile';
  static const String reportScreen = '/report_screen';
  static const String userDetails = '/user_details';
  static const String usersScreen = '/users_screen';
  static const String mainadminScreen = '/main_adminscreen';

  static final Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    secondSplash: (context) => const SecondScreen(),
    loginScreen: (context) => const LoginScreen(),
    maindonorScreen: (context) => const MaindonorScreen(),
    registrationScreen: (context) => const RegistrationScreen(),
    appNavigationScreen: (context) => const AppNavigationScreen(),
    homeScreen: (context) => const HomeScreen(),
    createDonationScreen: (context) => const CreateDonationScreen(),
    notificationsScreen: (context) => const NotificationsScreen(),
    profileScreen: (context) => const ProfileScreen(),
    historyScreen: (context) => const DonationHistory(),
    choosecharityScreen: (context) => const ChooseCharityScreen(),
    aiMatchScreen: (context) => const AIMatchSuggestionScreen(),
    donationdetailsScreen: (context) => const DonationDetailsInput(),
    confirmationScreen: (context) => const DonationConfirmationScreen(),
    dashboardScreen: (context) => const CharityHomeScreen(),
    notificationsScreen2: (context) => const CharityNotificationsScreen(),
    profileScreen2: (context) => const CharityProfileScreen(),
    donationsScreen2: (context) => const MyDonationsScreen(),
    historyScreen2: (context) => const CharityHistoryScreen(),
    ratedonorScreen: (context) => const RateDonorScreen(),
    maincharityScreen: (context) => const MaincharityScreen(),
    adminDashboard: (context) => const AdminDashboard(),
    admindonationDetails: (context) {
      final id = ModalRoute.of(context)!.settings.arguments as String;
      return AdminDonationdetails(id: id);
    },
    adminDonations: (context) => const AdminDonations(),
    adminNotifications: (context) => const AdminNotifications(),
    adminProfile: (context) => const AdminProfile(),
    reportScreen: (context) => const ReportsScreen(),
    userDetails: (context) {
      final id = ModalRoute.of(context)!.settings.arguments as String;
      return UserDetailsScreen(id: id);
    },
    usersScreen: (context) => const UsersScreen(),
    mainadminScreen: (context) => const MainAdminscreen(),
  };
}
