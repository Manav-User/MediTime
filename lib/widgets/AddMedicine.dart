import 'package:flutter/material.dart';
import 'package:medicinereminder/storage/local_storage_service.dart';
import 'package:medicinereminder/notifications/NotificationManager.dart';

class AddMedicine extends StatefulWidget {
  final double height;
  final LocalStorageService _storage;
  final NotificationManager manager;
  const AddMedicine(this.height, this._storage, this.manager);

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  static final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _dose = '';

  int _selectedIndex = 0;
  List<String> _icons = [
    'drug.png',
    'inhaler.png',
    'pill_rounded.png',
    'pill.png',
    'syringe.png',
    'ointment.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
        height: widget.height * .8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add New Medicine',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // back to main screen
                    Navigator.pop(context, null);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                    color: Theme.of(context).primaryColor.withOpacity(.65),
                  ),
                )
              ],
            ),
            _buildForm(),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Shape',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            _buildShapesList(),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  _submit(widget.manager);
                },
                child: Text(
                  'Add Medicine'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildShapesList() {
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _icons
            .asMap()
            .entries
            .map((MapEntry map) => _buildIcons(map.key))
            .toList(),
      ),
    );
  }

  Form _buildForm() {
    TextStyle labelsStyle =
        TextStyle(fontWeight: FontWeight.w400, fontSize: 25);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: labelsStyle,
            ),
            validator: (input) =>
                (input == null || input.length < 5) ? 'Name is short' : null,
            onSaved: (input) => _name = input ?? '',
          ),
          TextFormField(
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Dose',
              labelStyle: labelsStyle,
            ),
            validator: (input) =>
                (input == null || input.length > 50) ? 'Dose is long' : null,
            onSaved: (input) => _dose = input ?? '',
          )
        ],
      ),
    );
  }

  void _submit(NotificationManager manager) async {
    if (_formKey.currentState!.validate()) {
      // form is validated
      _formKey.currentState!.save();
      print(_name);
      print(_dose);
      //show the time picker dialog
      showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      ).then((selectedTime) async {
        if (selectedTime == null) return;
        int hour = selectedTime.hour;
        int minute = selectedTime.minute;
        print(selectedTime);
        // insert into local storage
        final medicine = Medicine(
          id: 0, // Will be assigned by storage
          name: _name,
          dose: _dose,
          image: 'assets/images/${_icons[_selectedIndex]}',
        );
        var medicineId = await widget._storage.insertMedicine(medicine);
        // schedule the notification
        manager.showNotificationDaily(medicineId, _name, _dose, hour, minute);
        // The medicine Id and Notification Id are the same
        print('New Med id: $medicineId');
        // go back
        Navigator.pop(context, medicineId);
      });
    }
  }

  Widget _buildIcons(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: (index == _selectedIndex)
              ? Theme.of(context).colorScheme.secondary.withOpacity(.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Image.asset('assets/images/' + _icons[index]),
      ),
    );
  }
}
