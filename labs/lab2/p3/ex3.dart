import "dart:io";

void main() {
  stdout.write("Enter factorial: ");

  int? number;
  number = int.tryParse(stdin.readLineSync()!);

  if (number == null || number < 0) {
    stderr.writeln("Please, enter a non-negative integer value.");
    exitCode = -1;
    return;
  }

  print("For loop: ${number}! is ${forFactorial(number)}.");
  print("For-in loop: ${number}! is ${forInFactorial(number)}.");
}

int forFactorial(int n) {
  int result = 1;

  for (var i = 1; i <= n; i++) {
    result *= i;
  }

  return result;
}

num forInFactorial(int n) {
  int result = 1;

  for (int i in Iterable.generate(n)) {
    // [0, ...., n - 1]
    result *= (i + 1);
  }

  return result;
}
