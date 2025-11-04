import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodly_backup/config/utils/images.dart';
import 'package:foodly_backup/config/utils/routes.dart';
import 'package:foodly_backup/features/auth/sign_in/screen/sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _profileImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String> _getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString('first_name') ?? '';
    final middleName = prefs.getString('middle_name') ?? '';
    final lastName = prefs.getString('last_name') ?? '';
    final fullName = '$firstName $middleName $lastName';
    return fullName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔙 Back Button + Title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFEB7A50),
                      size: 28,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'My Profile',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // for spacing balance
                ],
              ),
              const SizedBox(height: 25),

              // 🖼 Profile Picture + Edit Option
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: const Color(0xFFEADCD3),
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : const AssetImage(profile) as ImageProvider,
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEB7A50),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // 👩 Name
              FutureBuilder(
                future: _getFullName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  final name = snapshot.data;
                  return Text(
                    name ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  );
                },
              ),
              const SizedBox(height: 25),

              // 📊 Stats
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _StatBox(title: 'Recipes Created', count: 12),
                    _StatBox(title: 'Meals Planned', count: 48),
                    _StatBox(title: 'Fav Saved', count: 86),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 📚 Content Sections
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Content Sections',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 15),

              _SectionTile(
                icon: Icons.menu_book_rounded,
                color: Color(0xFFEB7A50),
                title: 'My Cookbook',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _SectionTile(
                icon: Icons.calendar_month_rounded,
                color: Color(0xFFEB7A50),
                title: 'Meal Planning History',
                onTap: () {},
              ),
              const SizedBox(height: 30),

              // ⚙ More Options
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'More Options',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 15),

              _OptionTile(
                icon: Icons.settings,
                title: 'Settings',
                color: Color(0xFFEB7A50),
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _OptionTile(
                icon: Icons.support_agent_rounded,
                title: 'Help and Support',
                color: Color(0xFFEB7A50),
                onTap: () {},
              ),
              const SizedBox(height: 40),

              // 🚪 Logout Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushReplacementNamed(
                      context,
                      RouteGenerator.signIn,
                    );
                    toast('Logged out successfully');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    'LogOut',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Widgets 💡

class _StatBox extends StatelessWidget {
  final String title;
  final int count;

  const _StatBox({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.black54, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SectionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _SectionTile({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
