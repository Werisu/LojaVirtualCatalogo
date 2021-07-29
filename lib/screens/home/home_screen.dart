import 'package:catalogoapp/common/custom_drawer/custom_drawer.dart';
import 'package:catalogoapp/models/home_manager.dart';
import 'package:catalogoapp/models/user_manager.dart';
import 'package:catalogoapp/screens/home/components/add_section_widget.dart';
import 'package:catalogoapp/screens/home/components/section_list.dart';
import 'package:catalogoapp/screens/home/components/section_staggered.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Color.fromARGB(255, 240, 230, 140)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text("Luah's Jóias"),
                  centerTitle: true,
                ),
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.pushNamed(context, '/cart'),
                  ),
                  Consumer2<UserManager, HomeManager>(
                    builder: (_, userManager, homeManager, __){
                      if(userManager.adminEnabled) {
                        if(homeManager.editing){
                          return PopupMenuButton(
                            onSelected: (e){
                              if(e == 'Salvar'){
                                homeManager.saveEditing();
                              }else{
                                homeManager.discardEditing();
                              }
                            },
                            itemBuilder: (_){
                              return ['Salvar', 'Descartar'].map((e) {
                                return PopupMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList();
                            }
                          );
                        }else{
                          return IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: homeManager.enterEditing,
                          );
                        }
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              ),
              Consumer<HomeManager>(
                builder: (_, homeManager, __){
                  final List<Widget>? children;
                  children = homeManager.sections.map<Widget>(
                    (section) {
                      switch(section.type){
                        case 'List':
                          return SectionList(section);
                        case 'Staggered':
                          return SectionStaggered(section);
                        default:
                          return Container();
                      }
                    }
                  ).toList();

                  if(homeManager.editing)
                    children.add(AddSectionWidget(homeManager));

                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
