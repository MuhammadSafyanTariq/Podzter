import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/Resource/FireStore_methods.dart';
import 'package:insta_clone/Widgets/Post_card.dart';
import 'package:insta_clone/Widgets/follow_button.dart';
import 'package:insta_clone/Widgets/icon_widget.dart';
import 'package:insta_clone/Widgets/social_icons_row.dart';
import 'package:insta_clone/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Color.fromRGBO(0, 0, 0, 0.50),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    super.initState();
    getData();
  }

  void deletePost(DocumentSnapshot snap) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          shrinkWrap: true,
          children: ["Delete"]
              .map(
                (e) => InkWell(
                  onTap: () {
                    firestoreMethods()
                        .deletePost((snap.data()! as dynamic)['postId']);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Text(e),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
    setState(() {});
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where(
            'uid',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();
      postLen = postSnap.docs.length;

      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Stack(children: [
              Image.asset(
                'assets/profilebg.png',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 20, left: 12),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                      // image: DecorationImage(
                      //     image: AssetImage(
                      //       'assets/profiletop.png',
                      //     ),
                      //     fit: BoxFit.cover)
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(height: ,)
                          const SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.arrow_back_ios),
                              // Spacer(),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                '@${userData['username']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
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
                                        color: Color.fromRGBO(0, 0, 0, 0.4),
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
                                        assetPath: 'bell',
                                        // size: 5,
                                        size: 18,
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
                                        color: Color.fromRGBO(0, 0, 0, 0.4),
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
                                        size: 18,
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
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userData['photoUrl'],
                                ),
                                radius: 42,
                              ),
                              const SizedBox(width: 20),
                              Center(
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    buildStatColumn(followers, 'Followers'),
                                    const SizedBox(width: 40),
                                    Container(
                                      height: 59,
                                      width: 0.5,
                                      color: Colors.white54,
                                    ),
                                    const SizedBox(width: 40),
                                    buildStatColumn(following, 'Following'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            userData['username'],
                            style: GoogleFonts.syne(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            '@${userData['username']} • Host',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const BulletPointList(items: [
                            'Buisness',
                            'Lifestyle',
                            'Coding',
                            'Dev'
                          ]),
                          const SizedBox(height: 10),
                          Text(
                            userData['bio'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const SocialIconsRow(),
                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FollowButton(
                                backgroundColor: Colors.white,
                                borderColor: Colors.white,
                                text: 'Follow',
                                textColor: Colors.black,
                                icon: IconWidget(assetPath: 'follow'),
                                function: () {},
                              ),
                              FollowButton(
                                backgroundColor: Colors.white24,
                                borderColor: Colors.transparent,
                                text: 'Message',
                                icon: IconWidget(assetPath: 'message'),
                                textColor: Colors.white,
                                function: () {},
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white24,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: Colors.white),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  const SizedBox(height: 20),
                  DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        // const TabBar(
                        //   tabs: [
                        //     Tab(icon: Icon(Icons.grid_on)),
                        //     Tab(icon: Icon(Icons.comment)),
                        //     Tab(icon: Icon(Icons.tag)),
                        //   ],
                        // ),
                        SizedBox(
                          height: 500, // Adjust height as needed
                          child: TabBarView(
                            children: [
                              buildPostsGrid(),
                              const Center(
                                  child: Text('Comments',
                                      style: TextStyle(color: Colors.white))),
                              const Center(
                                  child: Text('Tagged',
                                      style: TextStyle(color: Colors.white))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          );
  }

  Widget buildPostsGrid() {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
            return Container(child: PostCard(snap: snap));
            // return Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: NetworkImage(snap['postUrl']),
            //       fit: BoxFit.cover,
            //     ),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            // );
          },
        );
      },
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class BulletPointList extends StatelessWidget {
  final List<String> items;

  const BulletPointList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: items.map((item) {
        int index = items.indexOf(item);
        return Row(
          children: [
            Text(
              item,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
            if (index < items.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '•',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        );
      }).toList(),
    );
  }
}
