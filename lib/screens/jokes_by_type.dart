import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/jokes_provider.dart';
import '../models/joke_model.dart';
import '../services/api_service.dart';

class JokesByType extends StatefulWidget {
  final String type;
  const JokesByType({super.key, required this.type});

  @override
  State<JokesByType> createState() => _JokesByTypeState();
}

class _JokesByTypeState extends State<JokesByType> {
  List<Joke> jokes = [];

  @override
  void initState() {
    super.initState();
    getJokes();
  }

  void getJokes() async {
    ApiService.getJokesByType(widget.type).then((response) {
      setState(() {
        jokes = response.map<Joke>((j) => Joke.fromJson(j)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final jokesProvider = Provider.of<JokesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("${widget.type.toUpperCase()} Jokes",
            style: const TextStyle(color: Colors.white)),
      ),
      body: jokes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          final joke = jokes[index];
          final isFavorite = jokesProvider.isFavorite(joke);

          return ListTile(
            title: Text(joke.setup),
            subtitle: Text(joke.punchline),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                jokesProvider.toggleFavorite(joke);
              },
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}






