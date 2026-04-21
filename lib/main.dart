import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String?> board = List.generate(9, (_) => null);
  bool xORy = true;
  String _winner = '';

  void _handleTap(int index) {
    if (board[index] != null || _winner.isNotEmpty) {
      return;
    }

    setState(() {
      board[index] = xORy ? 'X' : 'O';
      xORy = !xORy;
      _checkWinner();
    });
  }

  void _checkWinner() {
    final winningCombos = [
      [0, 1, 2],
      [5, 4, 3],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];


    for (var combo in winningCombos) {
      if (
      board[combo[0]] != null &&
          board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]) {
        setState(() {
          _winner = board[combo[2]]!;
        });
        return;
      }
    }

    if (!board.contains(null)) {
      setState(() {
        _winner = 'Draw';
      });
    }
  }

  void _resetGame() {
    setState(() {
      board = List.generate(9, (_) => null);
      xORy = true;
      _winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
      ),
      body: Container(decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_winner.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _winner == 'Draw' ? 'It\'s a Draw!' : 'Player $_winner wins!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            Container(decoration: BoxDecoration(color: Colors.black,),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,

                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => _handleTap(index),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                       // boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 1,color: Colors.white),BoxShadow(blurRadius: 5, spreadRadius: 2,color: Colors.white),BoxShadow(blurRadius: 7, spreadRadius: 3,color: Colors.white)]
                      ),
                      child: Text(
                        board[index] ?? '',
                        style: TextStyle(
                          fontSize: 90,
                          fontWeight: FontWeight.bold,
                          shadows:board[index] == 'X' ?  sdo(Colors.red) :sdo(Colors.blue),
                          color:  board[index] == 'X' ? Colors.white : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetGame,
              child: Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }
}
List<Shadow> sdo(Color color1){
 return [Shadow(color: color1,blurRadius: 3,),Shadow(color: color1,blurRadius: 9,),Shadow(color: color1,blurRadius: 18,)];
}