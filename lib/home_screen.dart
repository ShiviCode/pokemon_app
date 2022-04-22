import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokemon_app/pokedata.dart';


class HomeScreen extends StatelessWidget {
 // const HomeScreen({ Key? key }) : super(key: key);



  var pokeapi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  
 
   Future<PokeData> getPokemon()async{
     var result = await http.get(Uri.http("raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json"));
     var body = json.decode(result.body);   
   
      return PokeData.fromJson(body);
   }
 void todo(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PokeData>(
        future: getPokemon(),
        builder: (context,sanp){
          if(sanp.hasData){

              return GridView.builder(
      
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1
                ), 
      
                itemCount: sanp.data!.pokemon!.length,
      
                itemBuilder: (context,index){
                  return Card(
                    child: Column(
                      children: [
                        
                        Text("${sanp.data!.pokemon![index].name}"),
                      
                        CachedNetworkImage(
                            imageUrl: sanp.data!.pokemon![index].img!,
                        ),
                       
                      ],
                    ),
                  );
                },
               );
             }
      
              else{
                return Center(
                    child: CircularProgressIndicator(),
                  ); 
                 }
           },
        ),
      
    );
  }
}

