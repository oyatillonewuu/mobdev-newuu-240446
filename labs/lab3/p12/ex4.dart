class DbException extends FormatException;
class CacheException extends FormatException;

void throwDbError() {
  throw DbException();
}

void throwCacheError() {
  throw CacheException();
}

void main() {
  try {
    throwDbError();
  } on DbException {
    print("Db error occurred");
  } on CacheException {
    print("Cache error occurred");
  } catch (e) {
    print("Some other error occurred: $e");
  }
}
