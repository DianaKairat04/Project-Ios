import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var isRegistered: Bool

    @AppStorage("savedEmail") private var savedEmail = ""
    @AppStorage("savedPassword") private var savedPassword = ""

    @State private var email = ""
    @State private var password = ""
    @State private var error = ""

    var body: some View {
        VStack {

            Spacer()   // бәрін ортасына итеру

            VStack(spacing: 22) {

                // 🔵 ЛОГО
                Image("welcome_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .shadow(radius: 8)

                // 🔵 Тақырып
                Text("Қош келдіңіз !")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)

                // 🔵 Email
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)

                // 🔵 Пароль
                SecureField("Құпия сөз", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)

                // 🔴 Қате хабарлама
                if !error.isEmpty {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.subheadline)
                }

                // 🔵 Кіру батырмасы
                Button {
                    loginAction()
                } label: {
                    Text("Кіру")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                // Тіркелу сілтемесі
                NavigationLink(
                    "Тіркелу",
                    destination: RegisterView(isRegistered: $isRegistered)
                )
                .font(.footnote)
            }
            .padding(.horizontal, 28)

            Spacer()
        }
        .background(Color("bg").ignoresSafeArea())
    }

    private func loginAction() {
        error = ""

        guard !email.isEmpty, !password.isEmpty else {
            error = "Барлық өрістерді толтырыңыз"
            return
        }

        if email == savedEmail && password == savedPassword {
            isLoggedIn = true
        } else {
            error = "Email немесе құпия сөз қате"
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false), isRegistered: .constant(true))
}
