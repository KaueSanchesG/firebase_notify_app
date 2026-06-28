import 'package:firebase_notify_app/ui/warning/warning_viewmodel.dart';
import 'package:firebase_notify_app/ui/warning/widgets/card_container.dart';
import 'package:flutter/material.dart';

class Warning extends StatefulWidget {
  const Warning({super.key, required this.vm});

  final WarningViewmodel vm;

  @override
  State<StatefulWidget> createState() => _WarningState();
}

class _WarningState extends State<Warning> {
  @override
  void initState() {
    super.initState();
    widget.vm.loadWarnings.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text('Alertas'),
      ),
      body: ListenableBuilder(
        listenable: widget.vm,
        builder: ((context, child) {
          if (widget.vm.loadWarnings.isRunning) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.vm.loadWarnings.hasError) {
            return Center(child: Text('Algo deu errado'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: widget.vm.warnings.length,
            itemBuilder: (context, index) {
              final warning = widget.vm.warnings[index];
              return Column(
                children: [
                  CardContainer(warningEntity: warning),
                  Container(padding: EdgeInsets.all(3.0)),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
