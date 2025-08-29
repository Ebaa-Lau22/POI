enum DebatesStatus {
  announced,
  confirmed,
  teamsConfirmed,
  preperation,
  active,
  past,
}

extension DebatesStatusExtension on DebatesStatus {
  String get name {
    switch (this) {
      case DebatesStatus.announced:
        return 'Announced';
      case DebatesStatus.confirmed:
        return 'Confirmed';
      case DebatesStatus.teamsConfirmed:
        return 'Teams';
      case DebatesStatus.preperation:
        return 'Preperation';
      case DebatesStatus.active:
        return 'Active';
      case DebatesStatus.past:
        return 'Past';
    }
  }

  String get serverName {
    switch (this) {
      case DebatesStatus.announced:
        return 'announced';
      case DebatesStatus.confirmed:
        return 'playersConfirmed';
      case DebatesStatus.teamsConfirmed:
        return 'teamsConfirmed';
      case DebatesStatus.preperation:
        return 'debatePreparation';
      case DebatesStatus.active:
        return 'ongoing';
      case DebatesStatus.past:
        return 'finished';
    }
  }
}
