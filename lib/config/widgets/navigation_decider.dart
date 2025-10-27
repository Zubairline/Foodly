import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodly_backup/config/utils/colors.dart';
import 'package:foodly_backup/config/utils/icons.dart';
import 'package:foodly_backup/config/utils/images.dart';
import 'package:foodly_backup/config/utils/routes.dart';
import 'package:foodly_backup/config/utils/themes.dart';
import 'package:foodly_backup/features/courses/screen/courses.dart';
import 'package:foodly_backup/features/discovery/screen/discovery.dart';
import 'package:foodly_backup/features/plan/screen/plan.dart';
import 'package:foodly_backup/features/shop/screen/shop.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  final List<Widget> _pages = [Discovery(), Plan(), Shop(), CoursesScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<String> _greeting() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString('first_name');
    debugPrint(firstName);
    return 'Hello, $firstName';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, RouteGenerator.profile),
            child: CircleAvatar(backgroundImage: AssetImage(profile)),
          ),
        ),
        title: FutureBuilder(
          future: _greeting(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Hello, ...');
            } else if (snapshot.hasError) {
              return Text('Hey there 👋');
            }
            return Text(snapshot.data!);
          },
        ),
        actions: [
          IconButton(
            onPressed: () => Text("You've tapped on the settings icon"),
            icon: SvgPicture.asset(settingsSvg, width: 22, height: 22),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("See you soon!")));
              Navigator.restorablePushReplacementNamed(
                context,
                RouteGenerator.signIn,
              );
            },
            icon: SvgPicture.asset(logout, width: 22, height: 22),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: background,
        elevation: 10,
        shadowColor: Color(0xffd9d9d9),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(homeSvg, 'Discovery', 0),
              _buildNavItem(calendarSvg, 'Plan', 1),
              40.width,
              _buildNavItem(shopSvg, 'Shop', 2),
              _buildNavItem(coursesSvg, 'Courses', 3),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: background,
        onPressed: () {},
        shape: CircleBorder(),
        child: Image.asset('assets/logo/png/Logo.png'),
      ),
    );
  }

  Widget _buildNavItem(String imagePath, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            imagePath,
            width: 40,
            height: 40,
            colorFilter: ColorFilter.mode(
              isSelected ? selectedColor : unselectedColor,
              BlendMode.srcIn,
            ),
          ),
          4.height,
          Text(
            label,
            style: navigationBar.copyWith(
              color: isSelected ? selectedColor : largeButtons,
            ),
          ),
        ],
      ),
    );
  }
}
