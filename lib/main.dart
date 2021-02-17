import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
        ),
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final  _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback Form"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/image6.jpg'),
            fit: BoxFit.cover,
          )
        ),
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                key: _fbKey,
                initialValue: {
                  'date': DateTime.now(),
                },
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'Event_Name',
                      style: Theme.of(context).textTheme.body1,
                      validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                      decoration: InputDecoration(labelText: "Event Name"),
                    ),
                    FormBuilderDateTimePicker(
                      name: "Event_Date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "Date of Event"),
                    ),
                    FormBuilderDropdown(
                      name: "Event_Time",
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(labelText: "Time"),
                      hint: Text('Select your Timing'),
                      validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                      items: ['10:00-11:00','11:00-12:00','12:00-13:00','13:00-14:00','14:00-15:00','15:00-16:00','16:00-17:00','17:00-18:00']
                          .map((time) => DropdownMenuItem(
                          value: time, child: Text("$time")))
                          .toList(),
                    ),
                    FormBuilderRating(
                      decoration: InputDecoration(labelText: "Rate The Event",labelStyle: Theme.of(context).textTheme.body1,),
                      name: "Event_Rate",
                      iconSize: 45.0,
                      initialValue: 3,
                      max: 5,
                    ),
                    FormBuilderRating(
                      decoration: InputDecoration(labelText: "Rate The Platform used for the Event",
                        labelStyle: Theme.of(context).textTheme.body1,),
                      name: "Platform_Rate",
                      iconSize: 45.0,
                      initialValue: 3,
                      max: 5,
                    ),
                    FormBuilderSlider(
                      name: "Co_ord",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.min(context, 1),
                      ]),
                      min: 0.0,
                      max: 10.0,
                      initialValue: 5.0,
                      divisions: 10,
                      decoration: InputDecoration(
                          labelStyle:   Theme.of(context).textTheme.body1,
                          labelText: "Were the event coordinators co-operative?"),
                    ),
                    FormBuilderCheckboxGroup (
                      decoration:
                      InputDecoration(labelText: "Was all the necesaary information provided?",labelStyle: Theme.of(context).textTheme.body1,),
                      name: "Event_Info",
                      initialValue: ["Totally!"],
                      options: [
                        FormBuilderFieldOption(value: "Totally!"),
                        FormBuilderFieldOption(value: "Some info was missing"),
                        FormBuilderFieldOption(value: "No"),
                      ],
                    ),
                    FormBuilderDropdown(
                      name: "Judge",
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(labelText: "Fairity"),
                      hint: Text('Were the judges fair?'),
                      validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                      items: ['YES','NO']
                          .map((fairness) => DropdownMenuItem(
                          value: fairness, child: Text("$fairness")))
                          .toList(),
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(labelText: "Team Members",labelStyle: Theme.of(context).textTheme.body1,),
                      name: "Team_Members",

                      options: List.generate(5, (i) => i )
                          .map(
                              (number) => FormBuilderFieldOption(value: number))
                          .toList(),
                    ),
                    FormBuilderTextField(
                      name: 'Suggestions',
                      style: Theme.of(context).textTheme.body1,
                      validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                      decoration: InputDecoration(labelText: "Suggestions"),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    child: Text("Submit",style: TextStyle(color: Colors.white),),
                    color: Colors.green,
                    onPressed: () {
                      _fbKey.currentState.save();
                      if (_fbKey.currentState.validate()) {
                        print(_fbKey.currentState.value);
                      }
                    },
                  ),
                  MaterialButton(
                    child: Text("Reset",style: TextStyle(color: Colors.white),),
                    color: Colors.deepOrange,
                    onPressed: () {
                      _fbKey.currentState.reset();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}