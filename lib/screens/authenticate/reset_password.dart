import 'package:after_layout/after_layout.dart';
import 'package:copeiros/services/auth.dart';
import 'package:copeiros/shared/layout_constants.dart';
import 'package:copeiros/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPassword extends StatefulWidget {

  final Function toggleView;
  ResetPassword({this.toggleView});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>{

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'OK', onPressed: () {
//              scaffold.hideCurrentSnackBar;
              widget.toggleView(signInKey);
            }
        ),
      ),
    );
  }

  Widget _buildSignInBtn() {
    return GestureDetector(
      onTap: () => widget.toggleView(signInKey),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Retornar para o ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Login',
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
  String error = '';
  String message = '';

  Widget _buildResetPasswordBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if(_formKey.currentState.validate()){
            setState(() => loading = true);
            dynamic result = await _auth.sendResetPasswordEmail(email);
            setState(() {
                message = 'Verifique se você recebeu o email de redefinição de senha!';
                loading = false;
            });
//            if(result == null){
//              setState(() {
//                error = 'Ocorreu um erro. Verifique o email inserido';
//                loading = false;
//              });
//            }
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'ENVIAR',
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
              SizedBox(height: 80.0,),
              Text(
                'Resetar Senha',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.0,),
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
              SizedBox(height: 30.0,),
              _buildResetPasswordBtn(),
              SizedBox(height: 20.0,),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.pinkAccent, fontSize: 14.0),
              ),
              Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              SizedBox(height: 30.0,),
              _buildSignInBtn()
            ],
          ),
        )
      ),
    );
  }
}

