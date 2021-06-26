import 'package:catalogoapp/common/custom_drawer/custom_drawer_header.dart';
import 'package:catalogoapp/common/custom_drawer/drawer_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              const Divider(),
              DrawerTile(iconData: Icons.home, title: "Inicio", page: 0,),
              DrawerTile(iconData: Icons.list, title: "Produtos", page: 1,),
              DrawerTile(iconData: Icons.playlist_add_check, title: "Meus pedidos", page: 2,),
              DrawerTile(iconData: Icons.location_on, title: "Lojas", page: 3,),
            ],
          ),
        ],
      ),
    );
  }
}
