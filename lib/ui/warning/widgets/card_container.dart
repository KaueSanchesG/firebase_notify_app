import 'package:firebase_notify_app/domain/models/warning_entity.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({super.key, required this.warningEntity});

  final WarningEntity warningEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsetsDirectional.symmetric(vertical: 2.0, horizontal: 3.0),
      child: Column(
        mainAxisSize: .min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.flood_outlined,
              color: warningEntity.quota.color,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Alerta!!', style: TextStyle(color: Colors.red)),
                Text(
                  warningEntity.formattedTimestamp,
                  style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
                ),
              ],
            ),
            subtitle: Text(warningEntity.message),
          ),
        ],
      ),
    );
  }
}
