import 'dart:io';

extension FileUtils on File {
  double get size {
    final sizeInBytes = lengthSync();
    final sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }
}
