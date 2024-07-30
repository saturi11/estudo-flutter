import 'package:flutter/material.dart';
import 'package:trilhaapp/service/app_storage.dart';

class ConfigSharedPage extends StatefulWidget {
  const ConfigSharedPage({super.key});

  @override
  State<ConfigSharedPage> createState() => _ConfigSharedPageState();
}

class _ConfigSharedPageState extends State<ConfigSharedPage> {
  AppStorage storage = AppStorage();

  String? nome;
  double? altura;
  bool? notificacoes = false;
  bool? modoEscuro = false;

  TextEditingController nomeController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    nome = await storage.getNome() ?? '';
    altura = await storage.getAltura() ?? 0;
    notificacoes = await storage.getNotificacoes();
    modoEscuro = await storage.getModoEscuro();

    nomeController.text = nome ?? '';
    alturaController.text = altura?.toString() ?? '';
    setState(() {});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildTextField(
                controller: nomeController,
                labelText: 'Nome usuário',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: alturaController,
                labelText: 'Altura',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildSwitchListTile(
                title: 'Modo Escuro',
                value: modoEscuro ?? false,
                onChanged: (bool value) {
                  setState(() {
                    modoEscuro = value;
                  });
                },
              ),
              _buildSwitchListTile(
                title: 'Receber notificações',
                value: notificacoes ?? false,
                onChanged: (bool value) {
                  setState(() {
                    notificacoes = value;
                  });
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            storage.setNome(nomeController.text);
            storage.setAltura(double.tryParse(alturaController.text) ?? 0);
            storage.setNotificacoes(notificacoes!);
            storage.setModoEscuro(modoEscuro!);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Dados salvos com sucesso'),
            ));
            Navigator.pop(context);
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontSize: 20)),
      value: value,
      onChanged: onChanged,
    );
  }
}
