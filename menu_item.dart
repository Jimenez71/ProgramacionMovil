// widgets/menu_item.dart
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  const MenuItem({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(name),
            subtitle: Text(description),
            trailing: Text('\$$price'),
          ),
        ],
      ),
    );
  }
}
