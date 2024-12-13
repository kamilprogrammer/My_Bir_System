import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/admin/AdminHomeScreen.dart';
import 'package:rjd_app/main.dart';
import 'package:http/http.dart' as http;

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  @override
  void initState() {
    super.initState();
    about();
  }

  Future<void> about() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "jwt");
    final response = await http.get(
        Uri.parse("http://192.168.0.100:3666/about"),
        headers: {"Authorization": "$token"});
    final body = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      setState(() {
        about_data = body['data'];
      });
    }
  }

  String about_data = "No Data";
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.0,
            actions: const [],
            title: const Text(
              "عن التطبيق",
              style: TextStyle(
                  fontFamily: "font1",
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                if (admin1.value == 'true') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Adminhomescreen()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Homescreen()));
                }
              },
            )),
        body: Container(
          width: MediaQuery.of(context).size.width,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.21, 0.98),
              end: Alignment(-0.21, -0.98),
              colors: [
                Color(0xFF17161C),
                Color(0xFF323751),
                Color(0x6F3949A1),
                Color(0x000026FF)
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 170,
                    height: 170,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/bir.jpg"),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x7F000000),
                          blurRadius: 10,
                          offset: Offset(4, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Rj-Data x Al-Bir Hospital \n Reports App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'font1',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: ShapeDecoration(
                    color: Colors.black26,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                padding: const EdgeInsets.all(10),
                child: Text(
                  textAlign: TextAlign.center,
                  'version: 1.0.5',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7599999904632568),
                    fontSize: 18,
                    fontFamily: 'font1',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SafeArea(
                  child: Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Text(about_data.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "font1",
                        fontWeight: FontWeight.w600)),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
