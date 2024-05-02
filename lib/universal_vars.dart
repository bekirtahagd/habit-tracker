//App State
bool isFirstTime = false;

//Habit
class Habit {
  String name = '';
  String question = '';
  String? note;
  int highestStreak = 0;
  int currentStreak = 0;

  //Constructor
  Habit(this.name, this.question, [this.note]);

  //Json
  Map<String, dynamic> toJson() => {
        'name': name,
        'question': question,
        'note': note,
        'highestStreak': highestStreak,
        'currentStreak': currentStreak,
  };

  Habit.fromJson(Map<String, dynamic> json){
    name = json['name'];
    question = json['question'];
    note = json['note'];
    highestStreak = json['highestStreak'];
    currentStreak = json['currentStreak'];
  }
}

List<Habit> defaultHabits = [
  Habit('Workout', 'Did you workout today?'),
  Habit('Reading', 'Did you read today?'),
  Habit('Meditating', 'Did you meditate today?'),
  Habit('Journaling', 'Did you journal today?'),
  Habit('Stretching', 'Did you stretch today?'),
];
List<Habit> habits = [];
String newHabitName = '';

//Date
final now = DateTime.now();

//Snackbar
bool isSnackbarActive = false;
String currentSnackbarMessage = '';
