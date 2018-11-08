import 'dart:core';
import 'dart:io';
import 'util.dart';

const int SIZE_BOARD = 5;
const int WIN = 5;

class caro {
  List<List<String>> _board;
  caro() {
    _board = new List<List<String>>(SIZE_BOARD);
    for (int i = 0; i < SIZE_BOARD; i++) {
      _board[i] = new List<String>(SIZE_BOARD);
      for (int j = 0; j < SIZE_BOARD; j++) {
        _board[i][j] = ' ';
      }
    }
  }

  display() {
    util.clear();
    stdout.write('    ');
    for (int i = 0; i < _board.length; i++) {
      stdout.write('-$i');
    }
    stdout.write('- Y\n');
    stdout.write('    ');
    for (int i = 0; i <= _board.length * 2; i++) {
      stdout.write('-');
    }
    for (int i = 0; i < _board.length; i++) {
      stdout.write('\n$i - |');
      for (int j = 0; j < _board[i].length; j++) {
        stdout.write('${_board[i][j]}|');
      }
      stdout.write('\n    ');
      for (int i = 0; i <= _board.length * 2; i++) {
        stdout.write('-');
      }
    }
    stdout.write('\nX');
  }

  bool isValid(int x, int y) {
    if (x < 0 || x >= _board.length || y < 0 || y >= _board.length)
      return false;
    return true;
  }

  bool isChessed(int x, int y) {
    if (_board[x][y] != 'O' && _board[x][y] != 'X') {
      return true;
    }
    return false;
  }

  bool chess(int x, int y, String c) {
    if ((x >= SIZE_BOARD || x < 0 || y >= SIZE_BOARD || y < 0) ||
        _board[x][y] != ' ') {
      return false;
    }
    _board[x][y] = c;
    return true;
  }

  bool isWin(int x, int y, String c) {
    int countLess = 0, countGreat = 0;
    // check x to top and (x + 1) to down
    for (int i = x; i >= 0; i--) {
      if (_board[i][y] != c) break;
      countLess++;
    }
    for (int i = x + 1; i < _board.length; i++) {
      if (_board[i][y] != c) break;
      countGreat++;
    }
    if (countLess + countGreat >= WIN) return true;

    //check y to left and y + 1 to right
    countLess = 0;
    countGreat = 0;
    for (int i = y; i >= 0; i--) {
      if (_board[x][i] != c) break;
      countLess++;
    }
    for (int i = y + 1; i < _board[0].length; i++) {
      if (_board[x][i] != c) break;
      countGreat++;
    }
    if (countLess + countGreat >= WIN) return true;

    // check diagonal
    countLess = 0;
    countGreat = 0;
    for (int i = x, j = y; isValid(i, j); i--, j--) {
      if (_board[i][j] != c) break;
      countGreat++;
    }

    for (int i = x + 1, j = y + 1; isValid(i, j); i++, j++) {
      if (_board[i][j] != c) break;
      countGreat++;
    }

    if (countLess + countGreat >= WIN) return true;

    // check diagonal
    countLess = 0;
    countGreat = 0;
    for (int i = x, j = y; isValid(i, j); i++, j--) {
      if (_board[i][j] != c) break;
      countGreat++;
    }

    for (int i = x - 1, j = y + 1; isValid(i, j); i--, j++) {
      if (_board[i][j] != c) break;
      countGreat++;
    }

    if (countLess + countGreat >= WIN) return true;

    return false;
  }
}

void main() {
  int n = 0;
  bool isWin = false;
  caro c = new caro();

  /*
	* Logic games
	*/
  while (true) {
    c.display();
    if (isWin == true) {
      stdout.write(
          (((n - 1) % 2 == 0) ? "\n\nPlayer 1 (X)" : "\n\nPlayer 2 (O)") +
              " is Win !!\n");
      break;
    }
    int x, y;
    bool check = true;
    do {
      stdout.write((n % 2 == 0) ? "\n\nPlayer 1 (X)" : "\n\nPlayer 2 (O)");
      stdout.write("\nx >>");
      x = util.getInput();
      stdout.write("y >>");
      y = util.getInput();
      check = c.chess(x, y, ((n % 2 == 0) ? 'X' : 'O'));

      if (check) {
        isWin = c.isWin(x, y, ((n % 2 == 0) ? 'X' : 'O'));
        break;
      }
      stdout.write("you select is wrong!!\nTry again\n");
    } while (true);

    n++;
  }
}
