import SwiftUI

struct RegisterView: View {
    @Binding var isRegistered: Bool

    @AppStorage("savedEmail") private var savedEmail = ""
    @AppStorage("savedPassword") private var savedPassword = ""

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var error = ""
    @State private var showAlert = false

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            Spacer().frame(height: 20)

            Text("Тіркелу")
                .font(.title.bold())

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)

            SecureField("Құпия сөз", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)

            SecureField("Құпия сөзді қайталаңыз", text: $confirmPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)

            if !error.isEmpty {
                Text(error).foregroundColor(.red).font(.subheadline)
            }

            Button {
                registerAction()
            } label: {
                Text("Тіркелу")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .alert("Сәтті тіркелді", isPresented: $showAlert) {
            Button("Жарайды") {
                // белгілеу: тіркелген = true
                isRegistered = true
                // Optional: жоғарғы Navigation стекке шығып таста
                dismiss()
            }
        } message: {
            Text("Енді логин арқылы кіре аласыз.")
        }
    }

    private func registerAction() {
        error = ""

        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty else {
            error = "Барлық өрістерді толтырыңыз"
            return
        }

        guard password == confirmPassword else {
            error = "Құпия сөздер сәйкес емес"
            return
        }

        // қысқа валидация email
        guard email.contains("@") else {
            error = "Дұрыс email енгізіңіз"
            return
        }

        // сақтау (қазіргі мысалда AppStorage)
        savedEmail = email
        savedPassword = password

        // көрсетілетін alert және App-level флагты true қыламыз
        showAlert = true
    }
}

#Preview {
    RegisterView(isRegistered: .constant(false))
}
