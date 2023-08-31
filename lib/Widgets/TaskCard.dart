import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Model/Task.dart'; // Import your Task model
import 'package:intl/intl.dart';
import '../Widgets/CustomStyle.dart';
import 'package:url_launcher/url_launcher.dart';

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
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 300,
                    child: Wrap(
                      spacing: 80,
                      runSpacing: 0,
                      children: [
                        Container(
                          height: 80,
                          child: TextFormField(
                            enabled: false,
                            style: TaskStyle.taskStyle,
                            initialValue: task.title,
                            decoration: InputDecoration(
                              labelText: 'Opgave',
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 200,
                          child: TextFormField(
                            enabled: false,
                            style: TaskStyle.taskStyle,
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
                            style: TaskStyle.taskStyle,
                            initialValue: '${task.citizenName}',
                            decoration: InputDecoration(
                              labelText: 'Borger',
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 200,
                          child: TextFormField(
                            enabled: false,
                            style: TaskStyle.taskStyle,
                            initialValue: '${task.address.streetName}',
                            decoration: InputDecoration(
                              labelText: 'Gade',
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 200,
                          child: TextFormField(
                            enabled: false,
                            style: TaskStyle.taskStyle,
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
                            style: TaskStyle.taskStyle,
                            initialValue: '${task.address.city}',
                            decoration: InputDecoration(
                              labelText: 'Postnummer',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //right section to google maps
                Expanded(
                  child: Container(
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/icon/google-maps.png',
                            width: 264,
                            height: 264,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String destination =
                                "${task.address.streetName},${task.address.city}";
                            launchURL(destination);
                          },
                          child: Text("Åbn Google Maps"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // section description
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          enabled: false,
                          style: TaskStyle.taskStyle,
                          initialValue: '${task.description}',
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Opgave beskrivelse',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //method to launch google maps
  void launchURL(String destination) async {
    String encodedDestination = Uri.encodeFull(destination);
    Uri googleMapsAppUrl = Uri.parse("geo:0,0?q=$encodedDestination");
    Uri googleMapsWebUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$encodedDestination");

    if (await canLaunchUrl(googleMapsAppUrl)) {
      // use google maps app
      await launchUrl(googleMapsAppUrl);
    } else if (await canLaunchUrl(googleMapsWebUrl)) {
      // use google maps web version - no navigation available
      await launchUrl(googleMapsWebUrl);
    } else {
      throw 'Could not launch Google Maps for $encodedDestination';
    }
  }
}
