import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignInProvider = StateProvider((_) => GoogleSignIn());

final userProvider = StateProvider((_) => false);
