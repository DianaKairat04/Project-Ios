import SwiftUI

@main
struct SchoolCertApp: App {

    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("isRegistered") var isRegistered = false

    @StateObject private var templateStore = TemplateStore()
    @StateObject private var profileData = ProfileData()

    var body: some Scene {
        WindowGroup {
            NavigationStack {

                // 1) Егер тіркелмеген → AuthSelectionView
                if !isRegistered {
                    AuthSelectionView(isLoggedIn: $isLoggedIn,
                                      isRegistered: $isRegistered)
                }

                // 2) Егер тіркелсе, бірақ кірмесе → LoginView
                else if !isLoggedIn {
                    LoginView(isLoggedIn: $isLoggedIn,
                              isRegistered: $isRegistered)
                }

                // 3) Кірсе → HomeView
                else {
                    HomeView(isLoggedIn: $isLoggedIn)
                }
            }
            // 📌 МІНДЕТТІ! АЙНАЛДЫРМАЙ КОЮҒА БОЛМАЙДЫ!
            .environmentObject(templateStore)
            .environmentObject(profileData)
        }
    }
}
