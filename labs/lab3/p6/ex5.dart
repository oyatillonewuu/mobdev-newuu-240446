const cardNumberLen = 16;

class CardInfo {
  final String _cardNumber;
  String? _cardName;
  double _balance;
  final DateTime _expiryDate;

  bool cardNumberVisible = true;
  bool cardNameVisible = true;
  bool balanceVisible = true;
  bool expiryDateVisible = true;

  CardInfo({
    required cardNumber,
    required cardName,
    required balance,
    required int expiryYear,
    required int expiryMonth,
  }) : _cardNumber = _getValidatedCardNumber(cardNumber),
       _balance = _getValidatedBalance(balance),
       _cardName = _getValidatedCardName(cardName),
       _expiryDate = _getValidatedExpiryDate(expiryYear, expiryMonth);

  String get cardName {
    if (!cardNameVisible) {
      return "(hidden)";
    }
    if (_cardName != null) {
      return _cardName!;
    }
    return "(none)";
  }

  String get cardNumber {
    if (!cardNumberVisible) {
      return "(hidden)";
    }
    return _cardNumber;
  }

  double get balance {
    if (!balanceVisible) {
      return -1;
    }
    return _balance;
  }

  String get expiryDate {
    if (!expiryDateVisible) {
      return "(hidden)";
    }
    return _getExpiryDateString();
  }

  set cardName(String? newCardName) {
    _cardName = _getValidatedCardName(newCardName);
  }

  set balance(double newBalance) {
    try {
      _balance = _getValidatedBalance(newBalance);
    } catch (_) {
      print("Error: invalid balance");
    }
  }

  static _getValidatedCardNumber(String cardNumber) {
    if (int.tryParse(cardNumber) == null ||
        cardNumber.length != cardNumberLen) {
      throw "Exception: Invalid card number";
    }
    return cardNumber;
  }

  static double _getValidatedBalance(double newBalance) {
    if (newBalance < 0.0) {
      throw "Exception: Invalid balance";
    }
    return newBalance;
  }

  static String? _getValidatedCardName(String? cardName) {
    if (cardName != null && cardName!.isEmpty) {
      return null;
    }
    return cardName;
  }

  static DateTime _getValidatedExpiryDate(int expiryYear, int expiryMonth) {
    if (expiryYear < 1 || expiryMonth < 1 || expiryMonth > 12) {
      throw "Exception: Invalid date";
    }
    return DateTime(expiryYear, expiryMonth);
  }

  String _getExpiryDateString() {
    int year = _expiryDate.year;
    int month = _expiryDate.month;
    return year.toString() + "/" + month.toString();
  }
}

void main() {
  CardInfo c1 = CardInfo(
    cardName: "Main card",
    cardNumber: "2222333344445555",
    balance: 10.0,
    expiryYear: 2026,
    expiryMonth: 6,
  );

  print(c1.cardName);
  print(c1.cardNumber);
  print(c1.balance);
  print(c1.expiryDate);

  c1.balance = -1.0;
}
