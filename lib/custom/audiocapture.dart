import 'dart:ffi';
import 'dart:typed_data';

typedef StartAudioCaptureNative = Void Function();
typedef StopAudioCaptureNative = Void Function();
typedef GetAudioDataNative = Int32 Function(Pointer<Float>, Int32);

class AudioCapture {
  late DynamicLibrary _lib;
  late void Function() startAudioCapture;
  late void Function() stopAudioCapture;
  late int Function(Pointer<Float>, int) _getAudioData;

  /// Creates a new instance of [AudioCapture].
  /// Warns: This constructor is in beta and might change in the future.
  AudioCapture() {
    // if (Platform.isWindows) {
    //   _lib = DynamicLibrary.open(
    //       "D:/Documents/GitHub/audioplayer/Debug/audioplayer.dll");
    // } else if (Platform.isMacOS) {
    //   _lib = DynamicLibrary.open('path_to_your_dylib.dylib');
    // }
  }

  void start() {
    // startAudioCapture();
  }

  void stop() {
    // stopAudioCapture();
  }

  bool getAudioData(Float32List buffer) {
    // final Pointer<Float> bufferPtr = calloc<Float>(buffer.length);
    // final int result = _getAudioData(bufferPtr, buffer.length);
    // if (result != 0) {
    //   for (int i = 0; i < buffer.length; i++) {
    //     buffer[i] = bufferPtr[i];
    //   }
    //   calloc.free(bufferPtr);
    //   return true;
    // } else {
    //   calloc.free(bufferPtr);
    return false;
    // }
  }
}
