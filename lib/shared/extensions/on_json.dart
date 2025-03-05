extension JsonStringifyExtension on Map<String, dynamic> {
  Map<String, dynamic> jsonStringify() {
    return map(
      (key, value) => MapEntry(
        key,
        value is List || value is Map ? value : value?.toString(),
      ),
    );
  }
}
