void main() {
  dynamic s = "Hello there";
  if (s is String) {
    //  promoted to string
    print("$s");
  }
}
