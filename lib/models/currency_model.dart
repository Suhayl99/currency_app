class CurrencyModel {
  int? id;
  String? code;
  String? ccy;
  String? ccyNmRU;
  String? ccyNmUZ;
  String? ccyNmUZC;
  String? ccyNmEN;
  String? nominal;
  String? rate;
  String? diff;
  String? date;

  CurrencyModel(
      {this.id,
      this.code,
      this.ccy,
      this.ccyNmRU,
      this.ccyNmUZ,
      this.ccyNmUZC,
      this.ccyNmEN,
      this.nominal,
      this.rate,
      this.diff,
      this.date});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['Code'];
    ccy = json['Ccy'];
    ccyNmRU = json['CcyNm_RU'];
    ccyNmUZ = json['CcyNm_UZ'];
    ccyNmUZC = json['CcyNm_UZC'];
    ccyNmEN = json['CcyNm_EN'];
    nominal = json['Nominal'];
    rate = json['Rate'];
    diff = json['Diff'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['Code'] = code;
    data['Ccy'] = ccy;
    data['CcyNm_RU'] = ccyNmRU;
    data['CcyNm_UZ'] = ccyNmUZ;
    data['CcyNm_UZC'] = ccyNmUZC;
    data['CcyNm_EN'] = ccyNmEN;
    data['Nominal'] = nominal;
    data['Rate'] = rate;
    data['Diff'] = diff;
    data['Date'] = date;
    return data;
  }

  CurrencyModel copyWith({
    int? id,
    String? code,
    String? ccy,
    String? ccyNmRu,
    String? ccyNmUz,
    String? ccyNmUzc,
    String? ccyNmEn,
    String? nominal,
    String? rate,
    String? diff,
    String? date,
  }) {
    return CurrencyModel(
      id: id ?? this.id,
      code: code ?? this.code,
      ccy: ccy ?? this.ccy,
      ccyNmRU: ccyNmRu ?? ccyNmRU,
      ccyNmUZ: ccyNmUz ?? ccyNmUZ,
      ccyNmUZC: ccyNmUzc ?? ccyNmUZC,
      ccyNmEN: ccyNmEn ?? ccyNmEN,
      nominal: nominal ?? this.nominal,
      rate: rate ?? this.rate,
      diff: diff ?? this.diff,
      date: date ?? this.date,
    );
  }
}