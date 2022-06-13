import 'package:email_auth/email_auth.dart';
import 'package:flutter_project_1/models/users/user.dart';

VatractionUser localCurrentUser = VatractionUser(uid: "", email: "", pwd: "");
late EmailAuth emailAuth;
late EmailAuth changePwdConfirm;
