import SwiftUI

struct AuthSelectionView: View {

    @Binding var isLoggedIn: Bool
    @Binding var isRegistered: Bool

    var body: some View {
        VStack {

            Spacer()   // экран ортасына итереді

            VStack(spacing: 24) {

                // 🔵 ЛОГО — "Қош келдіңіз!" үстінде
                Image("welcome_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .shadow(radius: 8)

                // 🔵 Тақырып
                Text("Қош келдіңіз!")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)

                // 🔵 КІРУ
                NavigationLink {
                    LoginView(isLoggedIn: $isLoggedIn,
                              isRegistered: $isRegistered)
                } label: {
                    Text("Кіру")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                // 🔵 ТІРКЕЛУ
                NavigationLink {
                    RegisterView(isRegistered: $isRegistered)
                } label: {
                    Text("Тіркелу")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(12)
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal, 28)

            Spacer()   // экран ортасына итереді
        }
        .background(Color("bg").ignoresSafeArea())
    }
}

#Preview {
    AuthSelectionView(
        isLoggedIn: .constant(false),
        isRegistered: .constant(false)
    )
}
