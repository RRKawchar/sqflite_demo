class Student {
  final int? id;
  final String name;
  final int age;
   final double grade;
  // final String mobile;
  // final String age;
  // final String image;

  Student({
    this.id,
    required this.name,
     required this.age,
     required this.grade,
    // required this.mobile,
    // required this.age,
    // required this.image,
  });


  factory Student.fromJson(Map<dynamic,dynamic> json){

    return Student(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        grade: json['grade'],
        // mobile: json['mobile'],
        // age: json['age'],
        // image: json['image'],
    );
  }


  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'name':name,
      'age':age,
      'grade':grade,
      // 'mobile':mobile,
      // 'age':age,
      // 'image':image,


    };
  }

}
