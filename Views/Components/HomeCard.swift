import SwiftUI

struct HomeCard: View {

    var title: String
    var icon: String
    var color: Color

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 34))
                .foregroundColor(color)

            Text(title)
                .font(DS.subtitle(15))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color("card"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 4)
    }
}

#Preview {
    HomeCard(title: "Test", icon: "star.fill", color: .blue)
}

