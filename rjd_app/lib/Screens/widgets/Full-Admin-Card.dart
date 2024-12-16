import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/admin/AdminHomeScreen.dart';
import 'package:rjd_app/Screens/widgets/Card.dart';
import 'package:action_slider/action_slider.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/true.dart';
import 'package:http/http.dart' as http;
import 'package:rjd_app/main.dart';

class Full_Admin_Card extends StatefulWidget {
  const Full_Admin_Card({super.key, required this.card, required this.index});

  @override
  final card;
  final index;
  @override
  State<Full_Admin_Card> createState() => _Full_Admin_CardState();
}

class _Full_Admin_CardState extends State<Full_Admin_Card> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                if (admin1.value == "true") {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          duration: const Duration(milliseconds: 300),
                          child: const Adminhomescreen()));
                } else {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 300),
                          type: PageTransitionType.leftToRight,
                          child: const Homescreen()));
                }
              },
            ),
            toolbarHeight: 50.0,
            title: Text(
              " طلب الصيانة رقم ${widget.index + 1}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'font1',
                  fontSize: 18.0),
            ),
            centerTitle: true,
          ),
          body: Container(
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
            child: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatusCard(
                      section: widget.card['desc'],
                      title: widget.card['report_title'],
                      name: widget.card['name'],
                      desc: widget.card['desc'],
                      done: widget.card['done'],
                      notes: widget.card['notes'],
                      index: widget.index),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: widget.card['done'] == false
                          ? ActionSlider.standard(
                              toggleColor: Colors.green,
                              action: (controller) async {
                                controller.loading();
                                await Update().then((val) {
                                  Future.delayed(const Duration(seconds: 1));
                                });

                                controller.success();
                              },
                              child: Container(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: const Text(
                                    'تم انجاز طلب الصيانة',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "font1", fontSize: 15),
                                  )),
                            )
                          : ActionSlider.standard(
                              toggleColor: Colors.red,
                              action: (controller) async {
                                controller.loading();
                                await NotYet();

                                controller.success();
                              },
                              child: Container(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: const Text(
                                    'لم يتم انجاز طلب الصيانة',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "font1", fontSize: 15),
                                  )),
                            ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final storage = const FlutterSecureStorage();

  Future<void> Update() async {
    final ip_address = url_api.value;
    final token = await storage.read(key: "jwt");
    final req = await http.put(
        Uri.parse("http://$ip_address:3666/done/${widget.card['id']}"),
        headers: {"Authorization": "$token"});

    if (req.statusCode == 200) {
      Future.delayed(const Duration(seconds: 1)).then((val) {
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
      });
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

  Future<void> NotYet() async {
    final token = await storage.read(key: "jwt");
    final ip_address = url_api.value;
    final req = await http.put(
        Uri.parse("http://$ip_address:3666/notyet/${widget.card['id']}"),
        headers: {"Authorization": "$token"});

    if (req.statusCode == 200) {
      Future.delayed(const Duration(seconds: 1)).then((val) {
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
      });
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
