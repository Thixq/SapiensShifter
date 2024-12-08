extension SapiStringExtension on String? {
  String? maxChahter(int maxChachter) {
    if (this!.length >= maxChachter) {
      return '${this?.substring(0, maxChachter)}...';
    }
    return this;
  }
}
