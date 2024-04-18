class AddCompetitionModel {
  String imageURL;
  String title;
  String deadline;
  String prizeAndDescription;
  String place;
  String eventId;
  String eventUploadedDate;
  bool payment;

  AddCompetitionModel(
      {required this.deadline,
      required this.payment,
      required this.eventId,
      required this.eventUploadedDate,
      required this.imageURL,
      required this.place,
      required this.prizeAndDescription,
      required this.title});
  Map<String, dynamic> toJson() => {
        "imageURL": imageURL,
        "payment":payment,
        "title": title,
        "deadline": deadline,
        "prizeAndDescription": prizeAndDescription,
        "place": place,
        "id": eventId,
        "eventUploadedDate": eventUploadedDate
      };
}
