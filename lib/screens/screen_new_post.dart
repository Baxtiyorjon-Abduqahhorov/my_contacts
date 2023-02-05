import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_contacts/api/api.dart';

class ScreenNewPost extends StatefulWidget {
  ScreenNewPost({super.key});

  @override
  State<ScreenNewPost> createState() => _ScreenNewPostState();
}

class _ScreenNewPostState extends State<ScreenNewPost> {
  TextEditingController captionController = TextEditingController();
  XFile? xfile1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Container(
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12)),
                child: xfile1 != null
                    ? ClipRRect(
                        child: Image.file(
                          File(xfile1!.path),
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: TextField(
              maxLines: 5,
              controller: captionController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue))),
            ),
          ),
          GestureDetector(
            onTap: () async {
              xfile1 =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (xfile1 != null) {
                setState(() {});
              }
            },
            child: Container(
              height: 45,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xFFFF003D),
                  borderRadius: BorderRadius.circular(5)),
              child: const Text(
                "Pick Image",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              if (captionController.text.isNotEmpty) {
                log('jhjhjhujh');
                Api().createPost(Hive.box("boxToken").get("token"),
                    captionController.text, xfile1 == null ? "" : xfile1!.path);
              }
            },
            child: Container(
              height: 45,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xFFFF003D),
                  borderRadius: BorderRadius.circular(5)),
              child: const Text(
                "Upload",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          )
        ],
      )),
    );
  }
}
