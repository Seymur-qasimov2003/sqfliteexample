import '../model/personmodel.dart';
import '../views/utils/dbhelper.dart';

class PersonService {
  ///create person
  Future<bool> createPerson(PersonModel model) async {
    try {
      bool isSaved = false;
      await DbHelper.initDb();
      int result = await DbHelper.insert('persons', model);
      result > 0 ? isSaved = true : isSaved = false;
      return isSaved;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///get all persons
  Future<List<PersonModel>> getPersons() async {
    try {
      await DbHelper.initDb();
      List<PersonModel> persons = await DbHelper.get('persons');
      return persons;
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///delete person
  Future<bool> deletePerson(int id) async {
    try {
      bool isDeleted = false;
      await DbHelper.initDb();
      int result = await DbHelper.delete('persons', id);
      result > 0 ? isDeleted = true : isDeleted = false;
      return isDeleted;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///update person
  Future<bool> updatePerson(PersonModel model) async {
    try {
      bool isUpdated = false;
      await DbHelper.initDb();
      int result = await DbHelper.update('persons', model);
      result > 0 ? isUpdated = true : isUpdated = false;
      return isUpdated;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
