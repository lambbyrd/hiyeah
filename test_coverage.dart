import 'dart:io';

void main(List<String> args) async {
  // Determine which test to run
  String testPath = 'test/widget_test.dart';
  if (args.isNotEmpty) {
    testPath = args[0];
  }
  
  // Run tests with coverage
  print('Running Flutter tests with coverage...');
  print('Test path: $testPath');
  
  final testProcess = await Process.run(
    'flutter',
    ['test', testPath, '--coverage'],
    workingDirectory: Directory.current.path,
  );
  
  if (testProcess.exitCode != 0) {
    print('Tests failed:');
    print(testProcess.stdout);
    print(testProcess.stderr);
    exit(1);
  }
  
  print('Tests completed successfully!');
  print(testProcess.stdout);
  
  // Display coverage report in console
  print('\n=== COVERAGE REPORT ===\n');
  
  final coverageFile = File('coverage/lcov.info');
  if (await coverageFile.exists()) {
    await displayCoverageSummary('coverage/lcov.info');
  } else {
    print('Coverage file not found at coverage/lcov.info');
    exit(1);
  }
}

Future<void> displayCoverageSummary(String filePath) async {
  final file = File(filePath);
  final lines = await file.readAsLines();
  
  int totalLines = 0;
  int coveredLines = 0;
  int totalFunctions = 0;
  int coveredFunctions = 0;
  int totalBranches = 0;
  int coveredBranches = 0;
  
  Map<String, FileData> fileData = {};
  String? currentFile;
  
  for (final line in lines) {
    if (line.startsWith('SF:')) {
      currentFile = line.substring(3);
      fileData[currentFile] = FileData();
    } else if (line.startsWith('LH:')) {
      final covered = int.parse(line.substring(3));
      coveredLines += covered;
      if (currentFile != null) fileData[currentFile]!.coveredLines = covered;
    } else if (line.startsWith('LF:')) {
      final total = int.parse(line.substring(3));
      totalLines += total;
      if (currentFile != null) fileData[currentFile]!.totalLines = total;
    } else if (line.startsWith('FNH:')) {
      final covered = int.parse(line.substring(4));
      coveredFunctions += covered;
      if (currentFile != null) fileData[currentFile]!.coveredFunctions = covered;
    } else if (line.startsWith('FNF:')) {
      final total = int.parse(line.substring(4));
      totalFunctions += total;
      if (currentFile != null) fileData[currentFile]!.totalFunctions = total;
    } else if (line.startsWith('BRH:')) {
      coveredBranches += int.parse(line.substring(4));
    } else if (line.startsWith('BRF:')) {
      totalBranches += int.parse(line.substring(4));
    }
  }
  
  final linePercentage = totalLines > 0 ? (coveredLines / totalLines * 100) : 0.0;
  final functionPercentage = totalFunctions > 0 ? (coveredFunctions / totalFunctions * 100) : 0.0;
  final branchPercentage = totalBranches > 0 ? (coveredBranches / totalBranches * 100) : 0.0;
  
  print('Coverage Summary:');
  print('================');
  print('Lines:      $coveredLines/$totalLines (${linePercentage.toStringAsFixed(1)}%)');
  print('Functions:  $coveredFunctions/$totalFunctions (${functionPercentage.toStringAsFixed(1)}%)');
  if (totalBranches > 0) {
    print('Branches:   $coveredBranches/$totalBranches (${branchPercentage.toStringAsFixed(1)}%)');
  }
  
  print('\nFile Coverage Details:');
  print('=====================');
  
  // Show files with coverage
  final sortedFiles = fileData.entries.toList()
    ..sort((a, b) => b.value.percentage.compareTo(a.value.percentage));
    
  for (final entry in sortedFiles) {
    final file = entry.key;
    final data = entry.value;
    final filename = file.split('/').last;
    final percentage = data.percentage.toStringAsFixed(1);
    final coverage = '${data.coveredLines}/${data.totalLines}';
    
    // Color code based on coverage
    String status = '';
    if (data.percentage >= 80) {
      status = '✅';
    } else if (data.percentage >= 60) {
      status = '⚠️ ';
    } else {
      status = '❌';
    }
    
    print('$status $filename: $coverage ($percentage%)');
  }
  
  // Show overall grade
  print('\nOverall Grade:');
  String grade = '';
  if (linePercentage >= 90) {
    grade = '🏆 Excellent (A)';
  } else if (linePercentage >= 80) {
    grade = '✅ Good (B)';
  } else if (linePercentage >= 70) {
    grade = '⚠️  Fair (C)';
  } else if (linePercentage >= 60) {
    grade = '😐 Poor (D)';
  } else {
    grade = '❌ Needs Work (F)';
  }
  print(grade);
}

class FileData {
  int totalLines = 0;
  int coveredLines = 0;
  int totalFunctions = 0;
  int coveredFunctions = 0;
  
  double get percentage => totalLines > 0 ? (coveredLines / totalLines * 100) : 0.0;
}