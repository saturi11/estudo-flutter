import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/configuracoes/config_hive_page.dart';
import 'package:trilhaapp/pages/heros.dart';
import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/numeros_aleatorios/numeros_aleatorios_page_Hive.dart';
import 'package:trilhaapp/pages/post_page.dart';
import 'package:trilhaapp/pages/tarefa/tarefa_page_http.dart';

import '../../pages/dados_cadastrais/dados_cadastrais_hive.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                context: context,
                builder: (BuildContext bc) {
                  return Wrap(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text("Camera"),
                        leading: const Icon(Icons.camera),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text("Galeria"),
                        leading: const Icon(Icons.image),
                      ),
                    ],
                  );
                },
              );
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.teal.shade700, // Cor principal
                    Colors.teal.shade900, // Cor secundária mais escura
                  ],
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://pbs.twimg.com/media/FnUFi3yXwAcL-uz.jpg:large"),
              ),
              accountName: const Text(
                "Gabriel Saturi",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: const Text(
                "Gabrielsaturi@email.com",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          _createDrawerItem(
            icon: Icons.person,
            text: 'Dados Cadastrais',
            onTap: () => _navigateTo(context, DadosCadastraisHive()),
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.settings,
            text: 'Configurações',
            onTap: () => _navigateTo(context, const ConfigHivePage()),
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.numbers,
            text: 'Gerador de números aleatórios',
            onTap: () =>
                _navigateTo(context, const NumerosAleatoriosHivePage()),
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.privacy_tip,
            text: 'Termos de uso e privacidade',
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      "Nunca é demais lembrar o peso e o significado destes problemas, uma vez que a mobilidade dos capitais internacionais deve passar por modificações independentemente dos relacionamentos verticais entre as hierarquias. O que temos que ter sempre em mente é que a percepção das dificuldades pode nos levar a considerar a reestruturação dos métodos utilizados na avaliação de resultados. Evidentemente, o comprometimento entre as equipes exige a precisão e a definição da gestão inovadora da qual fazemos parte. A nível organizacional, a competitividade nas transações comerciais prepara-nos para enfrentar situações atípicas decorrentes das diversas correntes de pensamento.",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              );
            },
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.post_add,
            text: 'Posts',
            onTap: () => _navigateTo(context, const PostPage()),
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.power,
            text: 'Heróis',
            onTap: () => _navigateTo(context, const HerosPage()),
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.http,
            text: 'Tarefas Http',
            onTap: () => _navigateTo(context, const TarefaHttpPage()),
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Sair',
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext) {
                  return AlertDialog(
                    alignment: Alignment.center,
                    title: const Text("Deseja realmente sair?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text("Sair"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 20),
            Flexible(child: Text(text, style: const TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
