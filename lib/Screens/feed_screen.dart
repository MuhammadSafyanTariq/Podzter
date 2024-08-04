import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:insta_clone/Widgets/Post_card.dart';
import 'package:insta_clone/Widgets/icon_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.black,
    //     statusBarColor: Colors.transparent,
    //     systemNavigationBarIconBrightness: Brightness.light,
    //   ),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Color.fromRGBO(0, 0, 0, 0.50),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/profilebg.png',
              ),
              fit: BoxFit.cover),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 143,
                // height: 160,
                // padding: const EdgeInsets.only(bottom: 10),
                // decoration: const BoxDecoration(
                //     borderRadius: BorderRadius.only(
                //       bottomLeft: Radius.circular(30),
                //       bottomRight: Radius.circular(30),
                //     ),
                //     image: DecorationImage(
                //         image: AssetImage(
                //           'assets/headerbg.png',
                //         ),
                //         fit: BoxFit.cover)),
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.only(bottom: 25),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Spacer(),
                    Spacer(),

                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Center(
                          // height: 100,
                          child: Image.asset(
                            'assets/logo.png',
                            height: 45,
                          ),
                          // width: 100,
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Stack(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  // color: Color.fromRGBO(0, 0, 0, 0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: IconWidget(
                                  assetPath: 'bell',
                                  // size: 5,
                                  size: 23,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Stack(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  shape: BoxShape.circle,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //       color: Colors.white10,
                                  //       blurRadius: 5),
                                  // ]
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: IconWidget(
                                  assetPath: 'menu',
                                  // size: 5,
                                  size: 23,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    Spacer(),

                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       for (int i = 0; i < 5; i++)
                    //         StoryWidget(
                    //           image: dummyImages[i],
                    //           name: dummyNames[i],
                    //         ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => PostCard(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                    childCount: snapshot.data!.docs.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
