import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/jokes_provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final jokesProvider = Provider.of<JokesProvider>(context);
    final favoriteJokes = jokesProvider.favoriteJokes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Favorites", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: favoriteJokes.isEmpty
          ? const Center(
        child: Text(
          "No favorites yet!",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];
          return ListTile(
            title: Text(joke.setup),
            subtitle: Text(joke.punchline),
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
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


