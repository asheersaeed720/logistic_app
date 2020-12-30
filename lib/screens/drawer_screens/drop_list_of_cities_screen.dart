import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/city.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class DropCitiesListScreen extends StatelessWidget {
  static const String routeName = '/drop-cities-list';
  @override
  Widget build(BuildContext context) {
    final userPvd = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Drop Cities List'),
      ),
      body: FutureBuilder<List<City>>(
        future: userPvd.getDropCityList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<City> city = snapshot.data;
            return ListView.builder(
              itemCount: city.length,
              itemBuilder: (context, i) {
                return Card(
                  elevation: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        '${city[i].cityName}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
