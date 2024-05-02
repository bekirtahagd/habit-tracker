import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_generator/material_color_generator.dart';

import 'AddHabitPage.dart';
import 'universal_vars.dart';
import 'consts/const_vars.dart';
import 'functionLibrary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(color: mainC),
        primaryColor: mainC,
        textTheme: GoogleFonts.interTextTheme(),
        dividerColor: mainC,
        iconTheme: const IconThemeData(color: whiteColor),
      ),
      home: const MyHomePage(title: 'HABIT TRACKER'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => HomePage();
}

class HomePage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      backgroundColor: backgroundC,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 130,
            ),
            Center(
              child: Text(
                isFirstTime ? 'Welcome. Nice to meet you!' : 'Welcome back!',
                style: const TextStyle(
                  fontSize: 24,
                  color: Color(0xFFFFFFFF),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55,
            ),
            const HabitTable(),
          ],
        ),
      ),
    );
  }
}

class HabitTable extends StatefulWidget {
  const HabitTable({Key? key}) : super(key: key);

  @override
  State<HabitTable> createState() => _HabitTableState();
}

class _HabitTableState extends State<HabitTable> {
  @override
  initState() {
    super.initState();
    isFirstTimeEntering().then((firstTime) {
      isFirstTime = firstTime;
      if (firstTime) {
        print('First Enter');
        onFirstEnter();
      } else {
        print('Back again');
        updateHabitVar(updateScreen: updatePage());
      }
    });
  }


  updatePage() {
    setState(() {
      textFieldController.clear();
    });
  }

  goToNewHabitPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddHabitPage(
                  updateHomePage: updatePage,
                )));
  }

  showSnackbar(message) {
    ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);

    if (!isSnackbarActive || currentSnackbarMessage != message) {
      scaffold.hideCurrentSnackBar();
      isSnackbarActive = true;
      currentSnackbarMessage = message;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              duration: const Duration(seconds: 2),
              content: SnackBarWidget(
                message: message,
                scaffold: ScaffoldMessenger.of(context),
              )))
          .closed
          .then((SnackBarClosedReason reason) {
        isSnackbarActive = false;
        currentSnackbarMessage = '';
      });
    }
  }

  TextStyle ts() {
    return const TextStyle(
      color: whiteColor,
      fontSize: 15,
      fontWeight: FontWeight.w200,
      letterSpacing: 0.2,
    );
  }

  final double containerHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            HabitContainer(
              title: '',
              columnTS: ts(),
              height: containerHeight,
            ),
            for (Habit habit in habits)
              HabitContainer(
                  title: habit.name, columnTS: ts(), height: containerHeight),
            NewHabitContainer(
              height: containerHeight,
              columnTS: ts(),
            ),
          ],
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            height: (habits.length + 2) * containerHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                final date = now.subtract(Duration(days: index));

                return Column(
                  children: [
                    DayContainer(
                      height: containerHeight,
                      day: date.day,
                      month: date.month,
                    ),
                    for (int i = 0; i < habits.length; i++)
                      TickContainer(
                        height: containerHeight,
                      ),
                    NewHabitTickBox(
                      height: containerHeight,
                      callbackFunction: goToNewHabitPage,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class HabitContainer extends StatelessWidget {
  const HabitContainer({
    Key? key,
    required this.title,
    required this.columnTS,
    required this.height,
  }) : super(key: key);

  final String title;
  final TextStyle columnTS;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: height,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(border: Border.all(color: mainC, width: 1)),
      child: Text(
        title,
        style: columnTS,
      ),
    );
  }
}

class DayContainer extends StatelessWidget {
  const DayContainer({
    Key? key,
    required this.height,
    required this.day,
    required this.month,
  }) : super(key: key);

  final double height;
  final int day;
  final int month;

  String monthText() {
    switch (month) {
      case 1:
        return 'jan.';
      case 2:
        return 'feb.';
      case 3:
        return 'mar.';
      case 4:
        return 'Apr.';
      case 5:
        return 'May.';
      case 6:
        return 'Jun.';
      case 7:
        return 'Jul.';
      case 8:
        return 'Aug.';
      case 9:
        return 'Sep.';
      case 10:
        return 'Oct.';
      case 11:
        return 'Nov.';
      case 12:
        return 'Dec.';
    }
    return '0';
  }

  TextStyle ts() {
    return const TextStyle(
      color: whiteColor,
      fontSize: 11,
      fontWeight: FontWeight.w200,
      letterSpacing: 0.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: height,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: mainC, width: 1)),
      child: Text(
        '${(day < 10 ? '0$day' : day)}\n${monthText()}',
        style: ts(),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TickContainer extends StatefulWidget {
  const TickContainer({Key? key, required this.height}) : super(key: key);

  final double height;

  @override
  State<TickContainer> createState() => _TickContainerState();
}

class _TickContainerState extends State<TickContainer> {
  bool _done = false;

  void changeDoneState() {
    setState(() {
      _done = !_done;
    });
  }

  void _showLongPressReminder() {
    ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
    String message = 'Hold to ${(_done == false) ? 'select' : 'deselect'}';

    if (!isSnackbarActive || currentSnackbarMessage != message) {
      scaffold.hideCurrentSnackBar();
      isSnackbarActive = true;
      currentSnackbarMessage = message;
      scaffold
          .showSnackBar(SnackBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              duration: const Duration(seconds: 2),
              content: SnackBarWidget(
                message: message,
                scaffold: ScaffoldMessenger.of(context),
              )))
          .closed
          .then((SnackBarClosedReason reason) {
        isSnackbarActive = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      enableFeedback: true,
      onTap: _showLongPressReminder,
      onLongPress: changeDoneState,
      child: Container(
        width: 50,
        height: widget.height,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(border: Border.all(color: mainC, width: 1)),
        child: (_done == true)
            ? const Icon(
                Icons.done,
                color: Colors.green,
                size: 40,
              )
            : const Icon(
                Icons.block,
                color: Colors.red,
                size: 30,
              ),
      ),
    );
  }
}

class SnackBarWidget extends StatelessWidget {
  const SnackBarWidget(
      {Key? key, required this.message, required this.scaffold})
      : super(key: key);

  final String message;
  final ScaffoldMessengerState scaffold;

  void _hideLongPressReminder() {
    scaffold.hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 60,
      decoration: const BoxDecoration(
        color: mainC,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Text(
              message,
              style: const TextStyle(
                  color: whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.3),
            ),
          ),
          Positioned(
            top: -20,
            left: 5,
            child: InkWell(
              onTap: _hideLongPressReminder,
              enableFeedback: false,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 34,
                    width: 34,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                  ),
                  const Positioned(
                      top: 3,
                      child: Icon(
                        Icons.clear_outlined,
                        color: whiteColor,
                        size: 30,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

TextEditingController textFieldController = TextEditingController();

class NewHabitContainer extends StatelessWidget {
  const NewHabitContainer(
      {Key? key, required this.height, required this.columnTS})
      : super(key: key);

  final double height;
  final TextStyle columnTS;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: height,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(border: Border.all(color: mainC, width: 1)),
      child: TextField(
          controller: textFieldController,
          style: columnTS,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: whiteColor),
            ),
          ),
          expands: false,
          autocorrect: false,
          onChanged: (text) {
            newHabitName = text;
          }),
    );
  }
}

class NewHabitTickBox extends StatelessWidget {
  const NewHabitTickBox(
      {Key? key, required this.height, required this.callbackFunction})
      : super(key: key);

  final double height;
  final Function callbackFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: height,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(border: Border.all(color: mainC, width: 1)),
      child: InkWell(
        onTap: () {
          callbackFunction();
        },
        child: const Center(
          child: Icon(
            Icons.add,
            color: whiteColor,
            size: 27,
          ),
        ),
      ),
    );
  }
}
