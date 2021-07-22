class Recommended {
  String date;
  String time;
  String imgUrl;
  String name;
  String category;
  String ageRestriction;

  Recommended(
      {this.imgUrl,
      this.name,
      this.category,
      this.ageRestriction,
      this.date,
      this.time});
}

List<Recommended> recommendedMovies = [
  Recommended(
      date: '03 Sep',
      time: '90min',
      imgUrl: 'assets/apples.jpg',
      name: 'Red Apples',
      category: '4,754.55',
      ageRestriction: 'A bunch of red apples'),
  Recommended(
      date: '03 Sep',
      time: '90min',
      imgUrl: 'assets/orange.png',
      name: 'Oranges',
      category: '8,754.55',
      ageRestriction: 'Just an orange lol'),
  Recommended(
      date: '03 Sep',
      time: '90min',
      imgUrl: 'assets/signup.png',
      name: 'Logo',
      category: 'Animation',
      ageRestriction: '0.0'),
];
