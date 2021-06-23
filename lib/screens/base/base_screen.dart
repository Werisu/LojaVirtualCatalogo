import 'package:catalogoapp/common/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: const Text("Luah's"),
          ),
        ),
        Container(color: Colors.red,),
        Container(color: Colors.yellow),
        Container(color: Colors.green),
      ],
    );
  }
}
