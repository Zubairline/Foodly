import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodly_backup/core/colors.dart';
import 'package:foodly_backup/core/icons.dart';
import 'package:foodly_backup/core/themes.dart';
import 'package:foodly_backup/features/cook_book/screen/cook_book.dart';
import 'package:foodly_backup/features/home/screen/home.dart';
import 'package:foodly_backup/features/plan/screen/plan.dart';
import 'package:foodly_backup/features/shop/screen/shop.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [Home(), Plan(), Shop(), CookBook()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(),
        title: Text('Hello, Sarah'),
        actions: [
          IconButton(
            onPressed: () => Text("You've tapped on the settings icon"),
            icon: SvgPicture.asset(settingsSvg, width: 22, height: 22),
          ),
          IconButton(
            onPressed: () => Text("You've tapped on the Logout icon"),
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
              _buildNavItem(cookBookSvg, 'CookBook', 3),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: background,
        onPressed: () {},
        shape: CircleBorder(),
        child: SvgPicture.asset('assets/logo/svg/Logo.svg'),
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
