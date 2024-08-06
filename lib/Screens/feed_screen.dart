import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            image: AssetImage('assets/profilebg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 120,
                padding: EdgeInsets.only(top: 15),
                margin: const EdgeInsets.only(bottom: 25),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Image.asset(
                          'assets/logo.png',
                          height: 45,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: IconWidget(
                                assetPath: 'bell',
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: IconWidget(
                                assetPath: 'menu',
                                size: 21,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return SliverList(
                  // There is some error in this part, can you tell me why?
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                      margin: EdgeInsets.only(
                          bottom:
                              index + 1 == snapshot.data!.docs.length ? 60 : 0),
                      child: PostCard(
                        snap: snapshot.data!.docs[index].data(),
                      ),
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
