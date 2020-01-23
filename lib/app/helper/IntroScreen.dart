import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "BEM-VINDO",
        description:
            "O Squadrum é um aplicativo pensado para auxiliar nas tarefas do dia a dia " +
                "dos times que utilizam o Scrum como framework para gerenciamento de projetos.",
        pathImage: "assets/images/welcome.png",
        backgroundColor: Colors.blue[800],
      ),
    );

    slides.add(
      Slide(
        title: "APROVEITE",
        description:
            "Utilize o Squadrum para gerenciar seus times, membros, lembretes, etc. Comece agora e faça seu time decolar com todas as nossas funcionalidades!",
        pathImage: "assets/images/rocket.png",
        backgroundColor: Colors.blue[800],
      ),
    );
  }

  void onDonePress() {
    Navigator.of(context).pop();
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.white,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.white,
    );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      colorActiveDot: Colors.white,
      renderDoneBtn: this.renderDoneBtn(),
      renderSkipBtn: this.renderSkipBtn(),
      renderNextBtn: this.renderNextBtn(),
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
