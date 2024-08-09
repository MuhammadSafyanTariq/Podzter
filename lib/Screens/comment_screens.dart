import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/Models/user.dart';
import 'package:insta_clone/Provider/user_provider.dart';
import 'package:insta_clone/Resource/FireStore_methods.dart';
import 'package:provider/provider.dart';

import '../Widgets/comment_card.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({
    super.key,
    required this.snap,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.90,
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 6,
                width: MediaQuery.of(context).size.width * 0.33,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "    Comments",
                  style: GoogleFonts.syne(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(widget.snap['postId'])
                      .collection('comments')
                      .orderBy('datePublished', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        final isLastComment = index ==
                            (snapshot.data! as dynamic).docs.length - 1;
                        return Column(
                          children: [
                            CommentCard(
                              snap: (snapshot.data! as dynamic).docs[index],
                            ),
                            if (!isLastComment)
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  color: Colors.white24,
                                  height: 0.5,
                                ),
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              height: kToolbarHeight,
              margin: EdgeInsets.only(
                bottom: 30,
              ),
              padding: const EdgeInsets.only(
                left: 16,
                right: 8,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl!),
                    radius: 18,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24, width: 0.8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Add a comment',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      firestoreMethods().postComment(
                        widget.snap['postId'],
                        _commentController.text,
                        user.uid!,
                        user.username!,
                        user.photoUrl!,
                      );
                      _commentController.text = "";
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        child: const Icon(Icons.send)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
