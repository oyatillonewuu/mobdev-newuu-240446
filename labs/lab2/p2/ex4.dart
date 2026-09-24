import "dart:io";

void main() {
  int? port;
  String? secret;

  stdout.write("Enter port: ");
  port = int.tryParse(stdin.readLineSync()!);

  if (port == null || port < 0) {
    stderr.writeln("Error: port must a non-negative integer.");
    exitCode = -1;
    return;
  }

  stdout.write("Enter secret: ");

  secret = stdin.readLineSync()!;
  // Pretty dumb example for fallback
  if (secret.isEmpty) {
    secret = null;
  }

  secret = secret ?? "Some default super secret";

  print("port: $port");
  print("secret: $secret");
}
