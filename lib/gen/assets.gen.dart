/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Icon.png
  AssetGenImage get icon => const AssetGenImage('assets/images/Icon.png');

  /// File path: assets/images/Illustration.png
  AssetGenImage get illustration =>
      const AssetGenImage('assets/images/Illustration.png');


  /// File path: assets/images/quizcompleted.png
  AssetGenImage get quizcompleted =>
      const AssetGenImage('assets/images/quizcompleted.png');

  /// File path: assets/images/quizdetail.png
  AssetGenImage get quizdetail =>
      const AssetGenImage('assets/images/quizdetail.png');

  /// File path: assets/images/review.png
  AssetGenImage get review => const AssetGenImage('assets/images/review.png');


  /// File path: assets/images/trueorfalse.png
  AssetGenImage get trueorfalse =>
      const AssetGenImage('assets/images/trueorfalse.png');

  AssetGenImage get profile  =>
      const AssetGenImage('assets/images/profile.png');


   AssetGenImage get boyicon  =>
      const AssetGenImage('assets/images/boy.png');          

   AssetGenImage get workonit  =>
      const AssetGenImage('assets/images/workonit.png'); 

  
  
       /// File path: assets/images/icon5.png
   AssetGenImage get icon5 => const AssetGenImage('assets/images/icon5.png');

  /// File path: assets/images/icon6.png
   AssetGenImage get cardimage4 =>
      const AssetGenImage('assets/images/cardimage4.png'); AssetGenImage get icon6 => const AssetGenImage('assets/images/icon6.png');
   AssetGenImage get vector  =>
      const AssetGenImage('assets/images/Vector.png');  
   AssetGenImage get profileicon  =>
      const AssetGenImage('assets/images/profileicon.png');  
      
   AssetGenImage get emailicon  =>
      const AssetGenImage('assets/images/message.png');  
     
   AssetGenImage get questionicon  =>
      const AssetGenImage('assets/images/questionicon.png');

   AssetGenImage get lockicon  =>
      const AssetGenImage('assets/images/lockicon.png');     


    AssetGenImage get Appicon1  =>
      const AssetGenImage('assets/images/appicon1.png');

  

  /// List of all assets
  List<AssetGenImage> get values => [
        icon,
        illustration,
        // avatar,
        quizcompleted,
        quizdetail,
        vector,
        icon5,
        icon6,
        cardimage4,
        review,
        profileicon,
        trueorfalse,
        profile,
        boyicon,
        // workonit,
     
        questionicon,
        lockicon,
        Appicon1,
   
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
