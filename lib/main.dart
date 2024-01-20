import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FLASHCARDS APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(94, 128, 99, 1),
        elevation: 0, 
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_img.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: screenWidth / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                List<String> subjects = ['Calculus', 'Geometry', 'Mechanics', 'EEE'];
                double textSize = screenWidth * 0.05;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          subject: subjects[index],
                          cardContent: getCardContent(index),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(94, 128, 99, 0.9),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        subjects[index],
                        style: TextStyle(
                          fontSize: textSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 4,
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String subject;
  final List<String> cardContent;

  const DetailsPage({required this.subject, required this.cardContent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Swipe Cards - $subject',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(94, 128, 99, 1),
      ),
      body: Center(
        child: SwipeCards(subject: subject, cardContent: cardContent),
      ),
    );
  }
}

class SwipeCards extends StatelessWidget {
  final String subject;
  final List<String> cardContent;

  SwipeCards({required this.subject, required this.cardContent, Key? key})
      : super(key: key);

  Widget buildCard(String latexExpression) {
    Color cardColor = Color.fromRGBO(155, 186, 159, 1);

    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.black, width: 2.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: cardColor,
        child: Center(
          child: TeXView(
            renderingEngine: TeXViewRenderingEngine.katex(),
            child: TeXViewDocument(
              latexExpression,
              style: TeXViewStyle.fromCSS('text-align: center; font-size: 30px'),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: cardContent.length,
      itemBuilder: (context, index) {
        return buildCard(cardContent[index]);
      },
    );
  }
}


List<String> getCardContent(int index) {
  List<List<String>> cardContents = [
    [
      r'\(\frac{d}{dx} x = 1\)',
      r'\(\frac{d}{dx} a = 0\)',
      r'\(\frac{d}{dx} \frac{1}{x} = -\frac{1}{x^2}\)',
      r'\(\frac{d}{dx}\ln(x) = \frac{1}{x}\)',
      r'\(\frac{d}{dx} e^x = e^x\)',
    ],
    [
      r' Area of Square = \[ A = s^2 \]',
      r' Area of Rectangle = \[ A = l \cdot w \]',
      r' Area of Circle = \[ A_{\text{circle}} = \pi r^2 \]',
      r' Area of Parallelogram = \[ A_{\text{parallelogram}} = b \cdot h \]',
      r'\Area of Cube = [ A = 6s^2 \]',
    ],
    [
      r'\[ v = u + at \]',
      r'\[ KE = \frac{1}{2} m v^2 \]',
      r'\[ W = mg \]',
      r'\[ F = ma \]',
      r'\[ P = \frac{W}{t} \]',
    ],
    [
      r'\[ I = \frac{Q}{t} \]',
      r'\[ R = \frac{V}{I} \]',
      r'\[ R_{\text{series}} = R_1 + R_2 + \ldots + R_n \]',
      r'\[ \frac{1}{R_{\text{parallel}}} = \frac{1}{R_1} + \frac{1}{R_2} + \ldots + \frac{1}{R_n} \]',
      r'\[ R = \rho \cdot \frac{L}{A} \]',
    ],
  ];
  return cardContents[index];
}
