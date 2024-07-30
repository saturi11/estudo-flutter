import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/widgets/app_images.dart';

class ListViewH extends StatefulWidget {
  const ListViewH({super.key});

  @override
  State<ListViewH> createState() => _ListViewHState();
}

class _ListViewHState extends State<ListViewH> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ListView Horizontal'),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(child: Image.asset(AppImages.morumbi)),
                  Card(child: Image.asset(AppImages.morumbi)),
                  Card(child: Image.asset(AppImages.morumbi)),
                ],
              ),
            ),
            Expanded(flex: 3, child: Container())
          ],
        ));
  }
}
