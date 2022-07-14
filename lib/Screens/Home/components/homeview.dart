import 'package:covid_pass/Functions/get_user.dart';
import 'package:covid_pass/Functions/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../models/usermodel.dart';

class HomeView extends StatelessWidget {
  HomeView({ Key? key }) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: Provider.of<LoadingState>(context).isLoading,
      child: FutureBuilder<UserModel>(
        future: getUsers.getUser(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if(snapshot.hasError){
            return const Center(child: Text("error loading"),);
          }else if(snapshot.hasData){
          UserModel? model = snapshot.data;
    
         switch (snapshot.connectionState){
           case ConnectionState.none:
           case ConnectionState.waiting:
           case ConnectionState.active:
           return const CircularProgressIndicator();
           case ConnectionState.done:
             return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(50.0),
                child: QrImage(
                  data: "${_auth.currentUser!.email?? model!.email},${_auth.currentUser!.uid}",
                  backgroundColor: Colors.white,
                ),
              ),
            ]
          );
         }
           }
           return Container();
        }
      ),
    );
  }
}