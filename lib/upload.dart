import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ImageUpload();
  }
}

class _ImageUpload extends State<ImageUpload> {
  final ImagePicker _picker = ImagePicker();
  File? uploadimage;
  Future<void> chooseImage() async {
    var choosedimage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }

  Future<void> uploadImage() async {
    var uploadurl = Uri.parse('your api url');
    try {
      List<int> imageBytes = uploadimage!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var response = await http.post(uploadurl, body: {
        'image': baseimage,
      });
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        if (jsondata["error"]) {
          print(jsondata["msg"]);
        } else {
          print(jsondata['msg']);
        }
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print("Error during converting to Base64");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Upload Image to Server"),
        ),
        backgroundColor: Color.fromARGB(255, 147, 64, 255),
      ),
      body: Container(
        height: 300,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: uploadimage == null
                    ? Container()
                    : SizedBox(height: 150, child: Image.file(uploadimage!))),
            Container(
                child: uploadimage == null
                    ? Container()
                    : ElevatedButton.icon(
                        onPressed: () {
                          uploadImage();
                        },
                        icon: const Icon(Icons.file_upload),
                        label: const Text("UPLOAD IMAGE"),
                      )),
            ElevatedButton.icon(
              onPressed: () {
                chooseImage();
              },
              icon: const Icon(Icons.folder_open),
              label: const Text("CHOOSE IMAGE"),
            )
          ],
        ),
      ),
    );
  }
}
