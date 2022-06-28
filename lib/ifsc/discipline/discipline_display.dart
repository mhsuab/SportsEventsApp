import 'package:flutter/material.dart';

enum Discipline { general, boulder, lead, speed }

class DisciplineData {
  final Color color;
  final String name;

  const DisciplineData({required this.color, required this.name});
}

const Map<Discipline, DisciplineData> disciplineMapping = {
  Discipline.general: DisciplineData(color: Color(0xFFAA9342), name: 'General'),
  Discipline.boulder: DisciplineData(color: Color(0xFF1782BB), name: 'Boulder'),
  Discipline.lead: DisciplineData(color: Color(0xFF00C462), name: 'Lead'),
  Discipline.speed: DisciplineData(color: Color(0xFFFF8438), name: 'Speed'),
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
                  style: const TextStyle(fontWeight: FontWeight.bold, shadows: [
                    Shadow(
                        offset: Offset(2, 0.7),
                        blurRadius: 10,
                        color: Colors.black12)
                  ]),
                ))
          ],
        ));
  }
}
