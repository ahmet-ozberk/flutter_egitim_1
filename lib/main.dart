import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_egitim_2/ders_2.dart';

void main() {
  runApp(MyApp());
}

// Android tasarım deseni 'Material'
// IOS tasarım deseni 'Cupertino'

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ApiKullanimi(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool parola = false;
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Burası AppBar"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          /* Container(
            width: 200,
            height: 200,
            color: Colors.orange,
            padding: EdgeInsets.all(24),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(24),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Text Widget",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          // ElevatedButton
          // OutlinedButton
          // TextButton
          // IconButton
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              alignment: Alignment.center,
              elevation: 15,
              shadowColor: Colors.deepOrange,
            ),
            child: const Text(
              "ElevatedButton",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          OutlinedButton(onPressed: () {}, child: Text("OutlinedButton")),
          TextButton(onPressed: () {}, child: Text("TextButton")),
          IconButton(onPressed: () {}, icon: Icon(Icons.add_a_photo)),
          Icon(
            Icons.clear,
            size: 34,
            color: Colors.red,
          ),
          */
          Container(
            height: 150,
            color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 50,
                  color: Colors.black45,
                ),
                Container(
                  width: 200,
                  height: 50,
                  color: Colors.red,
                ),
                Container(
                  width: 200,
                  height: 50,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
          Text(text),
          TextField(
            cursorColor: Colors.deepPurple,
            maxLength: 100,
            obscureText: parola,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            onChanged: (value) {
              setState(() {
                text = value;
              });
            },
            decoration: InputDecoration(
                fillColor: Colors.grey,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 3,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  borderSide: BorderSide(
                    color: Colors.yellow,
                    width: 2,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.access_time_filled_outlined),
                  onPressed: () {
                    setState(() {
                      parola = !parola;
                    });
                  },
                ),
                prefix: Icon(Icons.ac_unit_rounded),
                //hintText: "TextField Widget",
                labelText: "TextField Widget",
                labelStyle: TextStyle(
                  color: Colors.black,
                )),
          ),
          Container(
            height: 150,
            color: Colors.blue.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 50,
                  color: Colors.black45,
                ),
                Container(
                  width: 100,
                  height: 50,
                  color: Colors.red,
                ),
                Container(
                  width: 100,
                  height: 50,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            color: Colors.indigo,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Container(
                  width: 100,
                  height: 50,
                  color: Colors.black45,
                ),
                Container(
                  width: 100,
                  height: 50,
                  color: Colors.red,
                ),
                Container(
                  width: 100,
                  height: 50,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
