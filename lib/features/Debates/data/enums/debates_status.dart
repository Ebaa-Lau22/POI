enum DebatesStatus {
  announced,
  playersConfirmed,
  teamsConfirmed,
  active,
  finished,
  past,
}

extension DebatesStatusExtension on DebatesStatus {
  String get name {
    switch (this) {
      case DebatesStatus.announced:
        return 'Announced';
      case DebatesStatus.playersConfirmed:
        return 'Confirmed';
      case DebatesStatus.teamsConfirmed:
        return 'Teams';
      case DebatesStatus.active:
        return 'Active';
        case DebatesStatus.finished:
        return 'Finished';
      case DebatesStatus.past:
        return 'Past';
    }
  }

  String get serverName {
    switch (this) {
      case DebatesStatus.announced:
        return 'announced';
      case DebatesStatus.playersConfirmed:
        return 'playersConfirmed';
      case DebatesStatus.teamsConfirmed:
        return 'teamsConfirmed';
      case DebatesStatus.active:
        return 'ongoing';
         case DebatesStatus.finished:
        return 'finished';
      case DebatesStatus.past:
        return 'finished';
    }
  }
}
