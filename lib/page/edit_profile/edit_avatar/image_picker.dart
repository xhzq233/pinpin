import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinpin/component/header/blue_static_header.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';

class ImagePickerWidget extends StatefulWidget {

  const ImagePickerWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<ImagePickerWidget> {
  var _imgPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // const PPNavigationBar(title: "ImagePicker"),
              _ImageView(_imgPath),
              HoldActiveButton(
                onPressed: _takePhoto,
                builder: (_) => const Text("拍照"),
              ),
              HoldActiveButton(
                onPressed: _openGallery,
                builder: (_) => const Text("选择照片"),
              ),
            ],
          ),
        ));
  }

  /*图片控件*/
  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return const Center(
        child: Text("请选择图片或拍照"),
      );
    } else {
      return Image.file(
        imgPath,
      );
    }
  }


  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _imgPath = image;
    });
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
  }
}


