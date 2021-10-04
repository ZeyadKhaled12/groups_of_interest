import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaito/functions/group_setting_fun.dart';
import 'package:kaito/functions/make_group_fun.dart';

class GroupstChangeImage extends StatefulWidget {

  final String titleGroup;
  GroupstChangeImage(this.titleGroup);


  @override
  _GroupstChangeImageState createState() => _GroupstChangeImageState();
}

class _GroupstChangeImageState extends State<GroupstChangeImage> {


  GroupSettingFun _groupSettingFun = new GroupSettingFun();
  bool _isLoading = false;

  late var _image = File('text');
  final picker = ImagePicker();

  Future getImage(ImageSource src) async {
    final pickedFile =
        await picker.pickImage(source: src, maxWidth: 340, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });

    return pickedFile?.path;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.yellowAccent)),
                )
              : _image.path == 'text'
                  ? Text(
                      '',
                    )
                  : Image.file(
                      _image,
                      fit: BoxFit.cover,
                    ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: _isLoading
                ? Colors.grey.withOpacity(0)
                : Colors.grey.withOpacity(0.5),
          ),
          width: 340,
          height: 200,
        ),
        Padding(padding: EdgeInsets.only(bottom: 3)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
              width: 80,
              child: IconButton(
                highlightColor: Colors.white,
                icon: Icon(Icons.camera_alt,
                    size: 48, color: Colors.yellowAccent.withOpacity(0.8)),
                onPressed: () async {
                  await getImage(ImageSource.camera).then((value) async {
                    await ImageCropper.cropImage(
                        sourcePath: value,
                        aspectRatio: CropAspectRatio(ratioX: 340, ratioY: 200),
                        aspectRatioPresets: [CropAspectRatioPreset.square],
                        androidUiSettings: AndroidUiSettings(
                          initAspectRatio: CropAspectRatioPreset.original,
                          lockAspectRatio: false,
                          cropFrameColor: Colors.yellowAccent,
                          toolbarColor: Colors.yellowAccent,
                          activeControlsWidgetColor:
                              Theme.of(context).textTheme.bodyText1?.color,
                        )).then((value) {
                      setState(() {
                        _image = File('${value?.path}');
                      });
                    });
                  });
                },
              ),
            ),
            Padding(padding: EdgeInsets.all(20)),
            SizedBox(
              height: 80,
              width: 80,
              child: IconButton(
                highlightColor: Colors.white,
                icon: Icon(
                  Icons.photo,
                  size: 48,
                  color: Colors.yellowAccent.withOpacity(0.8),
                ),
                onPressed: () async {
                  await getImage(ImageSource.gallery).then((value) async {
                    await ImageCropper.cropImage(
                        sourcePath: value,
                        aspectRatio: CropAspectRatio(ratioX: 340, ratioY: 200),
                        aspectRatioPresets: [CropAspectRatioPreset.square],
                        androidUiSettings: AndroidUiSettings(
                          initAspectRatio: CropAspectRatioPreset.original,
                          lockAspectRatio: false,
                          cropFrameColor: Colors.yellowAccent,
                          toolbarColor: Colors.yellowAccent,
                          activeControlsWidgetColor:
                              Theme.of(context).textTheme.bodyText1?.color,
                        )).then((value) {
                      setState(() {
                        _image = File('${value?.path}');
                      });
                    });
                  });
                },
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(bottom: 3)),
        SizedBox(
          width: 340,
          child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              color: Colors.yellowAccent.withOpacity(0.8),
              onPressed:() async{
                if( _image.path != 'text'){

                  setState(() {
                    _isLoading = true;
                  });
                  print('\n\n\n\n\n\n\n\nWE ARE HERE\n\n\n\n\n\n\n\n\n');
                  String url = await _groupSettingFun.uploadImage(context, widget.titleGroup, _image);
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Submit',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'comfortaa'))),
        )
      ],
    );
  }
}
