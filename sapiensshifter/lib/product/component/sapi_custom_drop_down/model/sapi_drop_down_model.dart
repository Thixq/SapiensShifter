import 'package:equatable/equatable.dart';

class SapiDropDownModel<T> extends Equatable {
  const SapiDropDownModel({required this.displayName, required this.value});

  final String? displayName;
  final T? value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() {
    return this.displayName ?? super.toString();
  }
}
