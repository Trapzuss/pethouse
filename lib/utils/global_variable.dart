import 'package:flutter/material.dart';

import 'package:pet_house/screens/feed.dart';
import 'package:pet_house/screens/search.dart';
import 'package:pet_house/screens/profile.dart';
import 'package:pet_house/screens/collection.dart';

List<Widget> bottomNavigationScreenItems = [
  const Feed(),
  const Search(),
  const Collection(),
  const Profile(),
];
