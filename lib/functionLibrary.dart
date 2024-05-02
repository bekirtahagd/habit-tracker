import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'universal_vars.dart';
import 'AddHabitPage.dart';

//App State
Future<bool> isFirstTimeEntering() async {
  final prefs = await SharedPreferences.getInstance();
  final firstTime = prefs.getBool('isFirstTime');
  if (firstTime == null) {
    return true;
  } else {
    return false;
  }
}

Future<void> onFirstEnter() async {
  //Variable Management
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstTime', false);

  //Set Default Habits
  setDefaultHabits();
}

Future<void> resetEnter() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('isFirstTime');
  print('Reset First Time');
}

//Habits
Future<void> setDefaultHabits() async {
  //Variable Management
  final prefs = await SharedPreferences.getInstance();

  //Get JSON String for all Default Habits
  List<String> jsonDefaultHabits = [];
  for(int i = 0; i < defaultHabits.length; i++) {
    jsonDefaultHabits.add(jsonEncode(defaultHabits[i]));
  }

  //Upload Default Habits to Cache
  prefs.setStringList('Habits', jsonDefaultHabits);
  updateHabitVar();
}

//Habits
void addNewHabit() {
  Habit newHabit = Habit(newHabitName, currentQuestion, currentNote);
  habits.add(newHabit);
  updateHabitCache();
  newHabitName = '';
  }

Future<void> updateHabitCache() async {
  //Variable Management
  final prefs = await SharedPreferences.getInstance();

  //Get JSON String for all Default Habits
  List<String> jsonDefaultHabits = [];
  for(int i = 0; i < habits.length; i++) {
    jsonDefaultHabits.add(jsonEncode(habits[i]));
  }

  //Upload Default Habits to Cache
  prefs.setStringList('Habits', jsonDefaultHabits);
}

Future<void> updateHabitVar({updateScreen}) async {

    //Variable Management
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonHabits = prefs.getStringList('Habits');

    if(jsonHabits != null){
      //Json Management and habit upload
      for(int i = 0; i < jsonHabits.length; i++) {
        Map<String, dynamic> map = jsonDecode(jsonHabits[i]);

        //If JsonHabits length is bigger than habits, we need to add new items instead of overwriting the old ones
        if(i + 1 > habits.length){
          habits.add(Habit.fromJson(map));
        } else {
          habits[i] = Habit.fromJson(map);
        }
      }

      if(updateScreen != null){
        updateScreen();
      }
    }
}