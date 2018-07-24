import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonData {
  String name = '';
  String phoneNumber = '';
  String email = '';
  String password = '';
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: new GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child:
              new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}

class TextFormFieldDemo extends StatefulWidget {
  static const String routeName = "material/text-field";

  @override
  State createState() {
    return new _TextFormFieldDemoState();
  }
}

class _TextFormFieldDemoState extends State<TextFormFieldDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PersonData person = new PersonData();

  bool _autoValidate = false;
  bool _formWasEdited = false;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final _ChineseNumberTextInputFormatter _phoneNumberFormatter =
      new _ChineseNumberTextInputFormatter();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      showInSnackBar('${person.name}\'s phone number is ${person.phoneNumber}');
    }
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;

    if (form == null || !_formWasEdited || form.validate()) {
      return true;
    }

    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: const Text('This form has errors'),
              content: const Text('Really leave this form?'),
              actions: <Widget>[
                new FlatButton(
                  child: const Text('YES'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                new FlatButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  String _validatePhoneNumber(String value) {
    _formWasEdited = true;
    final RegExp phoneExp = new RegExp(r'^\\d\d\d\ \d\d\d\d\ \d\d\d\d$');
    if (!phoneExp.hasMatch(value))
      return '### #### #### - Enter a Chinese phone number.';
    return null;
  }

  String _validatePassword(String value) {
    _formWasEdited = true;
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return 'Please enter a password.';
    if (passwordField.value != value) return 'The passwords don\'t match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Text Fields'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: _autoValidate,
          onWillPop: _warnUserAboutInvalidData,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    labelText: 'Name * ',
                    hintText: 'What do people call you?',
                    filled: true,
                    border: const UnderlineInputBorder(),
                  ),
                  onSaved: (String value) {
                    person.name = value;
                  },
                  validator: _validateName,
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.phone),
                    labelText: 'Phone Number * ',
                    hintText: 'Where can we reach you?',
                    prefixText: '+86',
                    filled: true,
                    border: const UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (String value) {
                    person.phoneNumber = value;
                  },
                  validator: _validatePhoneNumber,
                  // TextInputFormatters are applied in sequence.
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                    // Fit the validating format.
                    _phoneNumberFormatter,
                  ],
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    labelText: 'E-mail',
                    hintText: 'Your email address',
                    filled: true,
                    border: const UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    person.email = value;
                  },
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Lify story',
                    hintText: 'Tell us about yourself',
                    helperText: 'Keep it short, this is just a demo.',
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Salary',
                    prefixText: '\$',
                    suffixText: 'USD',
                    suffixStyle: const TextStyle(color: Colors.green),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24.0),
                new PasswordField(
                  fieldKey: _passwordFieldKey,
                  helperText: 'No more than 8 characters.',
                  labelText: 'Password *',
                  onFieldSubmitted: (String value) {
                    setState(() {
                      person.password = value;
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  enabled:
                  person.password != null && person.password.isNotEmpty,//TODO:fix bug
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    labelText: 'Re-type password',
                  ),
                  maxLength: 8,
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 24.0),
                new Center(
                  child: new RaisedButton(
                    child: const Text('SUBMIT'),
                    onPressed: _handleSubmitted,
                  ),
                ),
                const SizedBox(height: 24.0),
                new Text(
                  '* indicates required field',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Format incoming numeric text to fit the format of 138 0000 0000
class _ChineseNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
//    String newText = newValue.text.toString();
//    if (newText.length > 3) {
//      final String first = newText.substring(0,3);
//      final String remain = newText.substring(3,newText.length);
//      newText = first + ' ' + remain;
//    }

  //TODO:implement this logic
    return new TextEditingValue(
      text: newValue.text.toString(),
      selection: new TextSelection.collapsed(offset: newValue.text.length),
    );
  }
}
