import 'package:flutter/material.dart';
import 'package:movie_app/components/toastification_custom.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherUtils {
  static void openTrailer(BuildContext context, String trailerCode) async {
    if (trailerCode.isEmpty) {
      return ToastificationCustom.show(
        context,
        type: ToastificationType.error,
        title: 'No trailer available',
      );
    } else {
      final url = Uri.parse('https://www.youtube.com/watch?v=$trailerCode');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);

        if (!context.mounted) return;
      } else {
        return ToastificationCustom.show(
          context,
          type: ToastificationType.error,
          title: 'Could not open trailer',
        );
      }
    }
  }

  static void watchMovie(BuildContext context, String urlMovie) async {
    if (urlMovie.isEmpty) {
      return ToastificationCustom.show(
        context,
        type: ToastificationType.error,
        title: 'That movie is not available',
      );
    } else {
      final url = Uri.parse(urlMovie);
      if (await canLaunchUrl(url)) {
        launchUrl(url, mode: LaunchMode.externalApplication);
        if (!context.mounted) return;
      } else {
        return ToastificationCustom.show(
          context,
          type: ToastificationType.error,
          title: 'Could not open movie',
        );
      }
    }
  }
}
