import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/profile_screen/profile_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}
class _AuthWrapperState extends State<AuthWrapper> {
  late Stream<User?> _authStream;

  @override
  void initState() {
    super.initState();
    _authStream = FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return UserDataCheck(uid: snapshot.data!.uid);
        }
          
        return const LoginScreen();
      },
    );
  }
}

class UserDataCheck extends StatefulWidget{
  final String uid;
  const UserDataCheck({super.key, required this.uid});
   
  @override
  State<UserDataCheck> createState() => _UserDataCheckState();
}

class _UserDataCheckState extends State<UserDataCheck>  {
  late Future<DocumentSnapshot> _userFuture;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  @override
  void didUpdateWidget(covariant UserDataCheck oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uid != widget.uid) {
      _initFuture();
    }
  }

  void _initFuture() {
    _userFuture = FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _userFuture, // Используем сохраненный фьючер
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
          return const ProfileScreen();
        }
        return const HomeScreen();
      },
    );
  }
}