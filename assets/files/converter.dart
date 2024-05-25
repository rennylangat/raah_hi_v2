import 'dart:convert';
import 'dart:io';

void main() async {
  // Load the provided JSON data from a file
  final file = File(
      '/Users/renny/Desktop/personal/raa_hi_v2/raah_hi_v2/assets/files/mountainData.json');
  final contents = await file.readAsString();
  final data = jsonDecode(contents) as List;

  // Function to convert the given JSON format to the desired format
  Map<String, dynamic> convertJson(
      Map<String, dynamic> mountain, int idCounter) {
    String randId = idCounter < 10 ? "$idCounter$idCounter" : "$idCounter";
    return {
      'id': idCounter,
      'name': mountain['name'] ?? '',
      'images': [
        'http://picsum.photos/7$randId',
        'http://picsum.photos/800',
        'http://picsum.photos/900',
      ],
      'location': mountain['location'] ?? '',
      'rating': 4.9, // Adding a default rating
      'starred': false, // Adding a default starred value
      'description': mountain['description'] ?? '',
      'altitude': mountain['altitude'] ?? '',
      'has_death_zone': mountain['has_death_zone'] ?? false,
      'first_climber': mountain['first_climber'] ?? '',
      'first_climbed_date': mountain['first_climbed_date'] ?? '',
      'country_flag_img': 'http://picsum.photos/200',
    };
  }

  // Initialize the result list and id counter
  final result = <Map<String, dynamic>>[];
  int idCounter = 1;

  // Convert each mountain in the original data
  for (var mountain in data) {
    result.add(convertJson(mountain, idCounter));
    idCounter += 1;
  }

  // Save the result to a JSON file
  const convertedFilePath =
      '/Users/renny/Desktop/personal/raa_hi_v2/raah_hi_v2/assets/files/converted_mountainData.json';
  final convertedFile = File(convertedFilePath);
  await convertedFile.writeAsString(jsonEncode(result), mode: FileMode.write);

  print('Converted JSON saved to $convertedFilePath');
}
