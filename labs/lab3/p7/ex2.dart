enum Day { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }

void main() {
  print("Days:");

  for (var day in Day.values) {
    print(day.name);
  }
}
