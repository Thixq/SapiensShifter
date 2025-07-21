import '/src/interfaces/interface.dart';

abstract class INetworkManager {
  void init();
  final INetworkOperation networkOperation;
  final String? basePath;

  INetworkManager(this.networkOperation, {this.basePath});
}
