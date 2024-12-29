import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/screens/new_list.dart';
import 'package:quick_list/widgets/quick_list_container.dart';
import 'package:quick_list/widgets/dashboard_bar.dart';

// ignore: non_constant_identifier_names
Map<String, String> CREATED_AT_SORT_MODES = {
  'descending': 'descending',
  'ascending':  'ascending'
};

class Dashboard extends StatefulWidget {
  const Dashboard({ super.key });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<QuickList> quickLists = [];
  String sortMode = CREATED_AT_SORT_MODES['descending']!;
  FirebaseFirestore fireDb   = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    _fetchQuickLists();
  }

  void _fetchQuickLists() {
    List<QuickList> documentItems = [];

    fireDb.collection('lists').get().then((event) {
      for (var doc in event.docs) {
        String quickListId = doc.id;
        QuickList quickList = QuickList.fromSnapshot(doc);

        fireDb.collection('/lists/$quickListId/list-items').get()
          .then((listItemSnapshot) {
            if (listItemSnapshot.docs.isNotEmpty) {
              for (var item in listItemSnapshot.docs) {
                QuickListItem listItem = QuickListItem.fromSnapshot(item);
                quickList.addToListItems(listItem);
              }
            }

            documentItems.add(quickList);
            // Descending Order
            documentItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            // Ascending Order
            // documentItems.sort((a, b) => a.createdAt.compareTo(b.createdAt));

            setState(() {
              quickLists = documentItems;
            });
          });
        }
      });
  }

  Future<void> _addNewList(BuildContext context) async {
    final bool? newQuickListAdded = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewList()),
    );

    if (!context.mounted) return;
    if (newQuickListAdded == null) return;

    if (newQuickListAdded) {
      _fetchQuickLists();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 4,
          bottom: 8
        ),
        child: Column(
        children: [
            DashboardBar(sortMode: sortMode),
            Padding(padding: EdgeInsets.all(2)),
            Expanded(
              child: QuickListContainer(quickLists)
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewList(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

}
