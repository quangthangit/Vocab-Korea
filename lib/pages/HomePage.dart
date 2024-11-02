import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vocabkpop/components/library/LibraryLesson.dart';
import 'package:vocabkpop/models/LoginHistoryModel.dart';
import 'package:vocabkpop/services/LoginHistoryService.dart';
import 'package:vocabkpop/widget/bar/HomeBar.dart';
import 'package:vocabkpop/app_colors.dart' as app_color;

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  LoginHistoryService loginHistory = LoginHistoryService();
  List<DateTime> _markedDays = [];

  @override
  void initState() {
    super.initState();
    _loadMarkedDays();
  }

  Future<void> _loadMarkedDays() async {
    try {
      LoginHistoryModel? loginHistoryModel =
      await loginHistory.getLoginHistoryModelByUser(
          FirebaseAuth.instance.currentUser!.uid);

      if (loginHistoryModel != null) {
        setState(() {
          _markedDays = loginHistoryModel.listDateTime;
        });
      } else {
        setState(() {
          _markedDays = [];
        });
      }
    } catch (error) {
      print('Error loading marked days: $error');
    }
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const HomeBar(),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: const Text(
              'Tiến độ học tập của bạn',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return _selectedDay != null && isSameDate(_selectedDay!, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  bool isMarkedDay =
                  _markedDays.any((markedDay) => isSameDate(markedDay, day));
                  bool isSelectedDay =
                      _selectedDay != null && isSameDate(_selectedDay!, day);

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      if (isMarkedDay)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: const Center(
                            child: Text(
                              '🔥',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      Center(
                        child: Text(
                          day.day.toString(),
                          style: TextStyle(
                            color: isMarkedDay || isSelectedDay
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                            fontWeight: isMarkedDay || isSelectedDay
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              eventLoader: (day) {
                return [];
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
