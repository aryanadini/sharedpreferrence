import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var email=prefs.getString("email");
  print(email);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email==null?Login():Home(),));
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.grey,
      child: ElevatedButton(
        onPressed: () async {
          SharedPreferences pref =await SharedPreferences.getInstance();
          pref.clear();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
            return Login();
          }));
        },
        child: const Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      ),
    );
  }
}
class Login extends StatelessWidget {
   Login({Key? key}) : super(key: key);
TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences pref =await SharedPreferences.getInstance();
                pref.setString("email", "${controller.text}");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                  return Home();
                }));
              },
              child: const Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
