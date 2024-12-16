import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rjd_app/Screens/LoginScreen.dart';
import 'package:rjd_app/Screens/Register%201.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:rjd_app/Screens/admin/Stats_Reports.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:rjd_app/Screens/widgets/false.dart';

late final ValueNotifier<String> user_id;
late final ValueNotifier<String> name;
late final ValueNotifier<String> section;
late final ValueNotifier<String> floor;
late final ValueNotifier<String> admin1;
late final ValueNotifier<String> worker;
late final ValueNotifier<String> url_api;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  user_id = ValueNotifier(localStorage.getItem('user_id') ?? '0');
  name = ValueNotifier(localStorage.getItem('name') ?? '0');
  section = ValueNotifier(localStorage.getItem('section') ?? '0');
  floor = ValueNotifier(localStorage.getItem('floor') ?? '0');
  admin1 = ValueNotifier(localStorage.getItem('admin1') ?? '0');
  worker = ValueNotifier(localStorage.getItem('worker') ?? '0');
  url_api = ValueNotifier(localStorage.getItem('url_api') ?? '0');

  user_id.addListener(() {
    localStorage.setItem('user_id', user_id.value.toString());
    print(user_id.value);
  });
  name.addListener(() {
    localStorage.setItem('name', name.value.toString());
    print(name.value);
  });

  section.addListener(() {
    localStorage.setItem('section', section.value.toString());
    print(section.value);
  });

  floor.addListener(() {
    localStorage.setItem('floor', floor.value.toString());
    print(floor.value);
  });
  admin1.addListener(() {
    localStorage.setItem('admin1', admin1.value.toString());
    print(admin1.value);
  });
  worker.addListener(() {
    localStorage.setItem('worker', worker.value.toString());
    print(worker.value);
  });
  url_api.addListener(() {
    localStorage.setItem('url_api', url_api.value.toString());
    print(url_api.value);
  });

  print(user_id.value);

  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  final storage = const FlutterSecureStorage();

  Future<void> updatelocal() async {
    print(await storage.read(key: "jwt"));
    final token = await storage.read(key: "jwt");
    print(token);
    final ip_address = url_api.value;
    final url = Uri.parse("http://$ip_address:3666/user/${user_id.value}");
    final response = await http.get(
      url,
      headers: {"Authorization": "$token"},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(utf8.decode(response.bodyBytes))[0]
          as Map<String, dynamic>;
      final tokenData = jsonDecode(utf8.decode(response.bodyBytes))[1]
          as Map<String, dynamic>;
      url_api.value = "192.168.160.248";
      print(url_api.value);
      name.value = result['username'];
      section.value = result['section'];
      floor.value = result['floor'].toString();
      admin1.value = result['admin'].toString();
      worker.value = result['worker'].toString();

      final token =
          await storage.write(key: "jwt", value: tokenData["access_token"]);
      print(tokenData['access_token']);
    } else if (response.statusCode == 404) {
      showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: const False(
                    text:
                        "حدث خطأ في النظام \nالرجاء التواصل مع الكادر التقني")),
          ],
        ),
      );
      Future.delayed(const Duration(seconds: 3)).then((val) {
        exit(0);
      });
    }
  }

  decideScreen() {
    if (user_id.value == '0') {
      return const Starter();
    } else {
      updatelocal().then(
        (value) {
          print(admin1.value);
          if (admin1.value == 'true') {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) => const StatsReport()));
          } else {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Homescreen()));
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: const MyDrawer(),
          body: decideScreen(),
        ));
  }
}

class Starter extends StatefulWidget {
  const Starter({super.key});

  @override
  State<Starter> createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/bir.jpg',
                      ),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x80000000),
                        offset: Offset(4, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: const SizedBox(
                    width: 172,
                    height: 172,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Rj-Data x Al-Bir Hospital \n Reports App',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Janna LT',
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: ShapeDecoration(
                  color: Colors.black26,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              padding: const EdgeInsets.all(10),
              child: Text(
                textAlign: TextAlign.center,
                'version: 1.0.5',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7599999904632568),
                  fontSize: 16,
                  fontFamily: 'Janna LT',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 80,
              height: 52,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-1.00, -0.04),
                  end: Alignment(1, 0.04),
                  colors: [Color(0xFF2B3185), Color.fromARGB(255, 43, 49, 132)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 300),
                          child: const RegisterScreen()));
                },
                child: const Text(
                  'إنشاء حساب',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'font1',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 80,
              height: 52,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-1.00, -0.04),
                  end: Alignment(1, 0.04),
                  colors: [Color(0xFF2B3185), Color.fromARGB(255, 43, 49, 132)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 300),
                          child: const LoginScreen()));
                },
                child: const Text(
                  'تسجيل الدخول',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'font1',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
