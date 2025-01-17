// ignore_for_file: library_private_types_in_public_api

extension DefualtDoubleExtension on double {
  _DoubleExtension get sapiDoubleExt => _DoubleExtension(this);
}

extension DoubleExtension on double? {
  _DoubleExtension get sapiDoubleExt => _DoubleExtension(this);
}

final class _DoubleExtension {
  _DoubleExtension(double? value) : _value = value;
  final double? _value;

  String? get priceFraction => _value?.toStringAsFixed(2).padLeft(5, '0');
}
