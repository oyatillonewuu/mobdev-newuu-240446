import 'package:cart_four_ways/widgets/cart_body.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cart_four_ways/setstate/cart_page_setstate.dart'
    show SetStateCartPage;

void main() {
  testWidgets(
    "Adding keyoard twice and applying SAVE10 gives discounted subtotal",
    (tester) async {
      await tester.pumpWidget(MaterialApp(home: SetStateCartPage()));
      await tester.pump();

      final productWidget = find
          .byType(ProductWidget)
          .allCandidates
          .firstWhere(
            (w) => w.widget.toString().toLowerCase().contains("keyboard"),
          )
          .widget;

      expect(find.byType(ProductWidget), findsWidgets);

      await tester.tap(find.byWidget(productWidget));
      await tester.tap(find.byWidget(productWidget));

      expect(find.byType(CouponInputWidget), findsOne);
      await tester.enterText(find.byType(CouponInputWidget), "SAVE10");
      expect(find.byType(CouponApplyButton), findsOne);
      await tester.tap(find.byType(CouponApplyButton));

      await tester.pump();

      expect(find.byType(CartBody), findsOne);
      final findStmt = find.byType(CartBody);
      findStmt.tryEvaluate();
      expect((findStmt.found.first.widget as CartBody).cartState.total, 88.20);
    },
  );
}
