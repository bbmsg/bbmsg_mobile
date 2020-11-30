import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  String imageUrl;
  ImageDialog({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          width: 350,
          height: 250,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )),
    );
  }
}
