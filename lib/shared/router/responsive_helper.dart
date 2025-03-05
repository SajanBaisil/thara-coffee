class ResponsiveHelper {
  double _deviceHeight = 700;
  DeviceType _deviceType = DeviceType.tablet;
  bool get isLargeScreen => _deviceType == DeviceType.tablet;
  bool get isTallScreen => _deviceHeight > 680;
  bool get isTablet => _deviceType == DeviceType.tablet;
  bool get isSmallScreen => !isTallScreen;
  set deviceType(DeviceType type) {
    _deviceType = type;
  }

  set deviceHeight(double height) {
    _deviceHeight = height;
  }

  double get deviceHeight => _deviceHeight;
  DeviceType get deviceType => _deviceType;
}

enum DeviceType {
  mobile,
  tablet,
}
