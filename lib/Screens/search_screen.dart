import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/Widgets/Post_card.dart';
import 'package:insta_clone/Widgets/icon_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUsers = false;
  int selectedIndex = 0;
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white24)),
        child: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search Here...',
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.white70),
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
    );
  }

  Widget _buildTabButton(
      String text, bool isSelected, bool isIcon, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 44,
        // width: double,
        padding: EdgeInsets.symmetric(
            horizontal: isIcon
                ? MediaQuery.of(context).size.width * 0.06
                : MediaQuery.of(context).size.width * 0.04,
            vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(30),
        ),
        child: isIcon
            ? Center(
                child: Image.asset(
                  'assets/icons/filter.png',
                  height: 20,
                  color: isSelected ? Colors.black : Colors.white,
                ),
              )
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontSize: 16),
                ),
              ),
      ),
    );
  }

  Widget _buildUserProfile(String imageUrl, String name, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.syne(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconWidget(assetPath: 'verify')
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.white24,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profilebg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              _buildSearchBar(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTabButton("Podcast", selectedIndex == 0, false, () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    }),
                    const SizedBox(width: 10),
                    _buildTabButton("Guest", selectedIndex == 1, false, () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    }),
                    const SizedBox(width: 10),
                    _buildTabButton("Sponsor", selectedIndex == 2, false, () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    }),
                    const SizedBox(width: 10),
                    _buildTabButton("", selectedIndex == 3, true, () {
                      // setState(() {
                      //   selectedIndex = 3;
                      // });
                    }),

                    // const Icon(Icons.filter_list, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Tailored For You",
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: FirebaseFirestore.instance.collection('users').get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return selectedIndex == 2
                      ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.data == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.only(
                                    bottom:
                                        index + 1 == snapshot.data!.docs.length
                                            ? 60
                                            : 0),
                                child: PostCard(
                                  snap: snapshot.data!.docs[index].data(),
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          itemBuilder: (context, index) {
                            var user = (snapshot.data! as dynamic).docs[index];
                            return _buildUserProfile(
                              user['photoUrl'],
                              user['username'],
                              'True Crime · Horror',
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
