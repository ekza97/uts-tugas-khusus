import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CekIMT()),
      ],
      child: MyApp(),
    ),
  );
}

class CekIMT extends ChangeNotifier {
  String StatusGizi = 'Belum ada hasil';
  double hasil;
  String imt;

  void validasiIMT(double weight, double height) {
    this.hasil = weight / ((height / 100) * 2);
    if (this.hasil > 40) {
      this.imt = this.hasil.toString();
      this.StatusGizi = 'Obese Class 3';
    } else if (this.hasil >= 35 && this.hasil < 40) {
      this.imt = this.hasil.toString();
      this.StatusGizi = 'Obese Class 2';
    } else if (this.hasil >= 30 && this.hasil < 35) {
      this.imt = this.hasil.toString();
      this.StatusGizi = 'Obese Class 1';
    } else if (this.hasil >= 25 && this.hasil < 30) {
      this.imt = this.hasil.toString();
      this.StatusGizi = 'Overweight';
    } else if (this.hasil >= 18.5 && this.hasil < 25) {
      this.imt = this.hasil.toString();
      this.StatusGizi = 'Normal Range';
    } else {
      this.imt = this.hasil.toString();
      this.StatusGizi = 'Underweight';
    }
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final txtWeight = TextEditingController();
  final txtHeight = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTS Tugas Khusus',
      home: Scaffold(
        appBar: AppBar(
          title: Text('UTS Tugas Khusus'),
        ),
        body: Form(
          key: _formKey,
          child: Consumer<CekIMT>(builder: (context, provider, snapshot) {
            return Center(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Container(
                        child: Text('Calculate Your Body Mass Index'),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: txtWeight,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.looks_one),
                            hintText: 'Enter your weight in Kg',
                            labelText: 'Your Weight *'),
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your weight";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: txtHeight,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.looks_two),
                            hintText: 'Enter your height in cm',
                            labelText: 'Your Height *'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your height";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            double weight = double.parse(txtWeight.text);
                            double height = double.parse(txtHeight.text);
                            provider.validasiIMT(weight, height);
                          }
                        },
                        child: Text('Check Your IMT'),
                        style: ElevatedButton.styleFrom(primary: Colors.purple),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        (provider.imt == null)
                            ? provider.StatusGizi
                            : 'Your IMT ' +
                                provider.imt +
                                ' = ' +
                                provider.StatusGizi,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          txtWeight.clear();
                          txtHeight.clear();
                        },
                        child: Text('Check Again'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.purpleAccent),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text('Created by Eka Saputra - 2020 65 053'),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
