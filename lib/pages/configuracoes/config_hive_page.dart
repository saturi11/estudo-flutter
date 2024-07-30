import 'package:flutter/material.dart';
import 'package:trilhaapp/model/config_model.dart';
import 'package:trilhaapp/repositories/config_repository.dart';

class ConfigHivePage extends StatefulWidget {
  const ConfigHivePage({super.key});

  @override
  State<ConfigHivePage> createState() => _ConfigHivePageState();
}

class _ConfigHivePageState extends State<ConfigHivePage> {
  late ConfigRepository repository;
  ConfigModel configModel = ConfigModel.vazio();

  TextEditingController nomeController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    repository = await ConfigRepository.load();
    configModel = repository.carregar();

    nomeController.text = configModel.nome;
    alturaController.text = configModel.altura.toString();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configurações com Hive'),
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
                value: configModel.modoEscuro,
                onChanged: (bool value) {
                  setState(() {
                    configModel.modoEscuro = value;
                  });
                },
              ),
              _buildSwitchListTile(
                title: 'Receber notificações',
                value: configModel.notificacoes,
                onChanged: (bool value) {
                  setState(() {
                    configModel.notificacoes = value;
                  });
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            configModel.nome = nomeController.text;
            configModel.altura = double.tryParse(alturaController.text) ?? 0;

            repository.salvar(configModel);

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
