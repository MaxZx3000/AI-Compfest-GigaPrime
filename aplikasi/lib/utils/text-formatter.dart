class TextFormatter{
  static String convertTrueValueToString(Map<String, bool> keyBooleanMap, {separator = " "}){
    String currentValueString = "";
    keyBooleanMap.forEach((key, value) {
      if (value == true){
        currentValueString += "$key$separator";
      }
    });
    return currentValueString;
  }
}