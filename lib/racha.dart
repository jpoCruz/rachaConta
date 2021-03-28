import 'package:flutter/material.dart';

class Racha extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Racha> {

  TextEditingController _totalController = TextEditingController();
  TextEditingController _alcoholController = TextEditingController();
  TextEditingController _peopleController = TextEditingController();
  TextEditingController _drinkingController = TextEditingController();


  String _final;
  double _currentSliderValue = 5;



  showAlertDialog(BuildContext context)
  {

    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Como usar o app"),
      content: Text("Escreva o valor total da conta e o valor das bebidas (incluído, não subtraia as bebidas do total)."
          "\n\nDepois, escreva quantas pessoas vão dividir a conta, e quantas dessas pessoas pediram bebidas com álcool."
          "\n\nPronto! Agora é só clicar em calcular."),

    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Racha Conta'),
        centerTitle: true,
        backgroundColor: Colors.amber,

      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15), //15 pixel de espaço

            TextField(
              controller: _totalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor total da conta',
                icon: Icon(Icons.attach_money),
              ),
            ),

            SizedBox(height: 15), //15 pixel de espaço

            TextField(
              controller: _alcoholController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor de todas as bebidas alcoólicas',
                icon: Icon(Icons.liquor),
              ),
            ),

            SizedBox(height: 15), //15 pixel de espaço

            TextField(
              controller: _peopleController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número total de pessoas',
                icon: Icon(Icons.person),
              ),
            ),

            SizedBox(height: 15), //15 pixel de espaço

            TextField(
              controller: _drinkingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número de pessoas bebendo',
                icon: Icon(Icons.person),
              ),
            ),

            SizedBox(height: 15), //15 pixel de espaço

              // slider para escolher porcentagem de gorjeta
            Slider(
              value: _currentSliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              activeColor: Colors.amber,
              label: ("Gorjeta: " + _currentSliderValue.round().toString() + '%'),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),

            SizedBox(height: 15),
            RaisedButton(
              color: Colors.amber,
              child: Text(
                "Calcular",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: calculate,
            ),
            SizedBox(height: 15),
            Text(
              _final == null ? "Por favor escreva os valores :)" : "$_final",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 45), //15 pixel de espaço

            FloatingActionButton(
              onPressed: () {
                showAlertDialog(context);
              },
              child: Icon(Icons.help_outline),
              backgroundColor: Colors.amber,
              
            ),
          ],
        ),
      ),
    );

  }

  void calculate() {
    double totalConta = double.parse(_totalController.text); //valor total da conta
    double totalAlcoool = double.parse(_alcoholController.text); //valor de todas as bebidas
    double pessoas = (double.parse(_peopleController.text)).floorToDouble(); //numero total de pessoas
    double pessoasBebendo = (double.parse(_drinkingController.text)).floorToDouble(); //numero de pessoas que estão bebendo

    double gorjeta = (_currentSliderValue);

    double totalSobrio = (totalConta - totalAlcoool);
    double pessoasSobrias = (pessoas - pessoasBebendo);

    double individualSobrio = (totalSobrio / pessoasSobrias);
    double individualBebendo = (totalAlcoool / pessoasBebendo);

    //adicionando o valor da gorjeta
    individualSobrio = individualSobrio + (individualSobrio * gorjeta / 100);
    individualBebendo = individualBebendo + (individualBebendo * gorjeta / 100);

    String infoGorjeta = ("Calculado com " + gorjeta.toString() + "% de gorjeta.\n");
    String finalSobrio = ("Valor individual para quem não bebeu: R\$ " + individualSobrio.toStringAsPrecision(2));
    String finalBebendo = ("\nValor individual para quem bebeu: R\$ " + individualBebendo.toStringAsPrecision(2));



    _final = infoGorjeta + finalSobrio + finalBebendo;


    setState(() {});
  }
}
