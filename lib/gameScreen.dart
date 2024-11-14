import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String returnWinner = '';
  bool oTurn = true;
  List<String> display = ['', '', '', '', '', '', '', '', ''];
  int xScore = 0;
  int oScore = 0;
  int filledBox = 0;
  bool winnerFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Player O',
                      style: TextStyle(fontSize: 28, color: Colors.greenAccent),
                    ),
                    Text(
                      oScore.toString(),
                      style: const TextStyle(fontSize: 28, color: Colors.greenAccent),
                    ),
                  ],
                ),
                const SizedBox(width: 70),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Player X',
                      style: TextStyle(fontSize: 28, color: Colors.greenAccent),
                    ),
                    Text(
                      xScore.toString(),
                      style: const TextStyle(fontSize: 28, color: Colors.greenAccent),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Board section (3x3 Tic-Tac-Toe grid)
          Expanded(
            flex: 3,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3x3 grid
              ),
              padding: const EdgeInsets.all(8.0),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (!winnerFound) Btnpressed(index); // Only allow tap if no winner
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green),
                    ),
                    child: Center(
                      child: Text(
                        display[index],
                        style: const TextStyle(
                          fontSize: 48.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Winner message and Play Again button section
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    returnWinner,
                    style: TextStyle(
                      fontSize: 35.0,
                      letterSpacing: 3,
                      color: Colors.greenAccent.shade700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (winnerFound || filledBox == 9) // Show button if game is over
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      onPressed: clearBoard,
                      child: const Text(
                        'Play Again',
                        style: TextStyle(fontSize: 23, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to handle button press for each cell
  void Btnpressed(int index) {
    setState(() {
      if (display[index] == '') {
        display[index] = oTurn ? 'O' : 'X';
        filledBox++;
        checkWinner();
        if (!winnerFound) {
          oTurn = !oTurn; // Switch player only if no winner
        }
      }
    });
  }

  // Function to check for a winner or a draw
  void checkWinner() {
    // Define winning combinations
    List<List<int>> winningCombos = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6]             // Diagonals
    ];

    // Check each winning combination
    for (var combo in winningCombos) {
      if (display[combo[0]] == display[combo[1]] &&
          display[combo[0]] == display[combo[2]] &&
          display[combo[0]] != '') {
        setState(() {
          returnWinner = 'Player ${display[combo[0]]} Wins!';
          scoreUpdate(display[combo[0]]);
          winnerFound = true; // Set winnerFound to true
        });
        return;
      }
    }

    // Check for a draw if all boxes are filled and no winner
    if (!winnerFound && filledBox == 9) {
      setState(() {
        returnWinner = 'It\'s a Draw!';
      });
    }
  }

  // Function to update score based on the winner
  void scoreUpdate(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  // Function to reset the game board
  void clearBoard() {
    setState(() {
      display = List.filled(9, ''); // Clear board
      returnWinner = '';
      filledBox = 0;
      winnerFound = false; // Reset winnerFound for new game
    });
    oTurn = true; // Start with player O
  }
}
