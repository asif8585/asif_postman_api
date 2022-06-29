// To parse this JSON data, do
//
//     final postModal = postModalFromJson(jsonString);

import 'dart:convert';

@override
String toString() {
  return 'PostOffice{PostOffice:$PostOffice}';
}

List<PostModal> postModalFromJson(String str) =>
    List<PostModal>.from(json.decode(str).map((x) => PostModal.fromJson(x)));

String postModalToJson(List<PostModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModal {
  PostModal({
    this.message,
    this.status,
    this.postOffice,
  });

  String? message;
  String? status;
  List<PostOffice>? postOffice;

  factory PostModal.fromJson(Map<dynamic, dynamic> json) => PostModal(
        message: json["Message"],
        status: json["Status"],
        postOffice: List<PostOffice>.from(
            json["PostOffice"].map((x) => PostOffice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Status": status,
        "PostOffice": List<dynamic>.from(postOffice!.map((x) => x.toJson())),
      };
}

class PostOffice {
  PostOffice({
    this.name,
    this.description,
    this.branchType,
    this.deliveryStatus,
    this.circle,
    this.district,
    this.division,
    this.region,
    this.block,
    this.state,
    this.country,
    this.pincode,
  });

  String? name;
  BranchType? branchType;
  dynamic description;
  DeliveryStatus? deliveryStatus;
  Block? circle;
  District? district;
  Division? division;
  Block? region;
  Block? block;
  Block? state;
  Country? country;
  String? pincode;

  factory PostOffice.fromJson(Map<dynamic, dynamic> json) => PostOffice(
        name: json["Name"],
        description: json["Description"],
        branchType: branchTypeValues.map[json["BranchType"]],
        deliveryStatus: deliveryStatusValues.map[json["DeliveryStatus"]],
        circle: blockValues.map[json["Circle"]],
        district: districtValues.map[json["District"]],
        division: divisionValues.map[json["Division"]],
        region: blockValues.map[json["Region"]],
        block: blockValues.map[json["Block"]],
        state: blockValues.map[json["State"]],
        country: countryValues.map[json["Country"]],
        pincode: json["Pincode"],
      );

  Map<dynamic, dynamic> toJson() => {
        "Name": name,
        "Description": description,
        "BranchType": branchTypeValues.reverse[branchType],
        "DeliveryStatus": deliveryStatusValues.reverse[deliveryStatus],
        "Circle": blockValues.reverse[circle],
        "District": districtValues.reverse[district],
        "Division": divisionValues.reverse[division],
        "Region": blockValues.reverse[region],
        "Block": blockValues.reverse[block],
        "State": blockValues.reverse[state],
        "Country": countryValues.reverse[country],
        "Pincode": pincode,
      };
}

enum Block { DELHI }

final blockValues = EnumValues({"Delhi": Block.DELHI});

enum BranchType { BRANCH_POST_OFFICE, SUB_POST_OFFICE }

final branchTypeValues = EnumValues({
  "Branch Post Office": BranchType.BRANCH_POST_OFFICE,
  "Sub Post Office": BranchType.SUB_POST_OFFICE
});

enum Country { INDIA }

final countryValues = EnumValues({"India": Country.INDIA});

enum DeliveryStatus { DELIVERY }

final deliveryStatusValues = EnumValues({"Delivery": DeliveryStatus.DELIVERY});

enum District { NORTH_WEST_DELHI }

final districtValues =
    EnumValues({"North West Delhi": District.NORTH_WEST_DELHI});

enum Division { DELHI_NORTH }

final divisionValues = EnumValues({"Delhi North": Division.DELHI_NORTH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
