import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../design_patterns/observer/observer.dart';

class StockRow extends StatelessWidget {
  final Stock stock;

  Color get color => stock.changeDirection == StockChangeDirection.growing
      ? Colors.green
      : Colors.red;

  const StockRow({
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: LayoutConstants.spaceXL * 2,
          child: Text(
            stock.symbol.toShortString(),
            style: TextStyle(color: color),
          ),
        ),
        const SizedBox(width: LayoutConstants.spaceM),
        SizedBox(
          width: LayoutConstants.spaceXL * 2,
          child: Text(
            stock.price.toString(),
            style: TextStyle(color: color),
            textAlign: TextAlign.end,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LayoutConstants.paddingM,
          ),
          child: Icon(
            stock.changeDirection == StockChangeDirection.growing
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            color: color,
          ),
        ),
        Text(
          stock.changeAmount.toStringAsFixed(2),
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
