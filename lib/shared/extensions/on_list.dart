extension NullableListExt on List<dynamic>? {
  bool get isNullOrEmpty => this == null || (this ?? []).isEmpty;

  T? firstWhereOrNull<T>(bool Function(T) test) {
    if (this == null) return null;
    for (final element in this!) {
      if (test(element as T)) return element;
    }
    return null;
  }
}
