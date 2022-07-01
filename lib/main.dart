import 'dart:convert';
import 'dart:io';

import 'package:currency_app/constans.dart';
import 'package:currency_app/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _editingControllerTop = TextEditingController();
  final TextEditingController _editingControllerBottom =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    _editingControllerTop.addListener(() {
      print(_editingControllerTop);
    });
    _editingControllerBottom.addListener(() {
      print(_editingControllerBottom);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _editingControllerTop.dispose();
    _editingControllerBottom.dispose();
  }

  Future<List<CurrencyModel>> loadData() async {
    try {
      var response =
          await get(Uri.parse("https://cbu.uz/oz/arkhiv-kursov-valyut/json/"));
      if (response == 200) {
        return [
          for (final item in jsonDecode(response.body))
            CurrencyModel.fromJson(item)
        ];
      } else {
        _showMessage("Unknown error");
      }
    } on SocketException {
      _showMessage("Connection error");
    } catch (e) {
      _showMessage(e.toString());
    }
  }

  _showMessage(String text, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green[400],
        content: Text(
          text,
          style: kTextStyle(size: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f2235),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Hello Suhayl,\n",
                      style: kTextStyle(size: 16),
                      children: [
                        TextSpan(
                          text: "welcome Back",
                          style:
                              kTextStyle(size: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white12)),
                      child: const Icon(
                        Icons.more_vert,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: loadData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        margin: const EdgeInsets.symmetric(vertical: 25),
                        decoration: BoxDecoration(
                          color: const Color(0xff2d334d),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Exchange",
                                  style: kTextStyle(
                                      size: 16, fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  iconSize: 20,
                                  icon: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                )
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                    _itemExCh(_editingControllerTop),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    _itemExCh(_editingControllerBottom),
                                  ],
                                ),
                                Container(
                                  height: 35,
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2d334d),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white12),
                                  ),
                                  child: const Icon(
                                    Icons.currency_exchange,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        child: Text(
                          "Eror",
                          style: kTextStyle(size: 18),
                        ),
                      );
                    } else {
                      return const Expanded(
                        child:  Center(
                          child: CircularProgressIndicator(color: Colors.white,),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _itemExCh(TextEditingController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller,
                  style: kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "0.00",
                    isDense: true,
                    hintStyle:
                        kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff10a4d4),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/spotify_logo.png",
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: Text(
                          "UZS",
                          style:
                              kTextStyle(size: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_right,
                        color: Colors.white54,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Text(
            "0.00",
            style:
                kTextStyle(fontWeight: FontWeight.w600, color: Colors.white54),
          ),
        ],
      ),
    );
  }
}
