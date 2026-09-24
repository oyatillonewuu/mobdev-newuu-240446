import "dart:io";

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print("Nothing to calculate.");
    return;
  }

  double sum = 0;

  for (var arg in arguments) {
    num? parsedNum = num.tryParse(arg);

    if (parsedNum == null) {
      stderr.writeln("Argument ${arg} is not a number");
      return;
    }

    sum += parsedNum;
  }

  double average = sum / arguments.length;
  String averageTruncated = average.toStringAsFixed(
    5,
  ); // preserve 5 digits of fraction

  print("Nums: ${arguments.join(", ")}");
  print("Average: $averageTruncated");
}
