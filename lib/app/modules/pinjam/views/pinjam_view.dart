import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_perpustakaan/app/routes/app_pages.dart';
import '../controllers/pinjam_controller.dart';

class PinjamView extends GetView<PinjamController> {
  const PinjamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Obx(
            () => Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(color: Colors.white),
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 1000),
                firstChild: MyPinjam(
                  controller: controller,
                ),
                secondChild: MyPinjamTrue(controller: controller),
                crossFadeState: controller.sucsesPeminjaman.value == false
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPinjam extends StatelessWidget {
  const MyPinjam({super.key, required this.controller});
  final PinjamController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Pinjam",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      overflow: TextOverflow.visible,
                      fontFamily:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600)
                              .fontFamily,
                      fontSize: 17.0,
                      color: const Color(0xFF000000),
                    ),
                  )
                ],
              ),
            )),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox.expand(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          controller.addPinjam();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF36969d),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.000000),
                          ),
                        ),
                        child: controller.loading.value
                            ? const CircularProgressIndicator()
                            : Text(
                                'PINJAM',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: GoogleFonts.baloo2(
                                            fontWeight: FontWeight.bold)
                                        .fontFamily),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          top: 70,
          left: 20,
          right: 20,
          bottom: 50,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Image.asset(
                  "assets/bg-buku.png",
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 100,),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              height: 120,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(controller
                                          .detailbookController
                                          .detailBuku
                                          .value
                                          .coverBuku
                                          .toString()),
                                      fit: BoxFit.fill)),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    controller
                                        .detailbookController.detailBuku.value.judulBuku
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700)
                                            .fontFamily,
                                        fontSize: 20),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 5),
                                Text(
                                    "Penulis : ${controller.detailbookController.detailBuku.value.penulisBuku.toString()}",
                                    style: TextStyle(
                                        fontFamily: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600)
                                            .fontFamily,
                                        fontSize: 17),
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis),
                                Text(
                                    "Penerbit : ${controller.detailbookController.detailBuku.value.penerbitBuku.toString()}",
                                    style: TextStyle(
                                        fontFamily: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600)
                                            .fontFamily,
                                        fontSize: 17),
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis),
                                Text(
                                    "Tahun Terbit : ${controller.detailbookController.detailBuku.value.tahunTerbit.toString()}",
                                    style: TextStyle(
                                        fontFamily: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600)
                                            .fontFamily,
                                        fontSize: 17),
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Text("Nama Peminjam : ${controller.username}",
                            style: TextStyle(
                                fontFamily:
                                    GoogleFonts.poppins(fontWeight: FontWeight.w500)
                                        .fontFamily,
                                fontSize: 17),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Text("Tanggal Pinjam : ${controller.day} - ${controller.month} - ${controller.year}",
                            style: TextStyle(
                                fontFamily:
                                    GoogleFonts.poppins(fontWeight: FontWeight.w500)
                                        .fontFamily,
                                fontSize: 17),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Text("Tanggal Kembali : ${controller.dayAfter} - ${controller.monthAfter} - ${controller.yearAfter}",
                            style: TextStyle(
                                fontFamily:
                                    GoogleFonts.poppins(fontWeight: FontWeight.w500)
                                        .fontFamily,
                                fontSize: 17),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ),      
              const SizedBox(height: 100,)
            ],
          ),
        ),
      ],
    );
  }
}

class MyPinjamTrue extends StatelessWidget {
  const MyPinjamTrue({super.key, required this.controller});
  final PinjamController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF36969d),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.000000),
                        ),
                      ),
                      child: Text(
                        'Kembali ke Halaman Buku',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily:
                                GoogleFonts.baloo2(fontWeight: FontWeight.bold)
                                    .fontFamily),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          top: 0,
          left: 20,
          right: 20,
          bottom: 50,
          child:  Column(
                children: [

                  const SizedBox(
                    height: 30,
                  ),

                  FittedBox(
                    child: Text(
                      'Peminjaman Buku Berhasil',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          letterSpacing: -0.3,
                          fontSize: 20.0,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.010,
                  ),

                  Divider(
                    color: Colors.black.withOpacity(0.10),
                    thickness: 1,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.020,
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        controller.detailbookController.detailBuku.value.judulBuku.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF41B54A),
                            fontSize: 36.0
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.030,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Tanggal Peminjaman', " ${controller.day} - ${controller.month} - ${controller.year}"
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),

                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Deadline Peminjaman',  "${controller.dayAfter} - ${controller.monthAfter} - ${controller.yearAfter}"
                        ),
                      ),
                    ],
                  ),



                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.040,
                  ),

                  Divider(
                    color: Colors.black.withOpacity(0.10),
                    thickness: 1,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.030,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Nama Peminjam',  "${controller.username}"
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Nama Buku', controller.detailbookController.detailBuku.value.judulBuku.toString(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Penulis Buku', controller.detailbookController.detailBuku.value.penulisBuku.toString(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Tahun Terbit', controller.detailbookController.detailBuku.value.tahunTerbit.toString(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.040,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          'Note:',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                              fontSize: 20.0
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),

                      FittedBox(
                        child: Text(
                          'Harap kembalikan buku tepat waktu. Terima kasih.',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF41B54A),
                              fontSize: 14.0
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.055,
                  ),

                  kontenButton(
                          (){
                        
                          Get.offAllNamed(Routes.DASHBOARD); // Navigasi ke halaman detail buku
                        
                      },
                      Text(
                        'Kembali ke Beranda',
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      100.0,
                      const Color(0xFF41B54A)
                  ),
                ],
              ),),
      ],
    );
  }
}

  Widget kontenBuktiPeminjaman(String judul, String isi){
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              judul,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: 16.0
              ),
            ),
          ),

          FittedBox(
            child: Text(
              isi,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16.0
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget kontenButton(final onPressed,final Widget child,
      final double radius,
      final Color buttonColor,){
    const Color borderColor = Color(0xFF424242);
    return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)
            ),
            side: const BorderSide(
              color: borderColor, // Warna border (stroke)
              width: 0.03, // Lebar border (stroke)
            ),
          ),
          onPressed: onPressed,
          child: child,
        )
    );
  }

