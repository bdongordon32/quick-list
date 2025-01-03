import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/providers/quick_lists_provider.dart';
import 'package:quick_list/screens/new_list.dart';
import 'package:quick_list/widgets/quick_list/list_card.dart';
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
  String sortMode = CREATED_AT_SORT_MODES['descending']!;
  FirebaseFirestore fireDb   = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    _fetchQuickLists();
  }

  void _fetchQuickLists() {
    fireDb.collection('lists')
      .get().then((event) {
      for (var doc in event.docs) {
        String quickListId = doc.id;
        QuickList quickList = QuickList.fromSnapshot(doc);

        fireDb
          .collection('/lists/$quickListId/list-items').get()
          .then((listItemSnapshot) {
            if (listItemSnapshot.docs.isNotEmpty) {
              for (var item in listItemSnapshot.docs) {
                QuickListItem listItem = QuickListItem.fromSnapshot(item);
                quickList.addToListItems(listItem);
              }
            }

            if (mounted) {
              Provider.of<QuickListsProvider>(
                context,
                listen: false
              ).addList(quickList);
            }
          });
        }
      });
  }

  void _toggleSort() {
    setState(() {
      if (sortMode == CREATED_AT_SORT_MODES['descending']) {
        setState(() => sortMode = 'ascending');
      } else {
        setState(() => sortMode = 'descending');
      }
    });

    if (mounted) {
      Provider.of<QuickListsProvider>(context, listen: false).toggleSort(sortMode);
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
        child: Consumer<QuickListsProvider>(
          builder: (context, listsProvider, child) {
            List<QuickList> quickLists = listsProvider.quickLists;
            listsProvider.toggleSort(sortMode);

            return Column(
              children: [
                DashboardBar(
                  sortMode: sortMode,
                  onToggleSort: _toggleSort,
                  quickListCount: quickLists.length,
                ),
                Padding(padding: EdgeInsets.all(2)),
                Expanded(
                  child: ListView.builder(
                    itemCount: quickLists.length,
                    itemBuilder: (BuildContext context, int index) => ListCard(quickLists[index]),
                  )
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewList()),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

}
