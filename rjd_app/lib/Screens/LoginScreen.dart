import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: '');
    TextEditingController passController = TextEditingController(text: '');
    double width = MediaQuery.of(context).size.width;

    final storage = const FlutterSecureStorage();
    Future<void> Login() async {
      if (nameController.text.isNotEmpty && passController.text.isNotEmpty) {
        final password = passController.text;

        final response = await http.post(
          Uri.parse("http://192.168.0.100:3666/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*",
            'Accept': '*/*'
          },
          body: jsonEncode(
            <String, String>{
              'username': nameController.text,
              'password': password.toString(),
            },
          ),
        );

        if (response.statusCode == 203) {
          showDialog(
            context: context,
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  height: MediaQuery.of(context).size.width - 40,
                  child: const False(text: "حساب غير متواجد"),
                ),
              ],
            ),
          );
        } else if (response.statusCode == 201) {
          final result = jsonDecode(response.body)[0] as Map<String, dynamic>;
          final tokenData =
              jsonDecode(response.body)[1] as Map<String, dynamic>;
          user_id.value = result['id'].toString();
          name.value = result['username'];
          section.value = result['section'];
          floor.value = result['floor'].toString();
          admin1.value = result['admin'].toString();
          worker.value = result['worker'].toString();
          final token = await storage
              .write(key: "jwt", value: tokenData["access_token"])
              .then((onValue) {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 300),
                    child: const MyApp()));
          });
          print(await storage.read(key: "jwt"));
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
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  height: MediaQuery.of(context).size.width - 40,
                  child: const False(text: "الرجاء ملء جميع الحقول")),
            ],
          ),
        );
      }
    }

    return PopScope(
      canPop: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 80),
                      width: MediaQuery.of(context).size.width > 375
                          ? MediaQuery.of(context).size.width * 50 / 100
                          : MediaQuery.of(context).size.width * 60 / 100,
                      height: 250,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 98.05,
                            child: Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 0.0)
                                ..rotateZ(-0.56),
                              child: Container(
                                width: 184,
                                height: 106,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF2B3185),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 15,
                            top: 94,
                            child: Container(
                              width: 182,
                              height: 182,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFD4D3F7),
                                shape: StarBorder.polygon(sides: 3),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 130.18,
                            top: 966,
                            child: Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 0.0)
                                ..rotateZ(3.14),
                              child: SizedBox(
                                width: 212.18,
                                height: 276,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: -98.05,
                                      child: Transform(
                                        transform: Matrix4.identity()
                                          ..translate(0.0, 0.0)
                                          ..rotateZ(2.58),
                                        child: Container(
                                          width: 184,
                                          height: 106,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFF77C9DB),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: -15,
                                      top: -94,
                                      child: Transform(
                                        transform: Matrix4.identity()
                                          ..translate(0.0, 0.0)
                                          ..rotateZ(3.14),
                                        child: Container(
                                          width: 182,
                                          height: 182,
                                          decoration: const ShapeDecoration(
                                            color: Color(0xCE90F8FF),
                                            shape: StarBorder.polygon(sides: 3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 40),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 40, top: 0),
                    child: Text(
                      "الرجاء إدخال البيانات المطلوبة",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5299999713897705),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 12,
                          offset: Offset(-10, 14),
                          spreadRadius: 4,
                        )
                      ],
                    ),
                    width: MediaQuery.of(context).size.width - 60,
                    height: 46,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6499999761581421),
                        fontSize: 14,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.person_outline_outlined,
                            size: 20.0,
                          ),
                          suffixIconColor:
                              Colors.black.withOpacity(0.6499999761581421),
                          hintText: 'اسم المستخدم',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6499999761581421),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(top: 10)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 12,
                            offset: Offset(-10, 14),
                            spreadRadius: 4,
                          )
                        ],
                      ),
                      width: MediaQuery.of(context).size.width - 60,
                      height: 46,
                      child: TextFormField(
                        validator: (String? val) {
                          return val!.length > 8
                              ? "يجب أن تكون كلمة السر من 8 محارف على الاقل"
                              : null;
                        },
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6499999761581421),
                          fontSize: 14,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        controller: passController,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.person_outline_outlined,
                              size: 20.0,
                            ),
                            suffixIconColor:
                                Colors.black.withOpacity(0.6499999761581421),
                            hintText: 'كلمة السر',
                            hintStyle: TextStyle(
                              color:
                                  Colors.black.withOpacity(0.6499999761581421),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(top: 10)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () async {
                  await Login();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 160,
                  height: 55,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 2.0, color: Color(0xFF2B3185)),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0xFF2B3185),
                        blurRadius: 14,
                        offset: Offset(0, 0),
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          'تسجيل الدخول',
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
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 200,
                  height: 55,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 2.0, color: Color(0xFF2B3185)),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0xFF2B3185),
                        blurRadius: 14,
                        offset: Offset(0, 0),
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          'العودة',
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
              ),
            ],
          )),
        ),
      ),
    );
  }
}
