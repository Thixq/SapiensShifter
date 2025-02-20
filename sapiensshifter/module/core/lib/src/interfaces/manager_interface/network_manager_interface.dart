import '/src/interfaces/interface.dart';

abstract class INetworkManager {
  void init();
  final INetworkOperation networkOperation;

  INetworkManager(this.networkOperation);
}
