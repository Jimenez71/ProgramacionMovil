import 'package:flutter/material.dart';

class PagoScreen extends StatelessWidget {
  final double cartTotal;

  PagoScreen({required this.cartTotal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Pago'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '¡Bienvenido a la página de pago!',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                'Total a pagar:  \$${cartTotal.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puedes implementar la lógica de pago
                    // Por ejemplo, procesar el pago, guardar la transacción, etc.
                    // Una vez que se complete el pago, puedes navegar a otra pantalla
                    // o mostrar un mensaje de confirmación.
                    Navigator.pop(context); // Volver a la pantalla anterior después del pago
                  },
                  child: Text(
                    'Realizar Pago',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}