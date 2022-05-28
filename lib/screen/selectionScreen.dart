import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vetlogin/screen/analysisView.dart';
import 'package:vetlogin/screen/analysis_input.dart';
import 'package:vetlogin/widget/selectButton.dart';

class SelectionScreen extends StatefulWidget {
  late final List<String> items;

  SelectionScreen(this.items) {}

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        SelectButton(
                          text: "Tahlil Görüntüle",
                          function: openAnalysisView,
                        ),
                        SelectButton(
                            text: "Tahlil Gir", function: openAnalisisInput)
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

  void openAnalysisView() {
    Navigator.push(
      this.context,
      MaterialPageRoute(
        builder: (context) => SimpleDropDown(),
      ),
    );
  }

  void openAnalisisInput() {
    Navigator.push(
      this.context,
      MaterialPageRoute(
        builder: (context) => AnaliysisInput(),
      ),
    );
  }
}