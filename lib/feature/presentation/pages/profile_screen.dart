import 'package:flutter/material.dart';
import 'package:magistr_code/feature/domain/entities/user_entity.dart';
import 'package:magistr_code/feature/presentation/pages/salary_screen.dart';
import 'package:magistr_code/feature/presentation/widgets/side_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as ProfileArguments;
    final user = arg.user;

    return Scaffold(
      appBar: AppBar(),
      drawer: SideMenu(
        user: user,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromRGBO(144, 64, 245, 1.0),
                  radius: 50,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(144, 64, 245, 1.0),
                    radius: 40,
                    child: Image.asset('assets/icons/profile.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${user.surName} ${user.name} \n${user.middleName}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        user.dateOfBirth,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.phoneNumber,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox.square(
                    dimension: 23,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: const Color(0xffd8c4f3), width: 2),
                    ),
                    margin: const EdgeInsets.only(bottom: 15),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Адрес: \n${user.address}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: const Color(0xffd8c4f3), width: 2),
                    ),
                    margin: const EdgeInsets.only(bottom: 23),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    child: Text(
                      "Кол-во учеников: ${user.studentsCount}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: const Color(0xffd8c4f3), width: 2),
                    ),
                    margin: const EdgeInsets.only(bottom: 23),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    child: Text(
                      "Кол-во групп: ${user.groupsCount}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: const Color(0xffd8c4f3), width: 2),
                    ),
                    margin: const EdgeInsets.only(bottom: 23),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    child: Text(
                      "Ставка: ${user.stake}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: const Color(0xffd8c4f3), width: 2),
                    ),
                    margin: const EdgeInsets.only(bottom: 23),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    child: Text(
                      "Расчет: ${user.paymentType == 0 ? "Фиксированный" : "Автоматический"}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      Navigator.of(context).pushNamed("/salary",
                          arguments: SalaryArguments(user: user));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffd8c4f3),
                      ),
                      margin: const EdgeInsets.only(bottom: 23),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      child: const Text(
                        textAlign: TextAlign.center,
                        "Зарплата",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileArguments {
  final UserEntity user;

  ProfileArguments({required this.user});
}
