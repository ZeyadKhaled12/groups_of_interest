
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';


class UserDetails with ChangeNotifier{

  FunFun _funFun = new FunFun();

  String? _name;
  String _email = '';
  String? _invitationCode;
  String _loginCode = '';
  bool _isSignUp = false;
  Color? _color;
  String? _firstTime;
  bool _isDelete = false;
  bool _isDeleteGroup = false;
  List _listOfGroups = [];
  String _lastGroupEntered = 'null';
  List _groupsOfScreen = [];
  bool _nullGroupEntered = false;
  bool _searchSit = false;
  String _searchWord = '';
  List _yourGroups = [];







  String? get name{
    return _name;
  }

  List get yourGroups{
    return _yourGroups;
  }

  bool get searchSit{
    return _searchSit;
  }

  String get searchWord{
    return _searchWord;
  }


  bool get nullGroupEntered{
    return _nullGroupEntered;
  }

  
  List get listOfGroups{
    
    return _listOfGroups;
  }

  List get groupOfScreen{

    return _groupsOfScreen;
  }

  String get lastGroupEntered{

    return _lastGroupEntered;
  }

  bool get isDelete{
    return _isDelete;
  }

  bool get isDeleteGroup{
    return _isDeleteGroup;
  }

  String? get firstTime{
    return _firstTime;
  }

  String get loginCode{
    return _loginCode;
  }

  Color? get color{
    return _color;
  }

  String get email{
    return _email;
  }

  String? get invitationCode{
    return _invitationCode;
  }

  bool get isSignUp{
    return _isSignUp;
  }


  Future<void> getUsers() async{

    await getYourGroups();

    _name =  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['name'];
    });

    _color =_funFun.getColor(await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['color'];
    }));

    _email = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['email'];
    });

    _invitationCode = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['invcode'];
    });

    _loginCode  = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['code'];
    });

    await getGroups();
    notifyListeners();
  }



  Future getName() async{
    _name =  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['name'];
    });
    notifyListeners();
  }



  Future getColor() async{
    _color = _funFun.getColor(await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['color'];
    }));
    notifyListeners();
  }



  Future getEmail() async{
    _email = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['email'];
    });
    notifyListeners();
  }

  Future getInvCode() async{
    _invitationCode = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['invcode'];
    });
    notifyListeners();
  }

  Future getLoginCode() async{
     _loginCode  = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['code'];
    });
     notifyListeners();
  }




    isSignUpFunc(){
    _isSignUp = true;
    notifyListeners();
  }


  void isLoginFunc(){
    _isSignUp = false;
    notifyListeners();
  }


   Future<void> isFirstTime( String _code) async{
    _firstTime =await FirebaseFirestore.instance
        .collection('codes')
        .doc(_code)
        .get().then((value) => value.data()?['firstTime']);
    print('\n\n\n\n\n\n\n\n$_firstTime\n\n\n\n\n\n');
    notifyListeners();

  }
  
  Future getFavGroups() async{
    
      await FirebaseFirestore.instance.collection('favGroup').doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('groups').get().then((value) {
          for(int i = 0; i < value.docs.length; i++){
            _listOfGroups.add(value.docs[i].id);
          }
    });
    print('\n\n\n\n\n\nJUST DOOOO IT\n\n\n\n\n\n\n\n');
    print('\n\n\n\n\nLOOOOL$_listOfGroups\n\n\n\n\n');
    notifyListeners();
    
  }

  void delGroup(String title) {
    if(_listOfGroups.contains(title)) {
      _listOfGroups.remove(title);
    }
    notifyListeners();
  }

  void addGroup(String title) {
    if(!_listOfGroups.contains(title)) {
      _listOfGroups.add(title);
    }
    notifyListeners();
  }
  

  void changeIsDelete(){
    _isDelete = !_isDelete;
    notifyListeners();
  }

  void changeIsDeleteFalse(){
    _isDelete = false;
    notifyListeners();
  }


  void changeIsDeleteGroup(){
    _isDeleteGroup = !_isDeleteGroup;
    notifyListeners();
  }

  void changeIsDeleteFalseGroup(){
    _isDeleteGroup = false;
    notifyListeners();
  }

  Future changeGroupEntered(String title) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setBool('nullGroup', true);

    //_nullGroupEntered = true;
    _lastGroupEntered = title;
    notifyListeners();
  }

  void nullGroupEnteredFun(){

    /*
    print('Walk from here');
    _lastGroupEntered = 'null';
    print(_lastGroupEntered);
    notifyListeners();

     */
    _nullGroupEntered = false;
    print('\n\n\n\n\nNULL : $_nullGroupEntered\n\n\n\n');
    notifyListeners();
  }

  Future getGroups() async{

    await FirebaseFirestore.instance.collection('groups')
        .orderBy('number',  descending: true)
        .get().then((value) {

      _groupsOfScreen = value.docs;
    });
    notifyListeners();

  }

  Future getYourGroups() async{


    _yourGroups.clear();
    print('\n\n\n\nWe get your fav\n\n\n\n\n');
    await getGroups();
    _groupsOfScreen.forEach((element) {
      print('\n\n\n\nWe get your fav0000\n\n\n\n\n');
      if(element['owner'] == FirebaseAuth.instance.currentUser?.uid){
        _yourGroups.add(element);

      }
    });

    notifyListeners();
  }

  Future searchForGroups(String string) async{

   _searchSit = true;
    _searchWord = string;

    List docs = [];
    await FirebaseFirestore.instance.collection('groups')
        .orderBy('number',  descending: true)
        .get().then((value) {
      docs = value.docs;
    });

    List groups = [];
    docs.forEach((element) {
      groups.add(element['interest']);
    });

    Map<int, List> _map = {
      10:[], 9:[], 8:[], 7:[], 6:[],
      5:[], 4:[], 3:[], 2:[], 1:[], 0:[]
    };

    List listOfSimilarity = [];
    groups.forEach((element) {
      listOfSimilarity.add((string.similarityTo(element) * 10).toInt());
    });

    int i = 0;
    listOfSimilarity.forEach((element) {
      _map.update(element, (value) => value + [groups[i]]);
      i++;
    });

    List finalList = [];
    _map.forEach((key, value) {
      finalList = finalList + value;
    });



    List docsWork = List.filled(docs.length, 0, growable: false);
    docs.forEach((element) {
      print('\n\n\n${finalList.indexOf(element['interest'])}\n\n\n');
      docsWork[finalList.indexOf(element['interest'])] = element;
    });

    _groupsOfScreen = docsWork;



    notifyListeners();
  }

   searchSitFun(){
    _searchSit = false;
    notifyListeners();
  }
















}

//Provider.of<Auth>(context, listen: false).getPrices();