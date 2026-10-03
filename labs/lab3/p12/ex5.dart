void doSomeWork() {
  throw FormatException("Bad things happened during execution");
}

void main() {
  try {
    doSomeWork();
  } catch (e, s) {
    print(e);
    print(s);
  }
}
