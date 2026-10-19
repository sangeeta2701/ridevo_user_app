import 'package:firebase_auth/firebase_auth.dart';
import 'package:ridevo_user_app/models/user_model.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currentUser;

UserModel? userModelCurrentInfo;
