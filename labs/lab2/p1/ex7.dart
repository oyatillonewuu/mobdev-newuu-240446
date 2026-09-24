import "dart:io";

void main(List<String> arguments) {
  Map<String, String> paramValues = {};

  for (String arg in arguments) {
    List<String> parts = arg.split("=");

    if (parts.length != 2 ||
        parts[0].contains("=") ||
        parts[1].contains("=") ||
        !parts[0].startsWith("--")) {
      stderr.writeln("Invalid usage.");
      printUsage();
      exitCode = -1;
      return;
    }

    var param = parts[0].replaceAll("-", "");
    var value = parts[1];

    paramValues[param] = value;
  }

  print("Parsed parameters:");

  if (paramValues.entries.isEmpty) {
    print("\t(None)");
    return;
  }

  for (var entry in paramValues.entries) {
    print("\t${entry.key}=${entry.value}");
  }
}

void printUsage() {
  stderr.writeln("Usage: dart run --[param1]=[value1] --[param2]=[value2] ...");
}
