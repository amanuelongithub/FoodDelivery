import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/components/default_button.dart';
import 'package:fooddelivery/components/textfields.dart';
import 'package:fooddelivery/service/firestore.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/dimension.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import '../provider/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../utils/utils.dart';

class EditCard extends StatefulWidget {
  final snap;
  const EditCard({super.key, this.snap});

  @override
  State<EditCard> createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  Uint8List? _file;

  @override
  Widget build(BuildContext context) {
    TextEditingController fullnamecontroller = TextEditingController();
    TextEditingController usernamecontroller = TextEditingController();

    @override
    void dispose() {
      fullnamecontroller.dispose();
      usernamecontroller.dispose();
      super.dispose();
    }

    @override
    void initState() {
      super.initState();
      fullnamecontroller = TextEditingController(text: widget.snap['fullName']);
      usernamecontroller = TextEditingController(text: widget.snap['username']);
    }

    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";

    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));

    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isDark == 'dark'
              ? Color.fromARGB(147, 78, 78, 78)
              : Color.fromARGB(255, 217, 217, 217)),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin:
            EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfile(isDark),
            // buildInput('Full name', fullnamecontroller.text),
            Text(
              "Full name",
              style: TextStyle(
                  fontSize: Dimensions.font18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Dimensions.height10),

            Container(
              margin: EdgeInsets.only(left: Dimensions.width30),
              child: TextFormField(
                // controller: fullnamecontroller,
                initialValue: widget.snap['fullName'] ?? '',
                showCursor: true,
                cursorColor: Color.fromARGB(151, 102, 78, 4),
                enableInteractiveSelection: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: inputBorder,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 126, 126, 126), width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  fullnamecontroller.text = value;
                },
              ),
            ),

            SizedBox(
              height: Dimensions.height20,
            ),
            Text(
              "User name",
              style: TextStyle(
                  fontSize: Dimensions.font18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Dimensions.height10),

            Container(
              margin: EdgeInsets.only(left: Dimensions.width30),
              child: TextFormField(
                // controller: usernamecontroller,
                initialValue: widget.snap['username'] ?? '',
                showCursor: true,
                cursorColor: Color.fromARGB(151, 102, 78, 4),
                enableInteractiveSelection: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: inputBorder,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 126, 126, 126), width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  usernamecontroller.text = value;
                },
                keyboardType: TextInputType.name,
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            // buildInput('User name', usernamecontroller.text),

            const Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DefaultButton(
                    press: () {},
                    text: 'clear',
                    primcolor: AppColors.seccolor,
                    width: Dimensions.width120,
                    hight: Dimensions.height40,
                  ),
                  DefaultButton(
                    press: () async {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.maincolor),
                              ));

                      String fullname =
                          fullnamecontroller.text.toString() == null
                              ? widget.snap['fullName']
                              : fullnamecontroller.text.toString();
                      String username =
                          usernamecontroller.text.toString() == null
                              ? widget.snap['username']
                              : usernamecontroller.text.toString();
                      print("&&&&&&&&&&&&&&&&&&&&&");
                      print(fullname);
                      print(
                        username,
                      );
                      String res = await FireStoreMethods().updateUserProfile(
                        fullName: fullname,
                        userName: username,
                        file: _file,
                      );
                      print(res);

                      navigatorKey.currentState!
                          .popUntil((rout) => rout.isFirst);
                      Get.offAllNamed('/');
                    },
                    text: 'save',
                    width: Dimensions.width120,
                    hight: Dimensions.height40,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

/*
  Widget buildInput(String label, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        SizedBox(height: Dimensions.height10),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: DefaultTextField(
              textEditingController: TextEditingController(text: name),
              hintText: "",
              keyboardType: TextInputType.name),
        ),
      ],
    );
  }
  
  */

  Widget buildProfile(String isDark) {
    return Align(
      alignment: Alignment.center,
      child: Stack(children: [
        CircleAvatar(
            radius: 60,
            child: _file == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.snap['userProfile'],
                      fit: BoxFit.contain,
                      width: double.maxFinite,
                      height: 220,
                      errorWidget: (context, url, error) => SizedBox(
                        height: double.infinity,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                    text: '!',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.red)),
                                TextSpan(
                                    text: 'Unable to load image',
                                    style: TextStyle(
                                      color: isDark == "dark"
                                          ? Colors.white
                                          : Color.fromARGB(221, 49, 49, 49),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: MemoryImage(_file!), fit: BoxFit.cover),
                        border: Border.all(
                            color: Color.fromARGB(255, 126, 126, 126))),
                  )),
        Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Color.fromARGB(134, 255, 193, 7),
              child: InkWell(
                onTap: () => _selectImag(context),
                child: Icon(
                  Icons.add_a_photo,
                  size: 20,
                  color: isDark == 'dark'
                      ? Color.fromARGB(255, 235, 235, 235)
                      : Color.fromARGB(222, 0, 0, 0),
                ),
              ),
            ))
      ]),
    );
  }

  _selectImag(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: const Text('Change Profile'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
