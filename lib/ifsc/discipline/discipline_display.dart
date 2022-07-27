import 'package:flutter/material.dart';

enum Discipline { combined, boulder, lead, speed }

class DisciplineData {
  final Color color;
  final String name;
  final int men;
  final int women;

  DisciplineData({
    required this.color,
    required this.name,
    required this.men,
    required this.women,
  });
}

Map<Discipline, DisciplineData> disciplineMapping = {
  Discipline.combined: DisciplineData(
    color: Color(0xFFAA9342),
    name: 'Combined',
    men: 4,
    women: 8,
  ),
  Discipline.boulder: DisciplineData(
    color: Color(0xFF1782BB),
    name: 'Boulder',
    men: 3,
    women: 7,
  ),
  Discipline.lead: DisciplineData(
    color: Color(0xFF00C462),
    name: 'Lead',
    men: 2,
    women: 6,
  ),
  Discipline.speed: DisciplineData(
    color: Color(0xFFFF8438),
    name: 'Speed',
    men: 1,
    women: 5,
  ),
};

class DisciplineDisplay extends StatelessWidget {
  final bool isFemale;
  final Discipline selected;
  final Function()? onGenderPressed;
  final Function()? onPressed;
  final Function()? onLongPressed;

  const DisciplineDisplay({
    Key? key,
    required this.isFemale,
    required this.selected,
    this.onGenderPressed,
    this.onPressed,
    this.onLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: onGenderPressed,
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(),
                  ),
                  child: Icon(
                    isFemale ? Icons.female : Icons.male,
                    shadows: const [
                      Shadow(
                          offset: Offset(2, 0.7),
                          blurRadius: 10,
                          color: Colors.black12)
                    ],
                  ),
                )),
            ElevatedButton(
              onPressed: onPressed,
              onLongPress: onLongPressed,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPrimary: disciplineMapping[selected]!.color,
                fixedSize: const Size(100, 40),
              ),
              child: Text(
                disciplineMapping[selected]!.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        offset: Offset(2, 0.7),
                        blurRadius: 10,
                        color: Colors.black12)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
