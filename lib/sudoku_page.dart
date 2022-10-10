import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'strings.dart';

final Map sudokuLevels = {
  dil["seviye1"]: 62,
  dil["seviye2"]: 53,
  dil["seviye3"]: 44,
  dil["seviye4"]: 35,
  dil["seviye5"]: 26,
};

final List sudokuSample = [
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
];

class SudokuPage extends StatefulWidget {
  const SudokuPage({Key? key}) : super(key: key);

  @override
  State<SudokuPage> createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dil["title"])),
      body: Center(
        child: Column(
          children: [
            Text(Hive.box("sudoku").get("seviye", defaultValue: "Kolay")),
            AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: Colors.grey,
                  child: Column(children: [
                    for (int x = 0; x < 9; x++)
                      Expanded(
                          child: Column(children: [
                        Expanded(
                          child: Row(
                            children: [
                              for (int y = 0; y < 9; y++)
                                Expanded(
                                    child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin: EdgeInsets.all(1),
                                          color: Colors.black87,
                                          alignment: Alignment.center,
                                          child: Text(
                                              sudokuSample[x][y].toString(),
                                              style: GoogleFonts.orbitron(
                                                  textStyle: TextStyle(
                                                      color: Color.fromARGB(255,
                                                          194, 82, 225))))),
                                    ),
                                    if (x == 2 || x == 5)
                                      SizedBox(
                                        width: 2,
                                      )
                                  ],
                                ))
                            ],
                          ),
                        ),
                        if (x == 2 || x == 5)
                          SizedBox(
                            height: 2,
                          )
                      ]))
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
