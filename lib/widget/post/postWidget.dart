// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final List<IconData> tags = [Icons.pets];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Row(
                children: [
                  Container(
                    width: 50,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://image.joox.com/JOOXcover/0/fe58ed87bcd7937b/300'),
                    ),
                  ),
                  Text(
                    'Username',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )),
              Container(
                  child: Row(
                children: [
                  Container(
                    width: 50,
                    child: Icon(Icons.language),
                  ),
                  Container(
                      width: 50,
                      child: Icon(
                        Icons.more_vert,
                      ))
                ],
              ))
            ],
          ),
          Container(
            child: Image.network(
                'https://image.joox.com/JOOXcover/0/fe58ed87bcd7937b/300'),
          ),
          Container(
              padding: EdgeInsets.only(top: 8),
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 8),
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://image.joox.com/JOOXcover/0/fe58ed87bcd7937b/300'),
                                  ),
                                ),
                                Text('username',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My dog become chuunibyuu...',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  for (var tag in tags)
                                    Chip(
                                      avatar: Icon(tag),
                                      label: Icon(Icons.chevron_right),
                                    )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.message),
                                  Icon(Icons.favorite)
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [Text('1.4k Liked')],
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                        'Actually he always hong bonkai everytime that i seen, Can anyone get them to pets pls!! ',
                        style: TextStyle(fontSize: 12)),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'View all 2 comments',
                      style: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  )
                ],
              )))
        ],
      ),
    );
  }
}
