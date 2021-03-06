import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/model/DarkThemeProvider.dart';
import 'package:pokemon/model/pokehub.dart';
import 'package:pokemon/screens/details_screen.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  var response;
  PokeHub pokemon;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    pokemon = PokeHub.fromJson(jsonData);
//    print(pokemon.pokemon[0].name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        showModalBottomSheet(context: context, builder: (context){
          return Container(
            decoration: BoxDecoration(
                color: Colors.transparent
            ),
            height: 100,
            width: double.infinity,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                    ),
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 20, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("Do you really want to exit?",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          SizedBox(width: 5,),
                          FlatButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            color: Colors.black,
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  letterSpacing: 1
                              ),
                            ),
                          ),
                          SizedBox(width: 25,),
                          FlatButton(
                            onPressed: (){
                              exit(0);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            color: Colors.white30,
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text("Pokemon"),
          actions: [
                IconButton(icon: themeChange.darkTheme?Icon(Icons.lightbulb): Icon(Icons.nightlight_round), onPressed: (){
                  themeChange.darkTheme = !themeChange.darkTheme;
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              pokemon = null;
              getData();
            });
          },
          child: Icon(
            Icons.refresh,
          ),
          backgroundColor: Colors.redAccent,
        ),
        body: Container(
          child: pokemon != null
              ? ListView.builder(
                  itemCount: pokemon.pokemon.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Hero(
                        tag: "${pokemon.pokemon[index].id}",
                        child: Image.network("${pokemon.pokemon[index].img}"),
                      ),
                      title: Text(
                        "${pokemon.pokemon[index].name}",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${pokemon.pokemon[index].weight}"),
                      trailing: Text("${pokemon.pokemon[index].type[0]}"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      pokemon: pokemon,
                                      index: index,
                                    )));
                      },
                    );
                  })
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}