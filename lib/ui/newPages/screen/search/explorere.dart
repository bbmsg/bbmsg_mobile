import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class Explorers extends StatefulWidget {
   final List imgs;
  Explorers(this.imgs,{Key key}) : super(key: key);

  @override
  _ExplorersState createState() => _ExplorersState();
}

class _ExplorersState extends State<Explorers> {
  @override
  Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.all(12),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
         itemCount:widget.imgs.length ,
         itemBuilder: (context,index){
            return Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      // borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                         image: widget.imgs[index],fit: BoxFit.cover,),
                  ),
                );
              },
              staggeredTileBuilder: (index) {
                return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
              }
              ),
      );
       }
        // children: List.generate(widget.imgs.length, (index) {
        //   String img = widget.imgs[index];
        //   return Image.asset(
        //     img,
        //     width: MediaQuery.of(context).size.width,
        //     fit: BoxFit.cover,
        //   );
        // }));

  }
  
