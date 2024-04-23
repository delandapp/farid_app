import 'package:e_perpustakaan/app/components/starRating.dart';
import 'package:e_perpustakaan/app/data/models/response_buku.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:e_perpustakaan/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class buildSection extends StatelessWidget {
  const buildSection({
    super.key,
    required this.data,
  });

  final List<DataBuku> data;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyBuku(data: data[index].buku!),
            const SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}

class MyBuku extends StatelessWidget {
  const MyBuku({super.key, required this.data});
  final List<Buku> data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final width = MediaQuery.of(Get.context!).size.width;
          final widthContainer = width - 50.0;
          return GestureDetector(
            onTap: () => Get.toNamed(Routes.DETAILBOOK,
                parameters: {"idbook": data[index].bukuID.toString()}),
            child: SizedBox(
              height: 180,
              width: MediaQuery.of(Get.context!).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    // Container dengan latar hitam dan konten buku
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 150,
                        width: widthContainer,
                        padding: const EdgeInsets.only(
                            left: 135, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF383838),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].judul!,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Penulis : ${data[index].penulis!}",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                data[index].deskripsi!,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Gambar di sebelah kiri (overlay)
                    Positioned(
                      left: 10,
                      top: 0,
                      bottom: 10,
                      child: Container(
                        width: 130,
                        height: 180,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(
                                      0.30), // Ubah nilai opacity sesuai kebutuhan
                                  BlendMode.darken,
                                ),
                                child: Image.network(
                                  data[index].coverBuku.toString(),
                                  width: 130,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              left: 5,
                              right: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.heart_broken,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'E-PERPUSTAKAAN',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 6,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
