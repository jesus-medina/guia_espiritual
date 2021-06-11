import 'package:guia_espiritual/data/datasource/person_local_datasource.dart';
import 'package:guia_espiritual/data/datasource/person_remote_datasource.dart';
import 'package:guia_espiritual/domain/person.dart';

class PersonRepository {
  final PersonLocalDataSource personLocalDataSource;
  final PersonRemoteDataSource personRemoteDataSource;

  PersonRepository(this.personLocalDataSource, this.personRemoteDataSource);

  DomainPerson getCurrentDataPerson() {

  }
}
