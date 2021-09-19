import 'dart:io';

main(List<String> args) {
  if (args.isEmpty) {
    print("Usage: dart totals.dart <inputFile.csv>");
    exit(1);
  }

  final inputFile = args.first;

  final lines = File(inputFile).readAsLinesSync();
  final totalDurationByTag = <String, double>{};

  lines.removeAt(0);

  var totalDuration = 0.0;

  for (var line in lines) {
    final values = line.split(',');
    final durationStr = values[3].replaceAll("\"", "");
    final duration = double.parse(durationStr);
    final tag = values[5].replaceAll("\"", "");
    final previousTotal = totalDurationByTag[tag];

    if (previousTotal == null) {
      totalDurationByTag[tag] = duration;
    } else {
      totalDurationByTag[tag] = previousTotal + duration;
    }

    totalDuration += duration;
  }

  for (var entry in totalDurationByTag.entries) {
    final durationFormatted = entry.value.toStringAsFixed(1);
    final tag = entry.key == '' ? 'Unallocated' : entry.key;

    print('$tag: ${durationFormatted}h');
  }

  print('Total for all tags: ${totalDuration.toStringAsFixed(1)}h');
}
