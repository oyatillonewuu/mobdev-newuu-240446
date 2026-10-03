typedef QueryResult<T> = List<T>;
typedef Connection = int;

abstract interface class DBConnector {
  Connection getConnection();
  QueryResult execute(Connection conn, String query);
}

class MySqlConnector implements DBConnector {
  Connection getConnection() {
    print("Returning dummy connection descriptor");
    return 1777;
  }

  QueryResult execute(Connection conn, String query) {
    print("Returning dummy result got by using connection `$conn`");
    return ["hello=world", "whois=there"];
  }
}

void doSomeBusinessLogic(DBConnector db) {
  print("Doing some business...");
  print("Connect db...");
  Connection conn = db.getConnection();
  print("Execute some query...");
  QueryResult res = db.execute(conn, "DROP DATABASE;");
  print(res);
  print("Bombed everything...:)");
}

void main() {
  MySqlConnector mysql = MySqlConnector();
  doSomeBusinessLogic(mysql);
}
