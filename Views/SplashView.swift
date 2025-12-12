import SwiftUI

struct SplashView: View {

    @Binding var isLoggedIn: Bool
    @Binding var isRegistered: Bool

    @State private var goToAuth = false

    var body: some View {
        ZStack {
            Color("bg").ignoresSafeArea()

            Text("SchoolCert")
                .font(.largeTitle.bold())

            NavigationLink(
                destination: AuthSelectionView(isLoggedIn: $isLoggedIn,
                                               isRegistered: $isRegistered),
                isActive: $goToAuth
            ) { EmptyView() }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                goToAuth = true
            }
        }
    }
}

#Preview {
    SplashView(isLoggedIn: .constant(false),
               isRegistered: .constant(false))
}
