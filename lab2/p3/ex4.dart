import "dart:math";
import "dart:io";

void main() {
  final random = Random();

  const maxNum = 10000;
  int number = random.nextInt(maxNum);

  print("Thought number from 0 to $maxNum (inclusive). Guess it!");

  int? guess;
  int attempts = 0;

  while (true) {
    attempts++;
    guess = int.tryParse(stdin.readLineSync()!);

    if (guess == null) {
      stderr.writeln("Please, enter a valid integer.");
      continue;
    }

    if (guess == number) {
      print("You won!");
      print("Attempts: $attempts.");
      break;
    } else if (guess < number) {
      print("Too low.");
    } else {
      print("Too high.");
    }
  }
}
