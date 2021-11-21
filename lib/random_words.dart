import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords  extends StatefulWidget{
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{

  final _randomWordPairs = <WordPair>[];
  final _savedWordsPairs = Set<WordPair>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordpair Generator'),
        actions: [
          IconButton(
              onPressed: _pushSaved,
              icon: const Icon(
                Icons.list,
                size: 30.0,)
          ),
        ],
      ),
      body: _buildList(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.deepPurple,
        child: Container(height: 50.0),
      ),
    );
  }

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

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordsPairs.contains(pair);
    return ListTile(
      title: Text( pair.asPascalCase,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _savedWordsPairs.remove(pair);
          }else{
            _savedWordsPairs.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved (){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _savedWordsPairs.map((WordPair pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: const TextStyle(
                  fontSize: 16.0
              ),
            ),
          );
        }
        );
        final List<Widget> divided = ListTile.divideTiles(
          tiles: tiles,
          context: context,
        ).toList();

        return Scaffold(
          appBar: AppBar(title: const Text('Saved WordsPairs')),
          body: ListView(
            children: divided,
          ),
        );
      },
    ),
    );
  }
}

