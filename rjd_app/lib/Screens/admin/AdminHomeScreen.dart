import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rjd_app/Screens/admin/AdminHomeScreen2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rjd_app/Screens/widgets/Card.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rjd_app/Screens/widgets/Full-Admin-Card.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/main.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Adminhomescreen extends StatefulWidget {
  const Adminhomescreen({super.key});

  @override
  State<Adminhomescreen> createState() => _AdminhomescreenState();
}

class _AdminhomescreenState extends State<Adminhomescreen> {
  @override
  @override
  void initState() {
    super.initState();
    fetchEmployees();
    fetchReports("All", {"id": 0, "name": "All"});
  }

  List reports = [];
  List employees = [];

  @override
  Widget build(BuildContext context) {
    final user = {"id": 0, "name": "All"};
    String date = "All";

    int index = 0;
    int inedxClicked = 0;
    double width = MediaQuery.of(context).size.width;
    String? val = "None";
    return admin1.value == 'true'
        ? PopScope(
            canPop: false,
            child: Scaffold(
              drawer: const MyDrawer(),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 300),
                          child: const AdminHomeScreen2()));
                },
                child: const Icon(
                  Icons.next_plan,
                  color: Color(0xFF323751),
                ).animate().rotate(),
              ).animate().scaleXY(),
              appBar: AppBar(
                actions: [
                  DropdownButton(
                    iconEnabledColor: Colors.black,
                    underline: const SizedBox(
                      height: 0,
                    ),
                    value: val,

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
                          fetchEmployees();
                          fetchReports("All", {"id": 0, "name": "All"});
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
                          fetchEmployees();
                          fetchReports("All", {"id": 0, "name": "All"});
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 8,
                              ),
                              itemCount: employees.length,
                              itemBuilder: (context, index) {
                                final employee = employees[index];
                                return GestureDetector(
                                  onTap: () {
                                    if (employee['username'] !=
                                        "جميع الحسابات") {
                                      setState(() {
                                        employees = employees.where((test) {
                                          return test['username'] ==
                                              employee['username'];
                                        }).toList();
                                        employees.insert(
                                            0, {"username": "جميع الحسابات"});

                                        inedxClicked = index;
                                        user.update(
                                            "id", (value) => employee['id']);
                                        user.update("name",
                                            (value) => employee['username']);
                                      });
                                      print(user);
                                      fetchReports(date, user);
                                    } else {
                                      fetchReports(
                                          "All", {"id": 0, "name": "All"});
                                      fetchEmployees();
                                    }
                                  },
                                  child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(minWidth: 40),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      height: 32,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF323751),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${employee['username']}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: "font1",
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                                .animate(
                                    delay: const Duration(milliseconds: 50))
                                .fade()
                                .slideY(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: RefreshIndicator(
                            color: Colors.blueAccent,
                            onRefresh: () {
                              fetchEmployees();
                              return fetchReports(date, user);
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
                                          if (admin1.value == "true" ||
                                              worker.value == "true") {
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
    final ip_address = url_api.value;
    final url = Uri.parse("http://$ip_address:3666/reports");
    final token = await storage.read(key: "jwt");
    final response = await http.get(
      url,
      headers: {"Authorization": "$token"},
    );
    if (response.statusCode == 200) {
      final body = response.bodyBytes;
      final finalJson = jsonDecode(utf8.decode(body));

      print(user);

      if (date == "All" && user["id"] == 0 && user['name'] == "All") {
        setState(() {
          reports = finalJson;
          reports = reports.where((test) {
            return test['done'] == false;
          }).toList();
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
                return test['done'] == false;
              })
              .toList();
        });
        print(reports);
      } else if (user["id"] != "All" && user['name'] != "All") {
        List reportsName = reports.where((report) {
          return report['name'] == user['name'].toString();
        }).toList();
        List reportsDone1 = reports.where((report) {
          return report['done_by'] == user['id'].toString();
        }).toList();

        List reportsDone2 = reports.where((report) {
          return report['done_by2'] == user['id'].toString();
        }).toList();
        setState(() {
          reports = finalJson;
          reports = reportsName + reportsDone1 + reportsDone2;
        });
      }
    }
  }

  Future<void> fetchEmployees() async {
    final ip_address = url_api.value;
    final url = Uri.parse("http://$ip_address:3666/employees");
    final token = await storage.read(key: "jwt");
    final response = await http.get(url, headers: {"Authorization": "$token"});
    final body = response.bodyBytes;
    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(body));
      setState(() {
        employees = json;
        employees.insert(0, {'username': 'جميع الحسابات'});
      });
    }
  }

  /*void View_Share(int status) async {
    //final reportShared = reports[status];
    //int reportId = reportShared['id'];
    print(reportId);

    showDialog(
        context: context,
        builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height - 400,
              width: MediaQuery.of(context).size.width - 60,
              child: ShareWidget(
                report_id: reportId,
              ),
            ));
  }*/
}
