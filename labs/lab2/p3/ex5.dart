void main() {
  save_me:
  for (int i = 0; i < 100000000000; i++) {
    for (int j = 0; j < 2000000000; j++) {
      for (int k = 0; k < 300000000000; k++) {
        for (int h = 0; h < 4444000; h++) {
          if (k == 1 && h == 100000) {
            break save_me;
          }
          print("Software goes crazy when loops are crazy.");
        }
      }
    }
  }
  print("Barely got saved.");
}
