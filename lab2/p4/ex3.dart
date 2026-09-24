import "dart:io";

void iDoXtoY([String? x = "like", String? y = "Rust"]) {
  print("I ${x} ${y}.");
}

void main() {
  String? x;
  stdout.write("You do: ");
  x = stdin.readLineSync()!;
  stdout.write("to Rust. Here:\n");

  iDoXtoY(x);
}
