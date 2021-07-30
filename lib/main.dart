import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main()
{
  runApp(Calculator());
}
class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation="0";
  String result="0";
  String expression="";
  double equationFontSize=38.0;
  double resultFontSize=48.0;
  buttonPressed(String buttonText){
    setState(() {
      if(buttonText=="--"){
        if(equation=="0")
          {
            expression="-";
          }
        else{
          expression=equation+"-";
        }
      }
      if(buttonText=="C"){
        equation="0";
        result="0";
        equationFontSize=38.0;
        resultFontSize=48.0;
      }
      else if(buttonText=="⌫"){
        equationFontSize=48.0;
        resultFontSize=38.0;
        equation=equation.substring(0,equation.length-1);
        if(equation=="")
          equation="0";
      }
      else if(buttonText=="="){
        equationFontSize=38.0;
        resultFontSize=48.0;
        expression=equation;
        //expression=expression.replaceAll('*',"*");
        //expression=expression.replaceAll('/','/')
        try{
          Parser p=new Parser();
          Expression exp=p.parse(expression);
          ContextModel cm=ContextModel();
          result='${exp.evaluate(EvaluationType.REAL,cm)}';
        }catch(e){
          result="error";
        }
      }
      else{
        equationFontSize=48.0;
        resultFontSize=38.0;
        if(equation=="0"){
          equation=buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }


  Widget buildButton(String buttonText,double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.width * 0.25 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          textStyle: TextStyle(fontSize: 25.0),
          //primary: Colors.blueGrey,
          //backgroundColor: Colors.teal,
          //onSurface: Colors.grey,
        ),
        child: Text(
            buttonText,
            style: TextStyle(color:Colors.white)),

        onPressed: ()=> buttonPressed(buttonText),
      ),


    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment:Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10,0),
            child: Text(equation,style:TextStyle(fontSize:equationFontSize),),
          ),

          Container(
            alignment:Alignment.bottomRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10,0),
            child: Text(result,style:TextStyle(fontSize:resultFontSize),),
          ),
          Expanded(
            child: Divider( thickness: 1.0,),
          ),

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width *.75,
                    child: Table(
                        children: [
                          TableRow(
                              children: [
                                buildButton("C",1 , Colors.black),
                                buildButton("⌫",1,Colors.black87),
                                buildButton("/",1,Colors.black87),



                              ]
                          ),

                          TableRow(
                              children: [
                                buildButton("7",1 , Colors.black54),
                                buildButton("8",1,Colors.black54),
                                buildButton("9",1,Colors.black54),


                              ]
                          ),
                          TableRow(
                              children: [
                                buildButton("4",1 , Colors.black54),
                                buildButton("5",1,Colors.black54),
                                buildButton("6",1,Colors.black54),


                              ]
                          ),
                          TableRow(
                              children: [
                                buildButton("1",1 , Colors.black54),
                                buildButton("2",1,Colors.black54),
                                buildButton("3",1,Colors.black54),


                              ]
                          ),
                          TableRow(
                              children: [
                                buildButton("--",1 , Colors.black54),
                                buildButton("0",1,Colors.black54),
                                buildButton(".",1,Colors.black54),


                              ]
                          )

                        ]
                    )
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    alignment: Alignment.bottomLeft,
                    child: Table(
                      children: [
                        TableRow(
                            children:[
                              buildButton("+",1 , Colors.black87),
                            ]
                        ),
                        TableRow(
                            children:[
                              buildButton("%",1 , Colors.black87),
                            ]
                        ),
                        TableRow(
                            children:[
                              buildButton("*", 1, Colors.black87),
                            ]
                        ),
                        TableRow(
                            children:[
                              buildButton("-", 1, Colors.black87),
                            ]
                        ),
                        TableRow(
                            children:[
                              buildButton("=",1, Colors.black),
                            ]
                        )
                      ],
                    )
                )
              ]
          )
        ],
      ),
    );
  }
}

