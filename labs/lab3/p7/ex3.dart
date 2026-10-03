enum MessageStatus { sent, dropped, delivered, received }

String messageStatusToUiDisplayValue(MessageStatus status) {
  return switch (status) {
    MessageStatus.sent => "Message sent and being delivered",
    MessageStatus.dropped => "Message got dropped before being delivered",
    MessageStatus.delivered =>
      "Message has been delivered and waiting for reception",
    MessageStatus.received => "Message has been received",
  };
}

void main() {
  MessageStatus msgStatus = MessageStatus.dropped;
  String uiDisplayValue = messageStatusToUiDisplayValue(msgStatus);
  print(uiDisplayValue);
}
