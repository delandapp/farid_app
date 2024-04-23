import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_perpustakaan/app/data/models/response_bookmark_book.dart';
import 'package:e_perpustakaan/app/routes/app_pages.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final heightFullBody =
        MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: controller.obx(
        (state) => SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Obx(
              () => controller.dataBookmark.value
                  ? const Center(
                      child: Text("Tidak Ada Koleksi"),
                    )
                  : ListView.builder(
                      itemCount: controller.listKoleksi.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          onDismissed: (direction) async {
                            await controller.deleteKoleksi(
                                controller.listKoleksi[index].bukuID!.toInt());
                            if (controller.jumlahData.value == 0) {
                              await controller.getDataKoleksi();
                            }
                          },
                          confirmDismiss: (direction) {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Confirm'),
                                    content: Text('Are you sure to delete ?'),
                                    actions: [
                                      Obx(
                                        () => ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: controller.loading.value
                                                ? const CircularProgressIndicator()
                                                : const Text("Yes")),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text('No')),
                                    ],
                                  );
                                });
                          },
                          background: Container(
                            color: Colors.grey,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 10),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.amber,
                              size: 25,
                            ),
                          ),
                          key: Key(index.toString()),
                          // Mengatur geser dari kanan ke kiri saja
                          direction: DismissDirection.endToStart,
                          child: ContentKoleksi(
                            width: width,
                            heightFullBody: heightFullBody,
                            data: controller.listKoleksi[index],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContentKoleksi extends StatelessWidget {
  const ContentKoleksi({
    super.key,
    required this.width,
    required this.data,
    required this.heightFullBody,
  });

  final double width;
  final DataBookmark data;
  final double heightFullBody;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width,
      height: heightFullBody * 0.28,
      // margin: EdgeInsets.only(bottom: heightFullBody * 0.00),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.DETAILBOOK, parameters: {"idbook" : data.bukuID.toString()}),
         child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.01)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 125,
                            height: 165,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.40), // Ubah nilai opacity sesuai kebutuhan
                                  BlendMode.darken,
                                ),
                                child: AspectRatio(
                                  aspectRatio: 4 / 6,
                                  child: Image.network(
                                    data.coverBuku.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 10,
                            left: 5,
                            right: 5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.bookmarks,
                                    color: Colors.white,
                                    size: 18,
                                  ),

                                  const SizedBox(
                                    width: 3,
                                  ),

                                  Expanded(
                                    child: Text(
                                      'Saved',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.3,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.judul!,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Text(
                                    data.penulis!,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: const Color(0xFF41B54A),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Row(
                                    children: [
                                      const SizedBox(
                                        height: 3,
                                      ),

                                      Text(
                                        data.rating!.toStringAsFixed(1),
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      const SizedBox(
                                        width: 3,
                                      ),

                                      const Icon(
                                        Icons.star_border_outlined,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Wrap(
                                    children: data.kategori!.map((kategori) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 2.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: const Color(0xFFF5F5F5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                            child: Text(
                                              kategori,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w700,
                                                color: Colors
                                                    .black,
                                                letterSpacing: -0.3,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
    );
  }
}
