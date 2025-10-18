import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class colorPickerPage extends StatefulWidget {
  const colorPickerPage({super.key});

  @override
  State<colorPickerPage> createState() => _colorPickerPageState();
}

// Asıl sınıf burda başlıyor
class _colorPickerPageState extends State<colorPickerPage> {
  Color selectedColor = Colors.blue;
  bool isCircular = false;
  bool isShowColorName = true ;

  void _randomColorSelect() {
    final color = colors.keys.toList();
    final randomColor = color[Random().nextInt(colors.length)];
    setState(() {
      selectedColor = randomColor;
    });
  }

  void _showColorCode() {
    Fluttertoast.showToast(
        msg: "RGB : (${selectedColor.red},${selectedColor.green},${selectedColor.blue})",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: selectedColor,
        textColor: Colors.white,
        fontSize: 24.0
    );
  }

  void _changeContainerShape(){
    setState(() { // ekrana yansıması için
      isCircular = !isCircular;  // çemberse kare yapacak , kareyse çember yapacak
    });
  }


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
        actions: [
          PopupMenuButton<String>(
            onSelected: (value){
              setState(() {
                isShowColorName = !isShowColorName;
              });
            },
            itemBuilder:(context){
              return [PopupMenuItem(
                value: "a",
                child:Row(
                  children: [
                    Icon(
                      isShowColorName ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 8,),
                    Text(isShowColorName ? "Hide color name" : "Show color name"),
                  ],
                ) ,
              )];
            },
            icon: Icon(Icons.more_vert),)
        ],
      ),
      body: Center(child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: BorderRadius.circular(isCircular ? 100 : 10),
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
          isShowColorName ? Text(colors[selectedColor] ?? "Selected Color") : SizedBox(),
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
              IconButton(onPressed: (){
                _changeContainerShape();},
                  icon: Icon(isCircular ? Icons.square_outlined : Icons.circle_outlined)),

            ],
          )
        ],
      ),),
    );
  }


}