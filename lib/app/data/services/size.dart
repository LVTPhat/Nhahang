class Resize {
  static double defaultWith = 1536;
  static double defaultHeight = 745.6;
  static late double currentWidth;
  static late double currentHeight;
  Resize(double width, double height) {
    currentWidth = width;
    currentHeight = height;
  }

  static double getSizeBaseOnWidth(double size) {
    return size * currentWidth / defaultWith;
  }

  static double getSizeBaseOnHeight(double size) {
    return size * currentHeight / defaultHeight;
  }

  static double getSizeChar(double size) {
    return (size * currentHeight * currentWidth) /
        (defaultHeight * defaultWith);
  }
}
