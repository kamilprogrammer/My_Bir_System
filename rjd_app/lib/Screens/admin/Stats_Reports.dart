import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:http/http.dart' as http;
import 'package:rjd_app/main.dart';

class StatsReport extends StatefulWidget {
  const StatsReport({super.key});

  @override
  State<StatsReport> createState() => _StatsReportState();
}

class _StatsReportState extends State<StatsReport> {
  int option = 0;
  List users = [];
  String reports = "";
  String reports_done = "";
  @override
  void initState() {
    super.initState();
    Get_Reports_Analytics();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          toolbarHeight: 50.0,
          title: const Text(
            'الاحصائيات',
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
            margin: const EdgeInsets.only(top: 0),
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
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20), // Top padding
                  // Tabs (اليوم and الشهر)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            right: 8, left: 8, top: 4, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            color: const Color(0x7F35394D)),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              option = 1;
                            });
                            Get_Reports_Analytics();
                          },
                          child: const Text(
                            'اليوم',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "font1",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            right: 8, left: 8, top: 4, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            color: const Color(0xFF35394D)),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              option = 0;
                            });
                            Get_Reports_Analytics();
                          },
                          child: const Text(
                            'الشهر',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "font1"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Stats Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      option == 0
                          ? _buildStatBox('مجموع الطلبات في الشهر',
                              reports.length.toString(), width)
                          : _buildStatBox('مجموع الطلبات في اليوم',
                              reports.length.toString(), width),
                      _buildStatBox('مجموع الطلبات المنتهية',
                          reports_done.length.toString(), width),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // List of Requests
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        color: Colors.white),
                    width: width - 20,
                    height: width - 40,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            spacing: 8,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: width * 0.18,
                                height: width - 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF35394D),
                                ),
                              ),
                              const Text(
                                "الشهر الحالي",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "font1",
                                    fontSize: 14,
                                    color: Color.fromARGB(128, 0, 0, 0)),
                              )
                            ],
                          ),
                          Column(
                            spacing: 8,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: width * 0.18,
                                height: width - 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF35394D),
                                ),
                              ),
                              const Text(
                                "الشهر الحالي",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "font1",
                                    fontSize: 14,
                                    color: Color.fromARGB(128, 0, 0, 0)),
                              )
                            ],
                          ),
                          Column(
                            spacing: 8,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: width * 0.18,
                                height: width - 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF35394D),
                                ),
                              ),
                              const Text(
                                "الشهر الحالي",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "font1",
                                    fontSize: 14,
                                    color: Color.fromARGB(128, 0, 0, 0)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final storage = const FlutterSecureStorage();
  Future<void> Get_Reports_Analytics() async {
    final ip_address = url_api.value;
    if (option == 0) {
      try {
        final url = Uri.parse("http://$ip_address:3666/analytics/users/month");
        final token = await storage.read(key: "jwt");

        final response = await http.get(
          url,
          headers: {"Authorization": "$token"},
        );
        if (response.statusCode == 200) {
          final body = response.bodyBytes;
          final json = jsonDecode(utf8.decode(body))[0];
          final json2 = jsonDecode(response.body);

          setState(() {
            users = json;
            reports = json2[1].toString();
            reports_done = json2[2].toString();
          });
        } else if (response.statusCode == 404) {}
      } catch (e) {
        print(e);
      }
    } else if (option == 1) {
      try {
        final ip_address = url_api.value;
        final url = Uri.parse("http://$ip_address:3666/analytics/users/day");
        final token = await storage.read(key: "jwt");

        final response = await http.get(
          url,
          headers: {"Authorization": "$token"},
        );
        if (response.statusCode == 200) {
          final body = response.bodyBytes;
          final json = jsonDecode(utf8.decode(body))[0];
          final json2 = jsonDecode(response.body);

          setState(() {
            users = json;
            reports = json2[1].toString();
            reports_done = json2[2].toString();
          });
        } else if (response.statusCode == 404) {}
      } catch (e) {
        print(e);
      }
    }
  }
}

// Widget for Stat Box
Widget _buildStatBox(String title, String value, double width) {
  return Container(
    width: (width / 2) - 20,
    padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.right,
          style: const TextStyle(
              fontSize: 12, color: Colors.black54, fontFamily: "font1"),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: RichText(
                maxLines: 1,
                text: TextSpan(
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF35394D),
                      fontFamily: "font3",
                    ),
                    text: value.length == 1 ? "0$value" : value),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Widget for Request Item
Widget _buildRequestItem(String name, String section, String count, int id) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0x1935394D),
      borderRadius: BorderRadius.circular(19),
    ),
    child: Row(
      children: [
        Container(
            width: 42,
            height: 42,
            decoration: ShapeDecoration(
              color: const Color(0x5965B741),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  id.toString(),
                  style: const TextStyle(
                      fontFamily: "font2", fontSize: 24, color: Colors.green),
                ),
              ),
            ) /*Icon(
            Icons.keyboard_double_arrow_up_rounded,
            color: Colors.green,
          ),*/
            ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "font1")),
            Text(section,
                style: const TextStyle(
                    fontSize: 14, color: Colors.grey, fontFamily: "font1")),
          ],
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: Text(
            count,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "font1",
                color: Color(0xFF35394D)),
          ),
        ),
      ],
    ),
  );
}
