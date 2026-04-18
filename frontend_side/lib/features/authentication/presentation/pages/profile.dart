import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/features/authentication/authentication.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 40,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "You",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
                text: 'Log Out',
                tap: () {
                  BlocProvider.of<AuthBloc>(context).add(LogoutUser());
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("You are logged out")));
                },
                height: 50,
                textColor: Colors.white,
                fontSize: 25,
                width: double.infinity),
          ],
        ),
      ),
    );
  }
}
