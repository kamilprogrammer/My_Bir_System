import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rjd_app/Screens/AboutScreen.dart';
import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/ReportScreen.dart';
import 'package:rjd_app/Screens/admin/AdminHomeScreen.dart';
import 'package:rjd_app/Screens/admin/Stats_Users.dart';
import 'package:rjd_app/Screens/admin/Users.dart';
import 'package:rjd_app/main.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.0,
          title: const Text(
            "قائمة الانتقال",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'font1',
                fontSize: 18.0),
          ),
          centerTitle: true,
          leading: const Icon(
            Icons.menu,
            color: Color.fromARGB(0, 255, 255, 255),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Scaffold.of(context).closeDrawer();
                },
                icon: const Icon(Icons.arrow_forward_ios))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                /// -- IMAGE
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2.0, color: const Color(0xFF2B3185)),
                          borderRadius: BorderRadius.circular(100)),
                      width: 160,
                      height: 160,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:
                              const Image(image: AssetImage("assets/bir.jpg"))),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xFF2B3185)),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(name.value,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'font1',
                        fontSize: 18.0)),
                Text(section.value,
                    style: const TextStyle(fontFamily: 'font1')),
                const SizedBox(height: 20),

                ListTile(
                  //isThreeLine: true,

                  leading: const Icon(Icons.home),
                  subtitle: const Text(
                    "آخر الطلبات",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'font1',
                        color: Colors.black87),
                  ),
                  title: const Text(
                    'الصفحة الرئيسية',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'font1',
                    ),
                  ),
                  onTap: () {
                    if (admin1.value == 'true') {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 300),
                              child: const Adminhomescreen()));
                    } else {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 300),
                              child: const Homescreen()));
                    }

                    // Handle tap
                  },
                ),
                admin1.value == 'false'
                    ? ListTile(
                        leading: const Icon(Icons.add_box_rounded),
                        title: Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: const Text(
                            'إضافة طلب صيانة',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'font1',
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 300),
                                  child: const ReportScreen()));
                          // Handle tap
                        },
                      )
                    : Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.dashboard_rounded),
                            title: Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              child: const Text(
                                'الاحصائيات',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'font1',
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: const StatsScreen()));
                              // Handle tap
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              child: const Text(
                                'جميع الحسابات',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'font1',
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: const Users()));
                            },
                          ),
                        ],
                      ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: const Text(
                      'عن التطبيق',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'font1',
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 300),
                            child: const AboutScreen()));
                    // Handle tap
                  },
                ),

                ListTile(
                  textColor: Colors.red,
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: const Text(
                      'تسجيل الخروج',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'font1',
                      ),
                    ),
                  ),
                  onTap: () async {
                    user_id.value = '0';
                    name.value = '0';
                    section.value = '0';
                    floor.value = '0';
                    admin1.value = '0';
                    final storage = const FlutterSecureStorage();
                    final token = await storage.deleteAll();
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.topToBottom,
                            duration: const Duration(milliseconds: 300),
                            child: const Starter()));
                    // Handle tap
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
