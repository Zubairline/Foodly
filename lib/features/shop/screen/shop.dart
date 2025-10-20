import 'package:flutter/material.dart';
import 'package:foodly_backup/core/colors.dart';
import 'package:foodly_backup/core/themes.dart';
import 'package:foodly_backup/features/shop/widgets/number_badge.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  int startDay = 12;
  int endDay = 19;

  void _pickDate(bool isStart) async {
    final newDay = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Day'),
          content: SizedBox(
            height: 200,
            width: 100,
            child: ListView.builder(
              itemCount: 31,
              itemBuilder: (context, index) {
                final day = index + 1;
                return ListTile(
                  title: Text('$day'),
                  onTap: () {
                    Navigator.of(context).pop(day);
                  },
                );
              },
            ),
          ),
        );
      },
    );
    if (newDay != null) {
      setState(() {
        if (isStart) {
          startDay = newDay;
        } else {
          endDay = newDay;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('MMMM').format(now);
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Meal',
                  style: welcomeText,
                  textAlign: TextAlign.center,
                ),

                SizedBox(
                  child: Row(
                    children: [
                      Text(
                        formattedTime,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      8.width,

                      // First date (12)
                      NumberBadge(
                        number: startDay.toString(),
                        onTap: () => _pickDate(true),
                      ),

                      8.width,
                      const Text(
                        'to',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Second date (19)
                      NumberBadge(
                        number: endDay.toString(),
                        onTap: () => _pickDate(false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 350,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Stack(
                children: [
                  // Centered close icon
                  Center(
                    child: Icon(
                      Icons.close_rounded,
                      size: 250,
                      color: Colors.grey.shade400,
                    ),
                  ),

                  // Top-right button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton.outlined(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      iconSize: 20,
                      visualDensity: VisualDensity.comfortable,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(navigationButton),
                ),
                child: Text(
                  'Generate Shopping List',
                  style: buttons.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
