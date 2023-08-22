import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Model/Task.dart'; // Import your Task model
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy EEEE', 'da');
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            // Sektion 1 og 2 (side om side)
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 300,
                  // color: Colors.red,
                  child: Wrap(
                    spacing: 80,
                    runSpacing: 0,
                    children: [
                      Container(
                        height: 80,
                        width: 200,
                        child: TextFormField(
                          enabled: false,
                          initialValue: formatter.format(task.startDate),
                          decoration: InputDecoration(
                            labelText: 'Dato',
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 200,
                        child: TextFormField(
                          enabled: false,
                          initialValue: '${task.citizenName}',
                          decoration: InputDecoration(
                            labelText: 'Borger',
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        child: TextFormField(
                          enabled: false,
                          initialValue: '${task.address.streetName}',
                          decoration: InputDecoration(
                            labelText: 'Gade',
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        child: TextFormField(
                          enabled: false,
                          initialValue: '${task.address.localArea}',
                          decoration: InputDecoration(
                            labelText: 'Lokalområde',
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        // color: Colors.green,
                        child: TextFormField(
                          enabled: false,
                          initialValue: '${task.address.city}',
                          decoration: InputDecoration(
                            labelText: 'Postnummer',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 300,
                    color: Colors.blue,
                    child: Center(),
                  ),
                ),
              ],
            ),
            // Sektion 3 (i bunden af sektion 1 og 2)
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      // color: Colors.yellow,
                      child: TextFormField(
                        enabled: false,
                        initialValue: '${task.description}',
                        maxLines: null, // Tillad ubegrænset antal linjer
                        decoration: InputDecoration(
                          labelText: 'Opgave beskrivelse',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
