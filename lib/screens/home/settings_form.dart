import 'package:brew/models/model_user.dart';
import 'package:brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/database.dart';




class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ModelUser?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data!;

          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings.',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                    validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(height: 20.0),
                  // dropdown
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      hintText: 'Sugars',
                    ),
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val.toString()),
                  ),

                  // slider
                  Slider(
                    value: (_currentStrength ?? userData.strength!).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? userData.strength!],

                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() => _currentStrength = val.round()),
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData.sugars!,
                            _currentName ?? userData.name!,
                            _currentStrength ?? userData.strength!
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),

                ],
              )
          );
        }
        else{
          return Loading();
        }

      }
    );
  }
}

