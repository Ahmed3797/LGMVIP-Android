class District {
  late String? notes, stateName;

  late int? active, confirmed, migratedother, deceased, recovered;
  late int? Deltaconfirmed, Deltadeceased, Deltarecovered;

  District.fromjson(Map<String, dynamic> obj, var data) {
    notes = obj["notes"];
    active = obj["active"];
    confirmed = obj["confirmed"];
    migratedother = obj["migratedother"];
    deceased = obj["deceased"];
    recovered = obj["recovered"];
    stateName = data;
    Deltaconfirmed = obj["delta"]["confirmed"];
    Deltadeceased = obj["delta"]["deceased"];
    Deltarecovered = obj["delta"]["recovered"];
  }
}
