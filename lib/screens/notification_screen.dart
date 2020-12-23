import 'package:flutter/material.dart';

import 'package:hani_almutairi_logistic/models/notification.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    final userPvd = Provider.of<UserProvider>(context);
    final authPvd = Provider.of<AuthProvider>(context);
    // return Scaffold(
    //   body: Center(
    //     child: Text(
    //       "${getTranslatedValue(context, 'no_notifications_found')}",
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: FutureBuilder(
          future: userPvd.getNotification(authPvd.user),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<NotificationMessage> message = snapshot.data;
              return ListView.builder(
                itemCount: message.length,
                itemBuilder: (context, i) {
                  // return Text('${message[i].text}');
                  return Card(
                    child: ListTile(
                      title: Text('${message[i].heading}'),
                      subtitle: Text('${message[i].text}'),
                      trailing: Icon(Icons.message_outlined),
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
      ),
    );
  }
}
