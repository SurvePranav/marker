import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marker/src/home/bloc/home_bloc.dart';
import 'package:marker/src/home/views/widgets/bouncing_button.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CalendarFormat format = CalendarFormat.month;

  @override
  void initState() {
    context.read<HomeBloc>()
      ..add(const GetAllMarks())
      ..add(
        SelectionChanged(
          date: DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        ),
      );

    super.initState();
  }

  void _onDaySelected(
    DateTime selected,
    DateTime focusedDay,
  ) {
    log(selected.toString());
    context.read<HomeBloc>().add(
          SelectionChanged(
            date: selected,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(
              height: 55,
              width: 55,
              child: Icon(
                Icons.edit_calendar_outlined,
                color: Colors.grey,
                size: 40,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text('Marke The Day'),
          ],
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              // const Text('Calendar Example'),
              Container(
                margin: const EdgeInsets.only(
                  top: 15,
                ),
                height: MediaQuery.sizeOf(context).height * 0.7,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TableCalendar(
                  rowHeight: 85,
                  availableGestures: AvailableGestures.all,
                  calendarFormat: format,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Week',
                    CalendarFormat.twoWeeks: 'Month',
                    CalendarFormat.week: '2 Weeks'
                  },
                  onFormatChanged: (f) {
                    setState(() {
                      format = f;
                    });
                  },
                  headerStyle: HeaderStyle(
                    titleCentered: true, // Center the title
                    formatButtonDecoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.white),
                        left: BorderSide(color: Colors.white),
                        right: BorderSide(color: Colors.white),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  enabledDayPredicate: (day) {
                    // Allow only dates up to today
                    return day.isBefore(DateTime.now());
                  },
                  calendarStyle: CalendarStyle(
                    markerSize: 20,
                    selectedTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: const BoxDecoration(
                      color: Color.fromARGB(
                          255, 81, 79, 79), // Background color for today

                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Colors.white, // Background color for selected
                      shape: BoxShape.circle,
                    ),
                    tableBorder: TableBorder.all(
                      color: Colors.white,
                    ),
                    weekendTextStyle: const TextStyle(
                      color: Colors.white, // Same color for weekend dates
                      fontWeight: FontWeight.normal, // Same weight as weekdays
                    ),
                    defaultTextStyle: const TextStyle(
                      color: Colors.white, // Same color for weekend dates
                      fontWeight: FontWeight.normal, // Same weight as weekdays
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    weekendStyle: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  weekendDays: const [7],
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(DateTime.now().year + 5, 12, 31),
                  focusedDay: state.selectedDate,
                  selectedDayPredicate: (day) =>
                      isSameDay(day, state.selectedDate),
                  onDaySelected: _onDaySelected,
                  eventLoader: context.read<HomeBloc>().isPresent,
                ),
              ),

              Expanded(
                child: Center(
                  child: BouncingButton(
                    isMarked: state.selectedValue.isNotEmpty,
                    onPressed: () {
                      context.read<HomeBloc>().add(
                            ToggleMarker(
                              date: state.selectedDate,
                            ),
                          );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
