import 'package:fluttertoast/fluttertoast.dart';
import 'package:piotrek84nn_int_radio_player/presentation/constants/colors.dart';
import 'package:piotrek84nn_int_radio_player/presentation/ui_helpers/i_toast.dart';

class ToastImp extends Fluttertoast implements IToast {
  @override
  void showToast(String str) {
    Fluttertoast.showToast(
      msg: str,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 3,
      backgroundColor: selectdBgColor,
      textColor: whiteColor,
      fontSize: 20,
    );
  }

  @override
  Future<void> dispose() async {
    await Fluttertoast.cancel();
  }
}
