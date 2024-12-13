import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:rjd_app/Screens/ReportScreen.dart';
import 'package:rjd_app/Screens/widgets/Card.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:rjd_app/Screens/widgets/Full-Admin-Card.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/share.dart';
import 'package:rjd_app/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<dynamic> reports = [];
  @override
  @override
  void initState() {
    super.initState();
    fetch_rep_user();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String val = "All";
  @override
  Widget build(BuildContext context) {
    print(reports);
    return PopScope(
      canPop: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButtonLocation: reports.isEmpty
              ? FloatingActionButtonLocation.centerFloat
              : FloatingActionButtonLocation.endFloat,
          floatingActionButton: Container(
              margin: reports.isEmpty
                  ? EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.45)
                  : const EdgeInsets.all(0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReportScreen()));
                },
                backgroundColor: const Color(0xFF323751),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )),
          key: _scaffoldKey,
          drawer: const MyDrawer(),
          appBar: AppBar(
            toolbarHeight: 50.0,
            title: const Text(
              'آخر الطلبات',
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(top: 20),
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
                        return fetch_rep_user();
                      },
                      child: reports.isEmpty
                          ? False(
                              text: worker.value == 'true'
                                  ? "لايوجد أي طلب صيانة محوّل إليك"
                                  : "لم تقدم أي طلب صيانة حتى الآن")
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
                                        PageTransition(
                                          type: PageTransitionType.bottomToTop,
                                          duration: Duration(milliseconds: 300),
                                          child: Full_Admin_Card(
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
                            ).animate().fade().flip(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void View_Share(int status) async {
    final reportShared = reports[status];
    int reportId = reportShared['id'];
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
  }

  final storage = FlutterSecureStorage();
  Future<void> fetch_rep_user() async {
    print(user_id.value);
    try {
      final url =
          Uri.parse("http://192.168.0.100:3666/reports/${user_id.value}");
      final token = await storage.read(key: "jwt");
      print(token);

      final response = await http.get(
        url,
        headers: {"Authorization": "$token"},
      );
      if (response.statusCode == 200) {
        final body = response.bodyBytes;
        final json = jsonDecode(utf8.decode(body));
        setState(() {
          reports = json;
        });

        print(reports);
      } else if (response.statusCode == 404) {}
    } catch (e) {
      print(e);
    }
  }
}
