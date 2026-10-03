class InvalidEmail extends FormatException {
  InvalidEmail(String message) : super("Invalid email: " + message);
}

/// Validation utilities for Auth use cases.
class AuthValidators {
  /// Throws [InvalidEmail] if [email]:
  ///   - does not contain '@' (or occurs more than once)
  ///   - does not contain '.' in second part (or contains more than one)
  static void validateEmail(String email) {
    if (!email.contains('@')) {
      throw InvalidEmail("no '@' found");
    }

    if (RegExp('@').allMatches(email).length != 1) {
      throw InvalidEmail("too many '@'");
    }

    int indexOfAtChar = email.indexOf('@');

    String part1, part2;

    part1 = email.substring(0, indexOfAtChar);
    part2 = email.substring(indexOfAtChar);

    if (part1.isEmpty || part2.isEmpty) {
      throw InvalidEmail("parts cannot be empty");
    }

    if (RegExp('.').allMatches(part2).length != 1) {
      throw InvalidEmail("no '.' in second part or too many");
    }

    int indexOfDotChar = part2.indexOf('.');

    if (email.substring(0, indexOfDotChar).isEmpty ||
        email.substring(indexOfDotChar).isEmpty) {
      throw InvalidEmail("parts split by '.' cannot be empty");
    }
  }
}
