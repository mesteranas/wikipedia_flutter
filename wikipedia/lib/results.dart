import 'viewText.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SearchResultsGUI extends StatelessWidget{
  final results;
  final language;
  SearchResultsGUI(this.results,this.language);
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text("search results"),),
    body: Center(
      child:Column(children: [
        for (var titles in this.results)
        ListTile(title: Text(titles),onTap:() async{
              final response = await http.get(
      Uri.parse('https://' + language + '.wikipedia.org/w/api.php'
          '?action=query'
          '&format=json'
          '&titles=' + titles + ''
          '&prop=extracts|revisions'
          '&rvprop=content'),
    );

    if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final page = data['query']['pages'].values.first;
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewText(titles, page['revisions'][0]['*'])));
      }
        } ,)
      ],) ,
    ),);
  }
}