import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/feature/domain/usecases/user.dart';
import 'package:magistr_code/locator_service.dart' as di;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Login login = di.sl<Login>();
  final controller1 = TextEditingController();

  void _login(String token) async {
    final failureOrUser = await login(UserParams(token: token));
    failureOrUser.fold(
      (failure) =>
          {Fluttertoast.showToast(msg: _mapFailureFromMessage(failure))},
      (user) => {
        Fluttertoast.showToast(msg: user.email),
        Navigator.pop(context),
        Navigator.pushNamed(context, "/main", arguments: user)
      },
    );
  }

  Future<void> _checkLogin() async {
    final failureOrUser = await login(const UserParams(token: ""));
    failureOrUser.fold(
      (failure) => {},
      (user) => {
        Fluttertoast.showToast(msg: user.email),
        Navigator.pop(context),
        Navigator.pushNamed(context, "/main", arguments: user)
      },
    );
  }

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }

  String _mapFailureFromMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ServerFailure";
      case CacheFailure:
        return "CacheFailure";
      default:
        return "Unexpected error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Авторизация",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 26),
            ),
            const SizedBox.square(
              dimension: 22,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 80),
              child: Text(
                "Сгенерировать токен можно в личном кабинете на сайте",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox.square(
              dimension: 100,
            ),
            TextField(
              controller: controller1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white10,
                hintText: "Ваш токен",
              ),
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
              ),
            ),
            const SizedBox.square(
              dimension: 50,
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _login(controller1.text);
                    },
                    child: const Text(
                      "Войти",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox.square(
                    dimension: 8,
                  ),
                  const Text("Войти с помощью\n почты",
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Система контроля ООО \"Школа ПРОГРАММИРОВАНИЯ Магистр Кода\"",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
