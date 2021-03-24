import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWord extends StatefulWidget {
  @override
  _RandomWordState createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWord> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int item) {
          if (item.isOdd) return Divider();
          final index = item ~/ 2;
          if (index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomWordPairs[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final _alreadySaved = _savedWordPairs.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase,
          style: TextStyle(
            fontSize: 18.0,
          )),
      trailing: Icon(_alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: _alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if(_alreadySaved){
            _savedWordPairs.remove(pair);
          }else{
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("WordPair Generator"),
        centerTitle: true,
      ),
      body: _buildList(),
    ));
  }
}
