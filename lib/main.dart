import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

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
