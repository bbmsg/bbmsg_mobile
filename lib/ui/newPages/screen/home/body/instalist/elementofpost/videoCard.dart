import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

class VideoCard extends StatefulWidget {
  final String videoname;
  VideoCard(this.videoname, {Key key}) : super(key: key);

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController _contrl;
  @override
  void initState() {
    super.initState();
    _contrl = VideoPlayerController.network(widget.videoname);
    _contrl.addListener(() {
      setState(() {});
    });
    _contrl.setLooping(true);
    _contrl.initialize();
  }

  @override
  void dispose() {
    _contrl.dispose();
    super.dispose();
  }

  takeScreenShoot() async {
    RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile = new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
  }

  var scr = new GlobalKey();
// RepaintBoundary(
//          key: scr,
//          child: new FlutterLogo(size: 50.0,))
  takescrshot() async {
    RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
  }

  Color newcolor = Colors.white;

  TextEditingController contentcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueAccent,
      // padding: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: _contrl.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(_contrl),
            ClosedCaption(text: _contrl.value.caption.text),
            _PlayPauseOverlay(controller: _contrl),
            VideoProgressIndicator(_contrl, allowScrubbing: true),
          ],
        ),
      ),

      //   ],
      // ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);
  final VideoPlayerController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
        InkWell(
          onTap: () {
             controller.value.isPlaying ? controller.pause() : controller.play();
          },
                  child: AnimatedSwitcher(
            duration: Duration(milliseconds: 50),
            reverseDuration: Duration(milliseconds: 200),
            child: controller.value.isPlaying
                ? SizedBox.shrink()
                : Container(
                    color: Colors.black26,
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 100.0,
                      ),
                    ),
                  ),
          ),
        ),
       
       
    );
  }
}



  // Padding(
  //             padding: EdgeInsets.only(top: 5),
  //             child: Flexible(
  //               child: TextField(
  //                 controller: contentcontroller,
  //                 style: TextStyle(color: Colors.white),
  //                 decoration: InputDecoration(
  //                     // filled: true,
  //                     fillColor: Colors.white,
  //                     hintText: 'add comment here',
  //                     hintStyle: TextStyle(color: Colors.white)),
  //               ),
  //             )),
  //         Padding(
  //             padding: EdgeInsets.only(top: 250),
  //             child: Flexible(
  //               child: ListView.builder(
  //                 itemCount: 10,
  //                 scrollDirection: Axis.horizontal,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return Draggable<String>(
  //                     onDragStarted: () {
  //                       print("onDragStarted");
  //                     },
  //                     data: newcolor.toString(),
  //                     childWhenDragging: Container(
  //                       //  color: newcolor,
  //                       width: 50,
  //                       height: 50,
  //                     ),
  //                     feedback: Container(
  //                       width: 50,
  //                       height: 50,
  //                     ),
  //                     child: Container(
  //                         // color: newcolor,
  //                         width: 50,
  //                         height: 50,
  //                         padding: EdgeInsets.only(left: 5),
  //                         child: Image.asset('assets/ico/$index.gif')),
  //                   );
  //                 },
  //               ),
  //             ))