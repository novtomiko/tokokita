import 'package:flutter/material.dart';
import 'package:tokokita/helpers/user_info.dart';
import 'package:tokokita/model/login.dart';
import 'package:tokokita/ui/buku_page.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

import '../bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _emailTextField(),
                  _passwordTextField(),
                  _buttonLogin(),
                  SizedBox(height: 30,),
                  _menuRegistrasi(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox email
  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        //validasi harus diisi
        if(value.isEmpty){
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  //Membuat Textbox password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        //validasi harus diisi
        if(value.isEmpty){
          return 'Password harus diisi';
        }
        return null;
      },
    );
  }

  ///Membuat Tombol Login
  Widget _buttonLogin() {
    return ElevatedButton(
        child: Text("Login"),
        onPressed: () {
          var validate = _formKey.currentState.validate();
          if (validate) {
            if (!_isLoading) _submit();
          }
        });
  }

  void _submit() {
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
      await UserInfo().setToken(value.token);
      await UserInfo().setUserID(value.userID);
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => BukuPage()));
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => WarningDialog(
                description: "Login gagal, silhakan coba lagi",
                okClick: () {},
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  //Membuat menu untuk membuka halaman registrasi
  Widget _menuRegistrasi() {
    return Container(
      child: Center(
        child: InkWell(
          child: Text("Registrasi",style: TextStyle(color: Colors.blue),),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context)=> RegistrasiPage()));
          },
        ),
      ),
    );
  }
}




  //Membuat menu untuk membuka halaman registrasi
 // Widget _menuRegistrasi() {
    //return Container(
      //child: Center(
        //child: InkWell(
          //child: Text("Registrasi",style: TextStyle(color: Colors.blue),),
          //onTap: () {
           // Navigator.push(context, new MaterialPageRoute(builder: (context)=> RegistrasiPage()));
          //},
       // ),
     // ),
    //);
 // }
