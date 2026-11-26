class Review {
  const Review({
    required this.rating,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
    this.comment,
  });

  final int rating;
  final String? comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    rating: (json['rating'] as num).toInt(),
    date: json['date'] as String,
    reviewerName: json['reviewerName'] as String,
    reviewerEmail: json['reviewerEmail'] as String,
    comment: json['comment'] as String?,
  );
}
