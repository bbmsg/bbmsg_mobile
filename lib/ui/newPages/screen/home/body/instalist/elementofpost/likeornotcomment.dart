import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Likornotcomment extends StatefulWidget {
  final String commentid;
  final String likeornotno;
  final int commnorreply;
///commnorreply= 1 then comment// commnorreply=2 the reply
  Likornotcomment(this.commentid, this.likeornotno,this.commnorreply, {Key key})
      : super(key: key);

  @override
  _LikornotcommentState createState() => _LikornotcommentState();
}

class _LikornotcommentState extends State<Likornotcomment> {
  bool likeornot = false;
  @override
  void initState() {
    super.initState();
    widget.likeornotno == '0' ? likeornot = false : likeornot = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          icon: Icon(
            likeornot
                // testico
                ? Icons.favorite
                : FontAwesomeIcons.heart,
            color: likeornot
                // testico
                ? Colors.red
                : Colors.black,
            size: 14,
          ),
          onPressed: () {
            switch (widget.commnorreply) {
              case 1:
                 likeornot
                ? removelike(int.parse(widget.likeornotno))
                : likecomment(int.parse(widget.commentid));
                break;
                case 2:
                  likeornot
                ? removelike(int.parse(widget.likeornotno))
                : likereply(int.parse(widget.commentid));
                break;
              default:
            }
           
                
            setState(() {
              likeornot = !likeornot;
            });
            setState(() {
              print(likeornot.toString() + widget.likeornotno.toString());
            });
          }),
    );
  }
}
