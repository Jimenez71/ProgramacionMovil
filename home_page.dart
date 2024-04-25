import 'package:flutter/material.dart';
import 'package:proyecto/vistas/bebidas.dart';
import 'package:proyecto/vistas/desayunos.dart';
import 'package:proyecto/vistas/paquete.dart';
import 'package:proyecto/vistas/niños.dart'; // Importa la vista de niños
import 'package:proyecto/vistas/pago.dart'; // Importa la vista de pago

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breakfast Menu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.brown[100], // Color café para el fondo
      ),
      home: Navegador(),
    );
  }
}

class Navegador extends StatefulWidget {
  @override
  _NavegadorState createState() => _NavegadorState();
}

class _NavegadorState extends State<Navegador> {
  int _selectedIndex = 0;

  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Breakfast Menu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Colors.white70,
          ),
        ),
        backgroundColor: Colors.brown, // Color café para la barra de App
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _openDrawer(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.brown,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Desayunos'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Paquetes'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Bebidas'),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Niños'),
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),
      body: _selectedIndex == 0
          ? DesayunoScreen()
          : _selectedIndex == 1
          ? MenuPaquetes()
          : _selectedIndex == 3
          ? MenuNinos()
          : _selectedIndex == 2
          ? BebidasScreen()
          : Center(
        child: Text(
          'Página no implementada aún',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
        Colors.brown, // Color café para la barra de navegación inferior
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.breakfast_dining_rounded),
            label: 'Desayunos',
            backgroundColor: Colors.brown,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Paquetes',
            backgroundColor: Colors.brown,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Bebidas',
            backgroundColor: Colors.brown,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.child_friendly),
            label: 'Niños',
            backgroundColor: Colors.brown,
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
