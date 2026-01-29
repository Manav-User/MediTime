import 'package:flutter/material.dart';
import 'package:medicinereminder/animations/fade_animation.dart';
import 'package:scoped_model/scoped_model.dart';
import '../database/moor_database.dart';
import '../models/Medicine.dart';
import '../storage/local_storage_service.dart';

class DeleteIcon extends StatefulWidget {
  final Color color;

  const DeleteIcon({this.color = Colors.grey});

  @override
  _DeleteIconState createState() => _DeleteIconState();
}

class _DeleteIconState extends State<DeleteIcon> {
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 20,
        left: 100,
        right: 100,
        child: ScopedModelDescendant<MedicineModel>(
            builder: (context, child, model) {
          return DragTarget<MedicinesTableData>(
            builder: (context, rejectedData, candidtateData) {
              return FadeAnimation(
                .5,
                Container(
                  width: 250,
                  height: 220,
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      Icons.delete,
                      color: _currentColor,
                      size: 60,
                    ),
                  ),
                ),
              );
            },
            onWillAccept: (medicine) {
              print('onWillAccept was called');
              setState(() {
                _currentColor = Colors.red;
              });
              return true;
            },
            onLeave: (v) {
              setState(() {
                _currentColor = Colors.grey;
              });
              print('onLeave');
            },
            onAccept: (medicine) {
              // remove it from the database
              final medicineToDelete = Medicine(
                id: medicine.id,
                name: medicine.name,
                image: medicine.image,
                dose: medicine.dose,
              );
              model.getStorage().deleteMedicine(medicineToDelete);
              //remove the medicine notifcation
              model.notificationManager.removeReminder(medicine.id);
              // for debugging
              print("medicine deleted" + medicine.toString());
              // show delete snakbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    'Medicine deleted',
                    style: TextStyle(fontSize: 20),
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          );
        }));
  }
}
