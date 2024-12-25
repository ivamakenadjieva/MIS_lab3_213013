import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/joke_model.dart';
import '../providers/jokes_provider.dart';

class RandomJoke extends StatefulWidget {
  const RandomJoke({super.key});

  @override
  State<RandomJoke> createState() => _RandomJokeState();
}

class _RandomJokeState extends State<RandomJoke> {
  Joke? joke;

  @override
  void initState() {
    super.initState();
    getTheRandomJoke();
  }

  void getTheRandomJoke() async {
    ApiService.getRandomJoke().then((data) {
      setState(() {
        joke = Joke.fromJson(data);
      });
    }).catchError((error) {
      setState(() {
        joke = Joke(
          type: "Error",
          setup: "Failed to load joke.",
          punchline: "Please try again later.",
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final jokesProvider = Provider.of<JokesProvider>(context);
    final isFavorite = joke != null && jokesProvider.isFavorite(joke!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Random Joke", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (joke != null) ...[
                Text(
                  joke!.setup,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  joke!.punchline,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    if (joke != null) {
                      jokesProvider.toggleFavorite(joke!);
                    }
                  },
                ),
              ] else ...[
                const CircularProgressIndicator(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}


