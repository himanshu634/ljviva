import 'package:flutter/material.dart';

// import '../constants/const_colors.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  String? _mobileNumber = '';
  String? _villageName = '';
  String? _personName = '';
  final FocusNode _villageFocus = FocusNode();
  final FocusNode _numberFocus = FocusNode();
  var _isSubmitting = false;

  void _onSubmit() {
    final _isValid = _formKey.currentState!.validate();
    if (_isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isSubmitting = !_isSubmitting;
      });
      //TODO: Add submitting logic
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter right value.",
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
      );
    }
  }

  // @override
  // void initState() {
  //   _villageFocus = FocusNode();
  //   _numberFocus = FocusNode();
  //   super.initState();
  // }

  @override
  void dispose() {
    _villageFocus.dispose();
    _numberFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildName() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            // onFieldSubmitted: ,

            autofocus: true,
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
              FocusScope.of(context).requestFocus(_villageFocus);
            },
            onSaved: (val) {
              _personName = val;
            },
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null)
                return "Your name should not empty";
              else if (value.trim().isEmpty)
                return "Please enter your name";
              else if (value.length < 6) return "Minimun 6 characters required";
              return null;
            },
            decoration: InputDecoration(
              labelText: "Enter your name here",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );

    Widget _buildVillage() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            onSaved: (val) {
              _villageName = val;
            },
            onFieldSubmitted: (_) {
              _villageFocus.unfocus();
              FocusScope.of(context).requestFocus(_numberFocus);
            },
            textInputAction: TextInputAction.next,
            focusNode: _villageFocus,
            // autovalidateMode:
            validator: (value) {
              if (value == null)
                return "Your village should not empty";
              else if (value.trim().isEmpty)
                return "Please enter your village name";
              return null;
            },
            decoration: InputDecoration(
              labelText: "Village/City",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );

    Widget _buildNumber() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            onSaved: (val) {
              _mobileNumber = val;
            },
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {
              _numberFocus.unfocus();
              _onSubmit();
            },
            focusNode: _numberFocus,
            validator: (value) {
              String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
              RegExp regExp = new RegExp(patttern);
              if (value == null) {
                return "Please enter mobile number";
              } else if (value.length == 0) {
                return 'Please enter mobile number';
              } else if (!regExp.hasMatch(value)) {
                return 'Please enter valid mobile number';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Mobile Number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );

    Widget _buildButton() => Container(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            //TODO: Here disable button functionality is pending, think about it
            onPressed: _onSubmit,
            child: _isSubmitting
                ? Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Verify Mobile Number",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              onSurface: Colors.black,
              // animationDuration: Duration(seconds: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        );

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("APMC"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                borderOnForeground: true,
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Registration",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildName(),
                      const SizedBox(height: 10),
                      _buildVillage(),
                      const SizedBox(height: 10),
                      _buildNumber(),
                      const SizedBox(height: 10),
                      _buildButton(),
                      // const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
