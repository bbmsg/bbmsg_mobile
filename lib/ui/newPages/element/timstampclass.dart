import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
String readTimestamp(DateTime timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
 
    var diff = now.difference(timestamp);
    var time = '';
   
    if (
      // diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0
        //  ||
        // diff.inMinutes > 0 && diff.inHours == 0 ||
        // diff.inHours > 0 && diff.inDays == 0
        ) {
      // time = format.format(timestamp);
       time = diff.inSeconds.toString() + 'm';
    }
    
    else if(   diff.inMinutes > 0 && diff.inHours == 0){
        time = diff.inMinutes.toString() + 'm';
    }
    else if(diff.inHours > 0 && diff.inHours <24){
  time = diff.inHours.toString() + 'h';
    }
     else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'd';
      } else {
        time = diff.inDays.toString() + 'd';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + 'w';
      } else {
        time = (diff.inDays / 7).floor().toString() + 'w';
      }
    }
    if (diff.inDays > 30) {
      time = (diff.inDays / 30).floor().toString() + ' Month';
    }
    if (diff.inDays > 365) {
      time = (diff.inDays / 365).floor().toString() + ' ' + 'years' + ' ';
    }
  
    return  time;
  }


   