class Student {
  final int? id;
  final String name;
  // final String fatherName;
  // final String motherName;
  // final String mobile;
  // final String age;
  // final String image;

  Student({
    this.id,
    required this.name,
    // required this.fatherName,
    // required this.motherName,
    // required this.mobile,
    // required this.age,
    // required this.image,
  });


  factory Student.fromJson(Map<String,dynamic> json){

    return Student(
        id: json['id'],
        name: json['name'],
        // fatherName: json['father_name'],
        // motherName: json['mother_name'],
        // mobile: json['mobile'],
        // age: json['age'],
        // image: json['image'],
    );
  }


  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'name':name,
      // 'father_name':fatherName,
      // 'mother_name':motherName,
      // 'mobile':mobile,
      // 'age':age,
      // 'image':image,


    };
  }

}
