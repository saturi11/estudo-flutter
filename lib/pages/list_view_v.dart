import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/widgets/app_images.dart';

class ListViewV extends StatelessWidget {
  const ListViewV({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset(AppImages.user1),
          title: Text("User 1"),
          subtitle: Text("SPFC"),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {},
            itemBuilder: (BuildContext bc) {
              return [
                PopupMenuItem(
                  child: Text("Editar"),
                  value: "Editar",
                ),
                PopupMenuItem(
                  child: Text("Excluir"),
                  value: "Excluir",
                ),
              ];
            },
          ),
          isThreeLine: true,
        ),
        ListTile(
          leading: Image.asset(AppImages.user2),
          title: Text("User 2"),
          subtitle: Text("SPFC"),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {},
            itemBuilder: (BuildContext bc) {
              return [
                PopupMenuItem(
                  child: Text("Editar"),
                  value: "Editar",
                ),
                PopupMenuItem(
                  child: Text("Excluir"),
                  value: "Excluir",
                ),
              ];
            },
          ),
          isThreeLine: true,
        ),
        ListTile(
          leading: Image.asset(AppImages.user3),
          title: Text("User 3"),
          subtitle: Text("SPFC"),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {},
            itemBuilder: (BuildContext bc) {
              return [
                PopupMenuItem(
                  child: Text("Editar"),
                  value: "Editar",
                ),
                PopupMenuItem(
                  child: Text("Excluir"),
                  value: "Excluir",
                ),
              ];
            },
          ),
          isThreeLine: true,
        ),
        ListTile(
          leading: Image.asset(AppImages.user4),
          title: Text("User 4"),
          subtitle: Text("SPFC"),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {},
            itemBuilder: (BuildContext bc) {
              return [
                PopupMenuItem(
                  child: Text("Editar"),
                  value: "Editar",
                ),
                PopupMenuItem(
                  child: Text("Excluir"),
                  value: "Excluir",
                ),
              ];
            },
          ),
          isThreeLine: true,
        ),
      ],
    );
  }
}
