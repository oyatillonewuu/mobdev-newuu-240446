bool isEven(int x) => x % 2 == 0;

void main() {
  // Let's test it!

  for (int i = 0; i < 100; i++) {
    print("Is $i even? ${isEven(i) ? 'Yes.' : 'No.'}");
  }
}
