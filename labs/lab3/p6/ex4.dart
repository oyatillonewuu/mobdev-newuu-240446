import "dart:core";

class Singleton {
  Singleton._internal();

  static final Singleton _instance = Singleton._internal();

  factory Singleton() {
    return _instance;
  }

  String message = "I am a singleton. Quite alone. Don't be alone.";
  final DateTime createdAt = DateTime.now();
}

void main() {
  Singleton s1 = Singleton();
  Singleton s2 = Singleton();
  print(s1.message);
  print("s1 created at: ${s1.createdAt}");
  print("s2 created at: ${s2.createdAt}");

  if (s1.createdAt == s2.createdAt && identical(s1, s2)) {
    print("So, s2 == s1");
    print("Singleton pattern is working");
  } else {
    print(
      "Not quite right... s2 != s1. What went wrong while implementing singleton?",
    );
  }
}
