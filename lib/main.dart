import 'dart:async';

import 'package:flutter/material.dart';

enum TypeTime { seconds, minute }

void main(List<String> args) {
  runApp(const PomodoApp());
}

//두번째 코딩 챌린지(2023.04.13)
// 유저가 타이머의 시간(15, 20, 25, 30, 35)을 선택할 수 있어야 합니다.
// 유저가 타이머를 재설정 (리셋)할 수 있어야 합니다.
// 유저가 한 사이클을 완료한 횟수를 카운트해야 합니다.
// 유저가 4개의 사이클(1라운드)를 완료한 횟수를 카운트해야 합니다.
// 각 라운드가 끝나면 사용자가 5분간 휴식을 취할 수 있어야 합니다.

class PomodoApp extends StatefulWidget {
  const PomodoApp({super.key});

  @override
  State<PomodoApp> createState() => _PomodoAppState();
}

class _PomodoAppState extends State<PomodoApp> {
  List<int> timeSet = [15, 20, 25, 30, 35];
  int selectedMinute = 0;
  int minutes = 0;
  int seconds = 60;
  bool isRunning = false;
  int totalRound = 0;
  int totalGoal = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (minutes == 0 && seconds == 0) {
      setState(() {
        minutes = selectedMinute;
        seconds = 0;
        isRunning = false;
        totalRound++;
        if (totalRound == 4) {
          totalGoal++;
          totalRound = 0;
        }
      });
      timer.cancel();
    } else {
      setState(() {
        if (seconds == 0) {
          seconds = 59;
          minutes--;
        } else {
          seconds--;
        }
      });
    }
  }

  String format(int times, TypeTime typeTime) {
    String str = '';
    switch (typeTime) {
      case TypeTime.minute:
        var duration = Duration(minutes: times);
        str = duration.inMinutes.toString() == '0'
            ? '00'
            : duration.inMinutes.toString();
        return str;

      case TypeTime.seconds:
        var duration = Duration(seconds: times);
        str = duration.inSeconds.toString() == '0'
            ? '00'
            : duration.inSeconds.toString();
        return str;

      default:
        return '00';
    }
  }

  void onClickReset() {
    isRunning = false;
    minutes = 0;
    seconds = 0;
    totalRound = 0;
    totalGoal = 0;
    selectedMinute = 0;
    setState(() {});
  }

  void btnSetTimer(String times) {
    minutes = int.parse(times);
    selectedMinute = minutes;
    seconds = 0;
    setState(() {});
  }

  void btnIconClick() {
    isRunning = isRunning == false ? true : false;
    switch (isRunning) {
      case true:
        timer = Timer.periodic(const Duration(seconds: 1), onTick);
        break;
      case false:
        timer.cancel();
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xffff3f41),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'POMOTIMER',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 40),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Text(
                      format(minutes, TypeTime.minute),
                      style: const TextStyle(
                          color: Color(0xffff3f41),
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    ' : ',
                    style: TextStyle(
                        color: Colors.blueGrey.shade100,
                        fontWeight: FontWeight.bold,
                        fontSize: 55),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 40),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Text(
                      format(seconds, TypeTime.seconds),
                      style: const TextStyle(
                          color: Color(0xffff3f41),
                          fontSize: 55,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var times = timeSet[index].toString();
                      return GestureDetector(
                        onTap: () {
                          btnSetTimer(times);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: const Color(0xffff3f41),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: Text(
                            times,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 20,
                          height: 20,
                        ),
                    itemCount: timeSet.length),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: IconButton(
                      onPressed: btnIconClick,
                      icon: isRunning == true
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_circle),
                      iconSize: 80,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: onClickReset, child: const Text('Reset')),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${totalRound.toString()}/4',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'ROUND',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${totalGoal.toString()}/12',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'GOAL',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 첫번째 코딩 챌린지(2023.04.10)
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void btnClick() {}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          'https://source.unsplash.com/random/',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: btnClick,
                      icon: const Icon(Icons.add),
                      iconSize: 50,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text('MONDAY 16'),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'TODAY',
                      style: TextStyle(fontSize: 28),
                    ),
                    Text(
                      ' ● ',
                      style: TextStyle(color: Colors.pink),
                    ),
                    Text(
                      '17  18  19  20  21  22',
                      style: TextStyle(fontSize: 28, color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const CardWidget(
                    title: 'DESIGN\nMEETING',
                    timeStart: '1130',
                    timeEnd: '1220',
                    colors: Color(0xffFEF754),
                    member: ['ALEX', 'HELENA', 'NANA']),
                const SizedBox(
                  height: 10,
                ),
                const CardWidget(
                    title: 'DAILY\nPROJECT',
                    timeStart: '1235',
                    timeEnd: '1410',
                    colors: Color(0xff9C6BCE),
                    member: ['ME', 'RICHARD', 'CIRY', '+4']),
                const SizedBox(
                  height: 10,
                ),
                const CardWidget(
                    title: 'WEEKLY\nPLANNING',
                    timeStart: '1500',
                    timeEnd: '1630',
                    colors: Color(0xffBCEE4B),
                    member: ['DEN', 'NANA', 'MARK']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title, timeStart, timeEnd;
  final Color colors;
  final List<String> member;
  const CardWidget(
      {super.key,
      required this.title,
      required this.timeStart,
      required this.timeEnd,
      required this.colors,
      required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colors,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      Text(
                        timeStart.substring(0, 2),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        timeStart.substring(2, 4),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Text(
                        '|',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        timeEnd.substring(0, 2),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        timeEnd.substring(2, 4),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Text(
                  title,
                  softWrap: true,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 50),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                SizedBox(
                  width: 200,
                  height: 20,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var members = member[index];
                        return Text(
                          members,
                          style: TextStyle(
                            fontSize: 15,
                            color:
                                members == 'ME' ? Colors.black : Colors.black38,
                            fontWeight: members == 'ME'
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: member.length),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
