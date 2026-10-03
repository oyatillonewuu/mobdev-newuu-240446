import "dart:io";

void printName(String? name) {
  if (name == null || name.isEmpty) {
    throw ArgumentError;
  }
  print(name);
}

void main() {
  print("Enter your name: ");
  try {
    printName(stdin.readLineSync()!);
  } catch (ArgumentError) {
    print("Invalid name supplied");
  }
}
