
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;





void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     title: 'Find Country',
     theme: ThemeData(
      primarySwatch: Colors.cyan,
     ),
     home: const MyCountryPage(),
    );
  }
}

class MyCountryPage extends StatefulWidget {
  const MyCountryPage({Key? key}) : super(key: key);
  

  @override
  State<MyCountryPage> createState() => _MyCountryPage();

}
class Country {
  final String capital;
  final int population;
  final double sexratio;
  final String region;
  final String code;
  final String currency;
 

 const Country({
  required this.capital,
  required this.population,
  required this.sexratio,
  required this.region,
  required this.code,
  required this.currency,
 
});
factory Country.fromJson(Map<String, dynamic> json){
  return Country(
    capital : json['capital'],
    population : json['population'],
    sexratio : json['sex_ratio'],
    region : json['region'],
    code : json['iso2'],
    
    currency : json['currencies'][0]['name'],
    
  );
}
}


 class _MyCountryPage extends State<MyCountryPage> {

      String count = "";
      
      final String apiUrl = 'https://api.api-ninjas.com/v1/country?name=';
      final String apiKey = 'Tu2HlIIU6tGgs+tgxv2K2A==yHUz6Q5a9160g6fw';
      final String flagUrl = 'https://www.flagsapi.com/code/flat/64.png';
      var population = 0;
      
      dynamic countryData;
      final searchController = TextEditingController();
      @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _searchCountry(String countryName) async {
    final response = await http.get(
      Uri.parse(apiUrl + countryName),
      headers: {
        'X-Api-Key': apiKey,
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        countryData = json.decode(response.body);
      });
       } else {
         throw Exception('Failed to load country data');
      }
      
  }


    
      
      
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(title: const Text("Countrty APP")),
        body: Padding(
          padding: const EdgeInsets.all(16),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Simple Country App",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 10),
            TextField(
              controller: searchController,
              decoration : InputDecoration(
                hintText: "Enter country name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
              onSubmitted: (value) {
                _searchCountry(value);
              },
            ),
                
              const SizedBox(height: 16),
            Expanded(
              child: countryData == null
                  ? const Center(
                       child:  Text('Enter a country name to search'),
                    )
                  : Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('infomation'),
                         // final isoCode = countryData[0]['alpha2Code'];
                          // flagUrl = 'https://www.flagsapi.com/code/flat/64.png';

                         // Image.network(
                          //  flagUrl,
                           // width: 50,
                           // height: 30,
                         // ),
                        
                          ListTile(
                             // leading: Image.network(countryData[0]['flagUrl']?? 'https://flagsapi.com/ '),
                              title: const Text ('Capital'),
                              subtitle:Text(countryData[0]['capital']?? ''),
                            
                          ),
                          ListTile(
                            title : const Text('Region'),
                            subtitle: Text(countryData[0]['region']?? ''),
                          ),
                           ListTile(
                            title : const Text('Currency'),
                            subtitle: Text(countryData[0]['currency']['name']?? ''),
                          ),
                          ListTile(
                            title : const Text('Population'),
                            subtitle: Text(countryData[0]['population']?. toInt().toString() ?? '0'),
                          ),
                          ListTile(
                            title : const Text('Gross Domestic Product'),
                            subtitle: Text(countryData[0]['gdp']?. toInt().toString() ?? '0'),
                          ),
                        // }

                        ]

              ),
            
            ),
            ),
          ],
            
           
        )));
    
  }
  
 
 }
 

 