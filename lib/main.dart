import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp( const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const RandomWords(),
    );
  }
}

class RandomWords  extends StatefulWidget{

  const RandomWords({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RandomWords();
}

class _RandomWords extends State<RandomWords>{

  final _randomWordPairs = <WordPair>[];

  @override
  Widget build(BuildContext context) {

    Widget _buildList() {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();
          final index = item ~/ 2;
          if (index >= _randomWordPairs.length){
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomWordPairs[index]);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordpair Generator'),
      ),
      body: _buildList(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.deepPurple,
        child: Container(height: 50.0),
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text( pair.asPascalCase,
      style: const TextStyle(
        fontSize: 18.0,
      ),
      ),
    );
  }
}

