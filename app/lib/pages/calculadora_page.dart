import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String infoText = 'Informe seus dados';

  String? errorTextWeight;
  String? errorTextHeight;

  void resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      infoText = 'Informe seus dados';
      errorTextWeight = null;
      errorTextHeight = null;
    });
  }

  void validate() {
    String weight = weightController.text;
    String height = heightController.text;

    setState(() {
      if (weight.isEmpty) {
        errorTextWeight = 'Preencha o seu peso';
      } else {
        errorTextWeight = null;
        infoText = 'Informe seus dados';
      }

      if (height.isEmpty) {
        errorTextHeight = 'Preencha a sua altura';
      } else {
        errorTextHeight = null;
        infoText = 'Informe seus dados';
      }
    });

    if (weight.isNotEmpty && height.isNotEmpty) {
      calculate();
    }
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if (imc < 17) {
        infoText = 'Muito abaixo do peso (${imc.toStringAsFixed(2)})';
      } else if (imc < 18.50) {
        infoText = 'Abaixo do peso (${imc.toStringAsFixed(2)})';
      } else if (imc < 25) {
        infoText = 'Peso normal (${imc.toStringAsFixed(2)})';
      } else if (imc < 30) {
        infoText = 'Acima do peso (${imc.toStringAsFixed(2)})';
      } else if (imc < 35) {
        infoText = 'Obesidade Grau I (${imc.toStringAsFixed(2)})';
      } else if (imc < 40) {
        infoText = 'Obesidade Grau II (${imc.toStringAsFixed(2)})';
      } else if (imc > 40) {
        infoText = 'Obesidade Grau III (${imc.toStringAsFixed(2)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora de IMC',
          style: GoogleFonts.quicksand(),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: resetFields,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 20),
          child: Column(
            children: [
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'Peso (kg)',
                  labelStyle: GoogleFonts.quicksand(
                    color: Colors.green,
                  ),
                  hintText: 'Ex: 85',
                  hintStyle: const TextStyle(
                    fontSize: 20,
                  ),
                  errorText: errorTextWeight,
                  suffixText: 'kg',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'Altura (cm)',
                  labelStyle: GoogleFonts.quicksand(
                    color: Colors.green,
                  ),
                  hintText: 'Ex: 190',
                  hintStyle: const TextStyle(
                    fontSize: 20,
                  ),
                  errorText: errorTextHeight,
                  suffixText: 'cm',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    validate();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    'Calcular',
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  infoText,
                  style: GoogleFonts.quicksand(
                    color: Colors.green,
                    fontSize: 30,
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
