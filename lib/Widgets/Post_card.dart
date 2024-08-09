import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Models/user.dart';
import 'package:insta_clone/Provider/user_provider.dart';
import 'package:insta_clone/Resource/FireStore_methods.dart';
import 'package:insta_clone/Screens/comment_screens.dart';
import 'package:insta_clone/Widgets/icon_widget.dart';
import 'package:insta_clone/Widgets/like_animation.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    super.key,
    required this.snap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    getComment();
  }

  void getComment() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      setState(() {
        commentLen = snap.docs.length;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black12,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/menubg.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 8,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                _buildBottomSheetItem(
                  icon: Icon(
                    Icons.visibility_off_rounded,
                    color: Colors.white,
                  ),
                  text: 'Hide Post',
                  onTap: () {
                    // Handle Hide Post
                  },
                ),
                _buildBottomSheetItem(
                  icon: Icon(
                    Icons.person_remove_rounded,
                    color: Colors.white,
                  ),
                  text: 'Unfollow',
                  onTap: () {
                    // Handle Unfollow
                  },
                ),
                _buildBottomSheetItem(
                  icon: Image.asset(
                    'assets/icons/redi.png',
                    height: 23,
                  ),
                  text: 'Report',
                  textColor: Colors.redAccent,
                  onTap: () {
                    // Handle Report
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetItem({
    required Widget icon,
    required String text,
    required VoidCallback onTap,
    Color textColor = Colors.white,
  }) {
    return ListTile(
      leading: icon,
      title: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ).copyWith(right: 0, top: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 27.5,
                        backgroundImage: NetworkImage(
                          widget.snap['profImage'],
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      // widget.snap['username'],
                                      "Safyan Tariq",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    IconWidget(assetPath: 'verify')
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                const Text(
                                  "Horror • True Crime",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        _showOptionsBottomSheet(context);
                      },
                      child: const Icon(
                        Icons.more_horiz_rounded,
                        color: Colors.white70,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final textSpan = TextSpan(
                      text: widget.snap['description'],
                      style: const TextStyle(fontSize: 18),
                    );

                    final textPainter = TextPainter(
                      text: textSpan,
                      maxLines: isExpanded ? null : 3,
                      textDirection: TextDirection.ltr,
                    )..layout(maxWidth: constraints.maxWidth);

                    final link = GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? 'Read less' : 'Read more',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          decorationColor: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    );

                    if (!isExpanded && textPainter.didExceedMaxLines) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                textSpan,
                                const TextSpan(
                                  text: '... ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          link,
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            textSpan,
                          ),
                          if (textPainter.didExceedMaxLines) link,
                        ],
                      );
                    }
                  },
                ),
              ),
              GestureDetector(
                onDoubleTap: () async {
                  setState(() {
                    isLikeAnimating = true;
                  });
                  await firestoreMethods().likePost(
                    widget.snap['postId'],
                    user.uid!,
                    widget.snap['likes'],
                  );
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.snap['postUrl'],
                              ))),
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isLikeAnimating ? 1 : 0,
                      child: LikeAnimation(
                        isAnimating: isLikeAnimating,
                        duration: const Duration(milliseconds: 400),
                        onEnd: () {
                          setState(
                            () {
                              isLikeAnimating = false;
                            },
                          );
                        },
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Row(
                    children: [
                      LikeAnimation(
                        isAnimating: widget.snap['likes'].contains(user.uid),
                        smallLike: true,
                        child: IconButton(
                            onPressed: () async {
                              await firestoreMethods().likePost(
                                widget.snap['postId'],
                                user.uid!,
                                widget.snap['likes'],
                              );
                            },
                            icon: widget.snap['likes'].contains(user.uid)
                                ? const Icon(
                                    Icons.favorite,
                                    color: Color(0xFFF9595F),
                                    size: 25,
                                  )
                                : const Icon(
                                    Icons.favorite_border_outlined,
                                    size: 25,
                                  )),
                      ),
                      IconButton(
                        onPressed: () => showBottomSheet(
                          context: context,
                          builder: (context) =>
                              CommentScreen(snap: widget.snap),
                        ),
                        //    Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => CommentScreen(
                        //     snap: widget.snap,
                        //   ),
                        // )),
                        icon: IconWidget(
                          assetPath: 'chat',
                          size: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Sorry this feature will be supported in future'),
                          ),
                        ),
                        icon: IconWidget(
                          assetPath: 'send',
                          size: 18,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.bookmark_border,
                              size: 25,
                            ),
                            onPressed: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Sorry this feature will be supported in future'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
