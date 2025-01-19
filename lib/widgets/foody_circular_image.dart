import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'foody_default_shadow.dart';

class FoodyCircularImage extends StatelessWidget {
  const FoodyCircularImage({
    super.key,
    this.imageAssetPath,
    this.imageLocalPath,
    this.imageUrl,
    this.onTap,
    this.showShadow = true,
    this.size = 80,
    this.padding = 15,
    this.defaultWidget,
  }) : assert(
          (imageAssetPath != null ? 1 : 0) +
                  (imageLocalPath != null ? 1 : 0) +
                  (imageUrl != null ? 1 : 0) <=
              1,
          'You cannot set imageAssetPath, imageLocalPath and imageUrl at the same time',
        );

  final String? imageAssetPath;
  final String? imageLocalPath;
  final String? imageUrl;
  final void Function()? onTap;
  final bool showShadow;
  final double size;
  final double padding;
  final Widget? defaultWidget;

  final double bottomRightIconSize = 24;

  @override
  Widget build(BuildContext context) {
    Widget inkWell([Widget? child]) => InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap != null
              ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onTap!.call();
                }
              : null,
          child: child,
        );

    Widget inkWellInOverlay() => Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: inkWell(),
          ),
        );

    Widget circularImage(image) => ClipOval(
          child: Stack(
            children: [
              image,
              inkWellInOverlay(),
            ],
          ),
        );

    Widget defaultAvatarContainer() => Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor.withOpacity(0.2),
          ),
          width: size,
          height: size,
          child: defaultWidget ??
              Image.asset(
                'assets/images/user.png',
                color: Theme.of(context).primaryColor,
              ),
        );

    Widget defaultAvatar() => inkWell(defaultAvatarContainer());

    Widget assetAvatar() => circularImage(
          Image.asset(
            imageAssetPath!,
            fit: BoxFit.cover,
            width: size,
            height: size,
          ),
        );

    Widget localAvatar() => circularImage(
          Image.file(
            File(imageLocalPath!),
            fit: BoxFit.cover,
            width: size,
            height: size,
          ),
        );

    Widget remoteAvatar() => circularImage(
          CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 300),
            fadeOutDuration: const Duration(milliseconds: 300),
            imageUrl: imageUrl!,
            fit: BoxFit.cover,
            width: size,
            height: size,
            placeholder: (_, __) => defaultAvatarContainer(),
            errorWidget: (_, __, ___) => defaultAvatarContainer(),
          ),
        );

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(showShadow ? 10 : 0),
        child: Ink(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
            boxShadow: showShadow ? foodyDefaultShadow() : null,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              imageAssetPath == null &&
                      imageLocalPath == null &&
                      imageUrl == null
                  ? defaultAvatar()
                  : imageAssetPath != null
                      ? assetAvatar()
                      : imageUrl == null
                          ? localAvatar()
                          : remoteAvatar(),
              if (onTap != null)
                Positioned(
                  top: (size / 2) * (1 + 1 / sqrt(2)) - 14.5,
                  left: (size / 2) * (1 + 1 / sqrt(2)) - 14.5,
                  child: inkWell(
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        PhosphorIconsRegular.camera,
                        size: bottomRightIconSize,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
