import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/config/route.dart';
import 'package:flutter_miniproject/model/sign_up.dart';
import 'package:flutter_miniproject/module/notifications/custom_message_dialog.dart';
import 'package:flutter_miniproject/provider/sign_in_provider.dart';
import 'package:flutter_miniproject/provider/userauth_api_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

class SignUpForm extends HookWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userfirstnamecontroller = useTextEditingController();
    final _userlastnamecontroller = useTextEditingController();
    final _usernamecontroller = useTextEditingController();
    final _emailcontroller = useTextEditingController();
    final _passwordcontroller = useTextEditingController();
    final _passwordVisible = useState(false);
    final _usernamevalidity = useState(true);
    final _userfnvalidity = useState(true);
    final _userlnvalidity = useState(true);
    final _emailvalidity = useState(true);
    final _passwordvalidity = useState(true);
    final _defaulticon = useState(1);
    final _auth = useProvider(authAPIProvider);
    final _emaildisplay = useProvider(showEmailProvider);
    String _maleAvatar =
        'https://firebasestorage.googleapis.com/v0/b/flutter-additionals.appspot.com/o/avatar%2FBoy%20free%20vector%20icons%20designed%20by%20Freepik.png?alt=media&token=87a0d143-9077-435d-bfbd-c644aa5464c8';
    String _femaleAvatar =
        'https://firebasestorage.googleapis.com/v0/b/flutter-additionals.appspot.com/o/avatar%2FCrear%20mi%20Avatar.png?alt=media&token=ffa93094-24b0-4c5b-861d-c5800b789b82';
    bool _checkEmail() {
      bool emailValidity = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_emailcontroller.text);

      if (emailValidity) {
        //  _emailvalidity.value = true;
        return true;
      }
      return false;
    }

    bool _checkPassword() {
      bool passwordStrength = RegExp(
              r"^(?=(.*[a-z]){3,})(?=(.*[A-Z]){2,})(?=(.*[0-9]){2,})(?=(.*[!@#$%^&*()\-__+.]){1,}).{8,}$")
          .hasMatch(_passwordcontroller.text);
      if (passwordStrength) {
        return true;
      }
      return false;
    }

    _checkCredentials() async {
      bool emailstatus = _checkEmail();
      bool passwordstatus = _checkPassword();
      if (emailstatus && passwordstatus) {
        print('good to go');
        // bool status = await _auth.auth.createUser(
        //     username: _usernamecontroller.text,
        //     password: _passwordcontroller.text,
        //     firstname: _userfirstnamecontroller.text,
        //     lastname: _userlastnamecontroller.text,
        //     email: _emailcontroller.text);

        final signupdetails = SignUp(
            username: _usernamecontroller.text,
            password: _passwordcontroller.text,
            firstName: _userfirstnamecontroller.text,
            lastName: _userlastnamecontroller.text,
            avatarurl: (_defaulticon.value == 1) ? _maleAvatar : _femaleAvatar,
            email: _emailcontroller.text);
        Response? response =
            await _auth.auth.createUser(signup: signupdetails.signup());
        if (response != null) {
          // print('successful');
          // Navigator.pop(context);

          if (response.statusCode == 201) {
            print(response.body);
            showMessageDialog(
                context, 'You Successfully Signed Up!', 'Sign Up', true);
            _emaildisplay.initialEmailDisplay = response.body;
            //Navigator.pop(context);
          } else {
            print('invalid');
            showMessageDialog(context, response.body, 'Error', false);
          }
        } else {
          print('failed, show message dialog');
          showMessageDialog(context, 'Request Failed!', 'Error', false);
        }
      } else {
        print(' not good to go');
        // if (!emailstatus) {
        //   _emailvalidity.value = emailstatus;
        // } else {
        //   _passwordvalidity.value = passwordstatus;
        // }
        showMessageDialog(context, 'Invalid Inputs', 'Error in Form', false);
      }
    }

    return Container(
      width: 350,
      height: (_emailvalidity.value && _passwordvalidity.value) ? 600 : 620,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListView(
        children: [
          Center(
            child: Text(
              'Sign Up',
              style: TextStyle(fontSize: 40),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          _CustomTextField(
            controller: _userfirstnamecontroller,
            obscureText: false,
            hintext: 'First Name',
            validity: _userfnvalidity,
          ),
          SizedBox(
            height: 20,
          ),
          _CustomTextField(
              controller: _userlastnamecontroller,
              obscureText: false,
              hintext: 'Last Name',
              validity: _userlnvalidity),
          SizedBox(
            height: 20,
          ),
          _CustomTextField(
              controller: _usernamecontroller,
              obscureText: false,
              hintext: 'UserName',
              validity: _usernamevalidity),
          SizedBox(
            height: 20,
          ),
          _CustomTextField(
            controller: _emailcontroller,
            validity: _emailvalidity,
            obscureText: false,
            hintext: 'Email',
          ),
          SizedBox(
            height: 20,
          ),
          _CustomTextField(
            controller: _passwordcontroller,
            validity: _passwordvalidity,
            obscureText: !_passwordVisible.value,
            hintext: 'Password',
            iconbutton: IconButton(
              icon: Icon(
                (!_passwordVisible.value)
                    ? Icons.visibility_off_outlined
                    : Icons.visibility,
              ),
              onPressed: () {
                _passwordVisible.value = !_passwordVisible.value;
              },
              // Icons.visibility_outlined,
              color: (!_passwordVisible.value) ? Colors.grey : Colors.blue,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Expanded(
          //   child: Column(
          //     children: [
          //       if (!_emailvalidity.value)
          //         Text(
          //           'Invalid Email',
          //           style: TextStyle(color: Colors.red, fontSize: 9),
          //         ),
          //       if (!_passwordvalidity.value)
          //         FittedBox(
          //           child: Column(
          //             children: [
          //               Text(
          //                 'Password must have atleast',
          //                 style: TextStyle(color: Colors.red, fontSize: 9),
          //               ),
          //               Text(
          //                 '* 8 characters length',
          //                 style: TextStyle(color: Colors.red, fontSize: 9),
          //               ),
          //               Text(
          //                 '* 2 letters in Upper Case',
          //                 style: TextStyle(color: Colors.red, fontSize: 9),
          //               ),
          //               Text(
          //                 '* 1 Special Character',
          //                 style: TextStyle(color: Colors.red, fontSize: 9),
          //               ),
          //               Text(
          //                 '* 2 numerals',
          //                 style: TextStyle(color: Colors.red, fontSize: 9),
          //               ),
          //               Text(
          //                 '* 3 letters in Lower Case',
          //                 style: TextStyle(color: Colors.red, fontSize: 9),
          //               ),
          //             ],
          //           ),
          //         )
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: (_defaulticon.value == 1) ? Colors.red : null,
                child: InkWell(
                  onTap: () {
                    _defaulticon.value = 1;
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child:
                        Image.network(_maleAvatar, width: 50.0, height: 50.0),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Material(
                color: (_defaulticon.value == 2) ? Colors.red : null,
                child: InkWell(
                  onTap: () {
                    _defaulticon.value = 2;
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child:
                        Image.network(_femaleAvatar, width: 50.0, height: 50.0),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.deepPurple.shade100,
              //     spreadRadius: 10,
              //     blurRadius: 20,
              //   ),
              // ],
            ),
            child: ElevatedButton(
              child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Center(child: Text("Create Account"))),
              onPressed: _checkCredentials,
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('All Ready Have An Account?'),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class _CustomTextField extends HookWidget {
  final TextEditingController controller;
  final ValueNotifier<bool>? validity;
  final IconButton? iconbutton;
  final bool obscureText;
  final String hintext;
  _CustomTextField({
    required this.controller,
    required this.validity,
    this.iconbutton,
    required this.obscureText,
    required this.hintext,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: iconbutton,
        hintText: hintext,
        filled: true,
        fillColor: Colors.blueGrey[50],
        labelStyle: TextStyle(fontSize: 12),
        contentPadding: EdgeInsets.only(left: 30),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: (validity!.value)
                  ? Colors.blueGrey.shade100
                  : Colors.red.shade200),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}


// enum Avatar{

// }