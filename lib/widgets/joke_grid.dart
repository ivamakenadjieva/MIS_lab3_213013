import 'package:flutter/material.dart';

class JokeGrid extends StatelessWidget {
  final List<String> jokeTypes;

  const JokeGrid({super.key, required this.jokeTypes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 3 / 4,
      ),
      itemCount: jokeTypes.length,
      itemBuilder: (context, index) {
        final type = jokeTypes[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/jokes', arguments: type);
          },
          child: Card(
            color: Colors.blue[100],
            child: Center(
              child: Text(
                type.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}