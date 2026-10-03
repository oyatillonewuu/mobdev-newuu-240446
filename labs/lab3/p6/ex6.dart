enum ImageEncoding { jpg, jpeg, png, svg }

class ImageInfo {
  final String imageId;
  final String imageHash;
  final String imageName;
  final ImageEncoding imageEncoding;

  const new(this.imageId, this.imageHash, this.imageName, this.imageEncoding);
}

void main() {
  ImageInfo i = ImageInfo(
    "imageid",
    "imagehash",
    "Some fancy name",
    ImageEncoding.png,
  );
}
