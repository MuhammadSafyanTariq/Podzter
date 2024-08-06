import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/Widgets/Post_card.dart';
import 'package:insta_clone/Widgets/custom_nav_bar.dart';
import 'package:insta_clone/Widgets/icon_widget.dart';

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({super.key});

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  @override
  void initState() {
    super.initState();
  }

  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
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

    return Stack(
      children: [
        Scaffold(
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
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 50, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.arrow_back_outlined,
                          size: 30,
                        ),
                        Text(
                          "Saved Posts",
                          style: GoogleFonts.syne(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
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
                              bottom: index + 1 == snapshot.data!.docs.length
                                  ? 60
                                  : 0),
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
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CustomNavBar(
            onItemSelected: _onItemSelected,
            selectedIndex: _selectedIndex,
          ),
        ),
      ],
    );
  }
}
