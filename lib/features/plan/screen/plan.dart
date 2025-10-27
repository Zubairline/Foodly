import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  DateTime? selectedDay;
  final Map<DateTime, List<String>> _tasks = {};

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final year = now.year;
    final months = List.generate(12, (index) => DateTime(year, index + 1));

    return GestureDetector(
      onTap: () {
        setState(() => selectedDay = null);
      },
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          itemCount: months.length,
          itemBuilder: (context, index) {
            final month = months[index];
            final firstDay = DateTime(month.year, month.month, 1);
            final lastDay = DateTime(
              month.year,
              month.month + 1,
              0,
            ); // end of month

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMonthCalendar(firstDay, lastDay),
                const SizedBox(height: 24),

                // 📦 Task container (only for selected day)
                if (selectedDay != null &&
                    selectedDay!.month == month.month) ...[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => _showAddTaskDialog(context),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Add new plan",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.orange.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if ((_tasks[selectedDay!] ?? []).isEmpty)
                            const Text(
                              "No tasks yet for this day.",
                              style: TextStyle(color: Colors.black54),
                            )
                          else
                            ..._tasks[selectedDay!]!.map((task) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        task,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.black54,
                                        size: 22,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _tasks[selectedDay!]!.remove(task);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  // 🗓 Monthly Calendar
  Widget _buildMonthCalendar(DateTime firstDay, DateTime lastDay) {
    return TableCalendar(
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: firstDay,
      currentDay: DateTime.now(),
      availableGestures: AvailableGestures.none,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        headerMargin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
        weekendStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
      calendarStyle: CalendarStyle(
        defaultDecoration: BoxDecoration(
          color: const Color(0xFFDABDA5),
          shape: BoxShape.circle,
        ),
        weekendDecoration: BoxDecoration(
          color: const Color(0xFFDABDA5),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.redAccent.shade400,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.redAccent.shade400,
          shape: BoxShape.circle,
        ),
        todayTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        selectedTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        defaultTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        weekendTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: (selected, focused) {
        setState(() {
          if (isSameDay(selectedDay, selected)) {
            selectedDay = null;
          } else {
            selectedDay = selected;
          }
        });
      },
    );
  }

  // 📝 Add Task Dialog
  void _showAddTaskDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add New Plan"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter your plan or task...",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty && selectedDay != null) {
                setState(() {
                  _tasks[selectedDay!] ??= [];
                  _tasks[selectedDay!]!.add(controller.text.trim());
                });
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrangeAccent,
            ),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
