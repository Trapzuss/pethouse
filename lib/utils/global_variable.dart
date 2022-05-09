import 'package:flutter/material.dart';

import 'package:pet_house/screens/feed.dart';
import 'package:pet_house/screens/search.dart';
import 'package:pet_house/screens/profile.dart';
import 'package:pet_house/screens/collections/collections.dart';

List<Widget> bottomNavigationScreenItems = [
  const FeedScreen(),
  const Search(),
  const collectionsScreen(),
  const Profile(),
];
