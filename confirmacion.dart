import 'package:flutter/material.dart';

class confirmacion extends StatelessWidget {
  final List<String> items;

  confirmacion({required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmación de Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '¡Pedido realizado con éxito!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Elementos del Pedido:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: items
                    .map(
                      (itemName) => ListTile(
                    title: Text(itemName),
                    // Puedes agregar más detalles aquí, como la cantidad, el precio, etc.
                  ),
                )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restaurante PM',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Menú del Restaurante PM',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  buildMenuCategory(
                    'Pizzas',
                    [
                      {'name': 'Pizza de Pepperoni', 'image': ''},
                      {'name': 'Pizza Margarita', 'image': ''},
                      {'name': 'Pizza Hawaiana', 'image': ''},
                    ],
                  ),
                  buildMenuCategory(
                    'Pastas',
                    [
                      {'name': 'Pasta Alfredo', 'image': ''},
                      {'name': 'Pasta a la Bolognesa', 'image': 'https://www.laespanolaaceites.com/wp-content/uploads/2019/05/espaguetis-a-la-bolonesa-1080x671.jpg'},
                      {'name': 'Pasta Primavera', 'image': ''},
                    ],
                  ),
                  // Agrega más categorías según sea necesario
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                addToCart();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text('Agregar al Carrito'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuCategory(String category, List<Map<String, String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          category,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 8),
        Column(
          children: items
              .map(
                (item) => buildMenuItem(category, item),
          )
              .toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildMenuItem(String category, Map<String, String> item) {
    bool isSelected = selectedItems.contains(item['name']);

    return ListTile(
      title: Text(item['name']!),
      subtitle: Text(category),
      leading: Image.network(
        item['image']!,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      trailing: Checkbox(
        value: isSelected,
        onChanged: (value) {
          setState(() {
            if (value!) {
              selectedItems.add(item['name']!);
            } else {
              selectedItems.remove(item['name']!);
            }
          });
        },
      ),
    );
  }

  void addToCart() {
    if (selectedItems.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Elementos Agregados al Carrito'),
            content: Column(
              children: [
                Text('Los siguientes elementos se han agregado al carrito:'),
                SizedBox(height: 8),
                for (var itemName in selectedItems) Text('- $itemName'),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);

                  // Navegar a la pantalla de confirmación y pasar la lista de elementos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => confirmacion(items: selectedItems),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );

      setState(() {
        selectedItems.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Selecciona al menos un elemento para agregar al carrito.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
