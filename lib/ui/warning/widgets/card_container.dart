import 'package:firebase_notify_app/domain/models/alert_entity.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({super.key, required this.alertEntity});

  final AlertEntity alertEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsetsDirectional.symmetric(vertical: 2.0, horizontal: 3.0),
      child: Column(
        mainAxisSize: .min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.flood_outlined, color: alertEntity.quota.color),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Alerta!!', style: TextStyle(color: Colors.red)),
                Text(
                  alertEntity.formattedTimestamp,
                  style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
                ),
              ],
            ),
            subtitle: Text(alertEntity.message),
          ),
        ],
      ),
    );
  }
}
