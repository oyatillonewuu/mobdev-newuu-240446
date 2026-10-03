Future<String> getUserById(int id) async {
  return Future.delayed(Duration(seconds: 2), () => "loga4m");
}

void main() async {
  print(await getUserById(0));
}
