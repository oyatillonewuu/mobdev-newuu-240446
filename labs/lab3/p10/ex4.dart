abstract interface class Cache<K, V> {
  bool isCached(K key);
  V? get(K key);
  void set(K key, V value);
  void delete(K key);
}

class User {
  String username;
  String email;
  String passwordHash;

  new(this.username, this.email, this.passwordHash);
}

typedef UserId = int;

class UserAccountCache implements Cache<UserId, User> {
  Map<UserId, User> _inMemoryCache = {};

  bool isCached(UserId uid) {
    return _inMemoryCache.containsKey(uid);
  }

  User? get(UserId uid) {
    return _inMemoryCache[uid];
  }

  void set(UserId uid, User user) {
    _inMemoryCache.putIfAbsent(uid, () => user);
  }

  void delete(UserId uid) {
    _inMemoryCache.remove(uid);
  }
}

void main() {
  List<User> users = [
    User("loga4m", "loga4m@example.com", "#JKDKAH(#DSFT\$43jf"),
    User("example", "example@example.com", "#JKDKAHsddsDSFT\$43jf"),
  ];

  UserAccountCache cache = UserAccountCache();

  for (var (index, user) in users.indexed) {
    cache.set(index, user);
  }

  print("Cached user with id=0: ${cache.get(0)!.username}");
  print("Deleting user with id=0 from cache...");
  cache.delete(0);
  print("Does user with id=0 exist still? ${cache.isCached(0) ? 'Yes' : 'No'}");
}
