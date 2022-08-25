class ApiConst {
  static String apiKey = "10865efa2b76440a973947f6427324ae";
  static String country = "tr";
  static List<String> categories = [
    topHeadlines,
    categoryBusines,
    categoryEntertainment,
    categoryHealth,
    categoryScience,
    categoryTechnology
  ];

  static List<String> categoriesName = [
    "Haberler",
    "İş Dünyası",
    "Eğlence",
    "Sağlık",
    "Bilim",
    "Teknoloji"
  ];

  static String topHeadlines =
      "https://newsapi.org/v2/top-headlines?country=$country&category=health&apiKey=$apiKey";

  static String categoryBusines =
      "https://newsapi.org/v2/top-headlines?country=$country&category=${CategoryName.business.name}&apiKey=$apiKey";

  static String categoryEntertainment =
      "https://newsapi.org/v2/top-headlines?country=$country&category=${CategoryName.entertainment.name}&apiKey=$apiKey";

  static String categoryHealth =
      "https://newsapi.org/v2/top-headlines?country=$country&category=${CategoryName.health.name}&apiKey=$apiKey";

  static String categoryScience =
      "https://newsapi.org/v2/top-headlines?country=$country&category=${CategoryName.science.name}&apiKey=$apiKey";
  static String categoryTechnology =
      "https://newsapi.org/v2/top-headlines?country=$country&category=${CategoryName.technology.name}&apiKey=$apiKey";
}

enum CategoryName {
  business,
  entertainment,
  health,
  science,
  technology,
}
