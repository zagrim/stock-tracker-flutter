double parsePercentage(String percentage) {
  var match = RegExp(r'([0-9.]+)%').firstMatch(percentage);
  if (match != null) {
    var value = match.group(1);
    if (value != null) {
      return double.parse(value) / 100;
    }
    return 0.0;
  }
  return 0.0;
}
