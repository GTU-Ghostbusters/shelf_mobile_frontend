import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelf_mobil_frontend/types/enums.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../screens/select_photo.dart';
import '../types/category.dart';
import 'account_page.dart';

class ShareBookPage extends StatefulWidget {
  const ShareBookPage({super.key});

  @override
  State<ShareBookPage> createState() => _ShareBookPageState();
}

class _ShareBookPageState extends State<ShareBookPage> {
  final List<Category> _categories =
      Category.getCategoryListAlphabeticSorted().sublist(1);
  Category? _selectedCategory;
  CargoPaymentType _cargoPaymentType = CargoPaymentType.senderPays;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  Future _pickImages(ImageSource source) async {
    if (source == ImageSource.camera) {
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;
        setState(() {
          imageFileList.add(image);
        });
      } on Exception {
        Navigator.of(context).pop();
      }
    } else {
      final List<XFile> selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        if (selectedImages.length <= 3 &&
            imageFileList.length + selectedImages.length <= 3) {
          imageFileList.addAll(selectedImages);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                    child: const Text("Close"))
              ],
              title: const Text("Number of Images"),
              contentPadding: const EdgeInsets.all(20),
              content: const Text("You can add maximum 3 images."),
            ),
          );
        }
        setState(() {});
      }
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImages,
              ),
            );
          }),
    );
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController numberOfPages = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AccountPage.isUserLogged() == false
        ? const AccountPage()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: const Text("SHARE BOOK"), centerTitle: true),
            body: Container(
              height: double.infinity,
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  tileMode: TileMode.mirror,
                  colors: [
                    Color.fromARGB(60, 255, 131, 220),
                    Color.fromARGB(60, 246, 238, 243),
                    Color.fromARGB(60, 76, 185, 252),
                  ],
                ),
              ),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      imageFileList.isEmpty
                          ? uploadButton()
                          : showSelectedImages(),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (name) {
                          if (name!.length < 5) {
                            return 'Book name must consist of at least 5 characters.';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.menu_book),
                          labelText: "Book Name",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please enter book name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        validator: (name) {
                          if (name!.length < 5) {
                            return 'Author name must consist of at least 5 characters.';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.person),
                          labelText: "Author Name",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please enter author name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: numberOfPages,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.numbers),
                          labelText: "Number Of Pages",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please enter number of pages",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<Category>(
                        value: _selectedCategory,
                        items: _categories
                            .map(
                              (item) => DropdownMenuItem<Category>(
                                value: item,
                                child: Text(item.title),
                              ),
                            )
                            .toList(),
                        onChanged: (item) =>
                            setState(() => _selectedCategory = item),
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.type_specimen),
                          labelText: " Category",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please choose category of book",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        maxLength: 300,
                        maxLines: 4,
                        minLines: 1,
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.text_snippet_rounded),
                          labelText: "Details of book",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: "Please enter details of book",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(10, 0, 0, 0),
                          border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(200, 37, 37, 37),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 5),
                            Icon(
                              Icons.local_shipping,
                              size: MediaQuery.of(context).size.width * 0.075,
                              color: const Color.fromARGB(200, 37, 37, 37),
                            ),
                            const SizedBox(width: 5),
                            ToggleSwitch(
                              initialLabelIndex: _cargoPaymentType ==
                                      CargoPaymentType.senderPays
                                  ? 0
                                  : 1,
                              cornerRadius: 5,
                              fontSize: 16,
                              borderWidth: 0,
                              activeFgColor: Colors.white,
                              activeBgColor: [Theme.of(context).primaryColor],
                              inactiveFgColor:
                                  const Color.fromARGB(200, 37, 37, 37),
                              inactiveBgColor: Colors.white,
                              totalSwitches: 2,
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.33,
                              labels: const ['Sender', 'Receiver'],
                              onToggle: (index) {
                                setState(() {
                                  _cargoPaymentType ==
                                          CargoPaymentType.senderPays
                                      ? _cargoPaymentType =
                                          CargoPaymentType.receiverPays
                                      : _cargoPaymentType =
                                          CargoPaymentType.senderPays;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                          onPressed: (() {}), child: const Text("UPLOAD")),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget uploadButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _showSelectPhotoOptions(context);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          borderOnForeground: true,
          color: const Color.fromARGB(240, 255, 255, 255),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                maxLines: 2,
                textAlign: TextAlign.center,
                "UPLOAD BOOK IMAGES",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.visible),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const Icon(Icons.add_photo_alternate_outlined, size: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget showSelectedImages() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(10, 0, 0, 0),
        border:
            Border.all(color: const Color.fromARGB(200, 37, 37, 37), width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageFileList.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.012,
                          vertical: 5),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.24,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0))),
                      child: Image.file(
                        File(imageFileList[index].path),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            imageFileList.removeAt(index);
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(240, 255, 255, 255),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child:
                              const Icon(Icons.remove_circle_outline, size: 22),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 3),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: imageFileList.length < 3
                      ? MaterialStatePropertyAll(Theme.of(context).primaryColor)
                      : MaterialStatePropertyAll(Colors.grey.shade600)),
              onPressed: (() {
                imageFileList.length < 3
                    ? _showSelectPhotoOptions(context)
                    : null;
              }),
              child: const Icon(Icons.add_a_photo_rounded)),
        ],
      ),
    );
  }
}
