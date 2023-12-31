import 'package:flutter/material.dart';

import '../models/stock.dart';
import '../utils/formats.dart';
import './price.dart';
import 'percent.dart';

class StockListItem extends StatelessWidget {
  final Stock item;
  const StockListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: theme.textTheme.subtitle1,
            ),
            Text(
              item.timestamp != null
                  ? timestampFormat.format(item.timestamp!)
                  : '',
              style: theme.textTheme.bodyText2,
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              item.latestPrice != null
                  ? Price(
                      item.latestPrice!,
                      item.currency,
                      textStyle: theme.textTheme.subtitle2,
                    )
                  : const Text(''),
              item.dayChange != null
                  ? Percent(item.dayChangePercent!)
                  : const Text(''),
            ],
          ),
        ),
      ],
    );
  }
}
