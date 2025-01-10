class People {
  People({
    this.id,
    this.name,
    this.email,
    this.imagePath,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? imagePath;

  @override
  String toString() {
    // TODO: implement toString
    return 'Id: $id, Name: $name, E-Mail: $email';
  }
}
