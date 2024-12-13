import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/true.dart';
import 'package:rjd_app/main.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

TextEditingController title_controller = TextEditingController(text: '');
TextEditingController place_controller = TextEditingController(text: '');
TextEditingController notes_controller = TextEditingController(text: '');
TextEditingController desc_controller = TextEditingController(text: '');

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          toolbarHeight: 50.0,
          backgroundColor: const Color.fromARGB(199, 212, 211, 247),
          title: const Text(
            'إضافة طلب صيانة',
            style: TextStyle(
                fontFamily: 'font1',
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
          ),
          surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 60),
            width: MediaQuery.of(context).size.width,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.21, 0.98),
                end: Alignment(-0.21, -1.2),
                colors: [
                  Color(0xFF17161C),
                  Color(0xFF323751),
                  Color(0x6F3949A1),
                  Color(0x000026FF)
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Text(
                        'عنوان البلاغ',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.800000011920929),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )
                    .animate(delay: const Duration(microseconds: 50))
                    .fade()
                    .slide(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width - 60,
                      height: 49,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF717AA4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 23,
                            offset: Offset(0, 12),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6499999761581421),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.name,
                        controller: title_controller,
                        decoration: InputDecoration(
                          hintText: 'عنوان البلاغ',
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(96, 78, 78, 78)
                                .withOpacity(0.6499999761581421),
                            fontSize: 13,
                            fontFamily: 'font1',
                            fontWeight: FontWeight.w700,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(right: 10),
                        ),
                      ),
                    ),
                  ],
                )
                    .animate(delay: const Duration(milliseconds: 50))
                    .fade()
                    .slide(),
                const SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Text(
                        'موقع العطل',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.800000011920929),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )
                    .animate(delay: const Duration(microseconds: 400))
                    .fade()
                    .slide(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width - 60,
                      height: 49,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF717AA4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 23,
                            offset: Offset(0, 12),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6499999761581421),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.name,
                        controller: place_controller,
                        decoration: InputDecoration(
                          hintText: 'الاستقبال10',
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(96, 78, 78, 78)
                                .withOpacity(0.6499999761581421),
                            fontSize: 13,
                            fontFamily: 'font1',
                            fontWeight: FontWeight.w700,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(right: 10),
                        ),
                      ),
                    ),
                  ],
                )
                    .animate(delay: const Duration(milliseconds: 400))
                    .fade()
                    .slide(),
                const SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Text(
                        'وصف العطل',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.800000011920929),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )
                    .animate(delay: const Duration(milliseconds: 800))
                    .fade()
                    .slide(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: width - 60,
                        height: 49,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF717AA4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 23,
                              offset: Offset(0, 12),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6499999761581421),
                            fontSize: 16,
                            fontFamily: 'font1',
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.name,
                          controller: desc_controller,
                          decoration: InputDecoration(
                            hintText: 'وصف العطل 33',
                            hintStyle: TextStyle(
                              color: const Color.fromARGB(96, 78, 78, 78)
                                  .withOpacity(0.6499999761581421),
                              fontSize: 13,
                              fontFamily: 'font1',
                              fontWeight: FontWeight.w700,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(right: 10),
                          ),
                        )),
                  ],
                )
                    .animate(delay: const Duration(milliseconds: 800))
                    .fade()
                    .slide(),
                const SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Text(
                        'ملاحظات',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.800000011920929),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )
                    .animate(delay: const Duration(milliseconds: 1200))
                    .fade()
                    .slide(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width - 60,
                      height: 49,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF717AA4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 23,
                            offset: Offset(0, 12),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6499999761581421),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.multiline,
                        controller: notes_controller,
                        decoration: InputDecoration(
                          hintText: 'ملاحظات اضافية لطلب الصيانة',
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(96, 78, 78, 78)
                                .withOpacity(0.6499999761581421),
                            fontSize: 13,
                            fontFamily: 'font1',
                            fontWeight: FontWeight.w700,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(right: 10),
                        ),
                      ),
                    ),
                  ],
                )
                    .animate(delay: const Duration(milliseconds: 1200))
                    .fade()
                    .slide(),
                const SizedBox(
                  height: 60,
                ),
                TextButton(
                  onPressed: SendReport,
                  child: Container(
                    width: width - 160,
                    height: 55,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 4.0, color: Color(0xFF2B3185)),
                        borderRadius: BorderRadius.circular(19),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0xFF2B3185),
                          blurRadius: 20,
                          offset: Offset(0, 0),
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text(
                            'إرسال الطلب',
                            style: TextStyle(
                              color: Color(0xFF2B3185),
                              fontSize: 16,
                              fontFamily: 'font1',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    .animate(delay: const Duration(milliseconds: 1600))
                    .fade()
                    .scale(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> SendReport() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "jwt");
    if (notes_controller.text.isNotEmpty &&
        desc_controller.text.isNotEmpty &&
        place_controller.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse("http://192.168.0.100:3666/add"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "$token"
        },
        body: jsonEncode(
          <String, dynamic>{
            'place': place_controller.text.toString(),
            'desc': desc_controller.text.toString(),
            'kind': "",
            'name': name.value.toString(),
            'report_title': title_controller.text,
            'date': DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
            'done_by': 0,
            'done_by2': 0,
            'notes': notes_controller.text,
            'userid': int.parse(user_id.value),
            'done': false
          },
        ),
      );

      if (response.statusCode == 201) {
        notes_controller.clear();
        desc_controller.clear();
        place_controller.clear();

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Homescreen()));

        showDialog(
            context: context,
            builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      height: MediaQuery.of(context).size.width - 40,
                      child: const True(text: "تم ارسال الطلب"),
                    ),
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      height: MediaQuery.of(context).size.width - 40,
                      child: const False(text: "حدث خطأ في النظام"),
                    ),
                  ],
                ));
      }
    }
  }
}
