import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rjd_app/Screens/admin/Users.dart';
import 'package:rjd_app/Screens/widgets/AdminCard.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/true.dart';
import 'package:rjd_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encrypt;

class User extends StatefulWidget {
  const User(
      {super.key,
      required this.name12,
      required this.onTap1,
      required this.onTap2,
      required this.floor,
      required this.desc,
      required this.type,
      required this.section,
      required this.inedx,
      required this.admin_user,
      required this.pass,
      required this.User_data,
      required this.onTap3});

  @override
  final String name12;
  final int inedx;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final VoidCallback onTap3;
  final String floor;
  final String desc;
  final String type;
  final String section;
  final String admin_user;
  final String pass;
  final User_data;
  @override
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  bool showPassword = true;

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: widget.name12);
    TextEditingController sectionController =
        TextEditingController(text: widget.section);
    TextEditingController floorController =
        TextEditingController(text: widget.floor);
    TextEditingController passController =
        TextEditingController(text: widget.pass);

    print(name.value);

    Future<void> update_user() async {
      if (nameController.text.isNotEmpty &&
          floorController.text.isNotEmpty &&
          sectionController.text.isNotEmpty &&
          passController.text.isNotEmpty) {
        final storage = FlutterSecureStorage();
        final token = await storage.read(key: "jwt");
        final response = await http.put(
          Uri.parse(
              "http://192.168.0.100:3666/update_user/${widget.User_data['id']}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*",
            'Accept': '*/*',
            "Authorization": "$token"
          },
          body: jsonEncode(
            <String, String>{
              'username': nameController.text,
              'floor': floorController.text,
              'section': sectionController.text,
              'password': passController.text,
              'worker': widget.User_data['worker'].toString(),
              'admin': widget.User_data['admin'].toString(),
            },
          ),
        );
        if (response.statusCode == 200) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Users()));
          showDialog(
            context: context,
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  height: MediaQuery.of(context).size.width - 40,
                  child: const True(text: "تم تحديث البيانات"),
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
                child: const False(text: "الرجاء ملء جميع الحقول"),
              ),
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
          appBar: AppBar(
            toolbarHeight: 50.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "${widget.inedx} الحساب رقم",
              style: const TextStyle(
                  fontFamily: 'font1',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            centerTitle: true,
          ),
          body: Container(
              child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AdminCard(
                share: () {},
                name: widget.name12,
                onTap1: widget.onTap1,
                onTap2: widget.onTap2,
                section: widget.admin_user == "true"
                    ? "حساب أدمن"
                    : widget.User_data['worker'] == false
                        ? "مستخدم عادي"
                        : 'موظف',
                type: "${widget.section} في \n${widget.floor} في الطابق ",
                desc: widget.desc,
                floor: widget.inedx,
                done: true,
                admin: true,
                user: true,
              ),
              const SizedBox(
                height: 80,
              ),
              widget.name12 != name.value
                  ? Column(
                      children: [
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
                                  color: Colors.black
                                      .withOpacity(0.6499999761581421),
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
                                    suffixIconColor: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    hintText: 'اسم المستخدم',
                                    hintStyle: TextStyle(
                                      color: Colors.black
                                          .withOpacity(0.6499999761581421),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(top: 12)),
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
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.6499999761581421),
                                  fontSize: 14,
                                  fontFamily: 'font1',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.name,
                                controller: floorController,
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                      Icons.format_list_numbered_rounded,
                                      size: 20.0,
                                    ),
                                    suffixIconColor: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    hintText: 'الطابق',
                                    hintStyle: TextStyle(
                                      color: Colors.black
                                          .withOpacity(0.6499999761581421),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(top: 12)),
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
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.6499999761581421),
                                  fontSize: 14,
                                  fontFamily: 'font1',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.streetAddress,
                                controller: sectionController,
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                      Icons.border_inner_rounded,
                                      size: 20.0,
                                    ),
                                    suffixIconColor: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    hintText: 'القسم',
                                    hintStyle: TextStyle(
                                      color: Colors.black
                                          .withOpacity(0.6499999761581421),
                                      fontSize: 14,
                                      fontFamily: 'font1',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(top: 12)),
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
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.6499999761581421),
                                  fontSize: 14,
                                  fontFamily: 'font1',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                                obscureText: showPassword,
                                controller: passController,
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                      Icons.lock_outline_rounded,
                                      size: 20.0,
                                    ),
                                    suffixIconColor: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    hintText: 'كلمة السر',
                                    hintStyle: TextStyle(
                                      color: Colors.black
                                          .withOpacity(0.6499999761581421),
                                      fontSize: 14,
                                      fontFamily: 'font1',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(
                                        top: 12, left: 8, right: 6)),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextButton(
                          onPressed: toggleShowPassword,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 220,
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
                                    child: const Icon(
                                  Icons.lock,
                                  color: Color(0xFF2B3185),
                                  size: 25.0,
                                )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: update_user,
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
                                    'تعديل البيانات',
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
                        const SizedBox(
                          height: 40,
                        ),
                        widget.admin_user == "true" &&
                                widget.User_data['worker'] == 'true'
                            ? Container()
                            : Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: ShapeDecoration(
                                          color: widget.admin_user == 'true'
                                              ? const Color(0xFF2B3185)
                                              : const Color(0xFF2B3185),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40))),
                                      child: Icon(
                                        Icons.person,
                                        color: widget.admin_user == 'true'
                                            ? Colors.white
                                            : Colors.white,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: widget.onTap3,
                                      style: TextButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF2B3185),
                                          padding: const EdgeInsets.all(20)),
                                      child: Text(
                                        widget.User_data['worker'] == 'false'
                                            ? "التحويل الى موظف"
                                            : "التحويل الى مستخدم",
                                        style: const TextStyle(
                                            fontFamily: 'font1',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: ShapeDecoration(
                                    color: widget.admin_user == 'true'
                                        ? const Color(0xFF2B3185)
                                        : const Color(0xFF2B3185),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40))),
                                child: Icon(
                                  Icons.person,
                                  color: widget.admin_user == 'true'
                                      ? Colors.white
                                      : Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: widget.onTap2,
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF2B3185),
                                    padding: const EdgeInsets.all(20)),
                                child: Text(
                                  widget.admin_user == 'true'
                                      ? "التحويل الى مستخدم"
                                      : "التحويل الى ادمن",
                                  style: const TextStyle(
                                      fontFamily: 'font1',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      "لا يمكن تعديل بيانات الحساب الحالي",
                      style: TextStyle(
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
              const SizedBox(
                height: 20,
              ),
              widget.name12 != name.value
                  ? Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: ShapeDecoration(
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40))),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: widget.onTap1,
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.all(20)),
                                child: const Text(
                                  "حذف الحساب نهائياً",
                                  style: TextStyle(
                                      fontFamily: 'font1',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    )
                  : Container()
            ],
          ))),
        ),
      ),
    );
  }
}
