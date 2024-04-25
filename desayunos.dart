import 'package:flutter/material.dart';
import 'package:proyecto/vistas/pago.dart';
// Variable global para almacenar el total del carrito
double cartTotal = 0.0;

void main() {
  runApp(MaterialApp(
    title: 'Desayuno App',
    home: DesayunoScreen(),
  ));
}

class DesayunoScreen extends StatefulWidget {
  @override
  _DesayunoScreenState createState() => _DesayunoScreenState();
}

class _DesayunoScreenState extends State<DesayunoScreen> {
  List<Map<String, dynamic>> _menuDesayuno = [
    {
      "nombre": "Huevos Rancheros",
      "imagen":
      "https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/447f5b7d44422586f8f606cc5aab9996/Derivates/ecb30dd92c89a663d3a96595ebd27520989e33c4.jpg",
      "descripcion":
      "Huevos estrellados sobre tortillas de maíz con salsa ranchera.",
      "precio": "\$5.99",
    },
    {
      "nombre": "Pancakes",
      "imagen":
      "https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/CCBC8257-1614-4027-A5F1-B3A40FC46905/Derivates/DB4155EF-4C31-4E24-8B06-419F09F2757F.jpg",
      "descripcion": "Deliciosos pancakes esponjosos con sirope de arce.",
      "precio": "\$4.49",
    },
    {
      "nombre": "Oatmeal",
      "imagen":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8PZj2SR9X6AOJUJtiGxYoJMYvwYmJMi3E3DdZ1t0kUg&s",
      "descripcion": "Avena cocida con frutas frescas y miel.",
      "precio": "\$3.99",
    },
    {
      "nombre": "Fruit Salad",
      "imagen":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREd7GQ94gAQsybpfGFM4K7QzuhXWJZz_ni2VByaLMrwQ&s",
      "descripcion": "Una selección de frutas frescas de temporada.",
      "precio": "\$6.99",
    },
  ];

  List<Map<String, dynamic>> _carrito = [];

  int _calcularTotalCarrito() {
    int total = 0;
    _carrito.forEach((item) {
      int cantidad = int.parse(item['cantidad'].toString());
      double precio =
          double.tryParse(item['precio'].toString().replaceAll('\$', '')) ?? 0;
      total += (cantidad * precio).toInt();
    });
    return total;
  }

  void _agregarAlCarrito(BuildContext context, Map<String, dynamic> item) {
    int cantidad = 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cantidad de ${item["nombre"]}'),
          content: TextFormField(
            keyboardType: TextInputType.number,
            initialValue: '1',
            onChanged: (value) {
              cantidad = int.tryParse(value) ?? 1;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final index = _carrito.indexWhere(
                          (element) => element['nombre'] == item["nombre"]);
                  if (index != -1) {
                    _carrito[index]['cantidad'] += cantidad;
                  } else {
                    _carrito.add({
                      'nombre': item["nombre"],
                      'cantidad': cantidad,
                      'precio': item['precio'],
                    });
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  void _quitarDelCarrito(Map<String, dynamic> item) {
    setState(() {
      _carrito.removeWhere((element) => element['nombre'] == item["nombre"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desayuno Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.payment),
            onPressed: () {
              // Navegar a la página de pago
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PagoScreen(cartTotal: cartTotal)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _menuDesayuno.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _menuDesayuno[index]["imagen"],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      _menuDesayuno[index]["nombre"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          _menuDesayuno[index]["descripcion"],
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Precio: ${_menuDesayuno[index]["precio"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _agregarAlCarrito(context, _menuDesayuno[index]);
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Carrito:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _carrito.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_carrito[index]["nombre"]),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    _quitarDelCarrito(_carrito[index]);
                  },
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: Icon(Icons.remove_shopping_cart),
                      title: Text(
                        _carrito[index]["nombre"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            "Cantidad: ${_carrito[index]["cantidad"]}",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Precio: ${_carrito[index]["precio"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                
                  '\$${_calcularTotalCarrito().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
