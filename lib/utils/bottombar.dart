import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:Kwiz/presentation/screens/SearchPage/search_page.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:Kwiz/presentation/screens/home/home_page.dart';
import 'package:Kwiz/presentation/screens/settings/settings_page.dart';
import 'package:Kwiz/presentation/screens/wallet/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // For reading from local storage


class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0; 
  final WalletBalanceController walletBalanceController = Get.put(WalletBalanceController()); 
  final box = GetStorage(); 

  // A list of GlobalKeys for each Navigator to keep separate stacks
  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(), // Home Navigator Key
    GlobalKey<NavigatorState>(), // Search Navigator Key
    GlobalKey<NavigatorState>(), // Wallet Navigator Key
    GlobalKey<NavigatorState>(), // Settings Navigator Key
  ];

  // To store the main pages (using IndexedStack to keep their states)
  List<Widget> _pages = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages = [
      Navigator(
        key: navigatorKeys[0],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (context) => HomePage());
        },
      ),
      Navigator(
        key: navigatorKeys[1],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (context) => SearchScreen());
        },
      ),
      Navigator(
        key: navigatorKeys[2],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (context) => WalletPage(userId: '', walletBalance: 0)); // Placeholder
        },
      ),
      Navigator(
        key: navigatorKeys[3],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (context) => SettingsPage());
        },
      ),
    ];
  }

  void _onItemTapped(int index) async {
    final userId = box.read(LocalStorageConstants.userId).toString();

    if (index == _selectedIndex) {
      // If the user taps the currently selected tab
      if (index == 0) {
        // If Home is selected again, pop until the first route
        if (navigatorKeys[index].currentState!.canPop()) {
          navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
        }
      }
    } else {
      // Change the selected tab
      setState(() {
        _selectedIndex = index;
      });

      // Handle Wallet tab selection
      if (index == 2 && userId.isNotEmpty) {
        await walletBalanceController.getWalletBalanceUser(
          context: context,
          user_id: userId,
        );

        final walletBalance = walletBalanceController.walletBalanceModel?.walletBalance;

        // Ensure the WalletPage is shown with the latest wallet balance
        if (navigatorKeys[2].currentState?.canPop() ?? false) {
          navigatorKeys[2].currentState!.popUntil((route) => route.isFirst); // Pop to the first route of Wallet
        }
        navigatorKeys[2].currentState!.pushReplacement(
          MaterialPageRoute(
            builder: (context) => WalletPage(userId: userId, walletBalance: walletBalance),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.yellowcolor, // Set the background color
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colours.yellowcolor, // Yellow background for the BottomNavigationBar
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colours.primaryColor, // Primary color for selected item
        unselectedItemColor: Colours.CardColour, // Grey for unselected items
        type: BottomNavigationBarType.fixed, // Ensure labels stay visible
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
