void misbehave() {
  try {
    throw FormatException("Just misbehaving on purpose");
  } on FormatException catch (e) {
    print("First time catch");
    print(e);
    rethrow;
  }
}

void main() {
  try {
    misbehave();
  } catch (e) {
    print(e);
    print("Second catch");
  }
}
