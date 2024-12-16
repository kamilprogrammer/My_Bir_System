import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rjd_app/Screens/Register%202.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name_controller = TextEditingController(text: '');

  String floor_count = "0";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                                              shape:
                                                  StarBorder.polygon(sides: 3),
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
                        'إنشاء الحساب',
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
                        controller: name_controller,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.person_outline_outlined,
                              size: 20.0,
                            ),
                            suffixIconColor:
                                Colors.black.withOpacity(0.6499999761581421),
                            hintText: 'اسم المستخدم',
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
                const SizedBox(
                  height: 16,
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
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                          ),
                          DropdownButton(
                            style: TextStyle(
                              color:
                                  Colors.black.withOpacity(0.6499999761581421),
                              fontSize: 14,
                              fontFamily: 'font1',
                              fontWeight: FontWeight.w700,
                            ),
                            onChanged: (val) {
                              setState(() {
                                floor_count = val.toString();
                              });
                            },
                            iconSize: 22.0,
                            value: floor_count,
                            icon:
                                const Icon(Icons.format_list_numbered_rounded),
                            alignment: Alignment.centerRight,
                            underline: const SizedBox(
                              height: 0,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "0",
                                alignment: Alignment.center,
                                child: Text(
                                  " الطابق   ",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "1",
                                child: Text(
                                  "1 ",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "2",
                                child: Text(
                                  "2",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "3",
                                child: Text(
                                  "3 ",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "4",
                                child: Text(
                                  "4 ",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "5",
                                child: Text(
                                  "5 ",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "6",
                                child: Text(
                                  "6 ",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "7",
                                child: Text(
                                  "7 ",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "8",
                                child: Text(
                                  "8 ",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "9",
                                child: Text(
                                  "9 ",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "10",
                                child: Text(
                                  "10 ",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () {
                    if (name_controller.text.isNotEmpty &&
                        floor_count != "0" &&
                        floor_count != "الطابق") {
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 300),
                            child: RegisterScreen2(
                                name_controller: name_controller.text,
                                floor_controller: floor_count),
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
                                child: const False(
                                    text: "الرجاء ملء جميع الحقول")),
                          ],
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: width - 160,
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
                            'التالي',
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
            ),
          ),
        ),
      ),
    );
  }
}
