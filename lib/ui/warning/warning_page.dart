import 'package:firebase_notify_app/domain/enums/quota_type.dart';
import 'package:firebase_notify_app/domain/models/alert_entity.dart';
import 'package:firebase_notify_app/ui/warning/widgets/card_container.dart';
import 'package:flutter/material.dart';

class Warning extends StatelessWidget {
  const Warning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text('Alertas'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          CardContainer(
            alertEntity: AlertEntity(
              id: 1,
              message: "Uma mensagem de teste",
              quota: QuotaType.minor,
              timestamp: DateTime.now(),
            ),
          ),
          Container(padding: EdgeInsets.all(3.0)),
          CardContainer(
            alertEntity: AlertEntity(
              id: 2,
              message: "Uma teste",
              quota: QuotaType.major,
              timestamp: DateTime.now(),
            ),
          ),
          Container(padding: EdgeInsets.all(3.0)),
          CardContainer(
            alertEntity: AlertEntity(
              id: 3,
              message: "Um teste de emnsagem",
              quota: QuotaType.moderate,
              timestamp: DateTime.now(),
            ),
          ),
        ],
      ),
    );
  }
}
