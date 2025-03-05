extension RemoveHtmlTags on String {
  String removeHtmlTags() {
    final exp = RegExp('<[^>]*>', multiLine: true);
    return replaceAll(exp, '');
  }
}

extension CustomStringExt on String? {
  bool get isNullOrEmpty => this == null || (this ?? '').trim().isEmpty;
  bool get notNullNorEmpty =>
      this != null &&
      (this ?? '').trim().isNotEmpty &&
      (this ?? '').trim() != 'null';
  String get firstLetterToCap {
    if (isNullOrEmpty) return '';
    final temp = <String>[];
    this!.trim().split(' ').toList().forEach((element) {
      if (element.trim().isEmpty) return;
      temp.add(element[0].toUpperCase() + element.substring(1));
    });
    return temp.join(' ');
  }

  String get fromSecondHeadToLetterToCap {
    if (isNullOrEmpty) return '';
    final temp = <String>[];
    this!.trim().split(' ').toList().forEach((element) {
      if (element.trim().isEmpty) return;
      temp.add(element[0].toUpperCase() + element.substring(1));
    });
    final data = temp.join(' ');
    return data[0].toLowerCase() + data.substring(1);
  }

  String get onlyFirstToLetterToCap {
    if (isNullOrEmpty) return '';
    final temp = <String>[];
    this!.trim().split(' ').toList().forEach((element) {
      if (element.trim().isEmpty) return;
      temp.add(element.toLowerCase());
    });
    final data = temp.join(' ');
    return data[0].toUpperCase() + data.substring(1);
  }
}

extension CapitalizeFirstLetter on String {
  String capitalizeFirstLetter() {
    if (isNullOrEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension StringExtension on String? {
  String capitalizeFirstLetterOfEachWord() {
    if (isNullOrEmpty) {
      return '';
    }
    final formattedString = this?.toLowerCase();
    final words = formattedString?.split(' ') ?? [];
    final capitalizedWords = <String>[];
    for (final word in words) {
      if (word.isNotEmpty) {
        final capitalizedWord = '${word[0].toUpperCase()}${word.substring(1)}';
        capitalizedWords.add(capitalizedWord);
      }
    }
    return capitalizedWords.join(' ');
  }
}

extension StringExtension2 on String? {
  bool get notValid {
    return (this ?? '').trim().isEmpty ||
        int.tryParse(this ?? '') == null ||
        (int.tryParse(this ?? '') ?? 0) <= 0;
  }

  bool get isValidMoney {
    final value = (this ?? '').replaceAll(' ', '').replaceAll(',', '');
    return value.trim().isEmpty ||
        double.tryParse(value) == null ||
        (double.tryParse(value) ?? 0) <= 0;
  }
}

extension StringFormatting on String {
  String toTwoLineFormat() {
    final words = split(' ');
    return words.length == 2 ? words.join('\n') : this;
  }
}

extension BoolCheck on String? {
  bool tryBestParse() {
    if (this == null) return false;
    final updatedValue = this!.trim().toLowerCase();
    if (updatedValue == 'true') return true;
    if (updatedValue == 'false') return false;
    if (updatedValue == '1') return true;
    if (updatedValue == '0') return false;
    return false;
  }
}

  // Helper function to check if a value is null or zero
  bool isNullOrZero(String? value) {
    return (double.tryParse(value ?? '0') ?? 0) == 0;
  }
