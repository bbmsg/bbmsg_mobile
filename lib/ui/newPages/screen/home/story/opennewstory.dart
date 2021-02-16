// import 'package:bbmsg_mobile/backend/server.dart';
// import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/elementofpost/videoCard.dart';
// import 'package:bbmsg_mobile/ui/newPages/screen/home/headappbars/head_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:flutter/rendering.dart';
// import 'dart:ui' as ui;
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';

// class Opennewstory extends StatefulWidget {
//   Opennewstory({Key key}) : super(key: key);

//   @override
//   _OpennewstoryState createState() => _OpennewstoryState();
// }

// class _OpennewstoryState extends State<Opennewstory> {
//   int imagorvideo = 1;
//   GlobalKey _containerKey = GlobalKey();
//   Uint8List uInt8List;
//   File imagcapture;
//   Future<File> writeToFile(Uint8List data) async {
//     final buffer = data.buffer;
//     Directory tempDir = await getTemporaryDirectory();
//     String tempPath = tempDir.path;
//     var filePath =
//         tempPath + '/file_01.jpg'; // file_01.tmp is dump file, can be anything
//     // return new File(filePath).writeAsBytes(
//     //     buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
//     return new File(filePath).writeAsBytes(data);
//   }

//   void convertWidgetToImage() async {
//     RenderRepaintBoundary renderRepaintBoundary =
//         _containerKey.currentContext.findRenderObject();
//     ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);
//     ByteData byteData =
//         await boxImage.toByteData(format: ui.ImageByteFormat.png);
//     uInt8List = byteData.buffer.asUint8List();
//     imagcapture = await writeToFile(uInt8List);
//   }

//   File pickedImages;
//   PickedFile savvideo;
//   String base64Image;
//   final ImagePicker picker = ImagePicker();
//   List<Asset> images = List<Asset>();
//   String _error = 'No Error Dectected';
//   getvideodata(BuildContext context) async {
//     final imageSource = await showDialog<ImageSource>(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: Text("Select the Video source"),
//               actions: <Widget>[
//                 MaterialButton(
//                   child: Text("Camera"),
//                   onPressed: () => Navigator.pop(context, ImageSource.camera),
//                 ),
//                 MaterialButton(
//                   child: Text("Gallery"),
//                   onPressed: () => Navigator.pop(context, ImageSource.gallery),
//                 )
//               ],
//             ));

//     if (imageSource != null) {
//       savvideo = await picker.getVideo(
//           source: imageSource, maxDuration: const Duration(seconds: 100));
//       print('images is full');

//       // if (savvideo != null) {
//       //   pickedImages = File(savvideo.path);
//       setState(() {});
//       // }
//     }
//   }

//   getimagdata(BuildContext context) async {
//     final imageSource = await showDialog<ImageSource>(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: Text("Select the image source"),
//               actions: <Widget>[
//                 MaterialButton(
//                   child: Text("Camera"),
//                   onPressed: () => Navigator.pop(context, ImageSource.camera),
//                 ),
//                 MaterialButton(
//                   child: Text("Gallery"),
//                   onPressed: () => Navigator.pop(context, ImageSource.gallery),
//                 )
//               ],
//             ));

//     if (imageSource != null) {
//       var imgfil = await picker.getImage(
//           source: imageSource,
//           maxHeight: 1350,
//           maxWidth: 1920,
//           imageQuality: 100);
//       print('images is full');

//       if (imgfil != null) {
//         setState(() {
//           pickedImages = File(imgfil.path);
//         });
//       }
//     }
//   }

//   Color newcolor = Colors.blueAccent;
//   TextEditingController contentcontroller = new TextEditingController();
//   int gridcount = 0;
//   Widget buildGridView() {
//     if (images.length > 1) {
//       gridcount = 2;
//     } else {
//       gridcount = 1;
//     }

//     return savvideo != null
//         ? Stack(
//             children: [
//               Container(
//                 height: 500,
//                 width: double.infinity,
//                 child: VideoCard(savvideo.path),
//               ),
//               Padding(
//                   padding: EdgeInsets.only(top: 5),
//                   child: Flexible(
//                     child: TextField(
//                       controller: contentcontroller,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                           // filled: true,

//                           fillColor: Colors.white,
//                           hintText: 'add comment here',
//                           hintStyle: TextStyle(color: Colors.white)),
//                     ),
//                   )),
//               Padding(
//                   padding: EdgeInsets.only(top: 250),
//                   child: Flexible(
//                     child: ListView.builder(
//                       itemCount: 10,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Container(
//                             width: 50,
//                             height: 50,
//                             padding: EdgeInsets.only(left: 5),
//                             child: Image.asset('assets/ico/$index.gif'));
//                       },
//                     ),
//                   ))
//             ],
//           )
//         : Stack(
//             children: [
//               // Padding(
//               //   padding: EdgeInsets.only(top: 8.0),
//               //   child: RepaintBoundary(
//               //     key: _containerKey,
//               //     child: GridView.count(
//               //       crossAxisCount: gridcount,
//               //       children: List.generate(images.length, (index) {
//               //         Asset asset = images[index];

//               //         return AssetThumb(
//               //           asset: asset,
//               //           width: 300,
//               //           height: 600,
//               //         );
//               //       }),
//               //     ),
//               //   ),
//               // ),
//               Container(
//                 width: double.infinity,
//                 height: 500,
//                 child: pickedImages != null
//                     ? Image.file(
//                         pickedImages,
//                         fit: BoxFit.fill,
//                       )
//                     : Container(color: Colors.blueAccent),
//               ),
//               Padding(
//                   padding: EdgeInsets.only(top: 10),
//                   child: Flexible(
//                     child: TextField(
//                       controller: contentcontroller,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                           // filled: true,
//                           fillColor: Colors.white,
//                           hintText: 'add comment here',
//                           hintStyle: TextStyle(color: Colors.white)),
//                     ),
//                   )),
//               Padding(
//                   padding: EdgeInsets.only(top: 250),
//                   child: Flexible(
//                     child: ListView.builder(
//                       itemCount: 10,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Container(
//                             width: 50,
//                             height: 50,
//                             padding: EdgeInsets.only(left: 5),
//                             child: Image.asset('assets/ico/$index.gif'));
//                       },
//                     ),
//                   ))
//             ],
//           );
//   }

//   Widget viewvideo() {
//     return pickedImages != null
//         ? Container(
//             height: 250,
//             width: double.infinity,
//             child: VideoCard(pickedImages.path),
//           )
//         : Text('');
//   }

//   Future<void> loadAssets() async {
//     List<Asset> resultList = List<Asset>();

//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 300,
//         enableCamera: true,
//         selectedAssets: images,
//         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "BBmsg",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//     } on Exception catch (e) {}

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       images = resultList;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   bool dialVisible = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: Headbar('Story', 1, createPost),
//       floatingActionButton: SpeedDial(
//         // both default to 16
//         marginRight: 18,
//         marginBottom: 20,
//         animatedIcon: AnimatedIcons.list_view,
//         animatedIconTheme: IconThemeData(size: 22.0),
//         // this is ignored if animatedIcon is non null
//         // child: Icon(Icons.add),
//         visible: dialVisible,
//         // If true user is forced to close dial manually
//         // by tapping main button and overlay is not rendered.
//         closeManually: false,
//         curve: Curves.bounceIn,
//         overlayColor: Colors.black,
//         overlayOpacity: 0.5,
//         onOpen: () => print('OPENING DIAL'),
//         onClose: () => print('DIAL CLOSED'),
//         tooltip: 'Speed Dial',
//         heroTag: 'speed-dial-hero-tag',
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 8.0,
//         shape: CircleBorder(),
//         children: [
//           SpeedDialChild(
//               child: Icon(Icons.camera_alt),
//               backgroundColor: Colors.red,
//               label: 'Video',
//               labelStyle: TextStyle(fontSize: 18.0),
//               onTap: () {
//                 setState(() {
//                   imagorvideo = 2;
//                 });
//                 getvideodata(context);
//               }),
//           SpeedDialChild(
//             child: Icon(Icons.image),
//             backgroundColor: Colors.blue,
//             label: 'Image',
//             labelStyle: TextStyle(fontSize: 18.0),
//             onTap: () {
//               setState(() {
//                 imagorvideo = 1;
//               });
//               savvideo = null;
//               getimagdata(context);
//             },
//           ),
//           SpeedDialChild(
//             child: Icon(Icons.send),
//             backgroundColor: Colors.green,
//             label: 'save',
//             labelStyle: TextStyle(fontSize: 18.0),
//             onTap: () {
//               if (imagorvideo == 1) {
//                 ///save image screen capture
//                 //   convertWidgetToImage();
//                 creatstory(pickedImages, contentcontroller.text, true)
//                     .then((value) {
//                   getstory('30');
//                 });
//               } else {
//                 //save video
//                 creatstoryvideo(savvideo, contentcontroller.text, true)
//                     .then((value) {
//                   getstory('30');
//                 });
//               }
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: buildGridView(),
//           ),
//           //Expanded(child: viewvideo())
//         ],
//       ),
//     );
//   }
// }
