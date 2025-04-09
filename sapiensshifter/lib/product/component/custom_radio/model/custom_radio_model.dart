class CustomRadioModel<T> {
  CustomRadioModel({required this.svgPath, required this.value});

  final String svgPath;
  final T value;

  CustomRadioModel<T> copyWith({required T value, String? svgPath}) {
    return CustomRadioModel(
      svgPath: svgPath ?? this.svgPath,
      value: value,
    );
  }
}
