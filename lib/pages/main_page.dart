import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/card-page.dart';
import 'package:trilhaapp/pages/consulta_cep.dart';
import 'package:trilhaapp/pages/list_view_h.dart';
import 'package:trilhaapp/pages/list_view_v.dart';
import 'package:trilhaapp/pages/tarefa/tarefa_page_sqlite.dart';
import 'package:trilhaapp/shared/widgets/custom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Main Page'),
          backgroundColor: Colors.teal.shade700,
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                children: const [
                  ConsultaCep(),
                  Cardpage(),
                  ListViewH(),
                  ListViewV(),
                  TarefaSqlitePage(),
                ],
              ),
            ),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                _pageController.jumpToPage(value);
              },
              currentIndex: _currentIndex,
              selectedItemColor: Colors.teal.shade700,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.send),
                  label: "HttpTeste",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.access_alarms),
                  label: "Alarms",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.work_history_rounded),
                  label: "Tarefas",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
