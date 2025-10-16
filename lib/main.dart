import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //theme: ThemeData(),
      home: colorPickerPage(),
    );
  }
}


class colorPickerPage extends StatefulWidget {
  const colorPickerPage({super.key});

  @override
  State<colorPickerPage> createState() => _colorPickerPageState();
}

// Asıl sınıf burda başlıyor
class _colorPickerPageState extends State<colorPickerPage> {
  void _randomColorSelect() {
    final color = colors.keys.toList();
    final randomColor = color[Random().nextInt(colors.length)];
    setState(() {
      selectedColor = randomColor;
    });
  }

  void _showColorCode() {

  }

  Color selectedColor = Colors.blue;

  final Map<Color,String> colors = {
    Colors.red : "Red", // bu bir entrydir. key + value dan oluşur
    Colors.black: "Black",
    Colors.blue : "Blue",
    Colors.pink : "Pink",
    Colors.yellow : "Yellow",
    Colors.green : "Green",
    Colors.brown : "Brown",
    Colors.purple : "Purple",
    Colors.grey : "Grey",
    Colors.orange:"Orange"
  };
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Color Picker"),
        centerTitle: true,
      ),
      body: Center(child: Column(
        children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                     color: selectedColor.withOpacity(1),
                    blurRadius: 15,
                    spreadRadius: 2
                  )
                ]
              ),
            ),
          SizedBox(height: 20,),
          Text("Blue"),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
            children: [
              DropdownButton<Color>(
                value: selectedColor,
                items: colors.entries.map((entry){
                return DropdownMenuItem(
                    value: entry.key,
                    child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: entry.key,
                    ),
                    SizedBox(width: 4,),
                    Text(entry.value),
                  ],
                )
                );
              }).toList(), onChanged: (value){
                setState(() {
                  selectedColor = value!;
                });
              },),
              ElevatedButton(onPressed: _randomColorSelect, child: Text("Random",style: TextStyle(color: Colors.black))),
              IconButton(onPressed: _showColorCode, icon: Icon(Icons.info)),
              IconButton(onPressed: (){}, icon: Icon(Icons.circle_outlined)),

            ],
          )
        ],
      ),),
    );
  }


}

