typedef UserProfiles = Map<String, dynamic>;

void main() {
  UserProfiles userProfiles = {};

  userProfiles.addAll({
    "loga4m": {"at": 2417},
    "algo4m": "Probably username",
  });

  print("$userProfiles");
}
