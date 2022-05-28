import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:vetlogin/model/data.dart';
import 'package:vetlogin/screen/list_screen.dart';

class SimpleDropDown extends StatefulWidget {
  @override
  _SimpleDropDownState createState() => _SimpleDropDownState();
}

class _SimpleDropDownState extends State<SimpleDropDown> {
  List<Data> animalList = [];
  TextEditingController farmname = TextEditingController();
  TextEditingController animalId = TextEditingController();
  TextEditingController analysisKind = TextEditingController();
  String search_text = "";
  _search_text(value) => setState(() => search_text = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahlil Görüntüle'),
      ),
      resizeToAvoidBottomInset: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: 600,
                  height: 1000,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 45, vertical: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, right: 222, left: 0.0, bottom: 5),
                              child: Text(
                                "Çiftlik Adı",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: TextField(
                                controller: farmname,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, right: 222, left: 0.0, bottom: 5),
                              child: Text(
                                "Hayvan İd",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: TextField(
                                controller: animalId,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, right: 218, left: 0.0, bottom: 5),
                              child: Text(
                                "Tahlil Türü",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: TextField(
                                controller: analysisKind,
                              ),
                            ),
                            buildLoginBtn()
                          ],
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          listQuery();
        },
        child: Text(
          'Görüntüle',
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

  listQuery() async {
    var url = Uri.parse("http://proje.yusufboran.com/mail/mastitis.php");
    var data = {
      'farmname': farmname.text.toString(),
      'animalId': animalId.text.toString(),
      'analysisKind': analysisKind.text.toString(),
    };

    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      print("mastitis-view run");
      var data = json.decode(response.body);
      data.forEach((e) {
        double value = double.parse(e["birinci_lob"]);
        value += double.parse(e["ikinci_lob"]);
        value += double.parse(e["ucuncu_lob"]);
        value += double.parse(e["dorduncu_lob"]);
        value = value / 4;

        animalList.add(Data(
            dateTime: e["transaction_date"].toString(),
            analysisKind: e["hastalik_turu"].toString(),
            farmName: e["ciftlik_isim"].toString(),
            mastitisValue: value,
            animalId: e["hayvan_id"].toString()));
      });
    } else {
      print('A network error occurred : mastitis-view');
    }
    openScren(animalList);
  }

  openScren(items) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ListScreen(items: items)),
    );
  }
}
