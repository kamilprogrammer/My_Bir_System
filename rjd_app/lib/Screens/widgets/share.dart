import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/true.dart';
import 'package:rjd_app/main.dart';
import 'package:http/http.dart' as http;

class ShareWidget extends StatefulWidget {
  const ShareWidget({super.key, required this.report_id});
  final report_id;

  @override
  State<ShareWidget> createState() => _ShareState();
}

class _ShareState extends State<ShareWidget> {
  List<dynamic> workers = [];

  int share1 = 0;
  int share2 = 0;

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 400,
      width: MediaQuery.of(context).size.width - 60,
      child: Dialog(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "تحويل المهمة",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'font1',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RefreshIndicator(
                child: SizedBox(
                  height: (80 * (workers.length < 3 ? workers.length : 3))
                      .toDouble(),
                  width: MediaQuery.of(context).size.width - 80,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    itemCount: workers.length,
                    itemBuilder: (context, index) {
                      final worker = workers[index];

                      return ListTile(
                        selected:
                            share1 == worker['id'] || share2 == worker['id'],
                        selectedTileColor: const Color.fromARGB(56, 78, 78, 78),
                        tileColor: Colors.white24,
                        onLongPress: () {
                          print(share1);
                          print(share2);
                          if (share1 == worker['id'] ||
                              share2 == worker['id']) {
                            if (share1.toString() == worker['id'].toString()) {
                              setState(() {
                                share1 = 0;
                              });

                              print(share1);
                            } else if (share2.toString() ==
                                worker['id'].toString()) {
                              setState(() {
                                share2 = 0;
                              });

                              print(share2);
                            } else {
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.of(context).pop();
                              });

                              showDialog(
                                context: context,
                                builder: (context) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          80,
                                      height:
                                          MediaQuery.of(context).size.width -
                                              40,
                                      child: const False(
                                          text: "يوجد مشكلة في النظام"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            if (share1 == 0) {
                              setState(() {
                                share1 = worker['id'];
                              });
                            } else if (share2 == 0) {
                              setState(() {
                                share2 = worker['id'];
                              });
                            }
                          }
                        },
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ),
                        title: Text(
                          worker['username'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'font1',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          worker['section'],
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color.fromARGB(211, 0, 0, 0),
                            fontFamily: 'font1',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                      //AdminCard(name: name, onTap1: onTap1, onTap2: onTap2, section: section, type: type, desc: desc, floor: floor, done: done, admin: admin)
                    },
                  ),
                ),
                onRefresh: () {
                  return reload();
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 108) / 2,
                      decoration: ShapeDecoration(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "إلغاء",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'font1',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 108) / 2,
                      decoration: ShapeDecoration(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          Share();
                        },
                        child: const Text(
                          "تحويل",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'font1',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
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
      ),
    );
  }

  Future<void> reload() async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "jwt");
      final url = Uri.parse("http://192.168.0.100:3666/employees");
      final response2 =
          await http.get(url, headers: {"Authorization": "$token"});
      final body = response2.bodyBytes;
      final json = jsonDecode(utf8.decode(body));
      print(name.value);
      setState(() {
        workers = json;
      });

      final response1 = await http.post(
          Uri.parse("http://192.168.0.100:3666/report/${widget.report_id}"),
          headers: {"Authorization": "$token"});
      final body1 = jsonDecode(response1.body);

      for (var worker in workers) {
        print(worker['id']);

        if (worker['id'].toString() == body1['done_by'].toString()) {
          if (share1 == 0) {
            setState(() {
              share1 = worker['id'];
            });
          }
        } else if (worker['id'].toString() == body1['done_by2'].toString()) {
          if (share2 == 0) {
            setState(() {
              share2 = worker['id'];
            });
          }
        } else if (worker['id'].toString() != body1['done_by'].toString() ||
            worker['id'].toString() != body1['done_by2'].toString()) {}
      }
    } catch (e) {
      print(e);
    }
  }

  /*Future<void> get_done_by_s() async {
    try {
      final url =
          Uri.parse("http://192.168.0.100:3666/report/${widget.report_id}");
      final response = await http.post(url);
      final body = response.bodyBytes;

      final json = jsonDecode(utf8.decode(body)) as Map<String, dynamic>;

      if (json['done_by'] != '0' && json['done_by2'] != '0') {
        if (worker['id'] == json['done_by']) {
          setState(() {
            workers_select[index] = true;
            share1 = int.parse(json['done_by']);

            workers_select[index] = true;
            share2 = int.parse(json['done_by2']);
          });
          print(share1 + share2);
        }
        setState(() {});
      } else if (json['done_by'] != '0') {
        print(json['done_by']);
        if (worker['id'] == json['done_by']) {
          setState(() {
            workers_select[index] = true;
            share1 = int.parse(json['done_by']);
          });
          print(share1);
        }
      } else if (json['done_by2'] != '0') {
        if (worker['id'] == json['done_by2']) {
          setState(() {
            workers_select = true;
            share2 = int.parse(json['done_by2']);
          });
          print(share2);
        }
      }
    } catch (e) {
      print(e);
    }
  }*/

  Future<void> Share() async {
    if (share1 == 0 && share2 == 0) {
      Future<bool> showAlertDialog(BuildContext context, String message) async {
        // set up the buttons
        Widget cancelButton = ElevatedButton(
          child: const Text(
            "لا",
            style: TextStyle(
                fontFamily: 'font1', fontWeight: FontWeight.bold, fontSize: 16),
          ),
          onPressed: () {
            // returnValue = false;
            Navigator.of(context).pop(false);
          },
        );
        Widget continueButton = ElevatedButton(
          child: const Text(
            "نعم",
            style: TextStyle(
                fontFamily: 'font1',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.red),
          ),
          onPressed: () {
            // returnValue = true;
            Navigator.of(context).pop(true);
          },
        );
        AlertDialog alert = AlertDialog(
          title: const Text(
            "هل أنت متأكد؟",
            textAlign: TextAlign.end,
            style: TextStyle(
                fontFamily: 'font1', fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Text(
            message,
            textAlign: TextAlign.end,
            style: const TextStyle(
                fontFamily: 'font1',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black38),
          ),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
        final result = await showDialog<bool?>(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
        return result ?? false;
      }

      showAlertDialog(context, "هل تريد إلغاء جميع التحويلات ؟")
          .then((bool1) async {
        if (bool1 == true) {
          final storage = FlutterSecureStorage();
          final token = await storage.read(key: "jwt");
          final request = await http.put(
              Uri.parse(
                  "http://192.168.0.100:3666/share/${widget.report_id}/$share1/$share2"),
              headers: {"Authorization": "$token"});
          if (request.statusCode == 200) {
            Navigator.pop(context);
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
        }
      });
    } else {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "jwt");
      final request = await http.put(
          Uri.parse(
              "http://192.168.0.100:3666/share/${widget.report_id}/$share1/$share2"),
          headers: {"Authorization": "$token"});

      if (request.statusCode == 200) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: const True(text: "تم تحويل المهمة"),
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
    }
  }
}
