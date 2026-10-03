sealed class NetworkPacket {}

class ApplicationLayerPacket extends NetworkPacket {}

class TcpLayerPacket extends NetworkPacket {}

class NetworkLayerPacket extends NetworkPacket {}

typedef Priority = int;

Priority getPriorityForNetworkPacket(NetworkPacket packet) {
  return switch (packet) {
    ApplicationLayerPacket() => 0,
    TcpLayerPacket() => 1,
    NetworkLayerPacket() => 2,
  };
}

void main() {
  NetworkPacket packet = NetworkLayerPacket();
  print("Packet type: ${packet.runtimeType.toString()}");
  print("Priority: ${getPriorityForNetworkPacket(packet)}");
}
