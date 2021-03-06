
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red, //color stepper
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
  int _activeCurrentStep = 0;
  bool isCompleted = false;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController().c;
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  Center buildComplete() {
    return  Center(
      child: Column(
        children:  <Widget>[
        const Text('Completed!!!'),
        ElevatedButton(
        onPressed:(() {
          setState(() {
              _activeCurrentStep = 0;
              isCompleted = false;
              name.clear();
              email.clear();
              pass.clear();
              address.clear();
              pincode.clear();
          });
        }), 
        child: const Text('Reset'),
        ),
        ],
      ),
    );
  }

// Here we have created list of steps that
// are required to complete the form
  List<Step> stepList() => [
        Step(
          state:
              _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 0,
          title: const Text('Account'),
          content: Container(
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
            state: _activeCurrentStep <= 1
                ? StepState.editing
                : StepState.complete,
            isActive: _activeCurrentStep >= 1,
            title: const Text('Address'),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: address,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full House Address',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: pincode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pin Code',
                    ),
                  ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeCurrentStep >= 2,
            title: const Text('Confirm'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${name.text}'),
                Text('Email: ${email.text}'),
                Text('Password: ${pass.text}'),
                Text('Address : ${address.text}'),
                Text('PinCode : ${pincode.text}'),
              ],
            )))
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          'Multi Step Form',
          style: TextStyle(color: Colors.white),
        ),
      ),

      // Here we have initialized the stepper widget
      body: 
      isCompleted
      ?  buildComplete()
      : 
      Stepper(
        //https://api.flutter.dev/flutter/material/Stepper-class.html
        type: StepperType.horizontal,
        currentStep: _activeCurrentStep,
        steps: stepList(),
        onStepContinue: () {
          //Button Continue
          final isLastStep = _activeCurrentStep == stepList().length - 1;
      
          if (isLastStep) {
      
            //alternatively we can set flag isCompleted to true
            setState(() => isCompleted = true );
      
            print('Competed');
            //send data to the server
          } else {
            //increment
            setState((() => _activeCurrentStep += 1));
          }
        },
        onStepCancel: () {
          //Button Cancel
          //decrement
          _activeCurrentStep > 0
              ? setState((() => _activeCurrentStep -= 1))
              : null;
        },
        onStepTapped: (int index) {
          //Go to Step by index
          setState(() {
            _activeCurrentStep = index;
          });
        },
        //Custom Buttons Next and Cancel
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          final isLastStep = _activeCurrentStep == stepList().length - 1;
          return Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: details.onStepContinue,
                  child:  Text( isLastStep ? 'CONFIRM' : 'NEXT' ),
                ),
              ),
              SizedBox(width: _activeCurrentStep != 0 ? 12 : 0),
               if (_activeCurrentStep != 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepCancel,
                    child: const Text('BACK'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
