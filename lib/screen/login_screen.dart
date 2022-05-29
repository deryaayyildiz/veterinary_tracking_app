import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vetlogin/screen/selectionScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formPass = GlobalKey<FormState>();
  final _formUser = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

   bool isHidden = true;
  togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  bool isRememberMe = false;
  List<String> items = [];

  Widget buildEmail() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'E-mail',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: Form(
              key: _formUser,
              child: TextFormField(
                obscureText: false,
                controller: username,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xff2c2772),
                    ),
                    hintText: 'E-mail',
                    hintStyle: TextStyle(color: Colors.black38)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '   Lütfen bir kullanıcı adınızı giriniz';
                  } else if (value.length < 4) {
                    return "   Kullanıcı adı en az 6 karakter olmalıdır";
                  } else if (value.length > 15) {
                    return "   Kullanıcı adı 15 karakterden uzun olmamalıdır";
                  }
                  return null;
                },
              ),
            ),
          )
        ]);
  }

  Widget buildPassword(isHidden) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Şifre',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: Form(
              key: _formPass,
              child: TextFormField(
                obscureText: true,
                style: TextStyle(color: Colors.black87),
                controller: password,
               //    obscureText: isHidden,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                                    splashColor: Colors.transparent,
                                    icon: isHidden
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: togglePasswordVisibility,
                                  ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xff2c2772),
                    ),
                    hintText: 'Şifre',
                    hintStyle: TextStyle(color: Colors.black38)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir parolanızı giriniz';
                  } else if (value.length < 4) {
                    return "Şifre en az 6 karakter olmalıdır";
                  } else if (value.length > 15) {
                    return "Şifre 15 karakterden uzun olmamalıdır";
                  }
                  return null;
                },
              ),
            ),
          )
        ]);
  }

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print("Forgot Password pressed"),
        child: const Center(
          child: Text(
            'Şifremi Unuttum',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRegisterBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navigator.push(
          //   this.context,
          //   MaterialPageRoute(
          //     builder: (context) => RegisterScreen(),
          //   ),
          // );
        },
        child: const Center(
          child: Text(
            'Kayıt Ol',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRememberCb() {
    return Container(
      height: 20,
      child: Row(children: <Widget>[
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(
            value: isRememberMe,
            checkColor: Colors.indigo,
            activeColor: Colors.white,
            onChanged: (value) {
              setState(() {
                isRememberMe = value!;
              });
            },
          ),
        ),
        const Text('Beni Hatırla',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
      ]),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      width: double.infinity,
      child: ElevatedButton(
        
        onPressed: () {  Navigator.push(
              this.context,
              MaterialPageRoute(
                builder: (context) => SelectionScreen(items),
              ),
            );
          bool passflag = false;
          bool userflag = false;
          if (_formPass.currentState!.validate())
            {
              passflag = true;
            }
          else
            {print("_formPass.currentState true");}
          if (_formUser.currentState!.validate()) {
            userflag = true;
          } else {
            print("_formUser.currentState true");
          }
          if (userflag && passflag) {
            Navigator.push(
              this.context,
              MaterialPageRoute(
                builder: (context) => SelectionScreen(items),
              ),
            );
          }
        },
        child: const Text(
          'GİRİŞ YAP',
          style: TextStyle(
            color: Color(0xff2c2772),
            fontSize: 18,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            // <-- Radius
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool passflag;
    bool userflag;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mastitis Tahlil Uygulaması'),
      ),
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Image(
                        image: AssetImage(
                          'assets/haytek_beyaz.png',
                        ),
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        'Veteriner Hekim Giriş ',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 15),
                      buildEmail(),
                      const SizedBox(height: 15),
                      buildPassword(true),
                      const SizedBox(height: 20),
                      buildRememberCb(),
                      const SizedBox(height: 30),
                      buildLoginBtn(),
                      buildForgotPassBtn(),
                      const SizedBox(height: 1),
                      buildRegisterBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
