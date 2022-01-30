import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    Key? key,
    required this.data,
    required this.itemBuilder,
    this.seperated = true,
  }) : super(key: key);
  final AsyncValue<List<T>> data;
  final ItemWidgetBuilder<T> itemBuilder;
  final bool seperated;

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (items) =>
          items.isNotEmpty ? _buildList(items, seperated) : Container(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, error) => Container(
        child: Text('Something went wrong Can\'t load items right now'),
      ),
    );
  }

  Widget _buildList(List<T> items, bool seperated) {
    return seperated
        ? ListView.separated(
            itemCount: items.length + 1,
            separatorBuilder: (context, index) => const Divider(height: 0.5),
            itemBuilder: (context, index) {
              if (index == 0 || index == items.length + 1) {
                return Container(); // zero height: not visible
              }
              return itemBuilder(context, items[index - 1]);
            },
          )
        : ListView.builder(
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index == 0 || index == items.length + 1) {
                return Container(); // zero height: not visible
              }
              return itemBuilder(context, items[index - 1]);
            },
          );
  }
}
