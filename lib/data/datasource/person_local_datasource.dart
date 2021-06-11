import 'package:guia_espiritual/data/person_data.dart';
import 'package:guia_espiritual/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonLocalDataSource {
  final Future<SharedPreferences> _sharedPreferences;

  PersonLocalDataSource(this._sharedPreferences);

  Future<DataPerson> getCurrentDataPerson() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    var stringDataPerson =
        sharedPreferences.getString(FirebaseConstants.KEY_DATA_PERSON);

    return DataPerson.fromJSONString(stringDataPerson);
  }

  Future<void> phoneCall() async {
    DataPerson dataPerson = await getCurrentDataPerson();
    launch("tel:${dataPerson.phoneNumber}");
  }
}
