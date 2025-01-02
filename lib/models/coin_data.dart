class CoinData {
  int? id;
  String? key;
  String? symbol;
  String? name;
  String? type;
  num? rank;
  int? categoryId;
  int? lastUpdated;
  String? totalSupply;
  String? maxSupply;
  String? circulatingSupply;
  String? volume24hBase;
  Images? images;
  String? price;
  String? high24h;
  String? low24h;
  String? volume24h;
  String? marketCap;
  String? fullyDilutedValuation;
  ATH? ath;
  ATL? atl;
  PercentChange? percentChange;
  String? sparkline7d;

  CoinData({
    this.id,
    this.key,
    this.symbol,
    this.name,
    this.type,
    this.rank,
    this.categoryId,
    this.lastUpdated,
    this.totalSupply,
    this.maxSupply,
    this.circulatingSupply,
    this.volume24hBase,
    this.images,
    this.price,
    this.high24h,
    this.low24h,
    this.volume24h,
    this.marketCap,
    this.fullyDilutedValuation,
    this.ath,
    this.atl,
    this.percentChange,
    this.sparkline7d,
  });

  CoinData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    symbol = json['symbol'];
    name = json['name'];
    type = json['type'];
    rank = json['rank'];
    categoryId = json['categoryId'];
    lastUpdated = json['lastUpdated'];
    totalSupply = json['totalSupply'];
    maxSupply = json['maxSupply'];
    circulatingSupply = json['circulatingSupply'];
    volume24hBase = json['volume24hBase'];
    images = json['images'] != null ? Images.fromJson(json['images']) : null;
    price = json['price'];
    high24h = json['high24h'];
    low24h = json['low24h'];
    volume24h = json['volume24h'];
    marketCap = json['marketCap'];
    fullyDilutedValuation = json['fullyDilutedValuation'];
    ath = json['ath'] != null ? ATH.fromJson(json['ath']) : null;
    atl = json['atl'] != null ? ATL.fromJson(json['atl']) : null;
    percentChange = json['percentChange'] != null
        ? PercentChange.fromJson(json['percentChange'])
        : null;
    sparkline7d = json['sparkline7d'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['symbol'] = symbol;
    data['name'] = name;
    data['type'] = type;
    data['rank'] = rank;
    data['categoryId'] = categoryId;
    data['lastUpdated'] = lastUpdated;
    data['totalSupply'] = totalSupply;
    data['maxSupply'] = maxSupply;
    data['circulatingSupply'] = circulatingSupply;
    data['volume24hBase'] = volume24hBase;
    if (images != null) data['images'] = images!.toJson();
    data['price'] = price;
    data['high24h'] = high24h;
    data['low24h'] = low24h;
    data['volume24h'] = volume24h;
    data['marketCap'] = marketCap;
    data['fullyDilutedValuation'] = fullyDilutedValuation;
    if (ath != null) data['ath'] = ath!.toJson();
    if (atl != null) data['atl'] = atl!.toJson();
    if (percentChange != null) data['percentChange'] = percentChange!.toJson();
    data['sparkline7d'] = sparkline7d;
    return data;
  }
}

class Images {
  String? native;
  String? icon;
  String? x60;
  String? x150;

  Images({this.native, this.icon, this.x60, this.x150});

  Images.fromJson(Map<String, dynamic> json) {
    native = json['native'];
    icon = json['icon'];
    x60 = json['x60'];
    x150 = json['x150'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['native'] = native;
    data['icon'] = icon;
    data['x60'] = x60;
    data['x150'] = x150;
    return data;
  }
}

class ATH {
  int? date;
  String? value;
  String? percentChange;

  ATH({this.date, this.value, this.percentChange});

  ATH.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    value = json['value'];
    percentChange = json['percentChange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['value'] = value;
    data['percentChange'] = percentChange;
    return data;
  }
}

class ATL {
  int? date;
  String? value;
  String? percentChange;

  ATL({this.date, this.value, this.percentChange});

  ATL.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    value = json['value'];
    percentChange = json['percentChange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['value'] = value;
    data['percentChange'] = percentChange;
    return data;
  }
}

class PercentChange {
  String? h24;
  String? d7;
  String? d30;
  String? m3;
  String? m6;

  PercentChange({this.h24, this.d7, this.d30, this.m3, this.m6});

  PercentChange.fromJson(Map<String, dynamic> json) {
    h24 = json['h24'];
    d7 = json['d7'];
    d30 = json['d30'];
    m3 = json['m3'];
    m6 = json['m6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h24'] = h24;
    data['d7'] = d7;
    data['d30'] = d30;
    data['m3'] = m3;
    data['m6'] = m6;
    return data;
  }
}
