import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/joke_grid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    getJokeTypes();
  }

  void getJokeTypes() async {
    ApiService.getJokeTypesFromAPI().then((types) {
      setState(() {
        jokeTypes = List<String>.from(types);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("213013", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/favorites');
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/random');
            },
            child: const Text(
              "Random Joke",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: JokeGrid(jokeTypes: jokeTypes),
    );
  }
}

