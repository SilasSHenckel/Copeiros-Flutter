import 'package:copeiros/models/user.dart';
import 'package:copeiros/services/auth.dart';
import 'package:copeiros/shared/layout_constants.dart';
import 'package:copeiros/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  Widget _buildSignUpBtn() {
    return GestureDetector(
      onTap: () => widget.toggleView(registerKey),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Não possui uma conta? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Cadastre-se',
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

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _textEditingControllerEmail = new TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isEmailTempValidated = false;
  bool isEmailTempSetted = false;

  String email = '';
  String password = '';
  String error = '';

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if(_formKey.currentState.validate()){
            setState(() => loading = true);
            AuthUser result = await _auth.signInWithEmailAndPassword(email, password);
            if(result == null){
              setState(() {
                error = 'Falha no login, verifique os campos.';
                loading = false;
              });
            }else{
//              if(!result.firebaseUser.isEmailVerified){
//                Fluttertoast.showToast(
//                    msg: 'O link de ativação da sua conta foi enviado para o seu email, conclua seu cadastro!',
//                    toastLength: Toast.LENGTH_LONG,
//                    backgroundColor: Colors.black54,
//                    textColor:  Colors.white,
//                    gravity: ToastGravity.CENTER,
//                    timeInSecForIosWeb: 10
//                );
//                setState(() {
//                  loading = false;
//                });
//              }
            }
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'ENTRAR',
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

  Future getEmailTemp() async {
    if(!isEmailTempValidated) {
      final SharedPreferences prefs = await _prefs;
      String emailTemp = prefs.getString('email');
      if (emailTemp != null && emailTemp != email) {
        setState(() {
          isEmailTempValidated = true;
          email = emailTemp != null ? emailTemp : '';
        });
      }
    }
  }

  void setEmailTemp(){
    if(!isEmailTempSetted && isEmailTempValidated){
      _textEditingControllerEmail.text = email;
      isEmailTempSetted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    getEmailTemp();
    setEmailTemp();

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
                  controller: _textEditingControllerEmail,
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
              SizedBox(height: 10.0,),
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () => widget.toggleView(resetPasswordKey),
                  padding: EdgeInsets.only(right: 0.0),
                  child: Text(
                    'Esqueceu sua senha?',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
              ),
              _buildLoginBtn(),
              SizedBox(height: 20.0,),
              Text(
                error,
                style: TextStyle(color: Colors.pinkAccent, fontSize: 14.0),
              ),
              SizedBox(height: 20.0,),
              _buildSignUpBtn()
            ],
          ),
        )
      ),

    );
  }


}

