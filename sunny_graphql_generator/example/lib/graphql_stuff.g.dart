// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_stuff.dart';

// **************************************************************************
// GraphQLGenerator
// **************************************************************************

class Contact extends BaseSunnyEntity implements IRef, HasPhases {
  Contact(
      {required this.id,
      required this.displayName,
      this.nickName,
      this.photoUrl,
      this.birthday,
      this.dateModified,
      this.dateCreated,
      required this.tribes,
      required this.phases,
      this.childFamily,
      this.parentFamily,
      this.friendGroups});

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
          typeName: 'Phase', isNullable: false),
      childFamily: GraphClientConfig.read(json['childFamily'],
          typeName: 'FamilyTribe', isNullable: true),
      parentFamily: GraphClientConfig.read(json['parentFamily'],
          typeName: 'FamilyTribe', isNullable: true),
      friendGroups: GraphClientConfig.readList(json['friendGroups'],
          typeName: 'FriendGroupTribe', isNullable: true));

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
        friendGroups = map.get('friendGroups');

  String id;

  String displayName;

  String? nickName;

  Uri? photoUrl;

  FlexiDate? birthday;

  DateTime? dateModified;

  DateTime? dateCreated;

  List<TribeMembership> tribes;

  List<Phase> phases;

  FamilyTribe? childFamily;

  FamilyTribe? parentFamily;

  List<FriendGroupTribe>? friendGroups;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "contact", "1.0.0", "mvext");

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
        this.phases = value as List<Phase>;
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

      default:
        throw "No field ${key} found on Contact";
    }
  }

  FieldRefInput? relatedJson() {
    return {};
  }

  MSchemaRef get mtype {
    return ref;
  }
}

class Tribe extends BaseSunnyEntity implements IRef, HasPhases {
  Tribe(
      {required this.id,
      required this.displayName,
      this.photoUrl,
      required this.slug,
      required this.tribeType,
      this.dateModified,
      this.dateCreated,
      required this.members,
      required this.phases});

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
          typeName: 'Phase', isNullable: false));

  Tribe.fromMap(Map<String, dynamic> map)
      : id = map.get('id'),
        displayName = map.get('displayName'),
        photoUrl = map.get('photoUrl'),
        slug = map.get('slug'),
        tribeType = map.get('tribeType'),
        dateModified = map.get('dateModified'),
        dateCreated = map.get('dateCreated'),
        members = map.get('members'),
        phases = map.get('phases');

  String id;

  String displayName;

  Uri? photoUrl;

  String slug;

  String tribeType;

  DateTime? dateModified;

  DateTime? dateCreated;

  List<TribeMember> members;

  List<Phase> phases;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "tribe", "1.0.0", "mvext");

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
        this.phases = value as List<Phase>;
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

      default:
        throw "No field ${key} found on Tribe";
    }
  }

  FieldRefInput? relatedJson() {
    return {};
  }

  MSchemaRef get mtype {
    return ref;
  }
}

class Phase extends BaseSunnyEntity implements IRef {
  Phase(
      {required this.id,
      required this.phased,
      required this.displayName,
      this.photoUrl,
      this.startDate,
      this.endDate,
      this.description,
      required this.dateCreated,
      required this.dateModified});

  factory Phase.fromJson(dynamic json) => Phase(
      id: (json['id'] as String),
      phased: GraphClientConfig.read(json['phased'],
          typeName: 'HasPhases', isNullable: false),
      displayName: (json['displayName'] as String),
      photoUrl: GraphClientConfig.read(json['photoUrl'],
          typeName: 'Uri', isNullable: true),
      startDate: GraphClientConfig.read(json['startDate'],
          typeName: 'FlexiDate', isNullable: true),
      endDate: GraphClientConfig.read(json['endDate'],
          typeName: 'FlexiDate', isNullable: true),
      description: (json['description'] as String?),
      dateCreated: GraphClientConfig.read(json['dateCreated'],
          typeName: 'DateTime', isNullable: false),
      dateModified: GraphClientConfig.read(json['dateModified'],
          typeName: 'DateTime', isNullable: false));

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

  HasPhases phased;

  String displayName;

  Uri? photoUrl;

  FlexiDate? startDate;

  FlexiDate? endDate;

  String? description;

  DateTime dateCreated;

  DateTime dateModified;

  static const ref =
      MSchemaRef("mverse", "reliveIt", "phase", "1.0.0", "mvext");

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
        this.phased = value as HasPhases;
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
        this.dateCreated = value as DateTime;
        break;
      case "dateModified":
        this.dateModified = value as DateTime;
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

  FieldRefInput? relatedJson() {
    return {};
  }

  MSchemaRef get mtype {
    return ref;
  }
}

class FamilyTribe extends BaseSunnyEntity {
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

  FieldRefInput? relatedJson() {
    return {};
  }

  MSchemaRef get mtype {
    return ref;
  }
}

class FriendGroupTribe extends BaseSunnyEntity {
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

  FieldRefInput? relatedJson() {
    return {};
  }

  MSchemaRef get mtype {
    return ref;
  }
}

class UserContact extends BaseSunnyEntity {
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

  FieldRefInput? relatedJson() {
    return {};
  }

  MSchemaRef get mtype {
    return ref;
  }
}

class TribeMembership extends BaseSunnyEntity
    with JoinTypeMixin<Tribe>
    implements TribeMemberDetails {
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

  FieldRefInput? relatedJson() {
    return {};
  }

  MSchemaRef get mtype {
    return ref;
  }
}

class TribeMember extends BaseSunnyEntity
    with JoinTypeMixin<Contact>
    implements TribeMemberDetails {
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

  FieldRefInput? relatedJson() {
    return {};
  }

  MSchemaRef get mtype {
    return ref;
  }
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

class ContactCreateInput implements GraphInput {
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
          friendGroups})
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
        };

  ContactCreateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  String get displayName {
    return this.get("displayName");
  }

  String? get nickName {
    return this.get("nickName");
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  FlexiDate? get birthday {
    return this.get("birthday");
  }

  ExtGraphRefList<Tribe, TribeMembership, TribeCreateInput, TribeUpdateInput>?
      get tribes {
    return this.get("tribes");
  }

  GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? get phases {
    return this.get("phases");
  }

  NullableGraphRef<FamilyTribe, FamilyTribeCreateInput, FamilyTribeUpdateInput>?
      get childFamily {
    return this.get("childFamily");
  }

  NullableGraphRef<FamilyTribe, FamilyTribeCreateInput, FamilyTribeUpdateInput>?
      get parentFamily {
    return this.get("parentFamily");
  }

  GraphRefList<FriendGroupTribe, FriendGroupTribeCreateInput,
      FriendGroupTribeUpdateInput>? get friendGroups {
    return this.get("friendGroups");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        case "displayName":
          return v;
        case "nickName":
          return v;
        case "photoUrl":
          return GraphClientConfig.write(v, typeName: "Uri", isList: false);
        case "birthday":
          return GraphClientConfig.write(v,
              typeName: "FlexiDate", isList: false);
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribes", this.tribes?.relatedJson),
        relatedFieldJson("phases", this.phases?.relatedJson),
        relatedFieldJson("childFamily", this.childFamily?.relatedJson),
        relatedFieldJson("parentFamily", this.parentFamily?.relatedJson),
        relatedFieldJson("friendGroups", this.friendGroups?.relatedJson),
      ]),
    };
  }
}

class ContactUpdateInput implements GraphInput {
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
          friendGroups})
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
        };

  ContactUpdateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  String get displayName {
    return this.get("displayName");
  }

  String? get nickName {
    return this.get("nickName");
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  FlexiDate? get birthday {
    return this.get("birthday");
  }

  ExtGraphRefList<Tribe, TribeMembership, TribeCreateInput, TribeUpdateInput>?
      get tribes {
    return this.get("tribes");
  }

  GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? get phases {
    return this.get("phases");
  }

  NullableGraphRef<FamilyTribe, FamilyTribeCreateInput, FamilyTribeUpdateInput>?
      get childFamily {
    return this.get("childFamily");
  }

  NullableGraphRef<FamilyTribe, FamilyTribeCreateInput, FamilyTribeUpdateInput>?
      get parentFamily {
    return this.get("parentFamily");
  }

  GraphRefList<FriendGroupTribe, FriendGroupTribeCreateInput,
      FriendGroupTribeUpdateInput>? get friendGroups {
    return this.get("friendGroups");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        case "displayName":
          return v;
        case "nickName":
          return v;
        case "photoUrl":
          return GraphClientConfig.write(v, typeName: "Uri", isList: false);
        case "birthday":
          return GraphClientConfig.write(v,
              typeName: "FlexiDate", isList: false);
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribes", this.tribes?.relatedJson),
        relatedFieldJson("phases", this.phases?.relatedJson),
        relatedFieldJson("childFamily", this.childFamily?.relatedJson),
        relatedFieldJson("parentFamily", this.parentFamily?.relatedJson),
        relatedFieldJson("friendGroups", this.friendGroups?.relatedJson),
      ]),
    };
  }
}

class FamilyTribeCreateInput implements GraphInput {
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

  FamilyTribeCreateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? get tribe {
    return this.get("tribe");
  }

  FlexiDate? get startDate {
    return this.get("startDate");
  }

  FlexiDate? get endDate {
    return this.get("endDate");
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get parents {
    return this.get("parents");
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get children {
    return this.get("children");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        case "startDate":
          return GraphClientConfig.write(v,
              typeName: "FlexiDate", isList: false);
        case "endDate":
          return GraphClientConfig.write(v,
              typeName: "FlexiDate", isList: false);
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribe", this.tribe?.relatedJson),
        relatedFieldJson("parents", this.parents?.relatedJson),
        relatedFieldJson("children", this.children?.relatedJson),
      ]),
    };
  }
}

class FamilyTribeUpdateInput implements GraphInput {
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

  FamilyTribeUpdateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? get tribe {
    return this.get("tribe");
  }

  FlexiDate? get startDate {
    return this.get("startDate");
  }

  FlexiDate? get endDate {
    return this.get("endDate");
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get parents {
    return this.get("parents");
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get children {
    return this.get("children");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        case "startDate":
          return GraphClientConfig.write(v,
              typeName: "FlexiDate", isList: false);
        case "endDate":
          return GraphClientConfig.write(v,
              typeName: "FlexiDate", isList: false);
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribe", this.tribe?.relatedJson),
        relatedFieldJson("parents", this.parents?.relatedJson),
        relatedFieldJson("children", this.children?.relatedJson),
      ]),
    };
  }
}

class FriendGroupTribeCreateInput implements GraphInput {
  FriendGroupTribeCreateInput(
      {GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? tribe,
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? friends})
      : _data = {
          if (tribe != null) "tribe": tribe,
          if (friends != null) "friends": friends,
        };

  FriendGroupTribeCreateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? get tribe {
    return this.get("tribe");
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get friends {
    return this.get("friends");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribe", this.tribe?.relatedJson),
        relatedFieldJson("friends", this.friends?.relatedJson),
      ]),
    };
  }
}

class FriendGroupTribeUpdateInput implements GraphInput {
  FriendGroupTribeUpdateInput(
      {GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? tribe,
      GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? friends})
      : _data = {
          if (tribe != null) "tribe": tribe,
          if (friends != null) "friends": friends,
        };

  FriendGroupTribeUpdateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  GraphRef<Tribe, TribeCreateInput, TribeUpdateInput>? get tribe {
    return this.get("tribe");
  }

  GraphRefList<Contact, ContactCreateInput, ContactUpdateInput>? get friends {
    return this.get("friends");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("tribe", this.tribe?.relatedJson),
        relatedFieldJson("friends", this.friends?.relatedJson),
      ]),
    };
  }
}

class PhaseCreateInput implements GraphInput {
  PhaseCreateInput(
      {GraphRef<HasPhases, HasPhasesCreateInput, HasPhasesUpdateInput>? phased,
      String? displayName,
      Uri? photoUrl,
      FlexiDate? startDate,
      FlexiDate? endDate,
      String? description})
      : _data = {
          if (phased != null) "phased": phased,
          if (displayName != null) "displayName": displayName,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (startDate != null) "startDate": startDate,
          if (endDate != null) "endDate": endDate,
          if (description != null) "description": description,
        };

  PhaseCreateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  GraphRef<HasPhases, HasPhasesCreateInput, HasPhasesUpdateInput>? get phased {
    return this.get("phased");
  }

  String get displayName {
    return this.get("displayName");
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  FlexiDate? get startDate {
    return this.get("startDate");
  }

  FlexiDate? get endDate {
    return this.get("endDate");
  }

  String? get description {
    return this.get("description");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        case "displayName":
          return v;
        case "photoUrl":
          return GraphClientConfig.write(v, typeName: "Uri", isList: false);
        case "startDate":
          return GraphClientConfig.write(v,
              typeName: "FlexiDate", isList: false);
        case "endDate":
          return GraphClientConfig.write(v,
              typeName: "FlexiDate", isList: false);
        case "description":
          return v;
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("phased", this.phased?.relatedJson),
      ]),
    };
  }
}

class PhaseUpdateInput implements GraphInput {
  PhaseUpdateInput(
      {GraphRef<HasPhases, HasPhasesCreateInput, HasPhasesUpdateInput>? phased,
      String? displayName,
      Uri? photoUrl,
      FlexiDate? startDate,
      FlexiDate? endDate,
      String? description})
      : _data = {
          if (phased != null) "phased": phased,
          if (displayName != null) "displayName": displayName,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (startDate != null) "startDate": startDate,
          if (endDate != null) "endDate": endDate,
          if (description != null) "description": description,
        };

  PhaseUpdateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  GraphRef<HasPhases, HasPhasesCreateInput, HasPhasesUpdateInput>? get phased {
    return this.get("phased");
  }

  String get displayName {
    return this.get("displayName");
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  FlexiDate? get startDate {
    return this.get("startDate");
  }

  FlexiDate? get endDate {
    return this.get("endDate");
  }

  String? get description {
    return this.get("description");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        case "displayName":
          return v;
        case "photoUrl":
          return GraphClientConfig.write(v, typeName: "Uri", isList: false);
        case "startDate":
          return GraphClientConfig.write(v,
              typeName: "FlexiDate", isList: false);
        case "endDate":
          return GraphClientConfig.write(v,
              typeName: "FlexiDate", isList: false);
        case "description":
          return v;
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("phased", this.phased?.relatedJson),
      ]),
    };
  }
}

class TribeCreateInput implements GraphInput {
  TribeCreateInput(
      {String? id,
      String? displayName,
      Uri? photoUrl,
      String? slug,
      String? tribeType,
      ExtGraphRefList<Contact, TribeMember, ContactCreateInput,
              ContactUpdateInput>?
          members,
      GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? phases})
      : _data = {
          if (id != null) "id": id,
          if (displayName != null) "displayName": displayName,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (slug != null) "slug": slug,
          if (tribeType != null) "tribeType": tribeType,
          if (members != null) "members": members,
          if (phases != null) "phases": phases,
        };

  TribeCreateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  String get id {
    return this.get("id");
  }

  String get displayName {
    return this.get("displayName");
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  String get slug {
    return this.get("slug");
  }

  String get tribeType {
    return this.get("tribeType");
  }

  ExtGraphRefList<Contact, TribeMember, ContactCreateInput, ContactUpdateInput>?
      get members {
    return this.get("members");
  }

  GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? get phases {
    return this.get("phases");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        case "id":
          return v;
        case "displayName":
          return v;
        case "photoUrl":
          return GraphClientConfig.write(v, typeName: "Uri", isList: false);
        case "slug":
          return v;
        case "tribeType":
          return v;
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("members", this.members?.relatedJson),
        relatedFieldJson("phases", this.phases?.relatedJson),
      ]),
    };
  }
}

class TribeUpdateInput implements GraphInput {
  TribeUpdateInput(
      {String? displayName,
      Uri? photoUrl,
      String? slug,
      String? tribeType,
      ExtGraphRefList<Contact, TribeMember, ContactCreateInput,
              ContactUpdateInput>?
          members,
      GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? phases})
      : _data = {
          if (displayName != null) "displayName": displayName,
          if (photoUrl != null) "photoUrl": photoUrl,
          if (slug != null) "slug": slug,
          if (tribeType != null) "tribeType": tribeType,
          if (members != null) "members": members,
          if (phases != null) "phases": phases,
        };

  TribeUpdateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  String get displayName {
    return this.get("displayName");
  }

  Uri? get photoUrl {
    return this.get("photoUrl");
  }

  String get slug {
    return this.get("slug");
  }

  String get tribeType {
    return this.get("tribeType");
  }

  ExtGraphRefList<Contact, TribeMember, ContactCreateInput, ContactUpdateInput>?
      get members {
    return this.get("members");
  }

  GraphRefList<Phase, PhaseCreateInput, PhaseUpdateInput>? get phases {
    return this.get("phases");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        case "displayName":
          return v;
        case "photoUrl":
          return GraphClientConfig.write(v, typeName: "Uri", isList: false);
        case "slug":
          return v;
        case "tribeType":
          return v;
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("members", this.members?.relatedJson),
        relatedFieldJson("phases", this.phases?.relatedJson),
      ]),
    };
  }
}

class UserContactCreateInput implements GraphInput {
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

  UserContactCreateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  String get id {
    return this.get("id");
  }

  GraphRef<Contact, ContactCreateInput, ContactUpdateInput>? get contact {
    return this.get("contact");
  }

  String? get username {
    return this.get("username");
  }

  String? get firebaseUid {
    return this.get("firebaseUid");
  }

  String? get email {
    return this.get("email");
  }

  String? get phone {
    return this.get("phone");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        case "id":
          return v;
        case "username":
          return v;
        case "firebaseUid":
          return v;
        case "email":
          return v;
        case "phone":
          return v;
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("contact", this.contact?.relatedJson),
      ]),
    };
  }
}

class UserContactUpdateInput implements GraphInput {
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

  UserContactUpdateInput.fromJson(this._data);

  final Map<String, dynamic> _data;

  GraphRef<Contact, ContactCreateInput, ContactUpdateInput>? get contact {
    return this.get("contact");
  }

  String? get username {
    return this.get("username");
  }

  String? get firebaseUid {
    return this.get("firebaseUid");
  }

  String? get email {
    return this.get("email");
  }

  String? get phone {
    return this.get("phone");
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

  JsonObject? toJson() {
    _fieldJson(k, v) {
      switch (k) {
        case "username":
          return v;
        case "firebaseUid":
          return v;
        case "email":
          return v;
        case "phone":
          return v;
        default:
          return null;
      }
    }

    return <String, dynamic>{
      for (var entry in this._data.entries)
        entry.key: _fieldJson(entry.key, entry.value),
    };
  }

  FieldRefInput? relatedJson() {
    return {
      ...?relatedToJson([
        relatedFieldJson("contact", this.contact?.relatedJson),
      ]),
    };
  }
}

enum FamilyMemberType {
  PARENT,
  CHILD,
}

FamilyMemberType parseFamilyMemberType(json) {
  switch (json!.toString().toLowerCase()) {
    case "parent":
      return FamilyMemberType.PARENT;
    case "child":
      return FamilyMemberType.CHILD;
    default:
      throw "Enum not recognized ${json}";
  }
}

enum RelatableType {
  CONTACT,
  ORG,
}

RelatableType parseRelatableType(json) {
  switch (json!.toString().toLowerCase()) {
    case "contact":
      return RelatableType.CONTACT;
    case "org":
      return RelatableType.ORG;
    default:
      throw "Enum not recognized ${json}";
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
  phased {
__typename
    ...on IRef {       id
      displayName
      photoUrl
 }  }

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
id
displayName
photoUrl
slug
tribeType
  }

}""");

final FamilyFragment = gql(""" fragment FamilyFragment on Family {
  id
  startDate
  endDate
  tribe {
    ...TribeFragment
  }
  parents {
    ...ContactFragment
  }
  children {
    ...ContactFragment
  }

}""");

final FriendGroupFragment =
    gql(""" fragment FriendGroupFragment on FriendGroup {
  id
  tribe {
    ...TribeFragment
  }
  friends {
    ...ContactFragment
  }

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
    extends GraphApi<Contact, ContactCreateInput, ContactUpdateInput> {
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

  Future<List<Tribe>> loadTribesForContact(String id) {
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

  Future<FamilyTribe?> loadChildFamilyForContact(String id) {
    return this.loadRelated(
      id: id,
      relatedType: "FamilyTribe",
      isNullable: true,
      field: "childFamily",
      fragments: DocumentNodes(
        [FamilyTribeFragment, ContactFragment],
      ),
    );
  }

  Future<FamilyTribe?> loadParentFamilyForContact(String id) {
    return this.loadRelated(
      id: id,
      relatedType: "FamilyTribe",
      isNullable: true,
      field: "parentFamily",
      fragments: DocumentNodes(
        [FamilyTribeFragment, ContactFragment],
      ),
    );
  }

  Future<List<FriendGroupTribe>?> loadFriendGroupsForContact(String id) {
    return this.loadRelatedList(
      id: id,
      relatedType: "FriendGroupTribe",
      isNullable: true,
      field: "friendGroups",
      fragments: DocumentNodes(
        [],
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

class TribeApi extends GraphApi<Tribe, TribeCreateInput, TribeUpdateInput> {
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
      case "PhaseCreateInput":
        return (_) => PhaseCreateInput.fromJson(_);
      case "PhaseUpdateInput":
        return (_) => PhaseUpdateInput.fromJson(_);
      case "TribeCreateInput":
        return (_) => TribeCreateInput.fromJson(_);
      case "TribeUpdateInput":
        return (_) => TribeUpdateInput.fromJson(_);
      case "UserContactCreateInput":
        return (_) => UserContactCreateInput.fromJson(_);
      case "UserContactUpdateInput":
        return (_) => UserContactUpdateInput.fromJson(_);
      case "Contact":
        return (_) => Contact.fromJson(_);
      case "Tribe":
        return (_) => Tribe.fromJson(_);
      case "Phase":
        return (_) => Phase.fromJson(_);
      case "FamilyTribe":
        return (_) => FamilyTribe.fromJson(_);
      case "FriendGroupTribe":
        return (_) => FriendGroupTribe.fromJson(_);
      case "UserContact":
        return (_) => UserContact.fromJson(_);
      case "TribeMembership":
        return (_) => TribeMembership.fromJson(_);
      case "TribeMember":
        return (_) => TribeMember.fromJson(_);
      case "FamilyMemberType":
        return (from) => parseFamilyMemberType(from);
      case "RelatableType":
        return (from) => parseRelatableType(from);
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
      case "PhaseCreateInput":
        return (from) => from?.toJson();
      case "PhaseUpdateInput":
        return (from) => from?.toJson();
      case "TribeCreateInput":
        return (from) => from?.toJson();
      case "TribeUpdateInput":
        return (from) => from?.toJson();
      case "UserContactCreateInput":
        return (from) => from?.toJson();
      case "UserContactUpdateInput":
        return (from) => from?.toJson();
      case "Contact":
        return (from) => from?.toJson();
      case "Tribe":
        return (from) => from?.toJson();
      case "Phase":
        return (from) => from?.toJson();
      case "FamilyTribe":
        return (from) => from?.toJson();
      case "FriendGroupTribe":
        return (from) => from?.toJson();
      case "UserContact":
        return (from) => from?.toJson();
      case "TribeMembership":
        return (from) => from?.toJson();
      case "TribeMember":
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
        return DocumentNodes(
            [FamilyTribeCreateOp, FamilyTribeFragment, ContactFragment]);
      case 'FamilyTribeUpdateOp':
        return DocumentNodes(
            [FamilyTribeUpdateOp, FamilyTribeFragment, ContactFragment]);
      case 'FamilyTribeDeleteOp':
        return FamilyTribeDeleteOp;
      case 'FamilyTribeListOp':
        return DocumentNodes(
            [FamilyTribeListOp, FamilyTribeFragment, ContactFragment]);
      case 'FamilyTribeLoadOp':
        return DocumentNodes(
            [FamilyTribeLoadOp, FamilyTribeFragment, ContactFragment]);
      case 'FamilyTribeCountOp':
        return FamilyTribeCountOp;
      case 'FriendGroupTribeCreateOp':
        return DocumentNodes([FriendGroupTribeCreateOp]);
      case 'FriendGroupTribeUpdateOp':
        return DocumentNodes([FriendGroupTribeUpdateOp]);
      case 'FriendGroupTribeDeleteOp':
        return FriendGroupTribeDeleteOp;
      case 'FriendGroupTribeListOp':
        return DocumentNodes([FriendGroupTribeListOp]);
      case 'FriendGroupTribeLoadOp':
        return DocumentNodes([FriendGroupTribeLoadOp]);
      case 'FriendGroupTribeCountOp':
        return FriendGroupTribeCountOp;
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

      default:
        return null;
    }
  }
}
