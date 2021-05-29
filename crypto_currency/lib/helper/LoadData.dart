class LoadData{
  final String id;
  final String name;
  final String symbol;
  final String slug;
  final String percent_change_1h;

  LoadData({this.id,this.name,this.symbol,this.slug,this.percent_change_1h});

  factory LoadData.fromJson(Map<String,dynamic> json){
    return LoadData(
      name: json['name'],
      symbol: json['symbol'],
      slug: json['slug'],
      percent_change_1h: json['percent_change_1h']

    );
  }

}