import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:rjd_app/Screens/widgets/User.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/true.dart';
import 'package:http/http.dart' as http;
import 'package:rjd_app/main.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<dynamic> users = [];
  @override
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return admin1.value == 'true'
        ? PopScope(
            canPop: false,
            child: Scaffold(
              drawer: const MyDrawer(),
              appBar: AppBar(
                toolbarHeight: 50.0,
                title: const Text(
                  "جميع الحسابات",
                  style: TextStyle(
                      fontFamily: 'font1',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                centerTitle: true,
                leading: Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  );
                }),
              ),
              body: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.5),
                          child: SizedBox(
                            height: users.length * 90,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height - 180),
                              child: RefreshIndicator(
                                onRefresh: fetchUsers,
                                color: Colors.blueAccent,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 6,
                                  ),
                                  itemCount: users.length,
                                  itemBuilder: (context, index) {
                                    final user = users[index];
                                    final storage =
                                        const FlutterSecureStorage();

                                    Future Update_worker(
                                        int status, String worker) async {
                                      if (name.value == user['username']) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    80,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    40,
                                                child: const False(
                                                    text:
                                                        "لا يمكن تعديل بيانات الحساب الحالي"),
                                              ),
                                            ],
                                          ),
                                        );
                                        fetchUsers();
                                      } else {
                                        final token =
                                            await storage.read(key: "jwt");
                                        if (worker == "false") {
                                          final updatedUser = users[status];

                                          final realIndex = updatedUser['id'];
                                          final ip_address = url_api.value;
                                          final req = await http.put(
                                              Uri.parse(
                                                  "http://$ip_address:3666/worker/$realIndex"),
                                              headers: {
                                                "Authorization": "$token"
                                              });

                                          if (req.statusCode == 200) {
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Users()));
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const True(
                                                        text:
                                                            "تم تحديث البيانات"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const False(
                                                        text:
                                                            "حدث خطأ في النظام"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        } else {
                                          final updatedUser = users[status];
                                          print("asas");
                                          final ip_address = url_api.value;
                                          final realIndex = updatedUser['id'];
                                          final req = await http.put(
                                              Uri.parse(
                                                  "http://$ip_address:3666/not_worker/$realIndex"),
                                              headers: {
                                                "Authorization": "$token"
                                              });
                                          final req2 = await http.put(
                                              Uri.parse(
                                                  "http://$ip_address:3666/not_admin/$realIndex"),
                                              headers: {
                                                "Authorization": "$token"
                                              });

                                          if (req.statusCode == 200 &&
                                              req2.statusCode == 200) {
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Users()));
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const True(
                                                        text:
                                                            "تم تحديث البيانات"),
                                                  ),
                                                ],
                                              ),
                                            );
                                            fetchUsers();
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const False(
                                                        text:
                                                            "حدث خطأ في النظام"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    }

                                    Future Update(
                                        int status, String admin) async {
                                      if (name.value == user['username']) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    80,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    40,
                                                child: const False(
                                                    text:
                                                        "لا يمكن تعديل بيانات الحساب الحالي"),
                                              ),
                                            ],
                                          ),
                                        );
                                        fetchUsers();
                                      } else {
                                        final token =
                                            await storage.read(key: "jwt");
                                        if (admin == "false") {
                                          print('false');
                                          final updatedUser = users[status];
                                          print("asas");
                                          final realIndex = updatedUser['id'];
                                          final ip_address = url_api.value;
                                          final req = await http.put(
                                              Uri.parse(
                                                  "http://$ip_address:3666/admin/$realIndex"),
                                              headers: {
                                                "Authorization": "$token"
                                              });

                                          if (req.statusCode == 200) {
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Users()));
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const True(
                                                        text:
                                                            "تم تحديث البيانات"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const False(
                                                        text:
                                                            "حدث خطأ في النظام"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        } else {
                                          final updatedUser = users[status];

                                          final realIndex = updatedUser['id'];
                                          final ip_address = url_api.value;
                                          final req = await http.put(
                                              Uri.parse(
                                                  "http://$ip_address:3666/not_admin/$realIndex"),
                                              headers: {
                                                "Authorization": "$token"
                                              });
                                          final req2 = await http.put(
                                              Uri.parse(
                                                  "http://$ip_address:3666/not_worker/$realIndex"),
                                              headers: {
                                                "Authorization": "$token"
                                              });

                                          if (req.statusCode == 200 &&
                                              req2.statusCode == 200) {
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Users()));
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const True(
                                                        text:
                                                            "تم تحديث البيانات"),
                                                  ),
                                                ],
                                              ),
                                            );
                                            fetchUsers();
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const False(
                                                        text:
                                                            "حدث خطأ في النظام"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    }

                                    Delete(int status) async {
                                      final ip_address = url_api.value;
                                      final token =
                                          await storage.read(key: "jwt");
                                      final response = await http.post(
                                          Uri.parse(
                                              "http://$ip_address:3666/user/${user_id.value}"),
                                          headers: {"Authorization": "$token"});

                                      if (response.statusCode == 200) {
                                        final result = jsonDecode(
                                                utf8.decode(response.bodyBytes))
                                            as Map<String, dynamic>;
                                        print(result['username']);
                                        print(user['username']);
                                        if (result['username'] ==
                                            user['username']) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      80,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      40,
                                                  child: const False(
                                                      text:
                                                          "لا يمكن حذف بيانات الحساب الحالي"),
                                                ),
                                              ],
                                            ),
                                          );
                                          fetchUsers();
                                        } else {
                                          final updatedReport = users[status];
                                          print("asas");
                                          final realIndex = updatedReport['id'];
                                          final req = await http.delete(
                                              Uri.parse(
                                                  "http://$ip_address:3666/del_user/$realIndex"),
                                              headers: {
                                                "Authorization": "$token"
                                              });

                                          if (req.statusCode == 200) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const True(
                                                        text: "تم حذف الحساب"),
                                                  ),
                                                ],
                                              ),
                                            );
                                            fetchUsers();
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) => Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              80,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              40,
                                                          child: const False(
                                                              text:
                                                                  "حدث خطأ في النظام"),
                                                        ),
                                                      ],
                                                    ));
                                          }
                                          print('else');
                                        }
                                      }
                                    }

                                    return Container(
                                        height: 70,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: user['admin'] == true
                                              ? const Color(0xFF2B3185)
                                              : Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: user['username'] == name.value
                                              ? Border.all(
                                                  width: 2,
                                                  color: Colors.white,
                                                )
                                              : Border.all(width: 0),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                  child: User(
                                                      onTap3: () {
                                                        Update_worker(
                                                            index,
                                                            user['worker']
                                                                .toString());
                                                      },
                                                      User_data: user,
                                                      pass: user['password'],
                                                      inedx: index + 1,
                                                      name12: user['username'],
                                                      onTap1: () {
                                                        Delete(index);
                                                      },
                                                      onTap2: () {
                                                        Update(
                                                          index,
                                                          user['admin']
                                                              .toString(),
                                                        );
                                                      },
                                                      admin_user: user['admin']
                                                          .toString(),
                                                      floor: user['floor']
                                                          .toString(),
                                                      desc: user['floor']
                                                          .toString(),
                                                      type: user['section'],
                                                      section: user['section']),
                                                  type: PageTransitionType
                                                      .rightToLeftWithFade,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                ));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          user['username'],
                                                          style: const TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      229,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              fontFamily:
                                                                  'font1',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        Text(
                                                          user['section'],
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white54,
                                                              fontFamily:
                                                                  'font1',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: ShapeDecoration(
                                                    color: Colors.black12,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                child: const Icon(Icons.person,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        )); //AdminCard(name: name, onTap1: onTap1, onTap2: onTap2, section: section, type: type, desc: desc, floor: floor, done: done, admin: admin)
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        ///ListView.builder(itemCount: ,),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        width: 40,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2B3185),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      const Text(
                                        "=> مستخدم أدمن",
                                        style: TextStyle(
                                            fontFamily: 'font1',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        width: 40,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      const Text(
                                        "=> مستخدم عادي",
                                        style: TextStyle(
                                            fontFamily: 'font1',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        width: 40,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2B3185),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 2.0, color: Colors.white),
                                        ),
                                      ),
                                      const Text(
                                        "=>  المستخدم الحالي",
                                        style: TextStyle(
                                            fontFamily: 'font1',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            drawer: const MyDrawer(),
            appBar: AppBar(
              toolbarHeight: 50.0,
              title: const Text(
                "جميع الحسابات",
                style: TextStyle(
                    fontFamily: 'font1',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              centerTitle: true,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  );
                },
              ),
            ),
            body: Column(
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

  final storage = const FlutterSecureStorage();
  Future<void> fetchUsers() async {
    final ip_address = url_api.value;
    try {
      final url = Uri.parse("http://$ip_address:3666/users");
      final token = await storage.read(key: "jwt");
      final response =
          await http.get(url, headers: {"Authorization": "$token"});
      if (response.statusCode == 200) {
        final body = response.bodyBytes;
        final json = jsonDecode(utf8.decode(body));
        print(name.value);
        setState(() {
          users = json;
        });

        print(users);
      } else if (response.statusCode == 401) {
        showDialog(
          context: context,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: const False(text: "الرجاء العودة لتسجيل الدخول"),
              ),
            ],
          ),
        );
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
    } catch (e) {
      print(e);
    }
  }
}
