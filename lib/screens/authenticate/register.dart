import 'package:copeiros/services/auth.dart';
import 'package:copeiros/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:copeiros/shared/layout_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>{

  Widget _buildSignInBtn() {
    return GestureDetector(
      onTap: () => widget.toggleView(signInKey),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Já possui uma conta? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Logar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if(_formKey.currentState.validate()){
            setState(() => loading = true);
            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
            if(result == null){
              setState(() {
                error = 'Insira um email válido';
                loading = false;
              });
            }else{
              Fluttertoast.showToast(
                  msg: 'Um email de validação foi enviado para você, clique no link para concluir seu cadastro!',
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: Colors.black54,
                  textColor:  Colors.white,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 10
              );
//              await _auth.signOut();
              widget.toggleView(signInKey);
            }
//            else{
//              widget.toggleView(signInKey);
//            }
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'REGISTRAR',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: myLinearGradient,
          ),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),

          child: Form (
            key: _formKey,
            child: Column (
              children: <Widget>[
                SizedBox(height: 100.0,),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Email', style: myLabelStyle)
                ),
                SizedBox(height: 10.0,),
                Container(
                  decoration: myBoxDecorationStyle,
                  child: TextFormField(
                    decoration: myTextInputDecoration.copyWith(
                        prefixIcon: Icon(Icons.email, color: Colors.white,),
                        hintText: 'Insira seu email',
                        hintStyle: TextStyle(color: Colors.white54)
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String value){
                      if(value.isEmpty) return "Preencha o email";

                      if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
                        return 'Insira um email válido';
                      }
                      return null;
                    },
                    onChanged: (val){
                      setState(() => email = val);
                    },
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Senha', style: myLabelStyle)
                ),
                SizedBox(height: 10.0,),
                Container(
                  decoration: myBoxDecorationStyle,
                  child: TextFormField(
                    decoration: myTextInputDecoration.copyWith(
                        prefixIcon: Icon(Icons.lock, color: Colors.white,),
                        hintText: 'Insira sua senha',
                        hintStyle: TextStyle(color: Colors.white54)
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) => val.length < 6 ? "A sua senha precisa ter no mínimo 6 caracteres" : null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() => password = val);
                    },
                  ),
                ),
                SizedBox(height: 58.0,),
                _buildRegisterBtn(),
                SizedBox(height: 20.0,),
                Text(
                  error,
                  style: TextStyle(color: Colors.pinkAccent, fontSize: 14.0),
                ),
                SizedBox(height: 20.0,),
                _buildSignInBtn()
              ],
            ),
          )
      ),
    );
  }
}
