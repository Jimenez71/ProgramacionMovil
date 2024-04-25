import 'package:flutter/material.dart';

class BebidasScreen extends StatefulWidget {
  @override
  _BebidasScreen createState() => _BebidasScreen();
}

class _BebidasScreen extends State<BebidasScreen> {
  List<Map<String, dynamic>> _menuPaquetes = [
    {
      "nombre": "Té Chaí",
      "imagen":
      "https://cdn.shopify.com/s/files/1/0327/1603/0091/files/beneficios_del_te_chai.jpg?v=1647241218", // Enlace de la imagen del paquete
      "descripcion":
      "Una exquisita mezcla de té negro con una combinación de especias aromáticas como canela, cardamomo, clavo de olor, jengibre y pimienta negra. Este té caliente y reconfortante ofrece una experiencia única para los amantes del té. "
          "Disfruta de su sabor robusto y equilibrado, perfecto para acompañar cualquier momento del día.",
      "precio": "\$1.99",
    },
    {
      "nombre": "Capuchino Caramel",
      "imagen":
      "https://okdiario.com/img/2021/10/16/caramel-machiato.jpg", // Enlace de la imagen del paquete
      "descripcion": " Una deliciosa variante del clásico capuchino, infusionado con un toque de caramelo suave y dulce. Este café indulgente se combina con espuma de leche cremosa y una generosa porción de jarabe de caramelo, creando una experiencia indulgente y reconfortante para los amantes del café con un toque dulce. Perfecto para disfrutar en cualquier momento del día, este capuchino de "
          "caramelo seguramente deleitará tu paladar con su irresistible sabor agridulce",
      "precio": "\$3.99",
    },
    {
      "nombre": "Agua",
      "imagen":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyAFICieiFSf7RI2QSb7xdOKP7To9EnnnHYCv7QSfalA&s", // Enlace de la imagen del paquete
      "descripcion": " ",

      "precio": "\$1",
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

  void _eliminarDelCarrito(int index) {
    setState(() {
      _carrito.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paquetes Menu'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _menuPaquetes.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _menuPaquetes[index]["imagen"],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      _menuPaquetes[index]["nombre"],
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
                          _menuPaquetes[index]["descripcion"],
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Precio: ${_menuPaquetes[index]["precio"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _agregarAlCarrito(context, _menuPaquetes[index]);
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
                    _eliminarDelCarrito(index);
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
