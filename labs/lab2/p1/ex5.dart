import "dart:io";

const argCount = 2;

void main(List<String> arguments) {
  if (arguments.length != argCount) {
    stderr.writeln(
      "Invalid number of arguments.\n"
      "Usage: dart run <program> <arg1> <arg2>",
    );
  }
}
