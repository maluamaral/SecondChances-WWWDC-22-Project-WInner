import SwiftUI
import AVKit

@main
struct MyApp: App {
    init() {
        try! UIFont.registerFonts(withExtension: "ttf") // Para fontes com formato ttf
    }
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                    Onboarding()
            }
            .navigationViewStyle(.stack)
            .ignoresSafeArea()
        }
    }
    
}
