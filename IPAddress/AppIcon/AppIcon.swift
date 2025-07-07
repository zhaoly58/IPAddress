import SwiftUI

struct AppIconMain: View {
    @AppStorage("SelectedIcon") private var activeAppIcon: String = "AppIcon"
    @AppStorage("EnableAutoSwitch") private var autoSwitchEnabled: Bool = false
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var showAppearancePrompt = false
    @State private var suggestedIconName: String? = nil
    @State private var currentTimeString: String = formattedNow()
    
    private let timeDisplayTimer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private let iconSwitchTimer = Timer.publish(every: 10.0, on: .main, in: .common).autoconnect()
    
    /// icon name mapping to  Assets resource prefix
    private let customIcons: [(displayName: String, assetName: String?)] = [
        ("Default/Unsubscribe icon", nil),
        ("Blue/Subscribe icon", "AppIcon1"),
        ("Superman icon", "AppIcon2"),
        ("Black mode icon", "AppIconBlack")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                // ⏰ Current time + Auto switch on/off + Status display
                Section(header: Text("Current Time")) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(currentTimeString)
                                .font(.system(.body, design: .monospaced))
                            Spacer()
                            if autoSwitchEnabled {
                                Label("Auto Changing mode", systemImage: "arrow.triangle.2.circlepath")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        Toggle("Auto change icon (every 10 sec)\nApp must be running on the screen", isOn: $autoSwitchEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                    }
                    .padding(.vertical, 4)
                }
                
                // 📌 Subscribe / Unsubscribe
                Section {
                    HStack {
                        Button("Subscribe") {
                            switchIcon(to: "AppIcon1")
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Unsubscribe") {
                            switchIcon(to: nil)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                // 🖼️ Icon candidates
                Section(header: Text("Icon Candidates")) {
                    ForEach(customIcons, id: \.assetName) { item in
                        HStack {
                            Image(uiImage: iconPreviewImage(for: item.assetName))
                                .resizable()
                                .frame(width: 48, height: 48)
                                .cornerRadius(8)
                            
                            Text(item.displayName)
                            
                            Spacer()
                            
                            if activeAppIcon == (item.assetName ?? "AppIcon") {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            switchIcon(to: item.assetName)
                        }
                    }
                }
            }
            .navigationTitle("Change App Icon")
            .onAppear {
                evaluateIconSwitch(for: colorScheme)
            }
            .onChange(of: colorScheme) { newScheme in
                evaluateIconSwitch(for: newScheme)
            }
            .onReceive(timeDisplayTimer) { _ in
                currentTimeString = Self.formattedNow()
            }
            .onReceive(iconSwitchTimer) { _ in
                guard autoSwitchEnabled else { return }

                let availableIcons = customIcons.map(\.assetName).filter { $0 != activeAppIcon }
                if let randomIcon = availableIcons.randomElement() {
                    switchIcon(to: randomIcon)
                }
            }
            .confirmationDialog("Switch app icon for \(colorScheme == .dark ? "dark" : "light") mode?",
                                isPresented: $showAppearancePrompt,
                                titleVisibility: .visible) {
                Button("Update Icon") {
                    switchIcon(to: suggestedIconName)
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
    
    /// Current Time (Real)
    static func formattedNow() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
    
    enum AppearanceIconState {
        case lightWithDefault
        case lightWithBlack
        case darkWithDefault
        case darkWithBlack
    }
    
    func evaluateIconSwitch(for scheme: ColorScheme) {
        let state: AppearanceIconState
        
        switch (scheme, activeAppIcon) {
        case (.light, "AppIconBlack"):
            state = .lightWithBlack
        case (.light, _):
            state = .lightWithDefault
        case (.dark, "AppIconBlack"):
            state = .darkWithBlack
        case (.dark, _):
            state = .darkWithDefault
        default:
            state = .lightWithDefault
        }
        
        switch state {
        case .lightWithDefault, .darkWithBlack:
            break
        case .lightWithBlack:
            suggestedIconName = nil
            showAppearancePrompt = true
        case .darkWithDefault:
            suggestedIconName = "AppIconBlack"
            showAppearancePrompt = true
        }
    }
    
    func iconPreviewImage(for name: String?) -> UIImage {
        let previewName = name ?? "AppIcon"
        return UIImage(named: previewName) ?? UIImage(systemName: "app")!
    }
    
    func switchIcon(to name: String?) {
        let iconName = name == "AppIcon" || name == nil ? nil : name
        guard iconName != UIApplication.shared.alternateIconName else {
            return
        }
        UIApplication.shared.setAlternateIconName(iconName) { error in
            if let error = error {
                print("⚠️ Failed to switch icon: \(error.localizedDescription)")
            } else {
                activeAppIcon = name ?? "AppIcon"
                print("✅ Successfully switched to: \(name ?? "AppIcon")")
            }
        }
    }
}
