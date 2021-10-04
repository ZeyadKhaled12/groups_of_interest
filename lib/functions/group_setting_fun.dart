import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/screens/home_screen.dart';
import 'package:provider/provider.dart';

class GroupSettingFun{


  String id = 'test';

  Future uploadImage(BuildContext ctx, String title, File image) async{

    id = Provider.of<UserDetails>(ctx, listen: false).email;

    final ref = FirebaseStorage.instance
        .ref()
        .child('group_image')
        .child(title + '.jpg');

    try {
      await ref.putFile(image);
    } on FirebaseException catch (e) {
      print('\n\n\n\n\n\n\n\n\n${e.code}\n\n\n\n\n\n\n\n\n');
    }

    final url = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('groups').doc(title)
        .update({
      'image_url': url,
    });

    return url;
  }

  Future changeColor(String title, String color) async{

    await FirebaseFirestore.instance.collection('groups').doc(title).update({
      'color': color
    });

  }

  Future addToBlockList(String uid, String title) async{
    await FirebaseFirestore.instance.collection('groups').doc(title).collection('block_list')
        .doc(uid).set({});
  }

  Future addUserToMembers(String title) async{

    await FirebaseFirestore.instance.collection('groups').doc(title)
        .collection('members').doc(FirebaseAuth.instance.currentUser?.uid).set({});

    int number = await FirebaseFirestore.instance.collection('groups').doc(title).get().then((value) {
      return value.get('number');
    });

    await FirebaseFirestore.instance.collection('groups').doc(title).update({
      'number': number+1
    });

  }

  Future deleteUserToMembers(BuildContext ctx, String title, bool bool) async{
    await FirebaseFirestore.instance.collection('groups').doc(title)
        .collection('members').doc(FirebaseAuth.instance.currentUser?.uid).delete();

    int number = await FirebaseFirestore.instance.collection('groups').doc(title).get().then((value) {
      return value.get('number');
    });

    await FirebaseFirestore.instance.collection('groups').doc(title).update({
      'number': number-1
    });

  }

  Future addUserToBlockMembers(String title, String uid) async{
    await FirebaseFirestore.instance.collection('groups').doc(title).collection('block_list').doc(uid).set({});
  }

  Future unBlock(String title, String uid) async{
    await FirebaseFirestore.instance.collection('groups').doc(title).collection('block_list').doc(uid).delete();
  }

  Future clearChat(String title) async{
    await FirebaseFirestore.instance.collection('groups').doc(title).collection('msg').get().then((value) {
      final docs = value.docs;
      docs.forEach((element) async{
       await FirebaseFirestore.instance.collection('groups').doc(title).collection('msg')
           .doc(element.id).delete();
      });
    });

  }

  Future removeGroup(BuildContext ctx, String title) async{

    print('\n\n\n\nRemove Group\n\n\n\n');
    final ref = FirebaseStorage.instance
        .ref()
        .child('group_image')
        .child(title + '.jpg');
    await ref.delete();
    await clearChat(title);

    await FirebaseFirestore.instance.collection('groups').doc(title).delete();

    await Provider.of<UserDetails>(ctx, listen: false).getYourGroups();
   Navigator.pop(ctx);
   Navigator.pop(ctx);





  }


  Future deleteMsgAdmin(String title, String id) async{
    await FirebaseFirestore.instance.collection('groups').doc(title).collection('msg')
        .doc(id).delete();
  }
  
  Future addUserToBlockAdmin(String title, String uid) async{

    await FirebaseFirestore.instance.collection('groups').doc(title)
        .collection('block_list').doc(uid).set({});
  }

}