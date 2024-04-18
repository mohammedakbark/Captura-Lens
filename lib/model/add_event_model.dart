class AddEventModel {
  String imageURL;
  String title;
  String deadline;
  String prizeAndDescription;
  String place;
  String eventId;
  String eventUploadedDate;

  AddEventModel(
      {required this.deadline,
      required this.eventId,
      required this.eventUploadedDate,
      required this.imageURL,
      required this.place,
      required this.prizeAndDescription,
      required this.title});
  Map<String, dynamic> toJson() => {
        "imageURL": imageURL,
        "title": title,
        "deadline": deadline,
        "prizeAndDescription": prizeAndDescription,
        "place": place,
        "id": eventId
        ,"eventUploadedDate":eventUploadedDate
      };
}
