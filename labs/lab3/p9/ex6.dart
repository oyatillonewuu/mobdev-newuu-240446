// NOTE: this code does not compile.
// As we can see, interface is a contract: the implementing
// class must override default behavior.
// In contrary, mixins are explicitly for sharing reusable
// code.

// Interface example

class Account;

abstract interface class TokenInterface {
  bool isValid();
  bool isExpired();
}

class JWToken implements TokenInterface {
  String token;

  new(this.token);

  bool isValid() {
    return !isExpired();
  }

  bool isExpired() {
    return false;
  }
}

interface class AuthProvider {
  Account getAccount() {
    print("Some default action for account");
    return Account();
  }

  TokenInterface signInPassword({
    required String email,
    required String password,
  }) {
    print("Some default action for Token");
    return JWToken("sds33sddfs");
  }
}

class GoogleAuth implements AuthProvider; // using interface FORCES overriding

// Mixin example

abstract class Human;

mixin SomeHumanCapabilities on Human {
  void speak(String sentence) {
    print(sentence);
  }

  void think() {
    print("Thought...");
  }
}

class Citizen extends Human with SomeHumanCapabilities {
  String name;
  new(this.name);
}

void main() {
  Citizen c = Citizen("Tony Stark Iron Man");
  c.speak("I am Iron Man");
  c.think();

  GoogleAuth gauth = GoogleAuth();
}
