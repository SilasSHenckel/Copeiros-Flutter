import 'dart:io';
import 'package:copeiros/models/cloud_storage_result.dart';
import 'package:copeiros/models/user.dart';
import 'package:copeiros/services/cloud_storage_service.dart';
import 'package:copeiros/services/user_service.dart';
import 'package:copeiros/shared/image_selector.dart';
import 'package:copeiros/shared/layout_constants.dart';
import 'package:copeiros/shared/loading.dart';
import 'package:flutter/material.dart';

class UserBasicInfo extends StatefulWidget {

  User user;
  final String uid;
  final String email;
  final Function setUserVerified;
  UserBasicInfo({this.user, this.uid, this.email, this.setUserVerified});

  @override
  _UserBasicInfoState createState() => _UserBasicInfoState();
}

enum Sex { Homem, Mulher }

class _UserBasicInfoState extends State<UserBasicInfo> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

//  DateTime selectedDate = DateTime.parse("19960101");
  File _selectedImage;

  Future selectImage() async{
    var tempImage = await ImageSelector().selectImage();
    if(tempImage != null){
      setState(() => _selectedImage = tempImage);
    }
  }

  Sex _sex = Sex.Homem;
  String name = '';
  String nickname = '';
  String error = '';
  String age = '';

//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//        context: context,
//        initialDate: selectedDate,
//        firstDate: DateTime(1950, 1),
//        lastDate: DateTime(2006));
//    if (picked != null && picked != selectedDate)
//      setState(() {
//        selectedDate = picked;
//      });
//  }




  @override
  Widget build(BuildContext context) {
    return  loading ? Loading() : Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: myLinearGradient,
        ),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
        child:  SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0,),
                Text(
                  'Meu Perfil',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0,),
                GestureDetector(
                  onTap: () => selectImage(),
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: _selectedImage == null ? AssetImage('assets/images/user_image.png') : Image.file(_selectedImage),
                      radius: 50,
                    ),
                  ),
                ),
                Divider(
                  height: 60,
                  color: Colors.white,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Nome', style: myLabelStyle)
                ),
                SizedBox(height: 10.0,),
                Container(
                  decoration: myBoxDecorationStyle,
                  child: TextFormField(
                    decoration: myTextInputDecoration.copyWith(
                        prefixIcon: Icon(Icons.person, color: Colors.white,),
                        hintText: 'Insira seu nome',
                        hintStyle: TextStyle(color: Colors.white54)
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String value){
                      if(value.isEmpty) return "Preencha o nome";
                      return null;
                    },
                    onChanged: (val){
                      setState(() => name = val);
                    },
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Apelido de Jogador', style: myLabelStyle)
                ),
                SizedBox(height: 10.0,),
                Container(
                  decoration: myBoxDecorationStyle,
                  child: TextFormField(
                    decoration: myTextInputDecoration.copyWith(
                        prefixIcon: Icon(Icons.insert_emoticon, color: Colors.white,),
                        hintText: 'Insira seu apelido',
                        hintStyle: TextStyle(color: Colors.white54)
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String value){
                      if(value.isEmpty) return "Preencha o apelido";
                      return null;
                    },
                    onChanged: (val){
                      setState(() => nickname = val);
                    },
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Idade', style: myLabelStyle)
                ),
                SizedBox(height: 10.0,),
                Container(
                  decoration: myBoxDecorationStyle,
                  child: TextFormField(
                    decoration: myTextInputDecoration.copyWith(
                        prefixIcon: Icon(Icons.cake, color: Colors.white,),
                        hintText: 'Insira sua idade',
                        hintStyle: TextStyle(color: Colors.white54)
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    validator: (String value){
                      if(value.isEmpty) return "Preencha sua idade";
                      if(int.parse(value) < 12) return "A idade mínima é 12 anos";
                      return null;
                    },
                    onChanged: (val){
                      setState(() => age = val);
                    },
                  ),
                ),
//                Text("${selectedDate.toLocal()}".split(' ')[0], style: TextStyle(color: Colors.white)),
//                SizedBox(height: 10.0,),
//                RaisedButton(
//                  onPressed: () => _selectDate(context),
//                  child: Text('Selecione'),
//                ),
                SizedBox(height: 20.0,),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Sou', style: myLabelStyle)
                ),
                SizedBox(height: 10.0,),
                ListTile(
                  title: const Text('Homem', style: TextStyle(color: Colors.white)),
                  leading: Radio(
                    activeColor: Colors.white,
                    value: Sex.Homem,
                    groupValue: _sex,
                    onChanged: (Sex value) {
                      setState(() => _sex = value);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Mulher', style: TextStyle(color: Colors.white)),
                  leading: Radio(
                    value: Sex.Mulher,
                    groupValue: _sex,
                    onChanged: (Sex value) {
                      setState(() => _sex = value);
                    },
                  ),
                ),
                SizedBox(height: 50.0,),
                Align(
                  alignment: FractionalOffset.bottomRight,
                  child: FlatButton(
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        User user = widget.user;
                        if(user == null) user = new User(uid: widget.uid, email: widget.email);
                        user.name = name;
                        user.nickName = nickname;
                        user.age = age;
                        user.sex = _sex.toString();
                        if(_selectedImage != null) {
                          CloudStorageResult storageResult = await CloudStorageService()
                              .uploadImage(imageToUpload: _selectedImage, title: user.uid);
                          if(storageResult != null) user.imageUrl = storageResult.imageUrl;
                        }
                        dynamic result = await UserService().updateUserData(user);
                        widget.setUserVerified(false);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Pronto',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.0,),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

