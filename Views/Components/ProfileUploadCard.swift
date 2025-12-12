import SwiftUI

struct ProfileUploadCard: View {
    var title: String
    var image: UIImage?

    var body: some View {
        HStack {
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }

            Text(title)
                .font(.headline)

            Spacer()
        }
        .padding()
        .background(Color("card"))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

