import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';


class MakeGroupFun {

  String id = 'test';


  Future uploadImage(BuildContext ctx, File image, String titleGroup,
      String interest) async {
    id = Provider.of<UserDetails>(ctx, listen: false).email;



    final ref = FirebaseStorage.instance
        .ref()
        .child('group_image')
        .child(titleGroup + '.jpg');

    try {
      await ref.putFile(image);
    } on FirebaseException catch (e) {
      print('\n\n\n\n\n\n\n\n\n${e.code}\n\n\n\n\n\n\n\n\n');
    }

    final url = await ref.getDownloadURL();
    print('\n\n\n\n\n\n$url\n\n\n\n\n\n');

    DateTime _myTime;
    _myTime = await NTP.now();



      await FirebaseFirestore.instance.collection('groups').doc(titleGroup)
          .collection('msg').add({});



      await FirebaseFirestore.instance.collection('owngroups').doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('groups').doc(titleGroup).set({});

      await FirebaseFirestore.instance.collection('groups').doc(titleGroup)
          .set({
        'interest': interest,
        'date': _myTime,
        'image_url': url,
        'number': 0,
        'owner': FirebaseAuth.instance.currentUser?.uid,
      });

    return url;
  }

  String getColor(Color? color) {
    if (color == Colors.red) {
      return 'red';
    }
    else if (color == Colors.orange) {
      return 'orange';
    }
    else if (color == Colors.blue) {
      return 'blue';
    }
    else if (color == Colors.purple) {
      return 'purple';
    }
    else if (color == Colors.pinkAccent) {
      return 'pink';
    }
    else if (color == Colors.green) {
      return 'green';
    }
    else if (color == Colors.brown) {
      return 'brown';
    }
    else if (color == Colors.cyanAccent) {
      return 'cyan';
    }
    else if (color == Colors.deepOrangeAccent) {
      return 'deepOrange';
    }
    return 'white';
  }

  Future setColor(BuildContext ctx, String titleGroup, String color) async {
    await FirebaseFirestore.instance.collection('groups')
        .doc(titleGroup)
        .update({
      'color': color
    });
  }

  Future sendMessage(String titleGroup, String msg) async {
    List detail = await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return [value.get('name'), value.get('color')];
    });

    DateTime _myTime;
    _myTime = await NTP.now();

    await FirebaseFirestore.instance.collection('groups').doc(titleGroup)
        .collection('msg')
        .add({
      'createdAt': _myTime,
      'text': msg,
      'userId': FirebaseAuth.instance.currentUser?.uid,
      'name': detail[0],
      'color': detail[1]
    });
  }

  Future deleteMessage(String titleGroup, String id) async{

    await FirebaseFirestore.instance.collection('groups').doc(titleGroup)
        .collection('msg').doc(id).delete();

  }
  
  Future addGroupFav(String title, BuildContext ctx) async{

    await FirebaseFirestore.instance.collection('favGroup').doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('groups').doc(title).set({});

    Provider.of<UserDetails>(ctx, listen: false).addGroup(title);
    
  }

  Future deleteGroupFav(String title, BuildContext ctx) async {


    await FirebaseFirestore.instance.collection('favGroup').doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('groups').doc(title).delete();

    Provider.of<UserDetails>(ctx, listen: false).delGroup(title);

  }

  Future<bool> knowIsFavGroup(String title,) async{


    await FirebaseFirestore.instance.collection('favGroup').doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('groups').doc(title).get().then((value) {
      print('${value.exists} The func');
       return value.exists;
    });


    return false;
  }
  
  Future changeColorImage(String title, String color) async{
    
    await FirebaseFirestore.instance.collection('groups').doc(title).update({
      'color': color
    });
    
  }


}