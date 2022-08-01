import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports/utils/utils.dart';

enum RoundPart { finalist, semifinalist, participant, dontcare }

class RankingTile extends StatelessWidget {
  final int rank;
  final String country;
  final RoundPart roundStatus;
  final Widget? child;
  final Widget? nextPage;

  const RankingTile({
    Key? key,
    required this.rank,
    required this.country,
    this.roundStatus = RoundPart.dontcare,
    this.child,
    this.nextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(
        left: 5.0,
        top: 0.0,
        right: 0.0,
        bottom: 3.0,
      ),
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(5),
        ),
      ),
      child: InkWell(
        customBorder: const BeveledRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(5),
          ),
        ),
        onTap: () {
          if (nextPage != null) {
            Provider.of<PageManager>(context, listen: false).push(
              MaterialPage(
                child: nextPage!,
              ),
            );
          }
        },
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20,
                decoration: ShapeDecoration(
                  color: getLableColor,
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(5),
                    ),
                  ),
                ),
              ),
              child ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Color get getLableColor {
    switch (roundStatus) {
      case RoundPart.finalist:
        return Colors.greenAccent;
      case RoundPart.semifinalist:
        return Colors.amberAccent;
      case RoundPart.participant:
      case RoundPart.dontcare:
      default:
        return Colors.transparent;
    }
  }
}
