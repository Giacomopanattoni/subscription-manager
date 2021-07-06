import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subscription_app/constants/auth.dart';
import 'package:subscription_app/constants/style.dart';
import 'package:subscription_app/services/appSettings.dart';
import 'package:subscription_app/widgets/dropdown.dart';
import 'package:subscription_app/widgets/textFormFieldCustom.dart';

class FormAddSubscription extends StatefulWidget {
  @override
  _FormAddSubscriptionState createState() => _FormAddSubscriptionState();
}

class _FormAddSubscriptionState extends State<FormAddSubscription> {
  final formController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var everyItem = 'month';

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: kTextFieldDecoration(
                hintText: Provider.of<AppSettings>(context, listen: false)
                    .multiLangString('name'),
                prefixIcon: Icons.label),
            onSaved: (String value) {},
            validator: (String value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          )

          //Dropdown(value: ,),
        ],
      ),
    );
  }
}
/* 
  int price;
  int renewalDay;
  int everyCount;
  String everyItem;
  String from;
  bool notify;
  String color;
  int categoryId;
  String image;
 */
