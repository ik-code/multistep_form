import 'package:flutter/material.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
@override
Widget build(BuildContext context) {
	return MaterialApp(
	title: 'Flutter Demo',
	theme: ThemeData(
		primarySwatch: Colors.blue,
	),
	home: const MyHomePage(),
	);
}
}

class MyHomePage extends StatefulWidget {
const MyHomePage({Key? key}) : super(key: key);

@override
_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

// Here we have created list of steps that
// are required to complete the form
List<Step> stepList() => [
		const Step(title: Text('Account'), content: Center(child: Text('Account'),)),
		const Step(title: Text('Address'), content: Center(child: Text('Address'),)),
		const Step(title: Text('Confirm'), content: Center(child: Text('Confirm'),))
];
@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(
		centerTitle: true,
		backgroundColor: Colors.green,
		title: const Text('Multi Step Form',style: TextStyle(color: Colors.white), ),
	),
	
	// Here we have initialized the stepper widget
	body: Stepper(
		steps: stepList(),
	)
	);
}
}
