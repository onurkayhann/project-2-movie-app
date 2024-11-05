import Foundation
import FirebaseFirestore
import FirebaseStorage
import AVFoundation

class AudioManager: ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
    @Published var isRecording = false
    private var audioFilename: URL?

    // Request microphone access
    func requestMicrophoneAccess(completion: @escaping (Bool) -> Void) {
        let audioSession = AVAudioSession.sharedInstance()
        switch audioSession.recordPermission {
        case .granted:
            completion(true)
        case .denied:
            completion(false)
        case .undetermined:
            audioSession.requestRecordPermission { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        default:
            completion(false)
        }
    }

    // Start recording audio
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        switch audioSession.recordPermission {
        case .granted:
            beginRecording()
        case .denied:
            print("Microphone access denied")
        case .undetermined:
            audioSession.requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.beginRecording()
                    } else {
                        print("Microphone access denied by user")
                    }
                }
            }
        @unknown default:
            break
        }
    }

    private func beginRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let id = UUID().uuidString
            audioFilename = documentsDirectory.appendingPathComponent("comment-\(id).m4a")
            
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioFilename!, settings: settings)
            audioRecorder?.record()
            isRecording = true
            print("Recording started, saving to: \(audioFilename!.path)")
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }

    // Stop recording audio
    func stopRecording() -> URL? {
        audioRecorder?.stop()
        isRecording = false
        let recordedURL = audioFilename
        print("Recording stopped. File saved at: \(recordedURL?.path ?? "No URL")")
        return recordedURL
    }

    // Play audio from a URL
    func playAudio(url: URL) {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                print("Audio is playing successfully.")
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        } else {
            print("File does not exist at path: \(url.path)")
        }
    }
}
