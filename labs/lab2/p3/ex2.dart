import "dart:io";

void main() {
  stdout.write("Enter an integer: ");

  int? number;
  number = int.tryParse(stdin.readLineSync()!);

  if (number == null) {
    stderr.writeln("Please, enter an integer value.");
    exitCode = -1;
    return;
  }

  if (number > 0) {
    print("$number is positive");
  } else if (number < 0) {
    print("$number is negative");
  } else {
    print("$number is our friend zero");
  }
}
