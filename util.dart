import 'dart:io';

class util {
  static void clear(){
    print("\x1B[2J\x1B[0;0H");
  }
  
  static int getInput() {
    String value = stdin.readLineSync();
    return int.parse(value);
  }
}