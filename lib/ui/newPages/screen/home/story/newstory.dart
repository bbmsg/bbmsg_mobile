import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/elementofpost/videoCard.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/headappbars/head_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_editor_pro/image_editor_pro.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Newstory extends StatefulWidget {
  Newstory({Key key}) : super(key: key);

  @override
  _NewstoryState createState() => _NewstoryState();
}

class _NewstoryState extends State<Newstory> {
  File pickedImages;
  PickedFile savvideo;
  String base64Image;
  final ImagePicker picker = ImagePicker();
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  getvideodata(BuildContext context) async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Select the Video source"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallery"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imageSource != null) {
      savvideo = await picker.getVideo(
          source: imageSource, maxDuration: const Duration(seconds: 100));
      print('images is full');

      // if (savvideo != null) {
      //   pickedImages = File(savvideo.path);
      setState(() {});
      // }
    }
  }

  Future<void> getimageditor() {
    final geteditimage =
        Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ImageEditorPro(
        appBarColor: Colors.blue,
        bottomBarColor: Colors.blue,
      );
    })).then((geteditimage) {
      if (geteditimage != null) {
        setState(() {
          _image = geteditimage;
        });
      }
    }).catchError((er) {
      print(er);
    });
  }

  bool dialVisible = true;
  int imagorvideo = 1;

  File _image;
  TextEditingController contentcontroller = new TextEditingController();

  int gridcount = 0;
  Widget buildGridView() {
    if (images.length > 1) {
      gridcount = 2;
    } else {
      gridcount = 1;
    }

    return Stack(
      children: [
        Container(
          height: 500,
          width: double.infinity,
          child: VideoCard(savvideo.path),
        ),
        Padding(
            padding: EdgeInsets.only(top: 5),
            child: Flexible(
              child: TextField(
                controller: contentcontroller,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    // filled: true,

                    fillColor: Colors.white,
                    hintText: 'add comment here',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            )),
        Padding(
            padding: EdgeInsets.only(top: 250),
            child: Flexible(
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.only(left: 5),
                      child: Image.asset('assets/ico/$index.gif'));
                },
              ),
            ))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds:5 )).then((value) {
      getimageditor();
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Image Editor Pro example'),
        // ),
        appBar: Headbar('Story', 1),
        floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.list_view,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: dialVisible,
          // If true user is forced to close dial manually
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.camera_alt),
                backgroundColor: Colors.red,
                label: 'Video',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  setState(() {
                    imagorvideo = 2;
                    contentcontroller.clear();
                  });
                  getvideodata(context);
                }),
            SpeedDialChild(
              child: Icon(Icons.image),
              backgroundColor: Colors.blue,
              label: 'Image',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                setState(() {
                  imagorvideo = 1;
                  contentcontroller.clear();
                });
                savvideo = null;
                getimageditor();
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.send),
              backgroundColor: Colors.green,
              label: 'save',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                if (imagorvideo == 1) {
                  creatstory(_image, contentcontroller.text, true)
                      .then((value) {
                    getstory('30');
                  });
                } else {
                  //save video
                  creatstoryvideo(savvideo, contentcontroller.text, true)
                      .then((value) {
                    getstory('30');
                  });
                }
              },
            ),
          ],
        ),
        body: imagorvideo == 1
            ? Center(
                child: _image == null
                    ? Image.asset(
                        'assets/pngs/back2.jpg',
                        fit: BoxFit.fill,
                      )
                    : Image.file(_image),
              )
            : Center(
                child: Expanded(
                  child: buildGridView(),
                ),
              ));
  }
}
