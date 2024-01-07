import 'package:flutter/material.dart';

/* ****  PHOTO ***** */
// Image de l'Photo
const imageEiffel = AssetImage('assets/images/eiffel.jpg');
const imagePise = AssetImage('assets/images/pise.jpg');
const imageBigBen = AssetImage('assets/images/bigben.jpg');
const imageDcTower = AssetImage('assets/images/dctower.png');
const imageFern = AssetImage('assets/images/fernsehturm.jpg');
const imageAtomium = AssetImage('assets/images/atomium.jpg');
const imagePrimeTower = AssetImage('assets/images/primetower.jpg');
// Decoration de l'image
const decorationImageEiffel = DecorationImage(
  image: imageEiffel,
  fit: BoxFit.cover,
);
const decorationImagePise = DecorationImage(
  image: imagePise,
  fit: BoxFit.cover,
);
const decorationImageBigBen = DecorationImage(
  image: imageBigBen,
  fit: BoxFit.cover,
);
const decorationImagePrimeTower = DecorationImage(
  image: imagePrimeTower,
  fit: BoxFit.cover,
);
const decorationImageAtomium = DecorationImage(
  image: imageAtomium,
  fit: BoxFit.cover,
);
const decorationImageFern = DecorationImage(
  image: imageFern,
  fit: BoxFit.cover,
);
const decorationImageDcTower = DecorationImage(
  image: imageDcTower,
  fit: BoxFit.cover,
);
// Decoration des Photos
const decoPhotoEiffel = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImageEiffel,
);
const decoPhotoPise = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImagePise,
);
const decoPhotoBigBen = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImageBigBen,
);
const decoPhotoPrimeTower = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImagePrimeTower,
);
const decoPhotoAtomium = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImageAtomium,
);
const decoPhotoFern = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImageFern,
);
const decoPhotoDcTower = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImageDcTower,
);
