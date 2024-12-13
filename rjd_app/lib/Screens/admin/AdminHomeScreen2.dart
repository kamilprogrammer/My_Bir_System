import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:rjd_app/Screens/admin/AdminHomeScreen.dart';
import 'package:rjd_app/Screens/widgets/Card.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rjd_app/Screens/widgets/Full-Admin-Card.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class AdminHomeScreen2 extends StatefulWidget {
  const AdminHomeScreen2({super.key});

  @override
  State<AdminHomeScreen2> createState() => _AdminHomeScreen2State();
}

class _AdminHomeScreen2State extends State<AdminHomeScreen2> {
  @override
  void initState() {
    super.initState();

    fetchReports("All", "All");
  }

  List reports = [];

  @override
  Widget build(BuildContext context) {
    String user = "All";
    String date = "All";
    String? val = "";
    return admin1.value == 'true'
        ? PopScope(
            canPop: false,
            child: Scaffold(
              drawer: const MyDrawer(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          duration: Duration(milliseconds: 300),
                          child: const Adminhomescreen()));
                },
                child: Transform.scale(
                  scaleX: -1,
                  child: const Icon(
                    Icons.next_plan,
                    color: Color(0xFF323751),
                  ).animate().rotate(),
                ),
              ).animate().scaleXY(),
              appBar: AppBar(
                actions: [
                  DropdownButton(
                    iconEnabledColor: Colors.black,
                    underline: const SizedBox(
                      height: 0,
                    ),
                    padding: const EdgeInsets.all(10),
                    iconSize: 30.0,
                    style: const TextStyle(
                      color: Colors.white,
                      //backgroundColor: Color(0xFF2B3185),
                    ),
                    onChanged: (String? newval) {
                      setState(() {
                        val = newval;
                      });
                      if (val == "Today") {
                        setState(() {
                          date = DateFormat("yyyy-MM-dd")
                              .format(DateTime.now())
                              .toString();
                        });
                        fetchReports(date, user);
                      } else if (val == "Yesterday") {
                        setState(() {
                          date = DateFormat("yyyy-MM-dd")
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 1)))
                              .toString();
                        });
                        fetchReports(date, user);
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        value: "All",
                        onTap: () {
                          fetchReports("All", "All");
                        },
                        child: Container(
                            child: const Text(
                          '',
                          style: TextStyle(
                            color: Color(0xFF2B3185),
                            fontFamily: "font1",
                          ),
                        )),
                      ),
                      DropdownMenuItem(
                        value: "Today",
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: const Text(
                              'اليوم',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF2B3185),
                                fontFamily: "font1",
                              ),
                            )),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Yesterday",
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: const Text(
                              'البارحة',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF2B3185),
                                fontFamily: "font1",
                              ),
                            )),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "None",
                        onTap: () {
                          fetchReports("All", "All");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: const Text(
                              '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF2B3185),
                                fontFamily: "font1",
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                    //value: val,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                  ),
                ],
                toolbarHeight: 50.0,
                title: const Text(
                  'آخر البلاغات',
                  style: TextStyle(
                      fontFamily: 'font1',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                centerTitle: true,
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
              ),
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: RefreshIndicator(
                            color: Colors.blueAccent,
                            onRefresh: () {
                              return fetchReports(user, date);
                            },
                            child: reports.isEmpty
                                ? False(
                                    text: worker.value == 'true'
                                        ? "لايوجد أي طلب صيانة محوّل إليك"
                                        : "لا يوجد أي طلبات صيانة")
                                : ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 0,
                                    ),
                                    itemCount: reports.length,
                                    itemBuilder: (context, index) {
                                      final report = reports[index];

                                      return GestureDetector(
                                        onTap: () {
                                          if (admin1.value == "true") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Full_Admin_Card(
                                                  card: report,
                                                  index: index,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: StatusCard(
                                          notes: report['notes'],
                                          title: report['report_title'],
                                          name: report['name'],
                                          section: report['place'],
                                          desc: report['desc'],
                                          done: report['done'],
                                          index: index,
                                        ).animate().fade().slide(),
                                      );
                                    },
                                  ).animate().fade().flip()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: const False(text: "حدث خطأ في النظام"),
              ),
            ],
          );
  }

  final storage = const FlutterSecureStorage();

  Future<void> fetchReports(date, user) async {
    final url = Uri.parse("http://192.168.0.100:3666/reports/done");
    final token = await storage.read(key: "jwt");
    final response = await http.get(
      url,
      headers: {"Authorization": "$token"},
    );
    final body = response.bodyBytes;
    final finalJson = jsonDecode(utf8.decode(body));

    if (date == "All" && user == "All") {
      setState(() {
        reports = finalJson;
      });
      print(reports);
    } else if (date != "All") {
      setState(() {
        reports = finalJson;
        reports = reports
            .where((report) {
              return report['date'] == date;
            })
            .toList()
            .where((test) {
              return test['done'] == true;
            })
            .toList();
      });
      print(reports);
    } else if (user != "All") {
      setState(() {
        reports = finalJson;
        reports = reports
            .where((report) {
              return report['name'] == user.toString();
            })
            .toList()
            .where((test) {
              return test['done'] == true;
            })
            .toList();
      });
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
    }
  }
}
