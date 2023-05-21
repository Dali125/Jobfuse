import 'package:flutter/material.dart';

class PopularService extends StatelessWidget {
  final String imageUrl;
  final String category;
  const PopularService({Key? key, required this.imageUrl, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
      ),
      child: Image.network(
        imageUrl,
        width: 220,
        height: 180,
        fit: BoxFit.cover,
      ),
    );

  }
}
