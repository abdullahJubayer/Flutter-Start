import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black
        )
      ),
      home: Scaffold(
        body: const Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _savedWord = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to dart"),
          actions: [
            IconButton(
              onPressed: _loadNext,
              icon: const Icon(Icons.list),
              tooltip: "Save Item",
            )
          ],
        ),
        body: _buildSuggestions());
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return const Divider();
        }
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWord.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        semanticLabel: alreadySaved ? "Remove from save" : "Save",
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWord.remove(pair);
          } else {
            _savedWord.add(pair);
          }
        });
      },
    );
  }

  void _loadNext() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final _tiles = _savedWord.map((pair) {
        return ListTile(
            title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ));
      });
      final divided=_tiles.isNotEmpty?
          ListTile.divideTiles(context: context,tiles: _tiles,).toList():<Widget>[];
      return Scaffold(
        appBar: AppBar(title: const Text("Saved show"),
        ),
        body: ListView(children: divided,),
      );
    }));
  }
}
