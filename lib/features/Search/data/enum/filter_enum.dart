enum FilterEnum { people, debates }

extension FilterEnumExtension on FilterEnum {
  String get name {
    switch (this) {
      case FilterEnum.people:
        return "People";
      case FilterEnum.debates:
        return "Debates";
    }
  }
}
