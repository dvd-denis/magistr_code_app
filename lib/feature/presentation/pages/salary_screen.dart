import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:magistr_code/feature/domain/entities/salary_entity.dart';
import 'package:magistr_code/feature/domain/entities/user_entity.dart';
import 'package:magistr_code/feature/presentation/bloc/salary_cubit/salary_cubit.dart';
import 'package:magistr_code/feature/presentation/bloc/salary_cubit/salary_state.dart';

class SalaryPage extends StatelessWidget {
  const SalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    const listMonths = <String>[
      "Сен",
      "Окт",
      "Ноя",
      "Дек",
      "Янв",
      "Фев",
      "Мар",
      "Апр",
      "Май",
      "Июн",
      "Июл",
      "Авг"
    ];

    final arg = ModalRoute.of(context)!.settings.arguments as SalaryArguments;
    final user = arg.user;
    BlocProvider.of<SalaryCubit>(context).load(user.token, user.id);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Зарплата",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            BlocBuilder<SalaryCubit, SalaryState>(
              builder: (context, state) {
                List<SalaryEntity> salaries = [];

                if (state is SalaryLoading && state.isFisrtFetch) {
                  return _loadingIndicator();
                } else if (state is SalaryLoading) {
                  salaries = state.oldSalaries;
                } else if (state is SalaryLoaded) {
                  salaries = state.salaries;
                }

                return DefaultTabController(
                  length: salaries.length,
                  initialIndex: () {
                    final currentMounth =
                        int.parse(DateFormat.M().format(DateTime.now()));
                    if (currentMounth > 8) {
                      return currentMounth - 1 - 8;
                    } else {
                      return currentMounth - 1 + 4;
                    }
                  }(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromRGBO(144, 64, 245, 1.0),
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          dividerHeight: 0,
                          tabs: List.generate(
                            listMonths.length,
                            (index) => Tab(
                              height: 80,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    listMonths[index],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: TabBarView(
                          children: List.generate(salaries.length, (index) {
                            final salary = salaries[index];
                            return Column(
                              children: [
                                const SizedBox.square(
                                  dimension: 23,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xffd8c4f3),
                                        width: 2),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Зп: ${salary.salary}",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xffd8c4f3),
                                        width: 2),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 23),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    "Аванс: ${salary.advance}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xffd8c4f3),
                                        width: 2),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 23),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    "Премия: ${salary.prize}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xffd8c4f3),
                                        width: 2),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 23),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    "Подпись: ${salary.isConfirm ? "Подписано" : "-"}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                const SizedBox.square(
                                  dimension: 23,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffd8c4f3)),
                                  margin: const EdgeInsets.only(bottom: 23),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    "Итог: ${salary.total}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class SalaryArguments {
  final UserEntity user;

  SalaryArguments({required this.user});
}
