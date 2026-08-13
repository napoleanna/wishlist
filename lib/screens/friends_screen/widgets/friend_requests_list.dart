import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';

class FriendRequestsList extends StatelessWidget {
  const FriendRequestsList({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return const SizedBox.shrink();
    
   return StreamBuilder<QuerySnapshot>(
     stream: FirebaseFirestore.instance
         .collection('users')
         .doc(currentUser.uid)
         .collection('friend_requests')
         .where('status', isEqualTo: 'pending')
         .snapshots(),
     builder: (context, snapshot) {
       if (snapshot.hasError) return const SizedBox.shrink();
       if (!snapshot.hasData) return const SizedBox.shrink();

       final allRequests = snapshot.data!.docs;
       if (allRequests.isEmpty) return const SizedBox.shrink();

       final previewRequests = allRequests.take(3).toList();

       final isDark = Theme.of(context).brightness == Brightness.dark;

       return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const SizedBox(height: 15),
           _buildHeader (allRequests.length, isDark),
           const SizedBox(height: 15),
           Column(children: previewRequests.map((preview) {
             final requestId = preview.id;
             final data = preview.data() as Map<String, dynamic>;
             return _buildRequestCard(
                 context, data, requestId, currentUser.uid, isDark);
           }).toList()),
           if (allRequests.length > 3)
             _buildViewAllButton(context, allRequests, currentUser.uid),
           const SizedBox(height: 10),
         ],
       );
     },
   );
  }

  Widget _buildHeader(int count, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Friend Requests',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF1F1F2E),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF946ABA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text('$count',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildViewAllButton(
      BuildContext context, List<QueryDocumentSnapshot> requests, String myId) {
    return Center(
      child:  TextButton(
          onPressed: () => _showAllRequestsSheet(context,  requests, myId),
          child: const Text(
            'View all requests',
            style: TextStyle(
              color: Color(0xFF7B61FF),
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
      ),
    );
  }

  Widget _buildRequestCard(
    BuildContext context, Map<String, dynamic> data,
      String requestId, String myId, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isDark ? Colors.white.withValues(alpha: 0.1)
                : const Color(0xFFF6F4FF),
            child: Icon(Icons.person, color: isDark ? Colors.white70
                : const Color(0xFF6d66b1)),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(data['fromNickname'] ?? 'Unknown',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF1F1F2E),
                  )),
          ),
          _buildRequestAction(
            icon: Icons.check,
            color: Colors.green,
            onTap: () => _acceptRequest(myId, requestId, data['fromNickname']
                ?? 'User'),
          ),
          const SizedBox(width: 8),
          _buildRequestAction(
            icon: Icons.close,
            color: Colors.redAccent,
            onTap: () => _rejectRequest(myId, requestId),
          ),
        ],
      ),
    );
  }


  Widget _buildRequestAction({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  void _showAllRequestsSheet(
      BuildContext context,
      List<QueryDocumentSnapshot> requests,
      String myId) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF403966) : const Color(0xFFF6F4FF),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text('All Requests',
                   style: TextStyle(
                     fontFamily: 'Poppins',
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                     color: isDark ? Colors.white : const Color(0xFF1F1F2E),
                    ),
                   ),
                   IconButton(
                     onPressed: () => Navigator.pop(context),
                     icon: Icon(Icons.close_rounded,
                         color: isDark ? Colors.white70
                             : const Color(0xFF6B6B8A),
                     size: 26,
                     ),
                   ),
                 ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final data = requests[index].data() as Map<String, dynamic>;
                final requestId = requests[index].id;
                return _buildRequestCard(context, data, requestId, myId, isDark);
              },
            ),
          ),
          ],
        ),
      ),
    );
  }

  Future<void> _acceptRequest(
      String myId,
      String fromId,
      String fromNickname) async {
    final batch = FirebaseFirestore.instance.batch();

    batch.set(FirebaseFirestore.instance.collection('users')
        .doc(myId).collection('friends').doc(fromId), {
      'friendId' : fromId,
      'name' : fromNickname,
      'addedAt' : FieldValue.serverTimestamp(),
    });

    batch.delete(FirebaseFirestore.instance.collection('users')
        .doc(myId).collection('friend_requests').doc(fromId));

        await batch.commit();
  }

  Future<void> _rejectRequest(String myId, String peerId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .collection('friend_requests')
        .doc(peerId)
        .delete();
  }
  }