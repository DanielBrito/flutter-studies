import "package:scoped_model/scoped_model.dart";

// Base class that the model for all entities extend.
class BaseModel extends Model {
  int stackIndex = 0;
  List entityList = [];
  String chosenDate = "";
  dynamic entityBeingEdited;

  // The date chosen by the user.
  void setChosenDate(String inDate) {
    print("## BaseModel.setChosenDate(): inDate = $inDate");

    chosenDate = inDate;

    // Notify listeners that the data is available so they can paint themselves.
    notifyListeners();
  }

  // Load data from database.
  void loadData(String inEntityType, dynamic inDatabase) async {
    print("## ${inEntityType}Model.loadData()");

    entityList = await inDatabase.getAll();
    notifyListeners();
  }

  // For navigating between entry and list views.
  void setStackIndex(int inStackIndex) {
    print("## BaseModel.setStackIndex(): inStackIndex = $inStackIndex");

    stackIndex = inStackIndex;
    notifyListeners();
  }
}
