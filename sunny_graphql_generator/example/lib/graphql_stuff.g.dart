// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_stuff.dart';

// **************************************************************************
// GraphQLGenerator
// **************************************************************************

class Tribe extends BaseSunnyEntity
    with HasPhasesMixin, HasMemoriesMixin
    implements IRef, HasPhases, MBaseModel, Entity {
  Tribe(
      {required this.id,
      required this.displayName,
      this.photoUrl,
      required this.slug,
      required this.tribeType,
      this.dateModified,
      this.dateCreated,
      required this.members,
      this.phases,
      this.memories});

  factory Tribe.fromJson(dynamic json) => Tribe(
      id: (json['id'] as String),
      displayName: (json['displayName'] as String),
      photoUrl: GraphClientConfig.read(json['photoUrl'],
          typeName: 'Uri', isNullable: true),
      slug: (json['slug'] as String),
      tribeType: (json['tribeType'] as String),
      dateModified: GraphClientConfig.read(json['dateModified'],
          typeName: 'DateTime', isNullable: true),
      dateCreated: GraphClientConfig.read(json['dateCreated'],
          typeName: 'DateTime', isNullable: true),
      members: GraphClientConfig.readList(
          GraphClientConfig.getDeep(json, 'membersConnection', 'edges'),
          typeName: 'TribeMember',
          isNullable: false),
      phases: GraphClientConfig.readList(json['phases'],
          typeName: 'Phase', isNullable: true),
      memories: GraphClientConfig.readList(json['memories'],
          typeName: 'Memory', isNullable: true));

  Tribe.fromMap(Map<String, dynamic> map)
      : id = map.get('id'),
        displayName = map.get('displayName'),
        photoUrl = map.get('photoUrl'),
        slug = map.get('slug'),
        tribeType = map.get('tribeType'),
        dateModified = map.get('dateModified'),
        dateCreated = map.get('dateCreated'),
        members = map.get('members'),
        phases = map.get('phases'),
        memories = map.get('memories');

  String id;

  String displayName;

  Uri? photoUrl;

  String slug;

  String tribeType;

  DateTime? dateModified;

  DateTime? dateCreated;

  List<TribeMember> members;

  List<Phase>? phases;

  List<Memory>? memories;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "tribe", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return Tribe.ref;
  }

  @override
  JsonObject toMap() => {
        'id': this.id,
        'displayName': this.displayName,
        'photoUrl': this.photoUrl,
        'slug': this.slug,
        'tribeType': this.tribeType,
        'dateModified': this.dateModified,
        'dateCreated': this.dateCreated,
        'members': this.members,
        'phases': this.phases,
        'memories': this.memories
      };
  JsonObject? toJson() {
    return {
      "id": this.id,
      "displayName": this.displayName,
      "photoUrl": GraphClientConfig.write(this.photoUrl,
          typeName: "Uri", isList: false),
      "slug": this.slug,
      "tribeType": this.tribeType,
      "dateModified": GraphClientConfig.write(this.dateModified,
          typeName: "DateTime", isList: false),
      "dateCreated": GraphClientConfig.write(this.dateCreated,
          typeName: "DateTime", isList: false),
      "members": GraphClientConfig.write(this.members,
          typeName: "TribeMember", isList: true),
      "phases":
          GraphClientConfig.write(this.phases, typeName: "Phase", isList: true),
      "memories": GraphClientConfig.write(this.memories,
          typeName: "Memory", isList: true),
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "id":
        this.id = value as String;
        break;
      case "displayName":
        this.displayName = value as String;
        break;
      case "photoUrl":
        this.photoUrl = value as Uri?;
        break;
      case "slug":
        this.slug = value as String;
        break;
      case "tribeType":
        this.tribeType = value as String;
        break;
      case "dateModified":
        this.dateModified = value as DateTime?;
        break;
      case "dateCreated":
        this.dateCreated = value as DateTime?;
        break;
      case "members":
        this.members = value as List<TribeMember>;
        break;
      case "phases":
        this.phases = value as List<Phase>?;
        break;
      case "memories":
        this.memories = value as List<Memory>?;
        break;
      default:
        throw "No field ${key} found for Tribe";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "id":
        return this.id;

      case "displayName":
        return this.displayName;

      case "photoUrl":
        return this.photoUrl;

      case "slug":
        return this.slug;

      case "tribeType":
        return this.tribeType;

      case "dateModified":
        return this.dateModified;

      case "dateCreated":
        return this.dateCreated;

      case "members":
        return this.members;

      case "phases":
        return this.phases;

      case "memories":
        return this.memories;

      default:
        throw "No field ${key} found on Tribe";
    }
  }
}

class TribeFields {
  const TribeFields._();
  static const id = "id";
  static const displayName = "displayName";
  static const photoUrl = "photoUrl";
  static const slug = "slug";
  static const tribeType = "tribeType";
  static const dateModified = "dateModified";
  static const dateCreated = "dateCreated";
  static const members = "members";
  static const phases = "phases";
  static const memories = "memories";
  static const values = {
    id,
    displayName,
    photoUrl,
    slug,
    tribeType,
    dateModified,
    dateCreated,
    members,
    phases,
    memories,
  };
}

class TribePaths {
  const TribePaths._();
  static const id = JsonPath<String>.single("id");
  static const displayName = JsonPath<String>.single("displayName");
  static const photoUrl = JsonPath<Uri?>.single("photoUrl");
  static const slug = JsonPath<String>.single("slug");
  static const tribeType = JsonPath<String>.single("tribeType");
  static const dateModified = JsonPath<DateTime?>.single("dateModified");
  static const dateCreated = JsonPath<DateTime?>.single("dateCreated");
  static const members = JsonPath<List<TribeMember>>.single("members");
  static const phases = JsonPath<List<Phase>?>.single("phases");
  static const memories = JsonPath<List<Memory>?>.single("memories");
  static const values = [
    id,
    displayName,
    photoUrl,
    slug,
    tribeType,
    dateModified,
    dateCreated,
    members,
    phases,
    memories,
  ];
}

class Contact extends BaseSunnyEntity
    with HasPhasesMixin, HasMemoriesMixin
    implements IRef, HasPhases, MBaseModel, Entity {
  Contact(
      {required this.id,
      required this.displayName,
      this.nickName,
      this.photoUrl,
      this.birthday,
      this.dateModified,
      this.dateCreated,
      required this.tribes,
      this.phases,
      this.childFamily,
      this.parentFamily,
      this.friendGroups,
      this.memories});

  factory Contact.fromJson(dynamic json) => Contact(
      id: (json['id'] as String),
      displayName: (json['displayName'] as String),
      nickName: (json['nickName'] as String?),
      photoUrl: GraphClientConfig.read(json['photoUrl'],
          typeName: 'Uri', isNullable: true),
      birthday: GraphClientConfig.read(json['birthday'],
          typeName: 'FlexiDate', isNullable: true),
      dateModified: GraphClientConfig.read(json['dateModified'],
          typeName: 'DateTime', isNullable: true),
      dateCreated: GraphClientConfig.read(json['dateCreated'],
          typeName: 'DateTime', isNullable: true),
      tribes: GraphClientConfig.readList(
          GraphClientConfig.getDeep(json, 'tribesConnection', 'edges'),
          typeName: 'TribeMembership',
          isNullable: false),
      phases: GraphClientConfig.readList(json['phases'],
          typeName: 'Phase', isNullable: true),
      childFamily: GraphClientConfig.read(json['childFamily'],
          typeName: 'FamilyTribe', isNullable: true),
      parentFamily: GraphClientConfig.read(json['parentFamily'],
          typeName: 'FamilyTribe', isNullable: true),
      friendGroups: GraphClientConfig.readList(json['friendGroups'],
          typeName: 'FriendGroupTribe', isNullable: true),
      memories: GraphClientConfig.readList(json['memories'],
          typeName: 'Memory', isNullable: true));

  Contact.fromMap(Map<String, dynamic> map)
      : id = map.get('id'),
        displayName = map.get('displayName'),
        nickName = map.get('nickName'),
        photoUrl = map.get('photoUrl'),
        birthday = map.get('birthday'),
        dateModified = map.get('dateModified'),
        dateCreated = map.get('dateCreated'),
        tribes = map.get('tribes'),
        phases = map.get('phases'),
        childFamily = map.get('childFamily'),
        parentFamily = map.get('parentFamily'),
        friendGroups = map.get('friendGroups'),
        memories = map.get('memories');

  String id;

  String displayName;

  String? nickName;

  Uri? photoUrl;

  FlexiDate? birthday;

  DateTime? dateModified;

  DateTime? dateCreated;

  List<TribeMembership> tribes;

  List<Phase>? phases;

  FamilyTribe? childFamily;

  FamilyTribe? parentFamily;

  List<FriendGroupTribe>? friendGroups;

  List<Memory>? memories;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "contact", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return Contact.ref;
  }

  @override
  JsonObject toMap() => {
        'id': this.id,
        'displayName': this.displayName,
        'nickName': this.nickName,
        'photoUrl': this.photoUrl,
        'birthday': this.birthday,
        'dateModified': this.dateModified,
        'dateCreated': this.dateCreated,
        'tribes': this.tribes,
        'phases': this.phases,
        'childFamily': this.childFamily,
        'parentFamily': this.parentFamily,
        'friendGroups': this.friendGroups,
        'memories': this.memories
      };
  JsonObject? toJson() {
    return {
      "id": this.id,
      "displayName": this.displayName,
      "nickName": this.nickName,
      "photoUrl": GraphClientConfig.write(this.photoUrl,
          typeName: "Uri", isList: false),
      "birthday": GraphClientConfig.write(this.birthday,
          typeName: "FlexiDate", isList: false),
      "dateModified": GraphClientConfig.write(this.dateModified,
          typeName: "DateTime", isList: false),
      "dateCreated": GraphClientConfig.write(this.dateCreated,
          typeName: "DateTime", isList: false),
      "tribes": GraphClientConfig.write(this.tribes,
          typeName: "TribeMembership", isList: true),
      "phases":
          GraphClientConfig.write(this.phases, typeName: "Phase", isList: true),
      "childFamily": GraphClientConfig.write(this.childFamily,
          typeName: "FamilyTribe", isList: false),
      "parentFamily": GraphClientConfig.write(this.parentFamily,
          typeName: "FamilyTribe", isList: false),
      "friendGroups": GraphClientConfig.write(this.friendGroups,
          typeName: "FriendGroupTribe", isList: true),
      "memories": GraphClientConfig.write(this.memories,
          typeName: "Memory", isList: true),
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "id":
        this.id = value as String;
        break;
      case "displayName":
        this.displayName = value as String;
        break;
      case "nickName":
        this.nickName = value as String?;
        break;
      case "photoUrl":
        this.photoUrl = value as Uri?;
        break;
      case "birthday":
        this.birthday = value as FlexiDate?;
        break;
      case "dateModified":
        this.dateModified = value as DateTime?;
        break;
      case "dateCreated":
        this.dateCreated = value as DateTime?;
        break;
      case "tribes":
        this.tribes = value as List<TribeMembership>;
        break;
      case "phases":
        this.phases = value as List<Phase>?;
        break;
      case "childFamily":
        this.childFamily = value as FamilyTribe?;
        break;
      case "parentFamily":
        this.parentFamily = value as FamilyTribe?;
        break;
      case "friendGroups":
        this.friendGroups = value as List<FriendGroupTribe>?;
        break;
      case "memories":
        this.memories = value as List<Memory>?;
        break;
      default:
        throw "No field ${key} found for Contact";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "id":
        return this.id;

      case "displayName":
        return this.displayName;

      case "nickName":
        return this.nickName;

      case "photoUrl":
        return this.photoUrl;

      case "birthday":
        return this.birthday;

      case "dateModified":
        return this.dateModified;

      case "dateCreated":
        return this.dateCreated;

      case "tribes":
        return this.tribes;

      case "phases":
        return this.phases;

      case "childFamily":
        return this.childFamily;

      case "parentFamily":
        return this.parentFamily;

      case "friendGroups":
        return this.friendGroups;

      case "memories":
        return this.memories;

      default:
        throw "No field ${key} found on Contact";
    }
  }
}

class ContactFields {
  const ContactFields._();
  static const id = "id";
  static const displayName = "displayName";
  static const nickName = "nickName";
  static const photoUrl = "photoUrl";
  static const birthday = "birthday";
  static const dateModified = "dateModified";
  static const dateCreated = "dateCreated";
  static const tribes = "tribes";
  static const phases = "phases";
  static const childFamily = "childFamily";
  static const parentFamily = "parentFamily";
  static const friendGroups = "friendGroups";
  static const memories = "memories";
  static const values = {
    id,
    displayName,
    nickName,
    photoUrl,
    birthday,
    dateModified,
    dateCreated,
    tribes,
    phases,
    childFamily,
    parentFamily,
    friendGroups,
    memories,
  };
}

class ContactPaths {
  const ContactPaths._();
  static const id = JsonPath<String>.single("id");
  static const displayName = JsonPath<String>.single("displayName");
  static const nickName = JsonPath<String?>.single("nickName");
  static const photoUrl = JsonPath<Uri?>.single("photoUrl");
  static const birthday = JsonPath<FlexiDate?>.single("birthday");
  static const dateModified = JsonPath<DateTime?>.single("dateModified");
  static const dateCreated = JsonPath<DateTime?>.single("dateCreated");
  static const tribes = JsonPath<List<TribeMembership>>.single("tribes");
  static const phases = JsonPath<List<Phase>?>.single("phases");
  static const childFamily = JsonPath<FamilyTribe?>.single("childFamily");
  static const parentFamily = JsonPath<FamilyTribe?>.single("parentFamily");
  static const friendGroups =
      JsonPath<List<FriendGroupTribe>?>.single("friendGroups");
  static const memories = JsonPath<List<Memory>?>.single("memories");
  static const values = [
    id,
    displayName,
    nickName,
    photoUrl,
    birthday,
    dateModified,
    dateCreated,
    tribes,
    phases,
    childFamily,
    parentFamily,
    friendGroups,
    memories,
  ];
}

class Phase extends BaseSunnyEntity
    implements IRef, MBaseModel, Entity, IPhase {
  Phase(
      {required this.id,
      this.phased,
      required this.displayName,
      this.photoUrl,
      this.startDate,
      this.endDate,
      this.description,
      this.dateCreated,
      this.dateModified});

  factory Phase.fromJson(dynamic json) => Phase(
      id: (json['id'] as String),
      phased: GraphClientConfig.read(json['phased'],
          typeName: 'HasPhases', isNullable: true),
      displayName: (json['displayName'] as String),
      photoUrl: GraphClientConfig.read(json['photoUrl'],
          typeName: 'Uri', isNullable: true),
      startDate: GraphClientConfig.read(json['startDate'],
          typeName: 'FlexiDate', isNullable: true),
      endDate: GraphClientConfig.read(json['endDate'],
          typeName: 'FlexiDate', isNullable: true),
      description: (json['description'] as String?),
      dateCreated: GraphClientConfig.read(json['dateCreated'],
          typeName: 'DateTime', isNullable: true),
      dateModified: GraphClientConfig.read(json['dateModified'],
          typeName: 'DateTime', isNullable: true));

  Phase.fromMap(Map<String, dynamic> map)
      : id = map.get('id'),
        phased = map.get('phased'),
        displayName = map.get('displayName'),
        photoUrl = map.get('photoUrl'),
        startDate = map.get('startDate'),
        endDate = map.get('endDate'),
        description = map.get('description'),
        dateCreated = map.get('dateCreated'),
        dateModified = map.get('dateModified');

  String id;

  HasPhases? phased;

  String displayName;

  Uri? photoUrl;

  FlexiDate? startDate;

  FlexiDate? endDate;

  String? description;

  DateTime? dateCreated;

  DateTime? dateModified;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "phase", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return Phase.ref;
  }

  @override
  JsonObject toMap() => {
        'id': this.id,
        'phased': this.phased,
        'displayName': this.displayName,
        'photoUrl': this.photoUrl,
        'startDate': this.startDate,
        'endDate': this.endDate,
        'description': this.description,
        'dateCreated': this.dateCreated,
        'dateModified': this.dateModified
      };
  JsonObject? toJson() {
    return {
      "id": this.id,
      "phased": GraphClientConfig.write(this.phased,
          typeName: "HasPhases", isList: false),
      "displayName": this.displayName,
      "photoUrl": GraphClientConfig.write(this.photoUrl,
          typeName: "Uri", isList: false),
      "startDate": GraphClientConfig.write(this.startDate,
          typeName: "FlexiDate", isList: false),
      "endDate": GraphClientConfig.write(this.endDate,
          typeName: "FlexiDate", isList: false),
      "description": this.description,
      "dateCreated": GraphClientConfig.write(this.dateCreated,
          typeName: "DateTime", isList: false),
      "dateModified": GraphClientConfig.write(this.dateModified,
          typeName: "DateTime", isList: false),
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "id":
        this.id = value as String;
        break;
      case "phased":
        this.phased = value as HasPhases?;
        break;
      case "displayName":
        this.displayName = value as String;
        break;
      case "photoUrl":
        this.photoUrl = value as Uri?;
        break;
      case "startDate":
        this.startDate = value as FlexiDate?;
        break;
      case "endDate":
        this.endDate = value as FlexiDate?;
        break;
      case "description":
        this.description = value as String?;
        break;
      case "dateCreated":
        this.dateCreated = value as DateTime?;
        break;
      case "dateModified":
        this.dateModified = value as DateTime?;
        break;
      default:
        throw "No field ${key} found for Phase";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "id":
        return this.id;

      case "phased":
        return this.phased;

      case "displayName":
        return this.displayName;

      case "photoUrl":
        return this.photoUrl;

      case "startDate":
        return this.startDate;

      case "endDate":
        return this.endDate;

      case "description":
        return this.description;

      case "dateCreated":
        return this.dateCreated;

      case "dateModified":
        return this.dateModified;

      default:
        throw "No field ${key} found on Phase";
    }
  }
}

class PhaseFields {
  const PhaseFields._();
  static const id = "id";
  static const phased = "phased";
  static const displayName = "displayName";
  static const photoUrl = "photoUrl";
  static const startDate = "startDate";
  static const endDate = "endDate";
  static const description = "description";
  static const dateCreated = "dateCreated";
  static const dateModified = "dateModified";
  static const values = {
    id,
    phased,
    displayName,
    photoUrl,
    startDate,
    endDate,
    description,
    dateCreated,
    dateModified,
  };
}

class PhasePaths {
  const PhasePaths._();
  static const id = JsonPath<String>.single("id");
  static const phased = JsonPath<HasPhases?>.single("phased");
  static const displayName = JsonPath<String>.single("displayName");
  static const photoUrl = JsonPath<Uri?>.single("photoUrl");
  static const startDate = JsonPath<FlexiDate?>.single("startDate");
  static const endDate = JsonPath<FlexiDate?>.single("endDate");
  static const description = JsonPath<String?>.single("description");
  static const dateCreated = JsonPath<DateTime?>.single("dateCreated");
  static const dateModified = JsonPath<DateTime?>.single("dateModified");
  static const values = [
    id,
    phased,
    displayName,
    photoUrl,
    startDate,
    endDate,
    description,
    dateCreated,
    dateModified,
  ];
}

class FamilyTribe extends BaseSunnyEntity
    with ITribeMixin
    implements MBaseModel, Entity {
  FamilyTribe(
      {required this.id,
      required this.tribe,
      this.startDate,
      this.endDate,
      required this.parents,
      required this.children});

  factory FamilyTribe.fromJson(dynamic json) => FamilyTribe(
      id: (json['id'] as String),
      tribe: GraphClientConfig.read(json['tribe'],
          typeName: 'Tribe', isNullable: false),
      startDate: GraphClientConfig.read(json['startDate'],
          typeName: 'FlexiDate', isNullable: true),
      endDate: GraphClientConfig.read(json['endDate'],
          typeName: 'FlexiDate', isNullable: true),
      parents: GraphClientConfig.readList(json['parents'],
          typeName: 'Contact', isNullable: false),
      children: GraphClientConfig.readList(json['children'],
          typeName: 'Contact', isNullable: false));

  FamilyTribe.fromMap(Map<String, dynamic> map)
      : id = map.get('id'),
        tribe = map.get('tribe'),
        startDate = map.get('startDate'),
        endDate = map.get('endDate'),
        parents = map.get('parents'),
        children = map.get('children');

  String id;

  Tribe tribe;

  FlexiDate? startDate;

  FlexiDate? endDate;

  List<Contact> parents;

  List<Contact> children;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "familyTribe", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return FamilyTribe.ref;
  }

  @override
  JsonObject toMap() => {
        'id': this.id,
        'tribe': this.tribe,
        'startDate': this.startDate,
        'endDate': this.endDate,
        'parents': this.parents,
        'children': this.children
      };
  JsonObject? toJson() {
    return {
      "id": this.id,
      "tribe":
          GraphClientConfig.write(this.tribe, typeName: "Tribe", isList: false),
      "startDate": GraphClientConfig.write(this.startDate,
          typeName: "FlexiDate", isList: false),
      "endDate": GraphClientConfig.write(this.endDate,
          typeName: "FlexiDate", isList: false),
      "parents": GraphClientConfig.write(this.parents,
          typeName: "Contact", isList: true),
      "children": GraphClientConfig.write(this.children,
          typeName: "Contact", isList: true),
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "id":
        this.id = value as String;
        break;
      case "tribe":
        this.tribe = value as Tribe;
        break;
      case "startDate":
        this.startDate = value as FlexiDate?;
        break;
      case "endDate":
        this.endDate = value as FlexiDate?;
        break;
      case "parents":
        this.parents = value as List<Contact>;
        break;
      case "children":
        this.children = value as List<Contact>;
        break;
      default:
        throw "No field ${key} found for FamilyTribe";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "id":
        return this.id;

      case "tribe":
        return this.tribe;

      case "startDate":
        return this.startDate;

      case "endDate":
        return this.endDate;

      case "parents":
        return this.parents;

      case "children":
        return this.children;

      default:
        throw "No field ${key} found on FamilyTribe";
    }
  }
}

class FamilyTribeFields {
  const FamilyTribeFields._();
  static const id = "id";
  static const tribe = "tribe";
  static const startDate = "startDate";
  static const endDate = "endDate";
  static const parents = "parents";
  static const children = "children";
  static const values = {
    id,
    tribe,
    startDate,
    endDate,
    parents,
    children,
  };
}

class FamilyTribePaths {
  const FamilyTribePaths._();
  static const id = JsonPath<String>.single("id");
  static const tribe = JsonPath<Tribe>.single("tribe");
  static const startDate = JsonPath<FlexiDate?>.single("startDate");
  static const endDate = JsonPath<FlexiDate?>.single("endDate");
  static const parents = JsonPath<List<Contact>>.single("parents");
  static const children = JsonPath<List<Contact>>.single("children");
  static const values = [
    id,
    tribe,
    startDate,
    endDate,
    parents,
    children,
  ];
}

class FriendGroupTribe extends BaseSunnyEntity
    with ITribeMixin
    implements MBaseModel, Entity {
  FriendGroupTribe(
      {required this.id, required this.tribe, required this.friends});

  factory FriendGroupTribe.fromJson(dynamic json) => FriendGroupTribe(
      id: (json['id'] as String),
      tribe: GraphClientConfig.read(json['tribe'],
          typeName: 'Tribe', isNullable: false),
      friends: GraphClientConfig.readList(json['friends'],
          typeName: 'Contact', isNullable: false));

  FriendGroupTribe.fromMap(Map<String, dynamic> map)
      : id = map.get('id'),
        tribe = map.get('tribe'),
        friends = map.get('friends');

  String id;

  Tribe tribe;

  List<Contact> friends;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "friendGroupTribe", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return FriendGroupTribe.ref;
  }

  @override
  JsonObject toMap() =>
      {'id': this.id, 'tribe': this.tribe, 'friends': this.friends};
  JsonObject? toJson() {
    return {
      "id": this.id,
      "tribe":
          GraphClientConfig.write(this.tribe, typeName: "Tribe", isList: false),
      "friends": GraphClientConfig.write(this.friends,
          typeName: "Contact", isList: true),
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "id":
        this.id = value as String;
        break;
      case "tribe":
        this.tribe = value as Tribe;
        break;
      case "friends":
        this.friends = value as List<Contact>;
        break;
      default:
        throw "No field ${key} found for FriendGroupTribe";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "id":
        return this.id;

      case "tribe":
        return this.tribe;

      case "friends":
        return this.friends;

      default:
        throw "No field ${key} found on FriendGroupTribe";
    }
  }
}

class FriendGroupTribeFields {
  const FriendGroupTribeFields._();
  static const id = "id";
  static const tribe = "tribe";
  static const friends = "friends";
  static const values = {
    id,
    tribe,
    friends,
  };
}

class FriendGroupTribePaths {
  const FriendGroupTribePaths._();
  static const id = JsonPath<String>.single("id");
  static const tribe = JsonPath<Tribe>.single("tribe");
  static const friends = JsonPath<List<Contact>>.single("friends");
  static const values = [
    id,
    tribe,
    friends,
  ];
}

class Memory extends BaseSunnyEntity
    implements IRef, MBaseModel, Entity, IMemory {
  Memory(
      {required this.id,
      this.contacts,
      this.tribes,
      required this.displayName,
      this.memoryDetails,
      this.location,
      this.photoUrl,
      required this.memoryDate,
      this.imageMedia,
      this.videoMedia,
      this.dateCreated,
      this.dateModified});

  factory Memory.fromJson(dynamic json) => Memory(
      id: (json['id'] as String),
      contacts: GraphClientConfig.readList(json['contacts'],
          typeName: 'Contact', isNullable: true),
      tribes: GraphClientConfig.readList(json['tribes'],
          typeName: 'Tribe', isNullable: true),
      displayName: (json['displayName'] as String),
      memoryDetails: (json['memoryDetails'] as String?),
      location: GraphClientConfig.read(json['location'],
          typeName: 'PhysicalLocation', isNullable: true),
      photoUrl: GraphClientConfig.read(json['photoUrl'],
          typeName: 'Uri', isNullable: true),
      memoryDate: GraphClientConfig.read(json['memoryDate'],
          typeName: 'FlexiDate', isNullable: false),
      imageMedia: GraphClientConfig.readList(json['imageMedia'],
          typeName: 'ImageMedia', isNullable: true),
      videoMedia: GraphClientConfig.readList(json['videoMedia'],
          typeName: 'VideoMedia', isNullable: true),
      dateCreated: GraphClientConfig.read(json['dateCreated'],
          typeName: 'DateTime', isNullable: true),
      dateModified: GraphClientConfig.read(json['dateModified'],
          typeName: 'DateTime', isNullable: true));

  Memory.fromMap(Map<String, dynamic> map)
      : id = map.get('id'),
        contacts = map.get('contacts'),
        tribes = map.get('tribes'),
        displayName = map.get('displayName'),
        memoryDetails = map.get('memoryDetails'),
        location = map.get('location'),
        photoUrl = map.get('photoUrl'),
        memoryDate = map.get('memoryDate'),
        imageMedia = map.get('imageMedia'),
        videoMedia = map.get('videoMedia'),
        dateCreated = map.get('dateCreated'),
        dateModified = map.get('dateModified');

  String id;

  List<Contact>? contacts;

  List<Tribe>? tribes;

  String displayName;

  String? memoryDetails;

  PhysicalLocation? location;

  Uri? photoUrl;

  FlexiDate memoryDate;

  List<ImageMedia>? imageMedia;

  List<VideoMedia>? videoMedia;

  DateTime? dateCreated;

  DateTime? dateModified;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "memory", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return Memory.ref;
  }

  @override
  JsonObject toMap() => {
        'id': this.id,
        'contacts': this.contacts,
        'tribes': this.tribes,
        'displayName': this.displayName,
        'memoryDetails': this.memoryDetails,
        'location': this.location,
        'photoUrl': this.photoUrl,
        'memoryDate': this.memoryDate,
        'imageMedia': this.imageMedia,
        'videoMedia': this.videoMedia,
        'dateCreated': this.dateCreated,
        'dateModified': this.dateModified
      };
  JsonObject? toJson() {
    return {
      "id": this.id,
      "contacts": GraphClientConfig.write(this.contacts,
          typeName: "Contact", isList: true),
      "tribes":
          GraphClientConfig.write(this.tribes, typeName: "Tribe", isList: true),
      "displayName": this.displayName,
      "memoryDetails": this.memoryDetails,
      "location": GraphClientConfig.write(this.location,
          typeName: "PhysicalLocation", isList: false),
      "photoUrl": GraphClientConfig.write(this.photoUrl,
          typeName: "Uri", isList: false),
      "memoryDate": GraphClientConfig.write(this.memoryDate,
          typeName: "FlexiDate", isList: false),
      "imageMedia": GraphClientConfig.write(this.imageMedia,
          typeName: "ImageMedia", isList: true),
      "videoMedia": GraphClientConfig.write(this.videoMedia,
          typeName: "VideoMedia", isList: true),
      "dateCreated": GraphClientConfig.write(this.dateCreated,
          typeName: "DateTime", isList: false),
      "dateModified": GraphClientConfig.write(this.dateModified,
          typeName: "DateTime", isList: false),
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "id":
        this.id = value as String;
        break;
      case "contacts":
        this.contacts = value as List<Contact>?;
        break;
      case "tribes":
        this.tribes = value as List<Tribe>?;
        break;
      case "displayName":
        this.displayName = value as String;
        break;
      case "memoryDetails":
        this.memoryDetails = value as String?;
        break;
      case "location":
        this.location = value as PhysicalLocation?;
        break;
      case "photoUrl":
        this.photoUrl = value as Uri?;
        break;
      case "memoryDate":
        this.memoryDate = value as FlexiDate;
        break;
      case "imageMedia":
        this.imageMedia = value as List<ImageMedia>?;
        break;
      case "videoMedia":
        this.videoMedia = value as List<VideoMedia>?;
        break;
      case "dateCreated":
        this.dateCreated = value as DateTime?;
        break;
      case "dateModified":
        this.dateModified = value as DateTime?;
        break;
      default:
        throw "No field ${key} found for Memory";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "id":
        return this.id;

      case "contacts":
        return this.contacts;

      case "tribes":
        return this.tribes;

      case "displayName":
        return this.displayName;

      case "memoryDetails":
        return this.memoryDetails;

      case "location":
        return this.location;

      case "photoUrl":
        return this.photoUrl;

      case "memoryDate":
        return this.memoryDate;

      case "imageMedia":
        return this.imageMedia;

      case "videoMedia":
        return this.videoMedia;

      case "dateCreated":
        return this.dateCreated;

      case "dateModified":
        return this.dateModified;

      default:
        throw "No field ${key} found on Memory";
    }
  }
}

class MemoryFields {
  const MemoryFields._();
  static const id = "id";
  static const contacts = "contacts";
  static const tribes = "tribes";
  static const displayName = "displayName";
  static const memoryDetails = "memoryDetails";
  static const location = "location";
  static const photoUrl = "photoUrl";
  static const memoryDate = "memoryDate";
  static const imageMedia = "imageMedia";
  static const videoMedia = "videoMedia";
  static const dateCreated = "dateCreated";
  static const dateModified = "dateModified";
  static const values = {
    id,
    contacts,
    tribes,
    displayName,
    memoryDetails,
    location,
    photoUrl,
    memoryDate,
    imageMedia,
    videoMedia,
    dateCreated,
    dateModified,
  };
}

class MemoryPaths {
  const MemoryPaths._();
  static const id = JsonPath<String>.single("id");
  static const contacts = JsonPath<List<Contact>?>.single("contacts");
  static const tribes = JsonPath<List<Tribe>?>.single("tribes");
  static const displayName = JsonPath<String>.single("displayName");
  static const memoryDetails = JsonPath<String?>.single("memoryDetails");
  static const location = JsonPath<PhysicalLocation?>.single("location");
  static const photoUrl = JsonPath<Uri?>.single("photoUrl");
  static const memoryDate = JsonPath<FlexiDate>.single("memoryDate");
  static const imageMedia = JsonPath<List<ImageMedia>?>.single("imageMedia");
  static const videoMedia = JsonPath<List<VideoMedia>?>.single("videoMedia");
  static const dateCreated = JsonPath<DateTime?>.single("dateCreated");
  static const dateModified = JsonPath<DateTime?>.single("dateModified");
  static const values = [
    id,
    contacts,
    tribes,
    displayName,
    memoryDetails,
    location,
    photoUrl,
    memoryDate,
    imageMedia,
    videoMedia,
    dateCreated,
    dateModified,
  ];
}

class PhysicalLocation extends BaseSunnyEntity
    implements IRef, MBaseModel, Entity {
  PhysicalLocation(
      {required this.id,
      this.lat,
      this.lon,
      required this.displayName,
      this.photoUrl});

  factory PhysicalLocation.fromJson(dynamic json) => PhysicalLocation(
      id: (json['id'] as String),
      lat: GraphClientConfig.doubleOf(json['lat']),
      lon: GraphClientConfig.doubleOf(json['lon']),
      displayName: (json['displayName'] as String),
      photoUrl: GraphClientConfig.read(json['photoUrl'],
          typeName: 'Uri', isNullable: true));

  PhysicalLocation.fromMap(Map<String, dynamic> map)
      : id = map.get('id'),
        lat = map.get('lat'),
        lon = map.get('lon'),
        displayName = map.get('displayName'),
        photoUrl = map.get('photoUrl');

  String id;

  double? lat;

  double? lon;

  String displayName;

  Uri? photoUrl;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "physicalLocation", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return PhysicalLocation.ref;
  }

  @override
  JsonObject toMap() => {
        'id': this.id,
        'lat': this.lat,
        'lon': this.lon,
        'displayName': this.displayName,
        'photoUrl': this.photoUrl
      };
  JsonObject? toJson() {
    return {
      "id": this.id,
      "lat": GraphClientConfig.doubleOf(this.lat),
      "lon": GraphClientConfig.doubleOf(this.lon),
      "displayName": this.displayName,
      "photoUrl": GraphClientConfig.write(this.photoUrl,
          typeName: "Uri", isList: false),
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "id":
        this.id = value as String;
        break;
      case "lat":
        this.lat = value as double?;
        break;
      case "lon":
        this.lon = value as double?;
        break;
      case "displayName":
        this.displayName = value as String;
        break;
      case "photoUrl":
        this.photoUrl = value as Uri?;
        break;
      default:
        throw "No field ${key} found for PhysicalLocation";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "id":
        return this.id;

      case "lat":
        return this.lat;

      case "lon":
        return this.lon;

      case "displayName":
        return this.displayName;

      case "photoUrl":
        return this.photoUrl;

      default:
        throw "No field ${key} found on PhysicalLocation";
    }
  }
}

class PhysicalLocationFields {
  const PhysicalLocationFields._();
  static const id = "id";
  static const lat = "lat";
  static const lon = "lon";
  static const displayName = "displayName";
  static const photoUrl = "photoUrl";
  static const values = {
    id,
    lat,
    lon,
    displayName,
    photoUrl,
  };
}

class PhysicalLocationPaths {
  const PhysicalLocationPaths._();
  static const id = JsonPath<String>.single("id");
  static const lat = JsonPath<double?>.single("lat");
  static const lon = JsonPath<double?>.single("lon");
  static const displayName = JsonPath<String>.single("displayName");
  static const photoUrl = JsonPath<Uri?>.single("photoUrl");
  static const values = [
    id,
    lat,
    lon,
    displayName,
    photoUrl,
  ];
}

class ImageMedia extends BaseSunnyEntity
    implements Dimensioned, Media, MBaseModel, Entity {
  ImageMedia(
      {required this.id,
      required this.fileName,
      this.checksum,
      required this.mediaUrl,
      this.caption,
      this.location,
      this.aspect,
      this.height,
      this.width,
      this.mediaType,
      this.orientation,
      this.originalUrl});

  factory ImageMedia.fromJson(dynamic json) => ImageMedia(
      id: (json['id'] as String),
      fileName: (json['fileName'] as String),
      checksum: (json['checksum'] as String?),
      mediaUrl: GraphClientConfig.read(json['mediaUrl'],
          typeName: 'Uri', isNullable: false),
      caption: (json['caption'] as String?),
      location: GraphClientConfig.read(json['location'],
          typeName: 'PhysicalLocation', isNullable: true),
      aspect: GraphClientConfig.doubleOf(json['aspect']),
      height: GraphClientConfig.doubleOf(json['height']),
      width: GraphClientConfig.doubleOf(json['width']),
      mediaType: GraphClientConfig.read(json['mediaType'],
          typeName: 'MediaType', isNullable: true),
      orientation: GraphClientConfig.read(json['orientation'],
          typeName: 'Orientation', isNullable: true),
      originalUrl: GraphClientConfig.read(json['originalUrl'],
          typeName: 'Uri', isNullable: true));

  ImageMedia.fromMap(Map<String, dynamic> map)
      : id = map.get('id'),
        fileName = map.get('fileName'),
        checksum = map.get('checksum'),
        mediaUrl = map.get('mediaUrl'),
        caption = map.get('caption'),
        location = map.get('location'),
        aspect = map.get('aspect'),
        height = map.get('height'),
        width = map.get('width'),
        mediaType = map.get('mediaType'),
        orientation = map.get('orientation'),
        originalUrl = map.get('originalUrl');

  String id;

  String fileName;

  String? checksum;

  Uri mediaUrl;

  String? caption;

  PhysicalLocation? location;

  double? aspect;

  double? height;

  double? width;

  MediaType? mediaType;

  Orientation? orientation;

  Uri? originalUrl;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "imageMedia", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return ImageMedia.ref;
  }

  @override
  JsonObject toMap() => {
        'id': this.id,
        'fileName': this.fileName,
        'checksum': this.checksum,
        'mediaUrl': this.mediaUrl,
        'caption': this.caption,
        'location': this.location,
        'aspect': this.aspect,
        'height': this.height,
        'width': this.width,
        'mediaType': this.mediaType,
        'orientation': this.orientation,
        'originalUrl': this.originalUrl
      };
  JsonObject? toJson() {
    return {
      "id": this.id,
      "fileName": this.fileName,
      "checksum": this.checksum,
      "mediaUrl": GraphClientConfig.write(this.mediaUrl,
          typeName: "Uri", isList: false),
      "caption": this.caption,
      "location": GraphClientConfig.write(this.location,
          typeName: "PhysicalLocation", isList: false),
      "aspect": GraphClientConfig.doubleOf(this.aspect),
      "height": GraphClientConfig.doubleOf(this.height),
      "width": GraphClientConfig.doubleOf(this.width),
      "mediaType": GraphClientConfig.write(this.mediaType,
          typeName: "MediaType", isList: false),
      "orientation": GraphClientConfig.write(this.orientation,
          typeName: "Orientation", isList: false),
      "originalUrl": GraphClientConfig.write(this.originalUrl,
          typeName: "Uri", isList: false),
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "id":
        this.id = value as String;
        break;
      case "fileName":
        this.fileName = value as String;
        break;
      case "checksum":
        this.checksum = value as String?;
        break;
      case "mediaUrl":
        this.mediaUrl = value as Uri;
        break;
      case "caption":
        this.caption = value as String?;
        break;
      case "location":
        this.location = value as PhysicalLocation?;
        break;
      case "aspect":
        this.aspect = value as double?;
        break;
      case "height":
        this.height = value as double?;
        break;
      case "width":
        this.width = value as double?;
        break;
      case "mediaType":
        this.mediaType = value as MediaType?;
        break;
      case "orientation":
        this.orientation = value as Orientation?;
        break;
      case "originalUrl":
        this.originalUrl = value as Uri?;
        break;
      default:
        throw "No field ${key} found for ImageMedia";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "id":
        return this.id;

      case "fileName":
        return this.fileName;

      case "checksum":
        return this.checksum;

      case "mediaUrl":
        return this.mediaUrl;

      case "caption":
        return this.caption;

      case "location":
        return this.location;

      case "aspect":
        return this.aspect;

      case "height":
        return this.height;

      case "width":
        return this.width;

      case "mediaType":
        return this.mediaType;

      case "orientation":
        return this.orientation;

      case "originalUrl":
        return this.originalUrl;

      default:
        throw "No field ${key} found on ImageMedia";
    }
  }
}

class ImageMediaFields {
  const ImageMediaFields._();
  static const id = "id";
  static const fileName = "fileName";
  static const checksum = "checksum";
  static const mediaUrl = "mediaUrl";
  static const caption = "caption";
  static const location = "location";
  static const aspect = "aspect";
  static const height = "height";
  static const width = "width";
  static const mediaType = "mediaType";
  static const orientation = "orientation";
  static const originalUrl = "originalUrl";
  static const values = {
    id,
    fileName,
    checksum,
    mediaUrl,
    caption,
    location,
    aspect,
    height,
    width,
    mediaType,
    orientation,
    originalUrl,
  };
}

class ImageMediaPaths {
  const ImageMediaPaths._();
  static const id = JsonPath<String>.single("id");
  static const fileName = JsonPath<String>.single("fileName");
  static const checksum = JsonPath<String?>.single("checksum");
  static const mediaUrl = JsonPath<Uri>.single("mediaUrl");
  static const caption = JsonPath<String?>.single("caption");
  static const location = JsonPath<PhysicalLocation?>.single("location");
  static const aspect = JsonPath<double?>.single("aspect");
  static const height = JsonPath<double?>.single("height");
  static const width = JsonPath<double?>.single("width");
  static const mediaType = JsonPath<MediaType?>.single("mediaType");
  static const orientation = JsonPath<Orientation?>.single("orientation");
  static const originalUrl = JsonPath<Uri?>.single("originalUrl");
  static const values = [
    id,
    fileName,
    checksum,
    mediaUrl,
    caption,
    location,
    aspect,
    height,
    width,
    mediaType,
    orientation,
    originalUrl,
  ];
}

class VideoMedia extends BaseSunnyEntity
    implements Dimensioned, Media, MBaseModel, Entity {
  VideoMedia(
      {required this.id,
      required this.fileName,
      this.checksum,
      required this.mediaUrl,
      this.caption,
      this.location,
      this.aspect,
      this.height,
      this.width,
      this.mediaType,
      this.orientation,
      this.originalUrl,
      this.durationMs,
      this.startFrom,
      this.thumbnailUrl});

  factory VideoMedia.fromJson(dynamic json) => VideoMedia(
      id: (json['id'] as String),
      fileName: (json['fileName'] as String),
      checksum: (json['checksum'] as String?),
      mediaUrl: GraphClientConfig.read(json['mediaUrl'],
          typeName: 'Uri', isNullable: false),
      caption: (json['caption'] as String?),
      location: GraphClientConfig.read(json['location'],
          typeName: 'PhysicalLocation', isNullable: true),
      aspect: GraphClientConfig.doubleOf(json['aspect']),
      height: GraphClientConfig.doubleOf(json['height']),
      width: GraphClientConfig.doubleOf(json['width']),
      mediaType: GraphClientConfig.read(json['mediaType'],
          typeName: 'MediaType', isNullable: true),
      orientation: GraphClientConfig.read(json['orientation'],
          typeName: 'Orientation', isNullable: true),
      originalUrl: GraphClientConfig.read(json['originalUrl'],
          typeName: 'Uri', isNullable: true),
      durationMs: GraphClientConfig.intOf(json['durationMs']),
      startFrom: GraphClientConfig.intOf(json['startFrom']),
      thumbnailUrl: GraphClientConfig.read(json['thumbnailUrl'],
          typeName: 'ImageMedia', isNullable: true));

  VideoMedia.fromMap(Map<String, dynamic> map)
      : id = map.get('id'),
        fileName = map.get('fileName'),
        checksum = map.get('checksum'),
        mediaUrl = map.get('mediaUrl'),
        caption = map.get('caption'),
        location = map.get('location'),
        aspect = map.get('aspect'),
        height = map.get('height'),
        width = map.get('width'),
        mediaType = map.get('mediaType'),
        orientation = map.get('orientation'),
        originalUrl = map.get('originalUrl'),
        durationMs = map.get('durationMs'),
        startFrom = map.get('startFrom'),
        thumbnailUrl = map.get('thumbnailUrl');

  String id;

  String fileName;

  String? checksum;

  Uri mediaUrl;

  String? caption;

  PhysicalLocation? location;

  double? aspect;

  double? height;

  double? width;

  MediaType? mediaType;

  Orientation? orientation;

  Uri? originalUrl;

  int? durationMs;

  int? startFrom;

  ImageMedia? thumbnailUrl;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "videoMedia", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return VideoMedia.ref;
  }

  @override
  JsonObject toMap() => {
        'id': this.id,
        'fileName': this.fileName,
        'checksum': this.checksum,
        'mediaUrl': this.mediaUrl,
        'caption': this.caption,
        'location': this.location,
        'aspect': this.aspect,
        'height': this.height,
        'width': this.width,
        'mediaType': this.mediaType,
        'orientation': this.orientation,
        'originalUrl': this.originalUrl,
        'durationMs': this.durationMs,
        'startFrom': this.startFrom,
        'thumbnailUrl': this.thumbnailUrl
      };
  JsonObject? toJson() {
    return {
      "id": this.id,
      "fileName": this.fileName,
      "checksum": this.checksum,
      "mediaUrl": GraphClientConfig.write(this.mediaUrl,
          typeName: "Uri", isList: false),
      "caption": this.caption,
      "location": GraphClientConfig.write(this.location,
          typeName: "PhysicalLocation", isList: false),
      "aspect": GraphClientConfig.doubleOf(this.aspect),
      "height": GraphClientConfig.doubleOf(this.height),
      "width": GraphClientConfig.doubleOf(this.width),
      "mediaType": GraphClientConfig.write(this.mediaType,
          typeName: "MediaType", isList: false),
      "orientation": GraphClientConfig.write(this.orientation,
          typeName: "Orientation", isList: false),
      "originalUrl": GraphClientConfig.write(this.originalUrl,
          typeName: "Uri", isList: false),
      "durationMs": GraphClientConfig.intOf(this.durationMs),
      "startFrom": GraphClientConfig.intOf(this.startFrom),
      "thumbnailUrl": GraphClientConfig.write(this.thumbnailUrl,
          typeName: "ImageMedia", isList: false),
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "id":
        this.id = value as String;
        break;
      case "fileName":
        this.fileName = value as String;
        break;
      case "checksum":
        this.checksum = value as String?;
        break;
      case "mediaUrl":
        this.mediaUrl = value as Uri;
        break;
      case "caption":
        this.caption = value as String?;
        break;
      case "location":
        this.location = value as PhysicalLocation?;
        break;
      case "aspect":
        this.aspect = value as double?;
        break;
      case "height":
        this.height = value as double?;
        break;
      case "width":
        this.width = value as double?;
        break;
      case "mediaType":
        this.mediaType = value as MediaType?;
        break;
      case "orientation":
        this.orientation = value as Orientation?;
        break;
      case "originalUrl":
        this.originalUrl = value as Uri?;
        break;
      case "durationMs":
        this.durationMs = value as int?;
        break;
      case "startFrom":
        this.startFrom = value as int?;
        break;
      case "thumbnailUrl":
        this.thumbnailUrl = value as ImageMedia?;
        break;
      default:
        throw "No field ${key} found for VideoMedia";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "id":
        return this.id;

      case "fileName":
        return this.fileName;

      case "checksum":
        return this.checksum;

      case "mediaUrl":
        return this.mediaUrl;

      case "caption":
        return this.caption;

      case "location":
        return this.location;

      case "aspect":
        return this.aspect;

      case "height":
        return this.height;

      case "width":
        return this.width;

      case "mediaType":
        return this.mediaType;

      case "orientation":
        return this.orientation;

      case "originalUrl":
        return this.originalUrl;

      case "durationMs":
        return this.durationMs;

      case "startFrom":
        return this.startFrom;

      case "thumbnailUrl":
        return this.thumbnailUrl;

      default:
        throw "No field ${key} found on VideoMedia";
    }
  }
}

class VideoMediaFields {
  const VideoMediaFields._();
  static const id = "id";
  static const fileName = "fileName";
  static const checksum = "checksum";
  static const mediaUrl = "mediaUrl";
  static const caption = "caption";
  static const location = "location";
  static const aspect = "aspect";
  static const height = "height";
  static const width = "width";
  static const mediaType = "mediaType";
  static const orientation = "orientation";
  static const originalUrl = "originalUrl";
  static const durationMs = "durationMs";
  static const startFrom = "startFrom";
  static const thumbnailUrl = "thumbnailUrl";
  static const values = {
    id,
    fileName,
    checksum,
    mediaUrl,
    caption,
    location,
    aspect,
    height,
    width,
    mediaType,
    orientation,
    originalUrl,
    durationMs,
    startFrom,
    thumbnailUrl,
  };
}

class VideoMediaPaths {
  const VideoMediaPaths._();
  static const id = JsonPath<String>.single("id");
  static const fileName = JsonPath<String>.single("fileName");
  static const checksum = JsonPath<String?>.single("checksum");
  static const mediaUrl = JsonPath<Uri>.single("mediaUrl");
  static const caption = JsonPath<String?>.single("caption");
  static const location = JsonPath<PhysicalLocation?>.single("location");
  static const aspect = JsonPath<double?>.single("aspect");
  static const height = JsonPath<double?>.single("height");
  static const width = JsonPath<double?>.single("width");
  static const mediaType = JsonPath<MediaType?>.single("mediaType");
  static const orientation = JsonPath<Orientation?>.single("orientation");
  static const originalUrl = JsonPath<Uri?>.single("originalUrl");
  static const durationMs = JsonPath<int?>.single("durationMs");
  static const startFrom = JsonPath<int?>.single("startFrom");
  static const thumbnailUrl = JsonPath<ImageMedia?>.single("thumbnailUrl");
  static const values = [
    id,
    fileName,
    checksum,
    mediaUrl,
    caption,
    location,
    aspect,
    height,
    width,
    mediaType,
    orientation,
    originalUrl,
    durationMs,
    startFrom,
    thumbnailUrl,
  ];
}

class UserContact extends BaseSunnyEntity implements MBaseModel, Entity {
  UserContact(
      {required this.id,
      required this.contact,
      this.username,
      this.firebaseUid,
      this.email,
      this.phone});

  factory UserContact.fromJson(dynamic json) => UserContact(
      id: (json['id'] as String),
      contact: GraphClientConfig.read(json['contact'],
          typeName: 'Contact', isNullable: false),
      username: (json['username'] as String?),
      firebaseUid: (json['firebaseUid'] as String?),
      email: (json['email'] as String?),
      phone: (json['phone'] as String?));

  UserContact.fromMap(Map<String, dynamic> map)
      : id = map.get('id'),
        contact = map.get('contact'),
        username = map.get('username'),
        firebaseUid = map.get('firebaseUid'),
        email = map.get('email'),
        phone = map.get('phone');

  String id;

  Contact contact;

  String? username;

  String? firebaseUid;

  String? email;

  String? phone;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "userContact", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return UserContact.ref;
  }

  @override
  JsonObject toMap() => {
        'id': this.id,
        'contact': this.contact,
        'username': this.username,
        'firebaseUid': this.firebaseUid,
        'email': this.email,
        'phone': this.phone
      };
  JsonObject? toJson() {
    return {
      "id": this.id,
      "contact": GraphClientConfig.write(this.contact,
          typeName: "Contact", isList: false),
      "username": this.username,
      "firebaseUid": this.firebaseUid,
      "email": this.email,
      "phone": this.phone,
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "id":
        this.id = value as String;
        break;
      case "contact":
        this.contact = value as Contact;
        break;
      case "username":
        this.username = value as String?;
        break;
      case "firebaseUid":
        this.firebaseUid = value as String?;
        break;
      case "email":
        this.email = value as String?;
        break;
      case "phone":
        this.phone = value as String?;
        break;
      default:
        throw "No field ${key} found for UserContact";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "id":
        return this.id;

      case "contact":
        return this.contact;

      case "username":
        return this.username;

      case "firebaseUid":
        return this.firebaseUid;

      case "email":
        return this.email;

      case "phone":
        return this.phone;

      default:
        throw "No field ${key} found on UserContact";
    }
  }
}

class UserContactFields {
  const UserContactFields._();
  static const id = "id";
  static const contact = "contact";
  static const username = "username";
  static const firebaseUid = "firebaseUid";
  static const email = "email";
  static const phone = "phone";
  static const values = {
    id,
    contact,
    username,
    firebaseUid,
    email,
    phone,
  };
}

class UserContactPaths {
  const UserContactPaths._();
  static const id = JsonPath<String>.single("id");
  static const contact = JsonPath<Contact>.single("contact");
  static const username = JsonPath<String?>.single("username");
  static const firebaseUid = JsonPath<String?>.single("firebaseUid");
  static const email = JsonPath<String?>.single("email");
  static const phone = JsonPath<String?>.single("phone");
  static const values = [
    id,
    contact,
    username,
    firebaseUid,
    email,
    phone,
  ];
}

class TribeMembership extends BaseSunnyEntity
    with JoinTypeMixin<Tribe>
    implements TribeMemberDetails, MBaseModel, Entity {
  TribeMembership(
      {this.node,
      this.joined,
      this.requested,
      this.role,
      this.isAdmin,
      this.dateCreated,
      this.dateModified});

  factory TribeMembership.fromJson(dynamic json) => TribeMembership(
      node: GraphClientConfig.read(json['node'],
          typeName: 'Tribe', isNullable: true),
      joined: (json['joined'] as bool?),
      requested: (json['requested'] as bool?),
      role: (json['role'] as String?),
      isAdmin: (json['isAdmin'] as bool?),
      dateCreated: GraphClientConfig.read(json['dateCreated'],
          typeName: 'DateTime', isNullable: true),
      dateModified: GraphClientConfig.read(json['dateModified'],
          typeName: 'DateTime', isNullable: true));

  TribeMembership.fromMap(Map<String, dynamic> map)
      : node = map.get('node'),
        joined = map.get('joined'),
        requested = map.get('requested'),
        role = map.get('role'),
        isAdmin = map.get('isAdmin'),
        dateCreated = map.get('dateCreated'),
        dateModified = map.get('dateModified');

  Tribe? node;

  bool? joined;

  bool? requested;

  String? role;

  bool? isAdmin;

  DateTime? dateCreated;

  DateTime? dateModified;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "tribeMembership", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return TribeMembership.ref;
  }

  @override
  JsonObject toMap() => {
        'node': this.node,
        'joined': this.joined,
        'requested': this.requested,
        'role': this.role,
        'isAdmin': this.isAdmin,
        'dateCreated': this.dateCreated,
        'dateModified': this.dateModified
      };
  JsonObject? toJson() {
    return {
      "node":
          GraphClientConfig.write(this.node, typeName: "Tribe", isList: false),
      "joined": this.joined,
      "requested": this.requested,
      "role": this.role,
      "isAdmin": this.isAdmin,
      "dateCreated": GraphClientConfig.write(this.dateCreated,
          typeName: "DateTime", isList: false),
      "dateModified": GraphClientConfig.write(this.dateModified,
          typeName: "DateTime", isList: false),
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "node":
        this.node = value as Tribe?;
        break;
      case "joined":
        this.joined = value as bool?;
        break;
      case "requested":
        this.requested = value as bool?;
        break;
      case "role":
        this.role = value as String?;
        break;
      case "isAdmin":
        this.isAdmin = value as bool?;
        break;
      case "dateCreated":
        this.dateCreated = value as DateTime?;
        break;
      case "dateModified":
        this.dateModified = value as DateTime?;
        break;
      default:
        throw "No field ${key} found for TribeMembership";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "node":
        return this.node;

      case "joined":
        return this.joined;

      case "requested":
        return this.requested;

      case "role":
        return this.role;

      case "isAdmin":
        return this.isAdmin;

      case "dateCreated":
        return this.dateCreated;

      case "dateModified":
        return this.dateModified;

      default:
        throw "No field ${key} found on TribeMembership";
    }
  }
}

class TribeMembershipFields {
  const TribeMembershipFields._();
  static const node = "node";
  static const joined = "joined";
  static const requested = "requested";
  static const role = "role";
  static const isAdmin = "isAdmin";
  static const dateCreated = "dateCreated";
  static const dateModified = "dateModified";
  static const values = {
    node,
    joined,
    requested,
    role,
    isAdmin,
    dateCreated,
    dateModified,
  };
}

class TribeMembershipPaths {
  const TribeMembershipPaths._();
  static const node = JsonPath<Tribe?>.single("node");
  static const joined = JsonPath<bool?>.single("joined");
  static const requested = JsonPath<bool?>.single("requested");
  static const role = JsonPath<String?>.single("role");
  static const isAdmin = JsonPath<bool?>.single("isAdmin");
  static const dateCreated = JsonPath<DateTime?>.single("dateCreated");
  static const dateModified = JsonPath<DateTime?>.single("dateModified");
  static const values = [
    node,
    joined,
    requested,
    role,
    isAdmin,
    dateCreated,
    dateModified,
  ];
}

class TribeMember extends BaseSunnyEntity
    with JoinTypeMixin<Contact>
    implements TribeMemberDetails, MBaseModel, Entity {
  TribeMember(
      {this.node,
      this.joined,
      this.requested,
      this.role,
      this.isAdmin,
      this.dateCreated,
      this.dateModified});

  factory TribeMember.fromJson(dynamic json) => TribeMember(
      node: GraphClientConfig.read(json['node'],
          typeName: 'Contact', isNullable: true),
      joined: (json['joined'] as bool?),
      requested: (json['requested'] as bool?),
      role: (json['role'] as String?),
      isAdmin: (json['isAdmin'] as bool?),
      dateCreated: GraphClientConfig.read(json['dateCreated'],
          typeName: 'DateTime', isNullable: true),
      dateModified: GraphClientConfig.read(json['dateModified'],
          typeName: 'DateTime', isNullable: true));

  TribeMember.fromMap(Map<String, dynamic> map)
      : node = map.get('node'),
        joined = map.get('joined'),
        requested = map.get('requested'),
        role = map.get('role'),
        isAdmin = map.get('isAdmin'),
        dateCreated = map.get('dateCreated'),
        dateModified = map.get('dateModified');

  Contact? node;

  bool? joined;

  bool? requested;

  String? role;

  bool? isAdmin;

  DateTime? dateCreated;

  DateTime? dateModified;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "tribeMember", "1.0.0", "mvext");

  MSchemaRef get mtype {
    return TribeMember.ref;
  }

  @override
  JsonObject toMap() => {
        'node': this.node,
        'joined': this.joined,
        'requested': this.requested,
        'role': this.role,
        'isAdmin': this.isAdmin,
        'dateCreated': this.dateCreated,
        'dateModified': this.dateModified
      };
  JsonObject? toJson() {
    return {
      "node": GraphClientConfig.write(this.node,
          typeName: "Contact", isList: false),
      "joined": this.joined,
      "requested": this.requested,
      "role": this.role,
      "isAdmin": this.isAdmin,
      "dateCreated": GraphClientConfig.write(this.dateCreated,
          typeName: "DateTime", isList: false),
      "dateModified": GraphClientConfig.write(this.dateModified,
          typeName: "DateTime", isList: false),
    };
  }

  @override
  void operator []=(String key, value) {
    switch (key) {
      case "node":
        this.node = value as Contact?;
        break;
      case "joined":
        this.joined = value as bool?;
        break;
      case "requested":
        this.requested = value as bool?;
        break;
      case "role":
        this.role = value as String?;
        break;
      case "isAdmin":
        this.isAdmin = value as bool?;
        break;
      case "dateCreated":
        this.dateCreated = value as DateTime?;
        break;
      case "dateModified":
        this.dateModified = value as DateTime?;
        break;
      default:
        throw "No field ${key} found for TribeMember";
    }
  }

  @override
  dynamic operator [](key) {
    switch (key) {
      case "node":
        return this.node;

      case "joined":
        return this.joined;

      case "requested":
        return this.requested;

      case "role":
        return this.role;

      case "isAdmin":
        return this.isAdmin;

      case "dateCreated":
        return this.dateCreated;

      case "dateModified":
        return this.dateModified;

      default:
        throw "No field ${key} found on TribeMember";
    }
  }
}

class TribeMemberFields {
  const TribeMemberFields._();
  static const node = "node";
  static const joined = "joined";
  static const requested = "requested";
  static const role = "role";
  static const isAdmin = "isAdmin";
  static const dateCreated = "dateCreated";
  static const dateModified = "dateModified";
  static const values = {
    node,
    joined,
    requested,
    role,
    isAdmin,
    dateCreated,
    dateModified,
  };
}

class TribeMemberPaths {
  const TribeMemberPaths._();
  static const node = JsonPath<Contact?>.single("node");
  static const joined = JsonPath<bool?>.single("joined");
  static const requested = JsonPath<bool?>.single("requested");
  static const role = JsonPath<String?>.single("role");
  static const isAdmin = JsonPath<bool?>.single("isAdmin");
  static const dateCreated = JsonPath<DateTime?>.single("dateCreated");
  static const dateModified = JsonPath<DateTime?>.single("dateModified");
  static const values = [
    node,
    joined,
    requested,
    role,
    isAdmin,
    dateCreated,
    dateModified,
  ];
}

abstract class Dimensioned {
  double? get height;
  set height(double? height);
  double? get width;
  set width(double? width);
}

abstract class ITribeMixin {
  Tribe get tribe;
  set tribe(Tribe tribe);
}

abstract class Media {
  String get id;
  set id(String id);
  String get fileName;
  set fileName(String fileName);
  String? get checksum;
  set checksum(String? checksum);
  Uri get mediaUrl;
  set mediaUrl(Uri mediaUrl);
  String? get caption;
  set caption(String? caption);
  PhysicalLocation? get location;
  set location(PhysicalLocation? location);
  double? get aspect;
  set aspect(double? aspect);
  double? get height;
  set height(double? height);
  double? get width;
  set width(double? width);
  MediaType? get mediaType;
  set mediaType(MediaType? mediaType);
  Orientation? get orientation;
  set orientation(Orientation? orientation);
}

abstract class TribeMemberDetails {
  bool? get joined;
  set joined(bool? joined);
  bool? get requested;
  set requested(bool? requested);
  String? get role;
  set role(String? role);
  bool? get isAdmin;
  set isAdmin(bool? isAdmin);
  DateTime? get dateCreated;
  set dateCreated(DateTime? dateCreated);
  DateTime? get dateModified;
  set dateModified(DateTime? dateModified);
}

class ContactCreateInput with GraphInputMixin implements MBaseModel {
  ContactCreateInput(
      {String? displayName,
      String? nickName,
      Uri? photoUrl,
      FlexiDate? birthday,
      ExtGraphRefList<Tribe, TribeMembership, TribeCreateInput,
              TribeUpdateInput>?
          tribes,
      GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? phases,
      NullableGraphRef<FamilyTribe, FamilyTribeCreateInput,
              FamilyTribeUpdateInput>?
          childFamily,
      NullableGraphRef<FamilyTribe, FamilyTribeCreateInput,
              FamilyTribeUpdateInput>?
          parentFamily,
      GraphRefList<FriendGroupTribe, FriendGroupTribeCreateInput,
              FriendGroupTribeUpdateInput>?
          friendGroups,
      GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? memories})
      : _data = {
          if (displayName != null) "displayName": displayName,
          if (nickName != null) "nickName": nickName,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (birthday != null) "birthday": birthday,
          if (tribes != null) "tribes": tribes,
          if (phases != null) "phases": phases,
          if (childFamily != null) "childFamily": childFamily,
          if (parentFamily != null) "parentFamily": parentFamily,
          if (friendGroups != null) "friendGroups": friendGroups,
          if (memories != null) "memories": memories,
        };

  ContactCreateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return Contact.ref;
  }

  String get displayName {
    return this.get("displayName");
  }

  void set displayName(String displayName) {
    _data["displayName"] = displayName;
  }

  String? get nickName {
    return this.get("nickName");
  }

  void set nickName(String? nickName) {
    _data["nickName"] = nickName;
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  void set photoUrl(Uri? photoUrl) {
    _data["photoUrl"] = photoUrl;
  }

  FlexiDate? get birthday {
    return this.get("birthday");
  }

  void set birthday(FlexiDate? birthday) {
    _data["birthday"] = birthday;
  }

  ExtGraphRefList<Tribe, TribeMembership, TribeCreateInput, TribeUpdateInput>?
      get tribes {
    return this.get("tribes");
  }

  void set tribes(
      ExtGraphRefList<Tribe, TribeMembership, TribeCreateInput,
              TribeUpdateInput>?
          tribes) {
    _data["tribes"] = tribes;
  }

  GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? get phases {
    return this.get("phases");
  }

  void set phases(
      GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? phases) {
    _data["phases"] = phases;
  }

  NullableGraphRef<FamilyTribe, FamilyTribeCreateInput, FamilyTribeUpdateInput>?
      get childFamily {
    return this.get("childFamily");
  }

  void set childFamily(
      NullableGraphRef<FamilyTribe, FamilyTribeCreateInput,
              FamilyTribeUpdateInput>?
          childFamily) {
    _data["childFamily"] = childFamily;
  }

  NullableGraphRef<FamilyTribe, FamilyTribeCreateInput, FamilyTribeUpdateInput>?
      get parentFamily {
    return this.get("parentFamily");
  }

  void set parentFamily(
      NullableGraphRef<FamilyTribe, FamilyTribeCreateInput,
              FamilyTribeUpdateInput>?
          parentFamily) {
    _data["parentFamily"] = parentFamily;
  }

  GraphRefList<FriendGroupTribe, FriendGroupTribeCreateInput,
      FriendGroupTribeUpdateInput>? get friendGroups {
    return this.get("friendGroups");
  }

  void set friendGroups(
      GraphRefList<FriendGroupTribe, FriendGroupTribeCreateInput,
              FriendGroupTribeUpdateInput>?
          friendGroups) {
    _data["friendGroups"] = friendGroups;
  }

  GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? get memories {
    return this.get("memories");
  }

  void set memories(
      GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? memories) {
    _data["memories"] = memories;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "displayName":
        json["displayName"] = value;
        break;
      case "nickName":
        json["nickName"] = value;
        break;
      case "photoUrl":
        json["photoUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "birthday":
        json["birthday"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribes", this.tribes?.relatedJson),
        relatedFieldJson("phases", this.phases?.relatedJson),
        relatedFieldJson("childFamily", this.childFamily?.relatedJson),
        relatedFieldJson("parentFamily", this.parentFamily?.relatedJson),
        relatedFieldJson("friendGroups", this.friendGroups?.relatedJson),
        relatedFieldJson("memories", this.memories?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class ContactUpdateInput with GraphInputMixin implements MBaseModel {
  ContactUpdateInput(
      {String? displayName,
      String? nickName,
      Uri? photoUrl,
      FlexiDate? birthday,
      ExtGraphRefList<Tribe, TribeMembership, TribeCreateInput,
              TribeUpdateInput>?
          tribes,
      GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? phases,
      NullableGraphRef<FamilyTribe, FamilyTribeCreateInput,
              FamilyTribeUpdateInput>?
          childFamily,
      NullableGraphRef<FamilyTribe, FamilyTribeCreateInput,
              FamilyTribeUpdateInput>?
          parentFamily,
      GraphRefList<FriendGroupTribe, FriendGroupTribeCreateInput,
              FriendGroupTribeUpdateInput>?
          friendGroups,
      GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? memories})
      : _data = {
          if (displayName != null) "displayName": displayName,
          if (nickName != null) "nickName": nickName,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (birthday != null) "birthday": birthday,
          if (tribes != null) "tribes": tribes,
          if (phases != null) "phases": phases,
          if (childFamily != null) "childFamily": childFamily,
          if (parentFamily != null) "parentFamily": parentFamily,
          if (friendGroups != null) "friendGroups": friendGroups,
          if (memories != null) "memories": memories,
        };

  ContactUpdateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return Contact.ref;
  }

  String get displayName {
    return this.get("displayName");
  }

  void set displayName(String displayName) {
    _data["displayName"] = displayName;
  }

  String? get nickName {
    return this.get("nickName");
  }

  void set nickName(String? nickName) {
    _data["nickName"] = nickName;
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  void set photoUrl(Uri? photoUrl) {
    _data["photoUrl"] = photoUrl;
  }

  FlexiDate? get birthday {
    return this.get("birthday");
  }

  void set birthday(FlexiDate? birthday) {
    _data["birthday"] = birthday;
  }

  ExtGraphRefList<Tribe, TribeMembership, TribeCreateInput, TribeUpdateInput>?
      get tribes {
    return this.get("tribes");
  }

  void set tribes(
      ExtGraphRefList<Tribe, TribeMembership, TribeCreateInput,
              TribeUpdateInput>?
          tribes) {
    _data["tribes"] = tribes;
  }

  GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? get phases {
    return this.get("phases");
  }

  void set phases(
      GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? phases) {
    _data["phases"] = phases;
  }

  NullableGraphRef<FamilyTribe, FamilyTribeCreateInput, FamilyTribeUpdateInput>?
      get childFamily {
    return this.get("childFamily");
  }

  void set childFamily(
      NullableGraphRef<FamilyTribe, FamilyTribeCreateInput,
              FamilyTribeUpdateInput>?
          childFamily) {
    _data["childFamily"] = childFamily;
  }

  NullableGraphRef<FamilyTribe, FamilyTribeCreateInput, FamilyTribeUpdateInput>?
      get parentFamily {
    return this.get("parentFamily");
  }

  void set parentFamily(
      NullableGraphRef<FamilyTribe, FamilyTribeCreateInput,
              FamilyTribeUpdateInput>?
          parentFamily) {
    _data["parentFamily"] = parentFamily;
  }

  GraphRefList<FriendGroupTribe, FriendGroupTribeCreateInput,
      FriendGroupTribeUpdateInput>? get friendGroups {
    return this.get("friendGroups");
  }

  void set friendGroups(
      GraphRefList<FriendGroupTribe, FriendGroupTribeCreateInput,
              FriendGroupTribeUpdateInput>?
          friendGroups) {
    _data["friendGroups"] = friendGroups;
  }

  GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? get memories {
    return this.get("memories");
  }

  void set memories(
      GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? memories) {
    _data["memories"] = memories;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "displayName":
        json["displayName"] = value;
        break;
      case "nickName":
        json["nickName"] = value;
        break;
      case "photoUrl":
        json["photoUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "birthday":
        json["birthday"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribes", this.tribes?.relatedJson),
        relatedFieldJson("phases", this.phases?.relatedJson),
        relatedFieldJson("childFamily", this.childFamily?.relatedJson),
        relatedFieldJson("parentFamily", this.parentFamily?.relatedJson),
        relatedFieldJson("friendGroups", this.friendGroups?.relatedJson),
        relatedFieldJson("memories", this.memories?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class FamilyTribeCreateInput with GraphInputMixin implements MBaseModel {
  FamilyTribeCreateInput(
      {GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? tribe,
      FlexiDate? startDate,
      FlexiDate? endDate,
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? parents,
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? children})
      : _data = {
          if (tribe != null) "tribe": tribe,
          if (startDate != null) "startDate": startDate,
          if (endDate != null) "endDate": endDate,
          if (parents != null) "parents": parents,
          if (children != null) "children": children,
        };

  FamilyTribeCreateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return FamilyTribe.ref;
  }

  GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? get tribe {
    return this.get("tribe");
  }

  void set tribe(GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? tribe) {
    _data["tribe"] = tribe;
  }

  FlexiDate? get startDate {
    return this.get("startDate");
  }

  void set startDate(FlexiDate? startDate) {
    _data["startDate"] = startDate;
  }

  FlexiDate? get endDate {
    return this.get("endDate");
  }

  void set endDate(FlexiDate? endDate) {
    _data["endDate"] = endDate;
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get parents {
    return this.get("parents");
  }

  void set parents(
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? parents) {
    _data["parents"] = parents;
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get children {
    return this.get("children");
  }

  void set children(
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? children) {
    _data["children"] = children;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "startDate":
        json["startDate"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
      case "endDate":
        json["endDate"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribe", this.tribe?.relatedJson),
        relatedFieldJson("parents", this.parents?.relatedJson),
        relatedFieldJson("children", this.children?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class FamilyTribeUpdateInput with GraphInputMixin implements MBaseModel {
  FamilyTribeUpdateInput(
      {GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? tribe,
      FlexiDate? startDate,
      FlexiDate? endDate,
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? parents,
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? children})
      : _data = {
          if (tribe != null) "tribe": tribe,
          if (startDate != null) "startDate": startDate,
          if (endDate != null) "endDate": endDate,
          if (parents != null) "parents": parents,
          if (children != null) "children": children,
        };

  FamilyTribeUpdateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return FamilyTribe.ref;
  }

  GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? get tribe {
    return this.get("tribe");
  }

  void set tribe(GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? tribe) {
    _data["tribe"] = tribe;
  }

  FlexiDate? get startDate {
    return this.get("startDate");
  }

  void set startDate(FlexiDate? startDate) {
    _data["startDate"] = startDate;
  }

  FlexiDate? get endDate {
    return this.get("endDate");
  }

  void set endDate(FlexiDate? endDate) {
    _data["endDate"] = endDate;
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get parents {
    return this.get("parents");
  }

  void set parents(
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? parents) {
    _data["parents"] = parents;
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get children {
    return this.get("children");
  }

  void set children(
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? children) {
    _data["children"] = children;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "startDate":
        json["startDate"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
      case "endDate":
        json["endDate"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribe", this.tribe?.relatedJson),
        relatedFieldJson("parents", this.parents?.relatedJson),
        relatedFieldJson("children", this.children?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class FriendGroupTribeCreateInput with GraphInputMixin implements MBaseModel {
  FriendGroupTribeCreateInput(
      {GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? tribe,
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? friends})
      : _data = {
          if (tribe != null) "tribe": tribe,
          if (friends != null) "friends": friends,
        };

  FriendGroupTribeCreateInput.fromJson(json)
      : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return FriendGroupTribe.ref;
  }

  GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? get tribe {
    return this.get("tribe");
  }

  void set tribe(GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? tribe) {
    _data["tribe"] = tribe;
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get friends {
    return this.get("friends");
  }

  void set friends(
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? friends) {
    _data["friends"] = friends;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribe", this.tribe?.relatedJson),
        relatedFieldJson("friends", this.friends?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class FriendGroupTribeUpdateInput with GraphInputMixin implements MBaseModel {
  FriendGroupTribeUpdateInput(
      {GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? tribe,
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? friends})
      : _data = {
          if (tribe != null) "tribe": tribe,
          if (friends != null) "friends": friends,
        };

  FriendGroupTribeUpdateInput.fromJson(json)
      : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return FriendGroupTribe.ref;
  }

  GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? get tribe {
    return this.get("tribe");
  }

  void set tribe(GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? tribe) {
    _data["tribe"] = tribe;
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get friends {
    return this.get("friends");
  }

  void set friends(
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? friends) {
    _data["friends"] = friends;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribe", this.tribe?.relatedJson),
        relatedFieldJson("friends", this.friends?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class ImageMediaCreateInput with GraphInputMixin implements MBaseModel {
  ImageMediaCreateInput(
      {String? fileName,
      String? checksum,
      Uri? mediaUrl,
      String? caption,
      PhysicalLocation? location,
      double? aspect,
      double? height,
      double? width,
      MediaType? mediaType,
      Orientation? orientation,
      Uri? originalUrl})
      : _data = {
          if (fileName != null) "fileName": fileName,
          if (checksum != null) "checksum": checksum,
          if (mediaUrl != null) "mediaUrl": mediaUrl,
          if (caption != null) "caption": caption,
          if (location != null) "location": location,
          if (aspect != null) "aspect": aspect,
          if (height != null) "height": height,
          if (width != null) "width": width,
          if (mediaType != null) "mediaType": mediaType,
          if (orientation != null) "orientation": orientation,
          if (originalUrl != null) "originalUrl": originalUrl,
        };

  ImageMediaCreateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return ImageMedia.ref;
  }

  String get fileName {
    return this.get("fileName");
  }

  void set fileName(String fileName) {
    _data["fileName"] = fileName;
  }

  String? get checksum {
    return this.get("checksum");
  }

  void set checksum(String? checksum) {
    _data["checksum"] = checksum;
  }

  Uri get mediaUrl {
    return this.get("mediaUrl");
  }

  void set mediaUrl(Uri mediaUrl) {
    _data["mediaUrl"] = mediaUrl;
  }

  String? get caption {
    return this.get("caption");
  }

  void set caption(String? caption) {
    _data["caption"] = caption;
  }

  PhysicalLocation? get location {
    return this.get("location");
  }

  void set location(PhysicalLocation? location) {
    _data["location"] = location;
  }

  double? get aspect {
    return this.get("aspect");
  }

  void set aspect(double? aspect) {
    _data["aspect"] = aspect;
  }

  double? get height {
    return this.get("height");
  }

  void set height(double? height) {
    _data["height"] = height;
  }

  double? get width {
    return this.get("width");
  }

  void set width(double? width) {
    _data["width"] = width;
  }

  MediaType? get mediaType {
    return this.get("mediaType");
  }

  void set mediaType(MediaType? mediaType) {
    _data["mediaType"] = mediaType;
  }

  Orientation? get orientation {
    return this.get("orientation");
  }

  void set orientation(Orientation? orientation) {
    _data["orientation"] = orientation;
  }

  Uri? get originalUrl {
    return this.get("originalUrl");
  }

  void set originalUrl(Uri? originalUrl) {
    _data["originalUrl"] = originalUrl;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "fileName":
        json["fileName"] = value;
        break;
      case "checksum":
        json["checksum"] = value;
        break;
      case "mediaUrl":
        json["mediaUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "caption":
        json["caption"] = value;
        break;
      case "location":
        json["location"] = GraphClientConfig.write(value,
            typeName: "PhysicalLocation", isList: false);
        break;
      case "aspect":
        json["aspect"] = GraphClientConfig.doubleOf(value);
        break;
      case "height":
        json["height"] = GraphClientConfig.doubleOf(value);
        break;
      case "width":
        json["width"] = GraphClientConfig.doubleOf(value);
        break;
      case "mediaType":
        json["mediaType"] = GraphClientConfig.write(value,
            typeName: "MediaType", isList: false);
        break;
      case "orientation":
        json["orientation"] = GraphClientConfig.write(value,
            typeName: "Orientation", isList: false);
        break;
      case "originalUrl":
        json["originalUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {};
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class ImageMediaUpdateInput with GraphInputMixin implements MBaseModel {
  ImageMediaUpdateInput(
      {String? fileName,
      String? checksum,
      Uri? mediaUrl,
      String? caption,
      PhysicalLocation? location,
      double? aspect,
      double? height,
      double? width,
      MediaType? mediaType,
      Orientation? orientation,
      Uri? originalUrl})
      : _data = {
          if (fileName != null) "fileName": fileName,
          if (checksum != null) "checksum": checksum,
          if (mediaUrl != null) "mediaUrl": mediaUrl,
          if (caption != null) "caption": caption,
          if (location != null) "location": location,
          if (aspect != null) "aspect": aspect,
          if (height != null) "height": height,
          if (width != null) "width": width,
          if (mediaType != null) "mediaType": mediaType,
          if (orientation != null) "orientation": orientation,
          if (originalUrl != null) "originalUrl": originalUrl,
        };

  ImageMediaUpdateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return ImageMedia.ref;
  }

  String get fileName {
    return this.get("fileName");
  }

  void set fileName(String fileName) {
    _data["fileName"] = fileName;
  }

  String? get checksum {
    return this.get("checksum");
  }

  void set checksum(String? checksum) {
    _data["checksum"] = checksum;
  }

  Uri get mediaUrl {
    return this.get("mediaUrl");
  }

  void set mediaUrl(Uri mediaUrl) {
    _data["mediaUrl"] = mediaUrl;
  }

  String? get caption {
    return this.get("caption");
  }

  void set caption(String? caption) {
    _data["caption"] = caption;
  }

  PhysicalLocation? get location {
    return this.get("location");
  }

  void set location(PhysicalLocation? location) {
    _data["location"] = location;
  }

  double? get aspect {
    return this.get("aspect");
  }

  void set aspect(double? aspect) {
    _data["aspect"] = aspect;
  }

  double? get height {
    return this.get("height");
  }

  void set height(double? height) {
    _data["height"] = height;
  }

  double? get width {
    return this.get("width");
  }

  void set width(double? width) {
    _data["width"] = width;
  }

  MediaType? get mediaType {
    return this.get("mediaType");
  }

  void set mediaType(MediaType? mediaType) {
    _data["mediaType"] = mediaType;
  }

  Orientation? get orientation {
    return this.get("orientation");
  }

  void set orientation(Orientation? orientation) {
    _data["orientation"] = orientation;
  }

  Uri? get originalUrl {
    return this.get("originalUrl");
  }

  void set originalUrl(Uri? originalUrl) {
    _data["originalUrl"] = originalUrl;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "fileName":
        json["fileName"] = value;
        break;
      case "checksum":
        json["checksum"] = value;
        break;
      case "mediaUrl":
        json["mediaUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "caption":
        json["caption"] = value;
        break;
      case "location":
        json["location"] = GraphClientConfig.write(value,
            typeName: "PhysicalLocation", isList: false);
        break;
      case "aspect":
        json["aspect"] = GraphClientConfig.doubleOf(value);
        break;
      case "height":
        json["height"] = GraphClientConfig.doubleOf(value);
        break;
      case "width":
        json["width"] = GraphClientConfig.doubleOf(value);
        break;
      case "mediaType":
        json["mediaType"] = GraphClientConfig.write(value,
            typeName: "MediaType", isList: false);
        break;
      case "orientation":
        json["orientation"] = GraphClientConfig.write(value,
            typeName: "Orientation", isList: false);
        break;
      case "originalUrl":
        json["originalUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {};
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class MemoryCreateInput with GraphInputMixin implements MBaseModel {
  MemoryCreateInput(
      {GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? contacts,
      GraphRefList<Tribe, TribeCreateInput, TribeUpdateInput>? tribes,
      String? displayName,
      String? memoryDetails,
      NullableGraphRef<PhysicalLocation, PhysicalLocationCreateInput,
              PhysicalLocationUpdateInput>?
          location,
      Uri? photoUrl,
      FlexiDate? memoryDate,
      GraphRefList<ImageMedia, ImageMediaCreateInput, ImageMediaUpdateInput>?
          imageMedia,
      GraphRefList<VideoMedia, VideoMediaCreateInput, VideoMediaUpdateInput>?
          videoMedia,
      DateTime? dateCreated,
      DateTime? dateModified})
      : _data = {
          if (contacts != null) "contacts": contacts,
          if (tribes != null) "tribes": tribes,
          if (displayName != null) "displayName": displayName,
          if (memoryDetails != null) "memoryDetails": memoryDetails,
          if (location != null) "location": location,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (memoryDate != null) "memoryDate": memoryDate,
          if (imageMedia != null) "imageMedia": imageMedia,
          if (videoMedia != null) "videoMedia": videoMedia,
          if (dateCreated != null) "dateCreated": dateCreated,
          if (dateModified != null) "dateModified": dateModified,
        };

  MemoryCreateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return Memory.ref;
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get contacts {
    return this.get("contacts");
  }

  void set contacts(
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? contacts) {
    _data["contacts"] = contacts;
  }

  GraphRefList<Tribe, TribeCreateInput, TribeUpdateInput>? get tribes {
    return this.get("tribes");
  }

  void set tribes(
      GraphRefList<Tribe, TribeCreateInput, TribeUpdateInput>? tribes) {
    _data["tribes"] = tribes;
  }

  String get displayName {
    return this.get("displayName");
  }

  void set displayName(String displayName) {
    _data["displayName"] = displayName;
  }

  String? get memoryDetails {
    return this.get("memoryDetails");
  }

  void set memoryDetails(String? memoryDetails) {
    _data["memoryDetails"] = memoryDetails;
  }

  NullableGraphRef<PhysicalLocation, PhysicalLocationCreateInput,
      PhysicalLocationUpdateInput>? get location {
    return this.get("location");
  }

  void set location(
      NullableGraphRef<PhysicalLocation, PhysicalLocationCreateInput,
              PhysicalLocationUpdateInput>?
          location) {
    _data["location"] = location;
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  void set photoUrl(Uri? photoUrl) {
    _data["photoUrl"] = photoUrl;
  }

  FlexiDate get memoryDate {
    return this.get("memoryDate");
  }

  void set memoryDate(FlexiDate memoryDate) {
    _data["memoryDate"] = memoryDate;
  }

  GraphRefList<ImageMedia, ImageMediaCreateInput, ImageMediaUpdateInput>?
      get imageMedia {
    return this.get("imageMedia");
  }

  void set imageMedia(
      GraphRefList<ImageMedia, ImageMediaCreateInput, ImageMediaUpdateInput>?
          imageMedia) {
    _data["imageMedia"] = imageMedia;
  }

  GraphRefList<VideoMedia, VideoMediaCreateInput, VideoMediaUpdateInput>?
      get videoMedia {
    return this.get("videoMedia");
  }

  void set videoMedia(
      GraphRefList<VideoMedia, VideoMediaCreateInput, VideoMediaUpdateInput>?
          videoMedia) {
    _data["videoMedia"] = videoMedia;
  }

  DateTime? get dateCreated {
    return this.get("dateCreated");
  }

  void set dateCreated(DateTime? dateCreated) {
    _data["dateCreated"] = dateCreated;
  }

  DateTime? get dateModified {
    return this.get("dateModified");
  }

  void set dateModified(DateTime? dateModified) {
    _data["dateModified"] = dateModified;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "displayName":
        json["displayName"] = value;
        break;
      case "memoryDetails":
        json["memoryDetails"] = value;
        break;
      case "photoUrl":
        json["photoUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "memoryDate":
        json["memoryDate"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
      case "dateCreated":
        json["dateCreated"] =
            GraphClientConfig.write(value, typeName: "DateTime", isList: false);
        break;
      case "dateModified":
        json["dateModified"] =
            GraphClientConfig.write(value, typeName: "DateTime", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("contacts", this.contacts?.relatedJson),
        relatedFieldJson("tribes", this.tribes?.relatedJson),
        relatedFieldJson("location", this.location?.relatedJson),
        relatedFieldJson("imageMedia", this.imageMedia?.relatedJson),
        relatedFieldJson("videoMedia", this.videoMedia?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class MemoryUpdateInput with GraphInputMixin implements MBaseModel {
  MemoryUpdateInput(
      {GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? contacts,
      GraphRefList<Tribe, TribeCreateInput, TribeUpdateInput>? tribes,
      String? displayName,
      String? memoryDetails,
      NullableGraphRef<PhysicalLocation, PhysicalLocationCreateInput,
              PhysicalLocationUpdateInput>?
          location,
      Uri? photoUrl,
      FlexiDate? memoryDate,
      GraphRefList<ImageMedia, ImageMediaCreateInput, ImageMediaUpdateInput>?
          imageMedia,
      GraphRefList<VideoMedia, VideoMediaCreateInput, VideoMediaUpdateInput>?
          videoMedia,
      DateTime? dateCreated,
      DateTime? dateModified})
      : _data = {
          if (contacts != null) "contacts": contacts,
          if (tribes != null) "tribes": tribes,
          if (displayName != null) "displayName": displayName,
          if (memoryDetails != null) "memoryDetails": memoryDetails,
          if (location != null) "location": location,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (memoryDate != null) "memoryDate": memoryDate,
          if (imageMedia != null) "imageMedia": imageMedia,
          if (videoMedia != null) "videoMedia": videoMedia,
          if (dateCreated != null) "dateCreated": dateCreated,
          if (dateModified != null) "dateModified": dateModified,
        };

  MemoryUpdateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return Memory.ref;
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get contacts {
    return this.get("contacts");
  }

  void set contacts(
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? contacts) {
    _data["contacts"] = contacts;
  }

  GraphRefList<Tribe, TribeCreateInput, TribeUpdateInput>? get tribes {
    return this.get("tribes");
  }

  void set tribes(
      GraphRefList<Tribe, TribeCreateInput, TribeUpdateInput>? tribes) {
    _data["tribes"] = tribes;
  }

  String get displayName {
    return this.get("displayName");
  }

  void set displayName(String displayName) {
    _data["displayName"] = displayName;
  }

  String? get memoryDetails {
    return this.get("memoryDetails");
  }

  void set memoryDetails(String? memoryDetails) {
    _data["memoryDetails"] = memoryDetails;
  }

  NullableGraphRef<PhysicalLocation, PhysicalLocationCreateInput,
      PhysicalLocationUpdateInput>? get location {
    return this.get("location");
  }

  void set location(
      NullableGraphRef<PhysicalLocation, PhysicalLocationCreateInput,
              PhysicalLocationUpdateInput>?
          location) {
    _data["location"] = location;
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  void set photoUrl(Uri? photoUrl) {
    _data["photoUrl"] = photoUrl;
  }

  FlexiDate get memoryDate {
    return this.get("memoryDate");
  }

  void set memoryDate(FlexiDate memoryDate) {
    _data["memoryDate"] = memoryDate;
  }

  GraphRefList<ImageMedia, ImageMediaCreateInput, ImageMediaUpdateInput>?
      get imageMedia {
    return this.get("imageMedia");
  }

  void set imageMedia(
      GraphRefList<ImageMedia, ImageMediaCreateInput, ImageMediaUpdateInput>?
          imageMedia) {
    _data["imageMedia"] = imageMedia;
  }

  GraphRefList<VideoMedia, VideoMediaCreateInput, VideoMediaUpdateInput>?
      get videoMedia {
    return this.get("videoMedia");
  }

  void set videoMedia(
      GraphRefList<VideoMedia, VideoMediaCreateInput, VideoMediaUpdateInput>?
          videoMedia) {
    _data["videoMedia"] = videoMedia;
  }

  DateTime? get dateCreated {
    return this.get("dateCreated");
  }

  void set dateCreated(DateTime? dateCreated) {
    _data["dateCreated"] = dateCreated;
  }

  DateTime? get dateModified {
    return this.get("dateModified");
  }

  void set dateModified(DateTime? dateModified) {
    _data["dateModified"] = dateModified;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "displayName":
        json["displayName"] = value;
        break;
      case "memoryDetails":
        json["memoryDetails"] = value;
        break;
      case "photoUrl":
        json["photoUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "memoryDate":
        json["memoryDate"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
      case "dateCreated":
        json["dateCreated"] =
            GraphClientConfig.write(value, typeName: "DateTime", isList: false);
        break;
      case "dateModified":
        json["dateModified"] =
            GraphClientConfig.write(value, typeName: "DateTime", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("contacts", this.contacts?.relatedJson),
        relatedFieldJson("tribes", this.tribes?.relatedJson),
        relatedFieldJson("location", this.location?.relatedJson),
        relatedFieldJson("imageMedia", this.imageMedia?.relatedJson),
        relatedFieldJson("videoMedia", this.videoMedia?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class PhaseCreateInput with GraphInputMixin implements MBaseModel {
  PhaseCreateInput(
      {NullableGraphRef<HasPhases, HasPhasesCreateInput, HasPhasesUpdateInput>?
          phased,
      String? displayName,
      Uri? photoUrl,
      FlexiDate? startDate,
      FlexiDate? endDate,
      String? description,
      DateTime? dateCreated,
      DateTime? dateModified})
      : _data = {
          if (phased != null) "phased": phased,
          if (displayName != null) "displayName": displayName,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (startDate != null) "startDate": startDate,
          if (endDate != null) "endDate": endDate,
          if (description != null) "description": description,
          if (dateCreated != null) "dateCreated": dateCreated,
          if (dateModified != null) "dateModified": dateModified,
        };

  PhaseCreateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return Phase.ref;
  }

  NullableGraphRef<HasPhases, HasPhasesCreateInput, HasPhasesUpdateInput>?
      get phased {
    return this.get("phased");
  }

  void set phased(
      NullableGraphRef<HasPhases, HasPhasesCreateInput, HasPhasesUpdateInput>?
          phased) {
    _data["phased"] = phased;
  }

  String get displayName {
    return this.get("displayName");
  }

  void set displayName(String displayName) {
    _data["displayName"] = displayName;
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  void set photoUrl(Uri? photoUrl) {
    _data["photoUrl"] = photoUrl;
  }

  FlexiDate? get startDate {
    return this.get("startDate");
  }

  void set startDate(FlexiDate? startDate) {
    _data["startDate"] = startDate;
  }

  FlexiDate? get endDate {
    return this.get("endDate");
  }

  void set endDate(FlexiDate? endDate) {
    _data["endDate"] = endDate;
  }

  String? get description {
    return this.get("description");
  }

  void set description(String? description) {
    _data["description"] = description;
  }

  DateTime? get dateCreated {
    return this.get("dateCreated");
  }

  void set dateCreated(DateTime? dateCreated) {
    _data["dateCreated"] = dateCreated;
  }

  DateTime? get dateModified {
    return this.get("dateModified");
  }

  void set dateModified(DateTime? dateModified) {
    _data["dateModified"] = dateModified;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "displayName":
        json["displayName"] = value;
        break;
      case "photoUrl":
        json["photoUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "startDate":
        json["startDate"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
      case "endDate":
        json["endDate"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
      case "description":
        json["description"] = value;
        break;
      case "dateCreated":
        json["dateCreated"] =
            GraphClientConfig.write(value, typeName: "DateTime", isList: false);
        break;
      case "dateModified":
        json["dateModified"] =
            GraphClientConfig.write(value, typeName: "DateTime", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("phased", this.phased?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class PhaseUpdateInput with GraphInputMixin implements MBaseModel {
  PhaseUpdateInput(
      {NullableGraphRef<HasPhases, HasPhasesCreateInput, HasPhasesUpdateInput>?
          phased,
      String? displayName,
      Uri? photoUrl,
      FlexiDate? startDate,
      FlexiDate? endDate,
      String? description,
      DateTime? dateCreated,
      DateTime? dateModified})
      : _data = {
          if (phased != null) "phased": phased,
          if (displayName != null) "displayName": displayName,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (startDate != null) "startDate": startDate,
          if (endDate != null) "endDate": endDate,
          if (description != null) "description": description,
          if (dateCreated != null) "dateCreated": dateCreated,
          if (dateModified != null) "dateModified": dateModified,
        };

  PhaseUpdateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return Phase.ref;
  }

  NullableGraphRef<HasPhases, HasPhasesCreateInput, HasPhasesUpdateInput>?
      get phased {
    return this.get("phased");
  }

  void set phased(
      NullableGraphRef<HasPhases, HasPhasesCreateInput, HasPhasesUpdateInput>?
          phased) {
    _data["phased"] = phased;
  }

  String get displayName {
    return this.get("displayName");
  }

  void set displayName(String displayName) {
    _data["displayName"] = displayName;
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  void set photoUrl(Uri? photoUrl) {
    _data["photoUrl"] = photoUrl;
  }

  FlexiDate? get startDate {
    return this.get("startDate");
  }

  void set startDate(FlexiDate? startDate) {
    _data["startDate"] = startDate;
  }

  FlexiDate? get endDate {
    return this.get("endDate");
  }

  void set endDate(FlexiDate? endDate) {
    _data["endDate"] = endDate;
  }

  String? get description {
    return this.get("description");
  }

  void set description(String? description) {
    _data["description"] = description;
  }

  DateTime? get dateCreated {
    return this.get("dateCreated");
  }

  void set dateCreated(DateTime? dateCreated) {
    _data["dateCreated"] = dateCreated;
  }

  DateTime? get dateModified {
    return this.get("dateModified");
  }

  void set dateModified(DateTime? dateModified) {
    _data["dateModified"] = dateModified;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "displayName":
        json["displayName"] = value;
        break;
      case "photoUrl":
        json["photoUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "startDate":
        json["startDate"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
      case "endDate":
        json["endDate"] = GraphClientConfig.write(value,
            typeName: "FlexiDate", isList: false);
        break;
      case "description":
        json["description"] = value;
        break;
      case "dateCreated":
        json["dateCreated"] =
            GraphClientConfig.write(value, typeName: "DateTime", isList: false);
        break;
      case "dateModified":
        json["dateModified"] =
            GraphClientConfig.write(value, typeName: "DateTime", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("phased", this.phased?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class PhysicalLocationCreateInput with GraphInputMixin implements MBaseModel {
  PhysicalLocationCreateInput(
      {String? id,
      double? lat,
      double? lon,
      String? displayName,
      Uri? photoUrl})
      : _data = {
          if (id != null) "id": id,
          if (lat != null) "lat": lat,
          if (lon != null) "lon": lon,
          if (displayName != null) "displayName": displayName,
          if (photoUrl != null) "photoUrl": photoUrl,
        };

  PhysicalLocationCreateInput.fromJson(json)
      : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return PhysicalLocation.ref;
  }

  String get id {
    return this.get("id");
  }

  void set id(String id) {
    _data["id"] = id;
  }

  double? get lat {
    return this.get("lat");
  }

  void set lat(double? lat) {
    _data["lat"] = lat;
  }

  double? get lon {
    return this.get("lon");
  }

  void set lon(double? lon) {
    _data["lon"] = lon;
  }

  String get displayName {
    return this.get("displayName");
  }

  void set displayName(String displayName) {
    _data["displayName"] = displayName;
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  void set photoUrl(Uri? photoUrl) {
    _data["photoUrl"] = photoUrl;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "id":
        json["id"] = value;
        break;
      case "lat":
        json["lat"] = GraphClientConfig.doubleOf(value);
        break;
      case "lon":
        json["lon"] = GraphClientConfig.doubleOf(value);
        break;
      case "displayName":
        json["displayName"] = value;
        break;
      case "photoUrl":
        json["photoUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {};
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class PhysicalLocationUpdateInput with GraphInputMixin implements MBaseModel {
  PhysicalLocationUpdateInput(
      {String? id,
      double? lat,
      double? lon,
      String? displayName,
      Uri? photoUrl})
      : _data = {
          if (id != null) "id": id,
          if (lat != null) "lat": lat,
          if (lon != null) "lon": lon,
          if (displayName != null) "displayName": displayName,
          if (photoUrl != null) "photoUrl": photoUrl,
        };

  PhysicalLocationUpdateInput.fromJson(json)
      : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return PhysicalLocation.ref;
  }

  String get id {
    return this.get("id");
  }

  void set id(String id) {
    _data["id"] = id;
  }

  double? get lat {
    return this.get("lat");
  }

  void set lat(double? lat) {
    _data["lat"] = lat;
  }

  double? get lon {
    return this.get("lon");
  }

  void set lon(double? lon) {
    _data["lon"] = lon;
  }

  String get displayName {
    return this.get("displayName");
  }

  void set displayName(String displayName) {
    _data["displayName"] = displayName;
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  void set photoUrl(Uri? photoUrl) {
    _data["photoUrl"] = photoUrl;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "id":
        json["id"] = value;
        break;
      case "lat":
        json["lat"] = GraphClientConfig.doubleOf(value);
        break;
      case "lon":
        json["lon"] = GraphClientConfig.doubleOf(value);
        break;
      case "displayName":
        json["displayName"] = value;
        break;
      case "photoUrl":
        json["photoUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {};
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class TribeCreateInput with GraphInputMixin implements MBaseModel {
  TribeCreateInput(
      {String? id,
      String? displayName,
      Uri? photoUrl,
      String? slug,
      String? tribeType,
      ExtGraphRefList<Contact, TribeMember, ContactCreateInput,
              ContactUpdateInput>?
          members,
      GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? phases,
      GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? memories})
      : _data = {
          if (id != null) "id": id,
          if (displayName != null) "displayName": displayName,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (slug != null) "slug": slug,
          if (tribeType != null) "tribeType": tribeType,
          if (members != null) "members": members,
          if (phases != null) "phases": phases,
          if (memories != null) "memories": memories,
        };

  TribeCreateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return Tribe.ref;
  }

  String get id {
    return this.get("id");
  }

  void set id(String id) {
    _data["id"] = id;
  }

  String get displayName {
    return this.get("displayName");
  }

  void set displayName(String displayName) {
    _data["displayName"] = displayName;
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  void set photoUrl(Uri? photoUrl) {
    _data["photoUrl"] = photoUrl;
  }

  String get slug {
    return this.get("slug");
  }

  void set slug(String slug) {
    _data["slug"] = slug;
  }

  String get tribeType {
    return this.get("tribeType");
  }

  void set tribeType(String tribeType) {
    _data["tribeType"] = tribeType;
  }

  ExtGraphRefList<Contact, TribeMember, ContactCreateInput, ContactUpdateInput>?
      get members {
    return this.get("members");
  }

  void set members(
      ExtGraphRefList<Contact, TribeMember, ContactCreateInput,
              ContactUpdateInput>?
          members) {
    _data["members"] = members;
  }

  GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? get phases {
    return this.get("phases");
  }

  void set phases(
      GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? phases) {
    _data["phases"] = phases;
  }

  GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? get memories {
    return this.get("memories");
  }

  void set memories(
      GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? memories) {
    _data["memories"] = memories;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "id":
        json["id"] = value;
        break;
      case "displayName":
        json["displayName"] = value;
        break;
      case "photoUrl":
        json["photoUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "slug":
        json["slug"] = value;
        break;
      case "tribeType":
        json["tribeType"] = value;
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("members", this.members?.relatedJson),
        relatedFieldJson("phases", this.phases?.relatedJson),
        relatedFieldJson("memories", this.memories?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class TribeUpdateInput with GraphInputMixin implements MBaseModel {
  TribeUpdateInput(
      {String? displayName,
      Uri? photoUrl,
      String? slug,
      String? tribeType,
      ExtGraphRefList<Contact, TribeMember, ContactCreateInput,
              ContactUpdateInput>?
          members,
      GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? phases,
      GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? memories})
      : _data = {
          if (displayName != null) "displayName": displayName,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (slug != null) "slug": slug,
          if (tribeType != null) "tribeType": tribeType,
          if (members != null) "members": members,
          if (phases != null) "phases": phases,
          if (memories != null) "memories": memories,
        };

  TribeUpdateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return Tribe.ref;
  }

  String get displayName {
    return this.get("displayName");
  }

  void set displayName(String displayName) {
    _data["displayName"] = displayName;
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  void set photoUrl(Uri? photoUrl) {
    _data["photoUrl"] = photoUrl;
  }

  String get slug {
    return this.get("slug");
  }

  void set slug(String slug) {
    _data["slug"] = slug;
  }

  String get tribeType {
    return this.get("tribeType");
  }

  void set tribeType(String tribeType) {
    _data["tribeType"] = tribeType;
  }

  ExtGraphRefList<Contact, TribeMember, ContactCreateInput, ContactUpdateInput>?
      get members {
    return this.get("members");
  }

  void set members(
      ExtGraphRefList<Contact, TribeMember, ContactCreateInput,
              ContactUpdateInput>?
          members) {
    _data["members"] = members;
  }

  GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? get phases {
    return this.get("phases");
  }

  void set phases(
      GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? phases) {
    _data["phases"] = phases;
  }

  GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? get memories {
    return this.get("memories");
  }

  void set memories(
      GraphRefList<Memory, MemoryCreateInput, MemoryUpdateInput>? memories) {
    _data["memories"] = memories;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "displayName":
        json["displayName"] = value;
        break;
      case "photoUrl":
        json["photoUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "slug":
        json["slug"] = value;
        break;
      case "tribeType":
        json["tribeType"] = value;
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("members", this.members?.relatedJson),
        relatedFieldJson("phases", this.phases?.relatedJson),
        relatedFieldJson("memories", this.memories?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class UserContactCreateInput with GraphInputMixin implements MBaseModel {
  UserContactCreateInput(
      {String? id,
      GraphRef<Contact, ContactCreateInput, ContactUpdateInput>? contact,
      String? username,
      String? firebaseUid,
      String? email,
      String? phone})
      : _data = {
          if (id != null) "id": id,
          if (contact != null) "contact": contact,
          if (username != null) "username": username,
          if (firebaseUid != null) "firebaseUid": firebaseUid,
          if (email != null) "email": email,
          if (phone != null) "phone": phone,
        };

  UserContactCreateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return UserContact.ref;
  }

  String get id {
    return this.get("id");
  }

  void set id(String id) {
    _data["id"] = id;
  }

  GraphRef<Contact, ContactCreateInput, ContactUpdateInput>? get contact {
    return this.get("contact");
  }

  void set contact(
      GraphRef<Contact, ContactCreateInput, ContactUpdateInput>? contact) {
    _data["contact"] = contact;
  }

  String? get username {
    return this.get("username");
  }

  void set username(String? username) {
    _data["username"] = username;
  }

  String? get firebaseUid {
    return this.get("firebaseUid");
  }

  void set firebaseUid(String? firebaseUid) {
    _data["firebaseUid"] = firebaseUid;
  }

  String? get email {
    return this.get("email");
  }

  void set email(String? email) {
    _data["email"] = email;
  }

  String? get phone {
    return this.get("phone");
  }

  void set phone(String? phone) {
    _data["phone"] = phone;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "id":
        json["id"] = value;
        break;
      case "username":
        json["username"] = value;
        break;
      case "firebaseUid":
        json["firebaseUid"] = value;
        break;
      case "email":
        json["email"] = value;
        break;
      case "phone":
        json["phone"] = value;
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("contact", this.contact?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class UserContactUpdateInput with GraphInputMixin implements MBaseModel {
  UserContactUpdateInput(
      {GraphRef<Contact, ContactCreateInput, ContactUpdateInput>? contact,
      String? username,
      String? firebaseUid,
      String? email,
      String? phone})
      : _data = {
          if (contact != null) "contact": contact,
          if (username != null) "username": username,
          if (firebaseUid != null) "firebaseUid": firebaseUid,
          if (email != null) "email": email,
          if (phone != null) "phone": phone,
        };

  UserContactUpdateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return UserContact.ref;
  }

  GraphRef<Contact, ContactCreateInput, ContactUpdateInput>? get contact {
    return this.get("contact");
  }

  void set contact(
      GraphRef<Contact, ContactCreateInput, ContactUpdateInput>? contact) {
    _data["contact"] = contact;
  }

  String? get username {
    return this.get("username");
  }

  void set username(String? username) {
    _data["username"] = username;
  }

  String? get firebaseUid {
    return this.get("firebaseUid");
  }

  void set firebaseUid(String? firebaseUid) {
    _data["firebaseUid"] = firebaseUid;
  }

  String? get email {
    return this.get("email");
  }

  void set email(String? email) {
    _data["email"] = email;
  }

  String? get phone {
    return this.get("phone");
  }

  void set phone(String? phone) {
    _data["phone"] = phone;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "username":
        json["username"] = value;
        break;
      case "firebaseUid":
        json["firebaseUid"] = value;
        break;
      case "email":
        json["email"] = value;
        break;
      case "phone":
        json["phone"] = value;
        break;
    }
  }

  dynamic _relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("contact", this.contact?.relatedJson),
      ]),
    };
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class VideoMediaCreateInput with GraphInputMixin implements MBaseModel {
  VideoMediaCreateInput(
      {String? fileName,
      String? checksum,
      Uri? mediaUrl,
      String? caption,
      PhysicalLocation? location,
      double? aspect,
      double? height,
      double? width,
      MediaType? mediaType,
      Orientation? orientation,
      Uri? originalUrl,
      int? durationMs,
      int? startFrom,
      ImageMedia? thumbnailUrl})
      : _data = {
          if (fileName != null) "fileName": fileName,
          if (checksum != null) "checksum": checksum,
          if (mediaUrl != null) "mediaUrl": mediaUrl,
          if (caption != null) "caption": caption,
          if (location != null) "location": location,
          if (aspect != null) "aspect": aspect,
          if (height != null) "height": height,
          if (width != null) "width": width,
          if (mediaType != null) "mediaType": mediaType,
          if (orientation != null) "orientation": orientation,
          if (originalUrl != null) "originalUrl": originalUrl,
          if (durationMs != null) "durationMs": durationMs,
          if (startFrom != null) "startFrom": startFrom,
          if (thumbnailUrl != null) "thumbnailUrl": thumbnailUrl,
        };

  VideoMediaCreateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return VideoMedia.ref;
  }

  String get fileName {
    return this.get("fileName");
  }

  void set fileName(String fileName) {
    _data["fileName"] = fileName;
  }

  String? get checksum {
    return this.get("checksum");
  }

  void set checksum(String? checksum) {
    _data["checksum"] = checksum;
  }

  Uri get mediaUrl {
    return this.get("mediaUrl");
  }

  void set mediaUrl(Uri mediaUrl) {
    _data["mediaUrl"] = mediaUrl;
  }

  String? get caption {
    return this.get("caption");
  }

  void set caption(String? caption) {
    _data["caption"] = caption;
  }

  PhysicalLocation? get location {
    return this.get("location");
  }

  void set location(PhysicalLocation? location) {
    _data["location"] = location;
  }

  double? get aspect {
    return this.get("aspect");
  }

  void set aspect(double? aspect) {
    _data["aspect"] = aspect;
  }

  double? get height {
    return this.get("height");
  }

  void set height(double? height) {
    _data["height"] = height;
  }

  double? get width {
    return this.get("width");
  }

  void set width(double? width) {
    _data["width"] = width;
  }

  MediaType? get mediaType {
    return this.get("mediaType");
  }

  void set mediaType(MediaType? mediaType) {
    _data["mediaType"] = mediaType;
  }

  Orientation? get orientation {
    return this.get("orientation");
  }

  void set orientation(Orientation? orientation) {
    _data["orientation"] = orientation;
  }

  Uri? get originalUrl {
    return this.get("originalUrl");
  }

  void set originalUrl(Uri? originalUrl) {
    _data["originalUrl"] = originalUrl;
  }

  int? get durationMs {
    return this.get("durationMs");
  }

  void set durationMs(int? durationMs) {
    _data["durationMs"] = durationMs;
  }

  int? get startFrom {
    return this.get("startFrom");
  }

  void set startFrom(int? startFrom) {
    _data["startFrom"] = startFrom;
  }

  ImageMedia? get thumbnailUrl {
    return this.get("thumbnailUrl");
  }

  void set thumbnailUrl(ImageMedia? thumbnailUrl) {
    _data["thumbnailUrl"] = thumbnailUrl;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "fileName":
        json["fileName"] = value;
        break;
      case "checksum":
        json["checksum"] = value;
        break;
      case "mediaUrl":
        json["mediaUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "caption":
        json["caption"] = value;
        break;
      case "location":
        json["location"] = GraphClientConfig.write(value,
            typeName: "PhysicalLocation", isList: false);
        break;
      case "aspect":
        json["aspect"] = GraphClientConfig.doubleOf(value);
        break;
      case "height":
        json["height"] = GraphClientConfig.doubleOf(value);
        break;
      case "width":
        json["width"] = GraphClientConfig.doubleOf(value);
        break;
      case "mediaType":
        json["mediaType"] = GraphClientConfig.write(value,
            typeName: "MediaType", isList: false);
        break;
      case "orientation":
        json["orientation"] = GraphClientConfig.write(value,
            typeName: "Orientation", isList: false);
        break;
      case "originalUrl":
        json["originalUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "durationMs":
        json["durationMs"] = GraphClientConfig.intOf(value);
        break;
      case "startFrom":
        json["startFrom"] = GraphClientConfig.intOf(value);
        break;
      case "thumbnailUrl":
        json["thumbnailUrl"] = GraphClientConfig.write(value,
            typeName: "ImageMedia", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {};
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class VideoMediaUpdateInput with GraphInputMixin implements MBaseModel {
  VideoMediaUpdateInput(
      {String? fileName,
      String? checksum,
      Uri? mediaUrl,
      String? caption,
      PhysicalLocation? location,
      double? aspect,
      double? height,
      double? width,
      MediaType? mediaType,
      Orientation? orientation,
      Uri? originalUrl,
      int? durationMs,
      int? startFrom,
      ImageMedia? thumbnailUrl})
      : _data = {
          if (fileName != null) "fileName": fileName,
          if (checksum != null) "checksum": checksum,
          if (mediaUrl != null) "mediaUrl": mediaUrl,
          if (caption != null) "caption": caption,
          if (location != null) "location": location,
          if (aspect != null) "aspect": aspect,
          if (height != null) "height": height,
          if (width != null) "width": width,
          if (mediaType != null) "mediaType": mediaType,
          if (orientation != null) "orientation": orientation,
          if (originalUrl != null) "originalUrl": originalUrl,
          if (durationMs != null) "durationMs": durationMs,
          if (startFrom != null) "startFrom": startFrom,
          if (thumbnailUrl != null) "thumbnailUrl": thumbnailUrl,
        };

  VideoMediaUpdateInput.fromJson(json) : _data = json as Map<String, dynamic>;

  final Map<String, dynamic> _data;

  MSchemaRef get mtype {
    return VideoMedia.ref;
  }

  String get fileName {
    return this.get("fileName");
  }

  void set fileName(String fileName) {
    _data["fileName"] = fileName;
  }

  String? get checksum {
    return this.get("checksum");
  }

  void set checksum(String? checksum) {
    _data["checksum"] = checksum;
  }

  Uri get mediaUrl {
    return this.get("mediaUrl");
  }

  void set mediaUrl(Uri mediaUrl) {
    _data["mediaUrl"] = mediaUrl;
  }

  String? get caption {
    return this.get("caption");
  }

  void set caption(String? caption) {
    _data["caption"] = caption;
  }

  PhysicalLocation? get location {
    return this.get("location");
  }

  void set location(PhysicalLocation? location) {
    _data["location"] = location;
  }

  double? get aspect {
    return this.get("aspect");
  }

  void set aspect(double? aspect) {
    _data["aspect"] = aspect;
  }

  double? get height {
    return this.get("height");
  }

  void set height(double? height) {
    _data["height"] = height;
  }

  double? get width {
    return this.get("width");
  }

  void set width(double? width) {
    _data["width"] = width;
  }

  MediaType? get mediaType {
    return this.get("mediaType");
  }

  void set mediaType(MediaType? mediaType) {
    _data["mediaType"] = mediaType;
  }

  Orientation? get orientation {
    return this.get("orientation");
  }

  void set orientation(Orientation? orientation) {
    _data["orientation"] = orientation;
  }

  Uri? get originalUrl {
    return this.get("originalUrl");
  }

  void set originalUrl(Uri? originalUrl) {
    _data["originalUrl"] = originalUrl;
  }

  int? get durationMs {
    return this.get("durationMs");
  }

  void set durationMs(int? durationMs) {
    _data["durationMs"] = durationMs;
  }

  int? get startFrom {
    return this.get("startFrom");
  }

  void set startFrom(int? startFrom) {
    _data["startFrom"] = startFrom;
  }

  ImageMedia? get thumbnailUrl {
    return this.get("thumbnailUrl");
  }

  void set thumbnailUrl(ImageMedia? thumbnailUrl) {
    _data["thumbnailUrl"] = thumbnailUrl;
  }

  @override
  void operator []=(String key, value) {
    if (this._data[key] != value) {
      this._data[key] = value;
    }
  }

  @override
  dynamic operator [](key) {
    return this._data[key];
  }

  JsonObject toMap() {
    return this._data;
  }

  _fieldJson(Map<String, dynamic> json, String key, value) {
    switch (key) {
      case "fileName":
        json["fileName"] = value;
        break;
      case "checksum":
        json["checksum"] = value;
        break;
      case "mediaUrl":
        json["mediaUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "caption":
        json["caption"] = value;
        break;
      case "location":
        json["location"] = GraphClientConfig.write(value,
            typeName: "PhysicalLocation", isList: false);
        break;
      case "aspect":
        json["aspect"] = GraphClientConfig.doubleOf(value);
        break;
      case "height":
        json["height"] = GraphClientConfig.doubleOf(value);
        break;
      case "width":
        json["width"] = GraphClientConfig.doubleOf(value);
        break;
      case "mediaType":
        json["mediaType"] = GraphClientConfig.write(value,
            typeName: "MediaType", isList: false);
        break;
      case "orientation":
        json["orientation"] = GraphClientConfig.write(value,
            typeName: "Orientation", isList: false);
        break;
      case "originalUrl":
        json["originalUrl"] =
            GraphClientConfig.write(value, typeName: "Uri", isList: false);
        break;
      case "durationMs":
        json["durationMs"] = GraphClientConfig.intOf(value);
        break;
      case "startFrom":
        json["startFrom"] = GraphClientConfig.intOf(value);
        break;
      case "thumbnailUrl":
        json["thumbnailUrl"] = GraphClientConfig.write(value,
            typeName: "ImageMedia", isList: false);
        break;
    }
  }

  dynamic _relatedJson() {
    return {};
  }

  JsonObject? toJson() {
    var _json = <String, dynamic>{
      ...?_relatedJson(),
    };
    for (var entry in this._data.entries) {
      _fieldJson(_json, entry.key, entry.value);
    }

    return _json;
  }
}

class FamilyMemberType extends GraphEnum<String> {
  static const PARENT = FamilyMemberType("PARENT");
  static const CHILD = FamilyMemberType("CHILD");
  static const values = [PARENT, CHILD];
  const FamilyMemberType(String value) : super(value);
  factory FamilyMemberType.fromJson(json) {
    switch (json!.toString().toLowerCase()) {
      case "parent":
        return FamilyMemberType.PARENT;
      case "child":
        return FamilyMemberType.CHILD;
      default:
        throw "Enum not recognized ${json}";
    }
  }
}

class MediaType extends GraphEnum<String> {
  static const VIDEO = MediaType("VIDEO");
  static const IMAGE = MediaType("IMAGE");
  static const values = [VIDEO, IMAGE];
  const MediaType(String value) : super(value);
  factory MediaType.fromJson(json) {
    switch (json!.toString().toLowerCase()) {
      case "video":
        return MediaType.VIDEO;
      case "image":
        return MediaType.IMAGE;
      default:
        throw "Enum not recognized ${json}";
    }
  }
}

class Orientation extends GraphEnum<String> {
  static const PORTRAIT = Orientation("PORTRAIT");
  static const LANDSCAPE = Orientation("LANDSCAPE");
  static const values = [PORTRAIT, LANDSCAPE];
  const Orientation(String value) : super(value);
  factory Orientation.fromJson(json) {
    switch (json!.toString().toLowerCase()) {
      case "portrait":
        return Orientation.PORTRAIT;
      case "landscape":
        return Orientation.LANDSCAPE;
      default:
        throw "Enum not recognized ${json}";
    }
  }
}

class RelatableType extends GraphEnum<String> {
  static const CONTACT = RelatableType("CONTACT");
  static const ORG = RelatableType("ORG");
  static const values = [CONTACT, ORG];
  const RelatableType(String value) : super(value);
  factory RelatableType.fromJson(json) {
    switch (json!.toString().toLowerCase()) {
      case "contact":
        return RelatableType.CONTACT;
      case "org":
        return RelatableType.ORG;
      default:
        throw "Enum not recognized ${json}";
    }
  }
}

final ContactFragment = gql(""" fragment ContactFragment on Contact {
  id
  displayName
  photoUrl
  nickName
  birthday
  dateCreated
  dateModified

}""");

final FamilyTribeFragment =
    gql(""" fragment FamilyTribeFragment on FamilyTribe {
  id
  startDate
  endDate
  children {
    ...ContactFragment
  }
  parents {
    ...ContactFragment
  }
  tribe {
    ...TribeFragment
  }

}""");

final TribeFragment = gql(""" fragment TribeFragment on Tribe {
  id
  displayName
  photoUrl
  dateCreated
  dateModified
  slug
  tribeType
  phases {
    ...PhaseFragment
  }
  members {
    ...ContactFragment
  }

}""");

final PhaseFragment = gql(""" fragment PhaseFragment on Phase {
  id
  displayName
  photoUrl
  startDate
  endDate
  dateCreated
  dateModified
  description

}""");

final FriendGroupTribeFragment =
    gql(""" fragment FriendGroupTribeFragment on FriendGroupTribe {
  id
  tribe {
    ...TribeFragment
  }
  friends {
    ...ContactFragment
  }

}""");

final ImageMediaFragment = gql(""" fragment ImageMediaFragment on ImageMedia {
  id
  aspect
  caption
  checksum
  fileName
  height
  location {
    ...PhysicalLocationFragment
  }
  mediaType
  mediaUrl
  orientation
  originalUrl
  width

}""");

final PhysicalLocationFragment =
    gql(""" fragment PhysicalLocationFragment on PhysicalLocation {
  id
  displayName
  photoUrl
  lat
  lon

}""");

final MemoryFragment = gql(""" fragment MemoryFragment on Memory {
  id
  displayName
  photoUrl
  memoryDate
  memoryDetails
  contacts {
    ...ContactFragment
  }
  tribes {
    ...TribeFragment
  }
  imageMedia {
    ...ImageMediaFragment
  }
  videoMedia {
    ...VideoMediaFragment
  }
  location {
    ...PhysicalLocationFragment
  }
  dateModified
  dateModified

}""");

final VideoMediaFragment = gql(""" fragment VideoMediaFragment on VideoMedia {
  id
  aspect
  caption
  checksum
  fileName
  height
  location {
    ...PhysicalLocationFragment
  }
  mediaType
  mediaUrl
  orientation
  originalUrl
  width
  durationMs
  startFrom

}""");

final UserContactFragment =
    gql(""" fragment UserContactFragment on UserContact {
  id
  contact {
    ...ContactFragment
  }
  email
  firebaseUid
  phone
  username

}""");

final ContactCreateOp = gql(r"""
    mutation createContact($input: ContactCreateInput!) {
      createContacts(input: [$input]) {
        contacts {
          ...ContactFragment,
        }
      }
    }
  """);

final ContactUpdateOp = gql(r"""
    mutation updateContact($id: ID!, 
                                  $update: ContactUpdateInput!
                                  $create: ContactRelationInput,
                                  $connect: ContactConnectInput,
                                  $disconnect: ContactDisconnectInput,
                                  $delete: ContactDeleteInput,
                                  ) {
      updateContacts(where: {id: $id}, update: $update, create: $create, 
                            connect: $connect, disconnect: $disconnect, delete: $delete) {
        contacts {
          ...ContactFragment,
        }
      }
    }
  """);

final ContactDeleteOp = gql(r"""
    mutation deleteContact($id: ID!) {
      deleteContacts(where: {id: $id}) {
        nodesDeleted
      }
    }
  """);

final ContactListOp = gql(r"""
    query listContact($where: ContactWhere!) {
      contacts(where: $where) {
        ...ContactFragment
      }
    }
  """);

final ContactLoadOp = gql(r"""
    query loadContact($id: ID!) {
      contacts(where: {id: $id}) {
        ...ContactFragment
      }
    }
  """);

final ContactCountOp = gql(r"""
    query countContacts {
      contactsCount
    }
  """);

class ContactApi
    extends GraphApi<Contact, ContactCreateInput, ContactUpdateInput>
    implements HasPhasesApi, HasMemoriesApi {
  ContactApi(this._client, this.resolver, this.serializer);

  @override
  final GraphSerializer serializer;

  @override
  final GraphQueryResolver resolver;

  final GraphQLClientGetter _client;

  MSchemaRef get mtype {
    return Contact.ref;
  }

  @override
  GraphQLClient client() {
    return this._client();
  }

  Future<List<Tribe>> loadTribesForRecord(String id) {
    return this.loadRelatedList(
      id: id,
      relatedType: "TribeMembership",
      isNullable: false,
      field: "tribes",
      fragments: DocumentNodes(
        [],
      ),
    );
  }

  Future<List<Phase>?> loadPhasesForRecord(String id) {
    return this.loadRelatedList(
      id: id,
      relatedType: "Phase",
      isNullable: true,
      field: "phases",
      fragments: DocumentNodes(
        [PhaseFragment],
      ),
    );
  }

  Future<FamilyTribe?> loadChildFamilyForRecord(String id) {
    return this.loadRelated(
      id: id,
      relatedType: "FamilyTribe",
      isNullable: true,
      field: "childFamily",
      fragments: DocumentNodes(
        [FamilyTribeFragment, ContactFragment, TribeFragment, PhaseFragment],
      ),
    );
  }

  Future<FamilyTribe?> loadParentFamilyForRecord(String id) {
    return this.loadRelated(
      id: id,
      relatedType: "FamilyTribe",
      isNullable: true,
      field: "parentFamily",
      fragments: DocumentNodes(
        [FamilyTribeFragment, ContactFragment, TribeFragment, PhaseFragment],
      ),
    );
  }

  Future<List<FriendGroupTribe>?> loadFriendGroupsForRecord(String id) {
    return this.loadRelatedList(
      id: id,
      relatedType: "FriendGroupTribe",
      isNullable: true,
      field: "friendGroups",
      fragments: DocumentNodes(
        [
          FriendGroupTribeFragment,
          TribeFragment,
          PhaseFragment,
          ContactFragment
        ],
      ),
    );
  }

  Future<List<Memory>?> loadMemoriesForRecord(String id) {
    return this.loadRelatedList(
      id: id,
      relatedType: "Memory",
      isNullable: true,
      field: "memories",
      fragments: DocumentNodes(
        [
          MemoryFragment,
          ContactFragment,
          TribeFragment,
          PhaseFragment,
          ImageMediaFragment,
          PhysicalLocationFragment,
          VideoMediaFragment
        ],
      ),
    );
  }
}

final FamilyTribeCreateOp = gql(r"""
    mutation createFamilyTribe($input: FamilyTribeCreateInput!) {
      createFamilyTribes(input: [$input]) {
        familyTribes {
          ...FamilyTribeFragment,
        }
      }
    }
  """);

final FamilyTribeUpdateOp = gql(r"""
    mutation updateFamilyTribe($id: ID!, 
                                  $update: FamilyTribeUpdateInput!
                                  $create: FamilyTribeRelationInput,
                                  $connect: FamilyTribeConnectInput,
                                  $disconnect: FamilyTribeDisconnectInput,
                                  $delete: FamilyTribeDeleteInput,
                                  ) {
      updateFamilyTribes(where: {id: $id}, update: $update, create: $create, 
                            connect: $connect, disconnect: $disconnect, delete: $delete) {
        familyTribes {
          ...FamilyTribeFragment,
        }
      }
    }
  """);

final FamilyTribeDeleteOp = gql(r"""
    mutation deleteFamilyTribe($id: ID!) {
      deleteFamilyTribes(where: {id: $id}) {
        nodesDeleted
      }
    }
  """);

final FamilyTribeListOp = gql(r"""
    query listFamilyTribe($where: FamilyTribeWhere!) {
      familyTribes(where: $where) {
        ...FamilyTribeFragment
      }
    }
  """);

final FamilyTribeLoadOp = gql(r"""
    query loadFamilyTribe($id: ID!) {
      familyTribes(where: {id: $id}) {
        ...FamilyTribeFragment
      }
    }
  """);

final FamilyTribeCountOp = gql(r"""
    query countFamilyTribes {
      familyTribesCount
    }
  """);

class FamilyTribeApi extends GraphApi<FamilyTribe, FamilyTribeCreateInput,
    FamilyTribeUpdateInput> {
  FamilyTribeApi(this._client, this.resolver, this.serializer);

  @override
  final GraphSerializer serializer;

  @override
  final GraphQueryResolver resolver;

  final GraphQLClientGetter _client;

  MSchemaRef get mtype {
    return FamilyTribe.ref;
  }

  @override
  GraphQLClient client() {
    return this._client();
  }
}

final FriendGroupTribeCreateOp = gql(r"""
    mutation createFriendGroupTribe($input: FriendGroupTribeCreateInput!) {
      createFriendGroupTribes(input: [$input]) {
        friendGroupTribes {
          ...FriendGroupTribeFragment,
        }
      }
    }
  """);

final FriendGroupTribeUpdateOp = gql(r"""
    mutation updateFriendGroupTribe($id: ID!, 
                                  $update: FriendGroupTribeUpdateInput!
                                  $create: FriendGroupTribeRelationInput,
                                  $connect: FriendGroupTribeConnectInput,
                                  $disconnect: FriendGroupTribeDisconnectInput,
                                  $delete: FriendGroupTribeDeleteInput,
                                  ) {
      updateFriendGroupTribes(where: {id: $id}, update: $update, create: $create, 
                            connect: $connect, disconnect: $disconnect, delete: $delete) {
        friendGroupTribes {
          ...FriendGroupTribeFragment,
        }
      }
    }
  """);

final FriendGroupTribeDeleteOp = gql(r"""
    mutation deleteFriendGroupTribe($id: ID!) {
      deleteFriendGroupTribes(where: {id: $id}) {
        nodesDeleted
      }
    }
  """);

final FriendGroupTribeListOp = gql(r"""
    query listFriendGroupTribe($where: FriendGroupTribeWhere!) {
      friendGroupTribes(where: $where) {
        ...FriendGroupTribeFragment
      }
    }
  """);

final FriendGroupTribeLoadOp = gql(r"""
    query loadFriendGroupTribe($id: ID!) {
      friendGroupTribes(where: {id: $id}) {
        ...FriendGroupTribeFragment
      }
    }
  """);

final FriendGroupTribeCountOp = gql(r"""
    query countFriendGroupTribes {
      friendGroupTribesCount
    }
  """);

class FriendGroupTribeApi extends GraphApi<FriendGroupTribe,
    FriendGroupTribeCreateInput, FriendGroupTribeUpdateInput> {
  FriendGroupTribeApi(this._client, this.resolver, this.serializer);

  @override
  final GraphSerializer serializer;

  @override
  final GraphQueryResolver resolver;

  final GraphQLClientGetter _client;

  MSchemaRef get mtype {
    return FriendGroupTribe.ref;
  }

  @override
  GraphQLClient client() {
    return this._client();
  }
}

final ImageMediaCreateOp = gql(r"""
    mutation createImageMedia($input: ImageMediaCreateInput!) {
      createImageMedia(input: [$input]) {
        imageMedia {
          ...ImageMediaFragment,
        }
      }
    }
  """);

final ImageMediaUpdateOp = gql(r"""
    mutation updateImageMedia($id: ID!, 
                                  $update: ImageMediaUpdateInput!
                                  $create: ImageMediaRelationInput,
                                  $connect: ImageMediaConnectInput,
                                  $disconnect: ImageMediaDisconnectInput,
                                  $delete: ImageMediaDeleteInput,
                                  ) {
      updateImageMedia(where: {id: $id}, update: $update, create: $create, 
                            connect: $connect, disconnect: $disconnect, delete: $delete) {
        imageMedia {
          ...ImageMediaFragment,
        }
      }
    }
  """);

final ImageMediaDeleteOp = gql(r"""
    mutation deleteImageMedia($id: ID!) {
      deleteImageMedia(where: {id: $id}) {
        nodesDeleted
      }
    }
  """);

final ImageMediaListOp = gql(r"""
    query listImageMedia($where: ImageMediaWhere!) {
      imageMedia(where: $where) {
        ...ImageMediaFragment
      }
    }
  """);

final ImageMediaLoadOp = gql(r"""
    query loadImageMedia($id: ID!) {
      imageMedia(where: {id: $id}) {
        ...ImageMediaFragment
      }
    }
  """);

final ImageMediaCountOp = gql(r"""
    query countImageMedia {
      imageMediaCount
    }
  """);

class ImageMediaApi
    extends GraphApi<ImageMedia, ImageMediaCreateInput, ImageMediaUpdateInput> {
  ImageMediaApi(this._client, this.resolver, this.serializer);

  @override
  final GraphSerializer serializer;

  @override
  final GraphQueryResolver resolver;

  final GraphQLClientGetter _client;

  MSchemaRef get mtype {
    return ImageMedia.ref;
  }

  @override
  GraphQLClient client() {
    return this._client();
  }
}

final MemoryCreateOp = gql(r"""
    mutation createMemory($input: MemoryCreateInput!) {
      createMemories(input: [$input]) {
        memories {
          ...MemoryFragment,
        }
      }
    }
  """);

final MemoryUpdateOp = gql(r"""
    mutation updateMemory($id: ID!, 
                                  $update: MemoryUpdateInput!
                                  $create: MemoryRelationInput,
                                  $connect: MemoryConnectInput,
                                  $disconnect: MemoryDisconnectInput,
                                  $delete: MemoryDeleteInput,
                                  ) {
      updateMemories(where: {id: $id}, update: $update, create: $create, 
                            connect: $connect, disconnect: $disconnect, delete: $delete) {
        memories {
          ...MemoryFragment,
        }
      }
    }
  """);

final MemoryDeleteOp = gql(r"""
    mutation deleteMemory($id: ID!) {
      deleteMemories(where: {id: $id}) {
        nodesDeleted
      }
    }
  """);

final MemoryListOp = gql(r"""
    query listMemory($where: MemoryWhere!) {
      memories(where: $where) {
        ...MemoryFragment
      }
    }
  """);

final MemoryLoadOp = gql(r"""
    query loadMemory($id: ID!) {
      memories(where: {id: $id}) {
        ...MemoryFragment
      }
    }
  """);

final MemoryCountOp = gql(r"""
    query countMemories {
      memoriesCount
    }
  """);

class MemoryApi extends GraphApi<Memory, MemoryCreateInput, MemoryUpdateInput> {
  MemoryApi(this._client, this.resolver, this.serializer);

  @override
  final GraphSerializer serializer;

  @override
  final GraphQueryResolver resolver;

  final GraphQLClientGetter _client;

  MSchemaRef get mtype {
    return Memory.ref;
  }

  @override
  GraphQLClient client() {
    return this._client();
  }
}

final PhaseCreateOp = gql(r"""
    mutation createPhase($input: PhaseCreateInput!) {
      createPhases(input: [$input]) {
        phases {
          ...PhaseFragment,
        }
      }
    }
  """);

final PhaseUpdateOp = gql(r"""
    mutation updatePhase($id: ID!, 
                                  $update: PhaseUpdateInput!
                                  $create: PhaseRelationInput,
                                  $connect: PhaseConnectInput,
                                  $disconnect: PhaseDisconnectInput,
                                  $delete: PhaseDeleteInput,
                                  ) {
      updatePhases(where: {id: $id}, update: $update, create: $create, 
                            connect: $connect, disconnect: $disconnect, delete: $delete) {
        phases {
          ...PhaseFragment,
        }
      }
    }
  """);

final PhaseDeleteOp = gql(r"""
    mutation deletePhase($id: ID!) {
      deletePhases(where: {id: $id}) {
        nodesDeleted
      }
    }
  """);

final PhaseListOp = gql(r"""
    query listPhase($where: PhaseWhere!) {
      phases(where: $where) {
        ...PhaseFragment
      }
    }
  """);

final PhaseLoadOp = gql(r"""
    query loadPhase($id: ID!) {
      phases(where: {id: $id}) {
        ...PhaseFragment
      }
    }
  """);

final PhaseCountOp = gql(r"""
    query countPhases {
      phasesCount
    }
  """);

class PhaseApi extends GraphApi<Phase, PhaseCreateInput, PhaseUpdateInput> {
  PhaseApi(this._client, this.resolver, this.serializer);

  @override
  final GraphSerializer serializer;

  @override
  final GraphQueryResolver resolver;

  final GraphQLClientGetter _client;

  MSchemaRef get mtype {
    return Phase.ref;
  }

  @override
  GraphQLClient client() {
    return this._client();
  }
}

final PhysicalLocationCreateOp = gql(r"""
    mutation createPhysicalLocation($input: PhysicalLocationCreateInput!) {
      createPhysicalLocations(input: [$input]) {
        physicalLocations {
          ...PhysicalLocationFragment,
        }
      }
    }
  """);

final PhysicalLocationUpdateOp = gql(r"""
    mutation updatePhysicalLocation($id: ID!, 
                                  $update: PhysicalLocationUpdateInput!
                                  $create: PhysicalLocationRelationInput,
                                  $connect: PhysicalLocationConnectInput,
                                  $disconnect: PhysicalLocationDisconnectInput,
                                  $delete: PhysicalLocationDeleteInput,
                                  ) {
      updatePhysicalLocations(where: {id: $id}, update: $update, create: $create, 
                            connect: $connect, disconnect: $disconnect, delete: $delete) {
        physicalLocations {
          ...PhysicalLocationFragment,
        }
      }
    }
  """);

final PhysicalLocationDeleteOp = gql(r"""
    mutation deletePhysicalLocation($id: ID!) {
      deletePhysicalLocations(where: {id: $id}) {
        nodesDeleted
      }
    }
  """);

final PhysicalLocationListOp = gql(r"""
    query listPhysicalLocation($where: PhysicalLocationWhere!) {
      physicalLocations(where: $where) {
        ...PhysicalLocationFragment
      }
    }
  """);

final PhysicalLocationLoadOp = gql(r"""
    query loadPhysicalLocation($id: ID!) {
      physicalLocations(where: {id: $id}) {
        ...PhysicalLocationFragment
      }
    }
  """);

final PhysicalLocationCountOp = gql(r"""
    query countPhysicalLocations {
      physicalLocationsCount
    }
  """);

class PhysicalLocationApi extends GraphApi<PhysicalLocation,
    PhysicalLocationCreateInput, PhysicalLocationUpdateInput> {
  PhysicalLocationApi(this._client, this.resolver, this.serializer);

  @override
  final GraphSerializer serializer;

  @override
  final GraphQueryResolver resolver;

  final GraphQLClientGetter _client;

  MSchemaRef get mtype {
    return PhysicalLocation.ref;
  }

  @override
  GraphQLClient client() {
    return this._client();
  }
}

final TribeCreateOp = gql(r"""
    mutation createTribe($input: TribeCreateInput!) {
      createTribes(input: [$input]) {
        tribes {
          ...TribeFragment,
        }
      }
    }
  """);

final TribeUpdateOp = gql(r"""
    mutation updateTribe($id: ID!, 
                                  $update: TribeUpdateInput!
                                  $create: TribeRelationInput,
                                  $connect: TribeConnectInput,
                                  $disconnect: TribeDisconnectInput,
                                  $delete: TribeDeleteInput,
                                  ) {
      updateTribes(where: {id: $id}, update: $update, create: $create, 
                            connect: $connect, disconnect: $disconnect, delete: $delete) {
        tribes {
          ...TribeFragment,
        }
      }
    }
  """);

final TribeDeleteOp = gql(r"""
    mutation deleteTribe($id: ID!) {
      deleteTribes(where: {id: $id}) {
        nodesDeleted
      }
    }
  """);

final TribeListOp = gql(r"""
    query listTribe($where: TribeWhere!) {
      tribes(where: $where) {
        ...TribeFragment
      }
    }
  """);

final TribeLoadOp = gql(r"""
    query loadTribe($id: ID!) {
      tribes(where: {id: $id}) {
        ...TribeFragment
      }
    }
  """);

final TribeCountOp = gql(r"""
    query countTribes {
      tribesCount
    }
  """);

class TribeApi extends GraphApi<Tribe, TribeCreateInput, TribeUpdateInput>
    implements HasPhasesApi, HasMemoriesApi {
  TribeApi(this._client, this.resolver, this.serializer);

  @override
  final GraphSerializer serializer;

  @override
  final GraphQueryResolver resolver;

  final GraphQLClientGetter _client;

  MSchemaRef get mtype {
    return Tribe.ref;
  }

  @override
  GraphQLClient client() {
    return this._client();
  }

  Future<List<Phase>?> loadPhasesForRecord(String id) {
    return this.loadRelatedList(
      id: id,
      relatedType: "Phase",
      isNullable: true,
      field: "phases",
      fragments: DocumentNodes(
        [PhaseFragment],
      ),
    );
  }

  Future<List<Memory>?> loadMemoriesForRecord(String id) {
    return this.loadRelatedList(
      id: id,
      relatedType: "Memory",
      isNullable: true,
      field: "memories",
      fragments: DocumentNodes(
        [
          MemoryFragment,
          ContactFragment,
          TribeFragment,
          PhaseFragment,
          ImageMediaFragment,
          PhysicalLocationFragment,
          VideoMediaFragment
        ],
      ),
    );
  }
}

final UserContactCreateOp = gql(r"""
    mutation createUserContact($input: UserContactCreateInput!) {
      createUserContacts(input: [$input]) {
        userContacts {
          ...UserContactFragment,
        }
      }
    }
  """);

final UserContactUpdateOp = gql(r"""
    mutation updateUserContact($id: ID!, 
                                  $update: UserContactUpdateInput!
                                  $create: UserContactRelationInput,
                                  $connect: UserContactConnectInput,
                                  $disconnect: UserContactDisconnectInput,
                                  $delete: UserContactDeleteInput,
                                  ) {
      updateUserContacts(where: {id: $id}, update: $update, create: $create, 
                            connect: $connect, disconnect: $disconnect, delete: $delete) {
        userContacts {
          ...UserContactFragment,
        }
      }
    }
  """);

final UserContactDeleteOp = gql(r"""
    mutation deleteUserContact($id: ID!) {
      deleteUserContacts(where: {id: $id}) {
        nodesDeleted
      }
    }
  """);

final UserContactListOp = gql(r"""
    query listUserContact($where: UserContactWhere!) {
      userContacts(where: $where) {
        ...UserContactFragment
      }
    }
  """);

final UserContactLoadOp = gql(r"""
    query loadUserContact($id: ID!) {
      userContacts(where: {id: $id}) {
        ...UserContactFragment
      }
    }
  """);

final UserContactCountOp = gql(r"""
    query countUserContacts {
      userContactsCount
    }
  """);

class UserContactApi extends GraphApi<UserContact, UserContactCreateInput,
    UserContactUpdateInput> {
  UserContactApi(this._client, this.resolver, this.serializer);

  @override
  final GraphSerializer serializer;

  @override
  final GraphQueryResolver resolver;

  final GraphQLClientGetter _client;

  MSchemaRef get mtype {
    return UserContact.ref;
  }

  @override
  GraphQLClient client() {
    return this._client();
  }
}

final VideoMediaCreateOp = gql(r"""
    mutation createVideoMedia($input: VideoMediaCreateInput!) {
      createVideoMedia(input: [$input]) {
        videoMedia {
          ...VideoMediaFragment,
        }
      }
    }
  """);

final VideoMediaUpdateOp = gql(r"""
    mutation updateVideoMedia($id: ID!, 
                                  $update: VideoMediaUpdateInput!
                                  $create: VideoMediaRelationInput,
                                  $connect: VideoMediaConnectInput,
                                  $disconnect: VideoMediaDisconnectInput,
                                  $delete: VideoMediaDeleteInput,
                                  ) {
      updateVideoMedia(where: {id: $id}, update: $update, create: $create, 
                            connect: $connect, disconnect: $disconnect, delete: $delete) {
        videoMedia {
          ...VideoMediaFragment,
        }
      }
    }
  """);

final VideoMediaDeleteOp = gql(r"""
    mutation deleteVideoMedia($id: ID!) {
      deleteVideoMedia(where: {id: $id}) {
        nodesDeleted
      }
    }
  """);

final VideoMediaListOp = gql(r"""
    query listVideoMedia($where: VideoMediaWhere!) {
      videoMedia(where: $where) {
        ...VideoMediaFragment
      }
    }
  """);

final VideoMediaLoadOp = gql(r"""
    query loadVideoMedia($id: ID!) {
      videoMedia(where: {id: $id}) {
        ...VideoMediaFragment
      }
    }
  """);

final VideoMediaCountOp = gql(r"""
    query countVideoMedia {
      videoMediaCount
    }
  """);

class VideoMediaApi
    extends GraphApi<VideoMedia, VideoMediaCreateInput, VideoMediaUpdateInput> {
  VideoMediaApi(this._client, this.resolver, this.serializer);

  @override
  final GraphSerializer serializer;

  @override
  final GraphQueryResolver resolver;

  final GraphQLClientGetter _client;

  MSchemaRef get mtype {
    return VideoMedia.ref;
  }

  @override
  GraphQLClient client() {
    return this._client();
  }
}

class GraphQLStuffJson {
  EntityReader? getReader(name) {
    switch (name) {
      case "ContactCreateInput":
        return (_) => ContactCreateInput.fromJson(_);
      case "ContactUpdateInput":
        return (_) => ContactUpdateInput.fromJson(_);
      case "FamilyTribeCreateInput":
        return (_) => FamilyTribeCreateInput.fromJson(_);
      case "FamilyTribeUpdateInput":
        return (_) => FamilyTribeUpdateInput.fromJson(_);
      case "FriendGroupTribeCreateInput":
        return (_) => FriendGroupTribeCreateInput.fromJson(_);
      case "FriendGroupTribeUpdateInput":
        return (_) => FriendGroupTribeUpdateInput.fromJson(_);
      case "ImageMediaCreateInput":
        return (_) => ImageMediaCreateInput.fromJson(_);
      case "ImageMediaUpdateInput":
        return (_) => ImageMediaUpdateInput.fromJson(_);
      case "MemoryCreateInput":
        return (_) => MemoryCreateInput.fromJson(_);
      case "MemoryUpdateInput":
        return (_) => MemoryUpdateInput.fromJson(_);
      case "PhaseCreateInput":
        return (_) => PhaseCreateInput.fromJson(_);
      case "PhaseUpdateInput":
        return (_) => PhaseUpdateInput.fromJson(_);
      case "PhysicalLocationCreateInput":
        return (_) => PhysicalLocationCreateInput.fromJson(_);
      case "PhysicalLocationUpdateInput":
        return (_) => PhysicalLocationUpdateInput.fromJson(_);
      case "TribeCreateInput":
        return (_) => TribeCreateInput.fromJson(_);
      case "TribeUpdateInput":
        return (_) => TribeUpdateInput.fromJson(_);
      case "UserContactCreateInput":
        return (_) => UserContactCreateInput.fromJson(_);
      case "UserContactUpdateInput":
        return (_) => UserContactUpdateInput.fromJson(_);
      case "VideoMediaCreateInput":
        return (_) => VideoMediaCreateInput.fromJson(_);
      case "VideoMediaUpdateInput":
        return (_) => VideoMediaUpdateInput.fromJson(_);
      case "Tribe":
        return (_) => Tribe.fromJson(_);
      case "Contact":
        return (_) => Contact.fromJson(_);
      case "Phase":
        return (_) => Phase.fromJson(_);
      case "FamilyTribe":
        return (_) => FamilyTribe.fromJson(_);
      case "FriendGroupTribe":
        return (_) => FriendGroupTribe.fromJson(_);
      case "Memory":
        return (_) => Memory.fromJson(_);
      case "PhysicalLocation":
        return (_) => PhysicalLocation.fromJson(_);
      case "ImageMedia":
        return (_) => ImageMedia.fromJson(_);
      case "VideoMedia":
        return (_) => VideoMedia.fromJson(_);
      case "UserContact":
        return (_) => UserContact.fromJson(_);
      case "TribeMembership":
        return (_) => TribeMembership.fromJson(_);
      case "TribeMember":
        return (_) => TribeMember.fromJson(_);
      case "FamilyMemberType":
        return (_) => FamilyMemberType.fromJson(_);
      case "MediaType":
        return (_) => MediaType.fromJson(_);
      case "Orientation":
        return (_) => Orientation.fromJson(_);
      case "RelatableType":
        return (_) => RelatableType.fromJson(_);
      default:
        return null;
    }
  }

  EntityWriter? getWriter(name) {
    switch (name) {
      case "ContactCreateInput":
        return (from) => from?.toJson();
      case "ContactUpdateInput":
        return (from) => from?.toJson();
      case "FamilyTribeCreateInput":
        return (from) => from?.toJson();
      case "FamilyTribeUpdateInput":
        return (from) => from?.toJson();
      case "FriendGroupTribeCreateInput":
        return (from) => from?.toJson();
      case "FriendGroupTribeUpdateInput":
        return (from) => from?.toJson();
      case "ImageMediaCreateInput":
        return (from) => from?.toJson();
      case "ImageMediaUpdateInput":
        return (from) => from?.toJson();
      case "MemoryCreateInput":
        return (from) => from?.toJson();
      case "MemoryUpdateInput":
        return (from) => from?.toJson();
      case "PhaseCreateInput":
        return (from) => from?.toJson();
      case "PhaseUpdateInput":
        return (from) => from?.toJson();
      case "PhysicalLocationCreateInput":
        return (from) => from?.toJson();
      case "PhysicalLocationUpdateInput":
        return (from) => from?.toJson();
      case "TribeCreateInput":
        return (from) => from?.toJson();
      case "TribeUpdateInput":
        return (from) => from?.toJson();
      case "UserContactCreateInput":
        return (from) => from?.toJson();
      case "UserContactUpdateInput":
        return (from) => from?.toJson();
      case "VideoMediaCreateInput":
        return (from) => from?.toJson();
      case "VideoMediaUpdateInput":
        return (from) => from?.toJson();
      case "Tribe":
        return (from) => from?.toJson();
      case "Contact":
        return (from) => from?.toJson();
      case "Phase":
        return (from) => from?.toJson();
      case "FamilyTribe":
        return (from) => from?.toJson();
      case "FriendGroupTribe":
        return (from) => from?.toJson();
      case "Memory":
        return (from) => from?.toJson();
      case "PhysicalLocation":
        return (from) => from?.toJson();
      case "ImageMedia":
        return (from) => from?.toJson();
      case "VideoMedia":
        return (from) => from?.toJson();
      case "UserContact":
        return (from) => from?.toJson();
      case "TribeMembership":
        return (from) => from?.toJson();
      case "TribeMember":
        return (from) => from?.toJson();
      case "FamilyMemberType":
        return (from) => from?.toJson();
      case "MediaType":
        return (from) => from?.toJson();
      case "Orientation":
        return (from) => from?.toJson();
      case "RelatableType":
        return (from) => from?.toJson();
      default:
        return null;
    }
  }
}

class ReliveItQueryResolver extends GraphQueryResolver {
  DocumentNode? getQuery(String queryName) {
    switch (queryName) {
      case 'ContactCreateOp':
        return DocumentNodes([ContactCreateOp, ContactFragment]);
      case 'ContactUpdateOp':
        return DocumentNodes([ContactUpdateOp, ContactFragment]);
      case 'ContactDeleteOp':
        return ContactDeleteOp;
      case 'ContactListOp':
        return DocumentNodes([ContactListOp, ContactFragment]);
      case 'ContactLoadOp':
        return DocumentNodes([ContactLoadOp, ContactFragment]);
      case 'ContactCountOp':
        return ContactCountOp;
      case 'FamilyTribeCreateOp':
        return DocumentNodes([
          FamilyTribeCreateOp,
          FamilyTribeFragment,
          ContactFragment,
          TribeFragment,
          PhaseFragment
        ]);
      case 'FamilyTribeUpdateOp':
        return DocumentNodes([
          FamilyTribeUpdateOp,
          FamilyTribeFragment,
          ContactFragment,
          TribeFragment,
          PhaseFragment
        ]);
      case 'FamilyTribeDeleteOp':
        return FamilyTribeDeleteOp;
      case 'FamilyTribeListOp':
        return DocumentNodes([
          FamilyTribeListOp,
          FamilyTribeFragment,
          ContactFragment,
          TribeFragment,
          PhaseFragment
        ]);
      case 'FamilyTribeLoadOp':
        return DocumentNodes([
          FamilyTribeLoadOp,
          FamilyTribeFragment,
          ContactFragment,
          TribeFragment,
          PhaseFragment
        ]);
      case 'FamilyTribeCountOp':
        return FamilyTribeCountOp;
      case 'FriendGroupTribeCreateOp':
        return DocumentNodes([
          FriendGroupTribeCreateOp,
          FriendGroupTribeFragment,
          TribeFragment,
          PhaseFragment,
          ContactFragment
        ]);
      case 'FriendGroupTribeUpdateOp':
        return DocumentNodes([
          FriendGroupTribeUpdateOp,
          FriendGroupTribeFragment,
          TribeFragment,
          PhaseFragment,
          ContactFragment
        ]);
      case 'FriendGroupTribeDeleteOp':
        return FriendGroupTribeDeleteOp;
      case 'FriendGroupTribeListOp':
        return DocumentNodes([
          FriendGroupTribeListOp,
          FriendGroupTribeFragment,
          TribeFragment,
          PhaseFragment,
          ContactFragment
        ]);
      case 'FriendGroupTribeLoadOp':
        return DocumentNodes([
          FriendGroupTribeLoadOp,
          FriendGroupTribeFragment,
          TribeFragment,
          PhaseFragment,
          ContactFragment
        ]);
      case 'FriendGroupTribeCountOp':
        return FriendGroupTribeCountOp;
      case 'ImageMediaCreateOp':
        return DocumentNodes(
            [ImageMediaCreateOp, ImageMediaFragment, PhysicalLocationFragment]);
      case 'ImageMediaUpdateOp':
        return DocumentNodes(
            [ImageMediaUpdateOp, ImageMediaFragment, PhysicalLocationFragment]);
      case 'ImageMediaDeleteOp':
        return ImageMediaDeleteOp;
      case 'ImageMediaListOp':
        return DocumentNodes(
            [ImageMediaListOp, ImageMediaFragment, PhysicalLocationFragment]);
      case 'ImageMediaLoadOp':
        return DocumentNodes(
            [ImageMediaLoadOp, ImageMediaFragment, PhysicalLocationFragment]);
      case 'ImageMediaCountOp':
        return ImageMediaCountOp;
      case 'MemoryCreateOp':
        return DocumentNodes([
          MemoryCreateOp,
          MemoryFragment,
          ContactFragment,
          TribeFragment,
          PhaseFragment,
          ImageMediaFragment,
          PhysicalLocationFragment,
          VideoMediaFragment
        ]);
      case 'MemoryUpdateOp':
        return DocumentNodes([
          MemoryUpdateOp,
          MemoryFragment,
          ContactFragment,
          TribeFragment,
          PhaseFragment,
          ImageMediaFragment,
          PhysicalLocationFragment,
          VideoMediaFragment
        ]);
      case 'MemoryDeleteOp':
        return MemoryDeleteOp;
      case 'MemoryListOp':
        return DocumentNodes([
          MemoryListOp,
          MemoryFragment,
          ContactFragment,
          TribeFragment,
          PhaseFragment,
          ImageMediaFragment,
          PhysicalLocationFragment,
          VideoMediaFragment
        ]);
      case 'MemoryLoadOp':
        return DocumentNodes([
          MemoryLoadOp,
          MemoryFragment,
          ContactFragment,
          TribeFragment,
          PhaseFragment,
          ImageMediaFragment,
          PhysicalLocationFragment,
          VideoMediaFragment
        ]);
      case 'MemoryCountOp':
        return MemoryCountOp;
      case 'PhaseCreateOp':
        return DocumentNodes([PhaseCreateOp, PhaseFragment]);
      case 'PhaseUpdateOp':
        return DocumentNodes([PhaseUpdateOp, PhaseFragment]);
      case 'PhaseDeleteOp':
        return PhaseDeleteOp;
      case 'PhaseListOp':
        return DocumentNodes([PhaseListOp, PhaseFragment]);
      case 'PhaseLoadOp':
        return DocumentNodes([PhaseLoadOp, PhaseFragment]);
      case 'PhaseCountOp':
        return PhaseCountOp;
      case 'PhysicalLocationCreateOp':
        return DocumentNodes(
            [PhysicalLocationCreateOp, PhysicalLocationFragment]);
      case 'PhysicalLocationUpdateOp':
        return DocumentNodes(
            [PhysicalLocationUpdateOp, PhysicalLocationFragment]);
      case 'PhysicalLocationDeleteOp':
        return PhysicalLocationDeleteOp;
      case 'PhysicalLocationListOp':
        return DocumentNodes(
            [PhysicalLocationListOp, PhysicalLocationFragment]);
      case 'PhysicalLocationLoadOp':
        return DocumentNodes(
            [PhysicalLocationLoadOp, PhysicalLocationFragment]);
      case 'PhysicalLocationCountOp':
        return PhysicalLocationCountOp;
      case 'TribeCreateOp':
        return DocumentNodes(
            [TribeCreateOp, TribeFragment, PhaseFragment, ContactFragment]);
      case 'TribeUpdateOp':
        return DocumentNodes(
            [TribeUpdateOp, TribeFragment, PhaseFragment, ContactFragment]);
      case 'TribeDeleteOp':
        return TribeDeleteOp;
      case 'TribeListOp':
        return DocumentNodes(
            [TribeListOp, TribeFragment, PhaseFragment, ContactFragment]);
      case 'TribeLoadOp':
        return DocumentNodes(
            [TribeLoadOp, TribeFragment, PhaseFragment, ContactFragment]);
      case 'TribeCountOp':
        return TribeCountOp;
      case 'UserContactCreateOp':
        return DocumentNodes(
            [UserContactCreateOp, UserContactFragment, ContactFragment]);
      case 'UserContactUpdateOp':
        return DocumentNodes(
            [UserContactUpdateOp, UserContactFragment, ContactFragment]);
      case 'UserContactDeleteOp':
        return UserContactDeleteOp;
      case 'UserContactListOp':
        return DocumentNodes(
            [UserContactListOp, UserContactFragment, ContactFragment]);
      case 'UserContactLoadOp':
        return DocumentNodes(
            [UserContactLoadOp, UserContactFragment, ContactFragment]);
      case 'UserContactCountOp':
        return UserContactCountOp;
      case 'VideoMediaCreateOp':
        return DocumentNodes(
            [VideoMediaCreateOp, VideoMediaFragment, PhysicalLocationFragment]);
      case 'VideoMediaUpdateOp':
        return DocumentNodes(
            [VideoMediaUpdateOp, VideoMediaFragment, PhysicalLocationFragment]);
      case 'VideoMediaDeleteOp':
        return VideoMediaDeleteOp;
      case 'VideoMediaListOp':
        return DocumentNodes(
            [VideoMediaListOp, VideoMediaFragment, PhysicalLocationFragment]);
      case 'VideoMediaLoadOp':
        return DocumentNodes(
            [VideoMediaLoadOp, VideoMediaFragment, PhysicalLocationFragment]);
      case 'VideoMediaCountOp':
        return VideoMediaCountOp;

      default:
        return null;
    }
  }
}
