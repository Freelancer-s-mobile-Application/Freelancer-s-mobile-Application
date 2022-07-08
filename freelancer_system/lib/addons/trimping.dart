String trimmed(String str) {
  String result = str;
  result = result.replaceAll('{', '');
  result = result.replaceAll('}', '');
  result = result.replaceAll(':', '');
  result = result.replaceAll('[', '');
  result = result.replaceAll(']', '');
  result = result.replaceAll('\\n', '');
  result = result.replaceAll('insert', '');
  result = result.replaceAll('attributes', '');
  result = result.replaceAll('video', '');
  result = result.replaceAll('color', '');
  result = result.replaceAll('"', '');
  return result;
}
