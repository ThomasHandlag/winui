import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

typedef StartAudioCaptureNative = Void Function();
typedef StopAudioCaptureNative = Void Function();
typedef GetAudioDataNative = Int32 Function(Pointer<Float>, Int32);

class AudioCapture {
  late DynamicLibrary _lib;
  late void Function() startAudioCapture;
  late void Function() stopAudioCapture;
  late int Function(Pointer<Float>, int) _getAudioData;

  AudioCapture() {
    if (Platform.isWindows) {
      _lib = DynamicLibrary.open('D:/Documents/GitHub/audiocapture/x64/Debug/audiocapture.dll');
    } 
    // else if (Platform.isMacOS) {
    //   _lib = DynamicLibrary.open('path_to_your_dylib.dylib');
    // }

    startAudioCapture = _lib
        .lookup<NativeFunction<Void Function()>>('StartAudioCapture')
        .asFunction();
    stopAudioCapture = _lib
        .lookup<NativeFunction<Void Function()>>('StopAudioCapture')
        .asFunction();
    _getAudioData = _lib
        .lookup<NativeFunction<Int32 Function(Pointer<Float>, Int32)>>('GetAudioData')
        .asFunction();
  }

  void start() {
    startAudioCapture();
  }

  void stop() {
    stopAudioCapture();
  }

  bool getAudioData(Float32List buffer) {
    final Pointer<Float> bufferPtr = calloc<Float>(buffer.length);
    final int result = _getAudioData(bufferPtr, buffer.length);
    if (result != 0) {
      for (int i = 0; i < buffer.length; i++) {
        buffer[i] = bufferPtr[i];
      }
      calloc.free(bufferPtr);
      return true;
    } else {
      calloc.free(bufferPtr);
      return false;
    }
  }
}
