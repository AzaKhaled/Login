import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';

import 'api_auth.dart';
//import 'package:firebase_core/firebase_core.dart';

//import 'firebase_options.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String phone = "NULL";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const CircleAvatar(
              radius: 112,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 110,
                backgroundImage: AssetImage('assets/login.png'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.all(8),
                  margin:const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Text(
              'sign in',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const Text('Enter your data'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                //key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                   const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  const  SizedBox(
                      height: 10,
                    ),
                    IntlPhoneField(
                      //  focusNode: focusNode,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      languageCode: "en",

                      onChanged: (val) {
                        phone = val.completeNumber;
                        print(val.completeNumber);
                      },
                      onCountryChanged: (country) {
                        print('Country changed to: ' + country.name);
                      },
                    ),
                   const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: MaterialButton(
                        child:const Text('Submit'),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if(phone!='NULL')
                            {
                              sendCode(phone);
                            }
                          //  _formKey.currentState?.validate();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendCode(String phoneNumber) {
    //222333
    print("sending code to Phone $phoneNumber");
    ApiAuth(context).verifyPhone(phoneNumber, () { });

    showOTPSheet();
  }

  showOTPSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (builder) {
          return Container(
            height: 400,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
               const Text("Code was send to your phone"),
                Text(phone),
                const SizedBox(
                  height: 10,
                ),
                Pinput(
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle:const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  submittedPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  length: 6,
                  /*validator: (s) {
                    return s == '222333' ? null : 'Code is incorrect';
                  },*/
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) async{
                    print("Entered Pin $pin");
                  bool isVer= await ApiAuth(context).checkCode(pin);
                    if(isVer)
                    {

                    }
                    else
                    {
                      
                    }
                 
                  },
                ),
               const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  child: Text('Verify'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () async {},
                ),
               const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  child: Text('back'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}
