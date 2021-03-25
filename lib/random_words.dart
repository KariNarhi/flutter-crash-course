import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// RandomWords class
class RandomWords extends StatefulWidget {
  // Create state for RandomWords
  @override
  RandomWordsState createState() => RandomWordsState(); 
}

// RandomWords State
class RandomWordsState extends State<RandomWords> {
  // Array of random word pairs
  final _randomWordPairs = <WordPair>[];
  // Set of saved word pairs
  final _savedWordPairs = Set<WordPair>();

  // Widget for building a ListView
  Widget _buildList() {
    return ListView.builder(
        // ListView padding
        padding: const EdgeInsets.all(16.0),
        // itemBuilder function, takes context and item as parameters
        itemBuilder: (context, item) {
          // Render divider if item is odd
          if (item.isOdd) return Divider();

          // Item index (non-odd)
          final index = item ~/ 2;

          // If index is greater or equal to _randomWordPairs length,
          // then generate 10 new wordpairs
          if (index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }

          // Return ListTile after building it
          return _buildRow(_randomWordPairs[index]);
        });
  }

  // Widget for building a ListTile
  Widget _buildRow(WordPair pair) {
    // Boolean result of checking if word is already saved
    final alreadySaved = _savedWordPairs.contains(pair);

    // Return ListTile widget
    return ListTile(
      // ListTile title
      title: Text(
        pair.asPascalCase,
        style: TextStyle(fontSize: 18.0),
      ),
      // Trailing for the title (conditional favorite icon)
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      // Do following when the tile is tapped
      onTap: () {
        setState(() {
          if (alreadySaved) {
            // If wordpair already saved, remove it.
            _savedWordPairs.remove(pair);
          } else {
            // If wordpair not saved, add it.
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  // Function for pushing saved words to Saved WordPairs view
  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      // Iterable of wordpair tiles
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        // Return ListTile
        return ListTile(
          // ListTile title
          title: Text(
            pair.asPascalCase,
            style: TextStyle(fontSize: 16.0),
          ),
        );
      });
      // Divide selected tiles and put them into a list
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      // Return Saved WordPairs scaffolding
      return Scaffold(
        appBar: AppBar(
          title: Text('Saved WordPairs'),
        ),
        // Body consisting of selected wordpairs with dividers
        body: ListView(children: divided),
      );
    }));
  }

  // Widget for building the WordPair Generator view
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPair Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      // Body consisting of list of wordpairs
      body: _buildList(),
    );
  }
}
