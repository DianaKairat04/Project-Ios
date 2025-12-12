import SwiftUI
import PhotosUI

struct ImagePicker: View {

    @Binding var image: UIImage?

    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: 140)

                if let img = image {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                } else {
                    VStack {
                        Image(systemName: "photo")
                            .font(.system(size: 32))
                        Text("Мөр жүктеу")
                    }
                    .foregroundColor(.gray)
                }
            }
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    image = uiImage
                }
            }
        }
    }
}

