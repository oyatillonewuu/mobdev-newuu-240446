enum MessageStatus { sent, dropped, delivered, received, unknown }

MessageStatus parseStatus(String status) {
  try {
    return MessageStatus.values.byName(status);
  } catch (_) {
    return MessageStatus.unknown;
  }
}

void main() {
  List<String> statuses = [
    "sent",
    "dropped",
    "delivered",
    "received",
    "failed",
  ];

  for (var status in statuses) {
    print("String status: $status");
    print("Parsed enum value: ${parseStatus(status)}");
  }
}
