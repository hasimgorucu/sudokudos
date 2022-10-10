import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:sudokudos/sudoku_page.dart';
import 'strings.dart';

class EnterPage extends StatefulWidget {
  const EnterPage({Key? key}) : super(key: key);

  @override
  State<EnterPage> createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  late Box sudokuBox;
  Future<Box> openBox() async {
    sudokuBox = await Hive.openBox("sudoku");
    return await Hive.openBox("completed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton(
                  onSelected: (value) {
                    if (sudokuBox.isOpen) {
                      sudokuBox.put("seviye", value);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SudokuPage()));
                    }
                  },
                  icon: Icon(
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 20.0,
                        color: Color.fromARGB(100, 5, 217, 232),
                      ),
                    ],
                    Icons.add,
                    color: Color.fromARGB(255, 5, 217, 232),
                    size: 36,
                  ),
                  itemBuilder: (context) {
                    return <PopupMenuEntry>[
                      for (String key in sudokuLevels.keys)
                        PopupMenuItem(
                            value: key,
                            child: Text(key,
                                style: GoogleFonts.orbitron(
                                    textStyle: TextStyle(fontSize: 14))))
                    ];
                  }),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            dil["title"],
            style: GoogleFonts.majorMonoDisplay(
                textStyle: const TextStyle(shadows: <Shadow>[
              Shadow(
                offset: Offset(3.0, 3.0),
                blurRadius: 20.0,
                color: Color.fromARGB(100, 5, 217, 232),
              ),
            ], fontSize: 34, color: Color.fromARGB(255, 5, 217, 232))),
          ),
          //centerTitle: true,
        ),
        body: FutureBuilder<Box>(
            future: openBox(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (snapshot.data!.length == 0)
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                dil["tamamlanan_yok"],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.orbitron(
                                  textStyle: const TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(10.0, 10.0),
                                        blurRadius: 20.0,
                                        color:
                                            Color.fromARGB(100, 194, 82, 225),
                                      ),
                                    ],
                                    color: Color.fromARGB(255, 194, 82, 225),
                                    fontSize: 16,
                                  ),
                                ),
                              )),
                        for (var element in snapshot.data!.values)
                          Text("$element")
                      ]),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })));
  }
}
