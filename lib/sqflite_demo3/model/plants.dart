
class Planets {
   final int? id;
   final String name;
   final int age;
   final int distancefromsun;

  Planets({
     this.id,
    required this.name,
    required this.age,
    required this.distancefromsun,
  });

  Planets.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        name = result["name"],
        age = result["age"],
        distancefromsun = result["distancefromsun"];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'distancefromsun': distancefromsun
    };
  }
}


