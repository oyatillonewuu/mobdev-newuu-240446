double div(double a, double b) {
  try {
    return a / b;
  } catch (UnsupportedError) {
    print("Invalid operation: division by zero");
    throw UnsupportedError;
  }
}

void main() {
  double a = 5.5;
  double b = 2.5;
  double c = 0.0;

  print("$a/$b=${div(a, b)}");
  try {
    print("$a/$c=${div(a, c)}");
  } catch (UnsupportedError) {
    return;
  }
}
