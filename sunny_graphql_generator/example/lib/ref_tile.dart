import 'package:example/graphql_stuff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefTile extends StatelessWidget {
  final IRef ref;
  final VoidCallback? onTap;

  const RefTile({Key? key, this.onTap, required this.ref}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: RefAvatar(ref),
      title: Text(ref.displayName),
      onTap: onTap,
    ));
  }
}

class RefAvatar extends StatelessWidget {
  final IRef ref;

  const RefAvatar(this.ref, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ref.photoUrl == null
        ? CircleAvatar(child: Icon(CupertinoIcons.profile_circled))
        : CircleAvatar(
            foregroundImage: NetworkImage(ref.photoUrl!.toString()),
          );
  }
}
