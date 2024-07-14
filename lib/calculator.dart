import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();

}

class _CalculatorAppState extends State<CalculatorApp> {
  String text = '0';
  String calculationText = ''; // Added to display ongoing calculation
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '';
  String opr = '';
  String preOpr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CALCULATOR',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    calculationText,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  buildButtonRow(['AC', '+/-', '%', '/'], Colors.grey, Colors.black),
                  buildButtonRow(['7', '8', '9', 'x'], Colors.grey.shade800, Colors.white),
                  buildButtonRow(['4', '5', '6', '-'], Colors.grey.shade800, Colors.white),
                  buildButtonRow(['1', '2', '3', '+'], Colors.grey.shade800, Colors.white),
                  buildButtonRow(['0', '.', '='], Colors.grey.shade800, Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons, Color buttonColor, Color textColor) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons.map((btnText) {
          return calcButton(btnText, buttonColor, textColor);
        }).toList(),
      ),
    );
  }

  Widget calcButton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(color: txtcolor, fontSize: 14),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: btncolor,
          padding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  void calculation(String btnText) {
    if (btnText == 'AC') {
      text = '0';
      calculationText = '';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
      calculationText = '';
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
        calculationText = '$numOne $btnText ';
      } else {
        numTwo = double.parse(result);
        calculationText += '$numTwo $btnText ';
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
      calculationText = '$numOne%';
    } else if (btnText == '.') {
      if (!result.contains('.')) {
        result += '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.startsWith('-')
          ? result = result.substring(1)
          : result = '-' + result;
      finalResult = result;
    } else {
      result += btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      List<String> splitDecimal = result.split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return splitDecimal[0];
    }
    return result;
  }
}
