import 'package:e_perpustakaan/app/components/buildSection.dart';
import 'package:e_perpustakaan/app/components/navProfil.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final heightFullBody =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final widthFullBody = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("BERANDA"),
        backgroundColor: const Color(0XFF58CBA2),
      ),
      body: Container(
        color: Colors.white,
        width: widthFullBody,
        height: heightFullBody,
        child: controller.obx(
          (state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              navProfil(
                title: controller.sapaanBerdasarkanWaktu(),
                image: "assets/profil.png",
                icon: FontAwesomeIcons.bell,
                subtitle: controller.username.value.toString(),
              ),
              Expanded(
                child: buildSection(data: state!)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
