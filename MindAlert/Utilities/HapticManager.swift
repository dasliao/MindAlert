import CoreHaptics
import Foundation

@MainActor
final class HapticManager: ObservableObject {
    static let shared = HapticManager()

    private var engine: CHHapticEngine?

    private init() {
        prepareEngine()
    }

    private func prepareEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            engine?.playsHapticsOnly = true
            engine?.isAutoShutdownEnabled = false
            try engine?.start()
        } catch {
            print("HapticManager: Failed to start engine — \(error)")
        }
    }

    /// Plays the 3-second countdown haptic (gradient_haptic.json) during panic button hold.
    func playGradientHaptic() {
        play(ahapNamed: "gradient_haptic")
    }

    /// Plays the long plan-activated haptic (long_haptic.json) when safety plan triggers.
    func playLongHaptic() {
        play(ahapNamed: "long_haptic")
    }

    func stopHaptic() {
        engine?.stop(completionHandler: nil)
        prepareEngine()
    }

    private func play(ahapNamed name: String) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            print("HapticManager: AHAP file '\(name).json' not found in bundle")
            return
        }
        if engine == nil { prepareEngine() }
        guard let engine else { return }
        do {
            try engine.start()
            try engine.playPattern(from: url)
        } catch {
            print("HapticManager: Failed to play '\(name)' — \(error)")
        }
    }
}
