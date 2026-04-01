class MediaUtils {
  static bool isVideoUrl(String url) {
    final lower = url.toLowerCase();
    return lower.contains("youtube.com") ||
        lower.contains("youtu.be") ||
        lower.contains("vimeo");
  }

  static bool isAudioUrl(String url) {
    final lower = url.toLowerCase();
    return lower.endsWith(".mp3") ||
        lower.endsWith(".aac") ||
        lower.endsWith(".m4a") ||
        lower.endsWith(".wav") ||
        lower.endsWith(".ogg") ||
        lower.endsWith(".mp4") || 
        lower.contains(".mp3?") ||
        lower.contains("audio");
  }
}