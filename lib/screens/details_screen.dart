import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String title,description;
  const DetailsScreen({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(title, style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                const SizedBox(height: 15),
                Text(
                description,
                style:const TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
