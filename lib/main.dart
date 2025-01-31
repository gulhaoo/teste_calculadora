import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String entrada = '';
  String resultado = '0';
  String operacao = '';
  double primeiroNumero = 0;
  double segundoNumero = 0;

  void atualizarEntrada(String valor) {
    setState(() {
      entrada += valor;
    });
  }

  void definirOperacao(String op) {
    setState(() {
      operacao = op;
      primeiroNumero = double.parse(entrada);
      entrada = '';
    });
  }

  void calcularResultado() {
    setState(() {
      segundoNumero = double.parse(entrada);
      switch (operacao) {
        case '+':
          resultado = (primeiroNumero + segundoNumero).toString();
          break;
        case '-':
          resultado = (primeiroNumero - segundoNumero).toString();
          break;
        case '*':
          resultado = (primeiroNumero * segundoNumero).toString();
          break;
        case '/':
          resultado = (primeiroNumero / segundoNumero).toString();
          break;
      }
      entrada = resultado;
    });
  }

  void calcularFuncao(String funcao) {
    setState(() {
      try {
        double valor = double.parse(entrada);
        switch (funcao) {
          case 'sin':
            resultado = sin(valor).toString();
            break;
          case 'cos':
            resultado = cos(valor).toString();
            break;
          case 'tan':
            resultado = tan(valor).toString();
            break;
          case 'sqrt':
            resultado = sqrt(valor).toString();
            break;
        }
        entrada = resultado;
      } catch (e) {
        resultado = 'Erro';
      }
    });
  }

  void limpar() {
    setState(() {
      entrada = '';
      resultado = '0';
      operacao = '';
      primeiroNumero = 0;
      segundoNumero = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              color: Colors.blue,
              child: Text(
                entrada,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              color: Colors.white,
              child: Text(
                resultado,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(8),
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  ...['7', '8', '9', '/'].map((value) => buildButton(value)),
                  ...['4', '5', '6', '*'].map((value) => buildButton(value)),
                  ...['1', '2', '3', '-'].map((value) => buildButton(value)),
                  ...['0', 'C', '=', '+'].map((value) => buildButton(value)),
                  ...['sin', 'cos', 'tan', 'sqrt'].map((value) => buildButton(value)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String value) {
    return ElevatedButton(
      onPressed: () {
        if (value == 'C') {
          limpar();
        } else if (['+', '-', '*', '/'].contains(value)) {
          definirOperacao(value);
        } else if (value == '=') {
          calcularResultado();
        } else if (['sin', 'cos', 'tan', 'sqrt'].contains(value)) {
          calcularFuncao(value);
        } else {
          atualizarEntrada(value);
        }
      },
      child: Text(
        value,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
