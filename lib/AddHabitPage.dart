import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'consts/const_vars.dart';
import 'universal_vars.dart';
import 'functionLibrary.dart';

//newHabitName//Reference Number = 1
String currentQuestion = ''; //Reference Number = 2
String currentNote = ''; //Reference Number = 3

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({Key? key, this.updateHomePage}) : super(key: key);

  final updateHomePage;

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final formKey = GlobalKey<FormState>();

  validateForm() {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      addNewHabit();


      returnToHomepage();
    }
  }

  returnToHomepage() {
    Navigator.pop(context);
    widget.updateHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Habit'),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
        centerTitle: true,
        toolbarHeight: 80,
        iconTheme: const IconThemeData(color: whiteColor, size: 25),
      ),
      backgroundColor: backgroundC,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
        padding: const EdgeInsetsDirectional.fromSTEB(23, 70, 23, 80),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              labelAndInput(
                  'How do you want us to call the habit?',
                  'Name',
                  Icons.edit,
                  'e.g. Workout, Read, Meditate, etc.',
                  false,
                  true,
                  newHabitName,
                  1),
              const SizedBox(
                height: 45,
              ),
              labelAndInput(
                  'How should we ask for the habit?',
                  'Question',
                  Icons.help,
                  'e.g. Did you already train today?',
                  false,
                  false,
                  null,
                  2),
              const SizedBox(
                height: 45,
              ),
              labelAndLongInput('Would you like to add a note?', 'Note',
                  Icons.device_unknown, '(optional)', true, 3),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: addNewHabitButton(validateForm),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget labelAndInput(labelText, hintText, icon, helper, optional, copyValue,
    value, refNum) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        labelText,
        style: labelStyle(),
      ),
      SizedBox(
        height: labelAndInputDistance,
      ),
      TextFormField(
        onChanged: (text) {
          switch (refNum) {
            case 1:
              newHabitName = text;
              break;
            case 2:
              currentQuestion = text;
              break;
            case 3:
              currentNote = text;
              break;
          }
        },
        initialValue: !copyValue
            ? null
            : (value != '')
            ? newHabitName
            : null,
        maxLines: 1,
        style: inputStyle(),
        cursorColor: whiteColor,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          contentPadding: const EdgeInsetsDirectional.fromSTEB(14, 16, 12, 10),
          suffixIcon: Icon(
            icon,
            color: whiteColor,
            size: 22,
          ),
          hintText: hintText,
          hintStyle: hintStyle(),
          filled: true,
          fillColor: mainC,
          enabled: true,
          enabledBorder: border(),
          focusedBorder: border(),
        ),
        validator: (value) {
          if (value == '' && !optional) {
            return 'You need to fill up this field!';
          } else {
            return null;
          }
        },
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(3, 4, 0, 0),
        child: Text(
          helper,
          style: helperStyle(),
        ),
      ),
    ],
  );
}

Widget labelAndLongInput(labelText, hintText, icon, helper, optional, refNum) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        labelText,
        style: labelStyle(),
      ),
      SizedBox(
        height: labelAndInputDistance - 12,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 3),
        child: Text(
          helper,
          style: helperStyle(),
        ),
      ),
      TextFormField(
        onChanged: (text) {
          switch (refNum) {
            case 1:
              newHabitName = text;
              break;
            case 2:
              currentQuestion = text;
              break;
            case 3:
              currentNote = text;
              break;
          }
        },
        maxLines: 8,
        style: inputStyle(),
        cursorColor: whiteColor,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          contentPadding: const EdgeInsetsDirectional.fromSTEB(14, 16, 12, 10),
          suffixIcon: Padding(
            padding:
            const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 120),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: whiteColor,
                size: 22,
              ),
            ),
          ),
          hintText: hintText,
          hintStyle: hintStyle(),
          filled: true,
          fillColor: mainC,
          enabled: true,
          enabledBorder: border(),
          focusedBorder: border(),
        ),
        validator: (value) {
          if (value == '' && !optional) {
            return 'You need to fill up this field!';
          } else {
            return null;
          }
        },
      ),
    ],
  );
}

double labelAndInputDistance = 18;

TextStyle labelStyle() {
  return GoogleFonts.inter(
      color: whiteColor,
      fontSize: 17,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400);
}

TextStyle inputStyle() {
  return GoogleFonts.inter(
      color: whiteColor, fontSize: 15, fontWeight: FontWeight.w400);
}

TextStyle hintStyle() {
  return GoogleFonts.inter(
      color: const Color(0xFFF6F2F2),
      fontSize: 13,
      fontWeight: FontWeight.w400);
}

TextStyle helperStyle() {
  return GoogleFonts.inter(
    color: whiteColor,
    fontSize: 9,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );
}

OutlineInputBorder border() {
  return OutlineInputBorder(
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
      borderRadius: BorderRadius.circular(10));
}

Widget addNewHabitButton(validate) {
  return ElevatedButton(
    onPressed: validate,
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 13, 10, 13),
      child: Text(
        'Create New Habit',
        style: buttonStyle(),
      ),
    ),
  );
}

TextStyle buttonStyle() {
  return const TextStyle(
    fontSize: 14,
  );
}
