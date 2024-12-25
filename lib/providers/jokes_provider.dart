import 'package:flutter/material.dart';
import '../models/joke_model.dart';

class JokesProvider with ChangeNotifier {
  List<Joke> _favoriteJokes = [];

  List<Joke> get favoriteJokes => _favoriteJokes;

  void toggleFavorite(Joke joke) {
    if (_favoriteJokes.contains(joke)) {
      _favoriteJokes.remove(joke);
    } else {
      _favoriteJokes.add(joke);
    }
    notifyListeners();
  }

  bool isFavorite(Joke joke) {
    return _favoriteJokes.any((fav) => fav.setup == joke.setup && fav.punchline == joke.punchline);
  }
}







