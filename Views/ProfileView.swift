import SwiftUI
import PhotosUI

struct ProfileView: View {

    @EnvironmentObject var profile: ProfileData 

    @State private var pickerItemLogo: PhotosPickerItem?
    @State private var pickerItemSeal: PhotosPickerItem?
    @State private var pickerItemSignature: PhotosPickerItem?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                Text("Мектеп профилі")
                    .font(.title.bold())

                // ЛОГОТИП
                PhotosPicker(selection: $pickerItemLogo, matching: .images) {
                    ProfileUploadCard(title: "Логотип", image: profile.schoolLogo)
                }
                .onChange(of: pickerItemLogo) { _, newItem in
                    loadImage(from: newItem) { img in profile.schoolLogo = img }
                }

                // МӨР
                PhotosPicker(selection: $pickerItemSeal, matching: .images) {
                    ProfileUploadCard(title: "Мөр", image: profile.schoolSeal)
                }
                .onChange(of: pickerItemSeal) { _, newItem in
                    loadImage(from: newItem) { img in profile.schoolSeal = img }
                }

                // ДИРЕКТОР ҚОЛЫ
                NavigationLink(destination: SignatureCanvasView(image: $profile.directorSignature)) {
                    ProfileUploadCard(title: "Директор қолтаңбасы", image: profile.directorSignature)
                }
                
                NavigationLink {
                    TemplateDesignerView(
                        template: .constant(
                            TemplateModel(
                                name: "Custom",
                                category: "🖼 Design",
                                description: "User custom template",
                                accentColor: .blue,
                                backgroundColor: .white,
                                fontStyle: .regular,
                                logoPosition: .top,
                                backgroundImage: nil
                            )
                        )
                    )

                } label: {
                    ProfileUploadCard(title: "Шаблонды баптау", image: nil)
                }



            }
            .padding()
        }
    }

    func loadImage(from item: PhotosPickerItem?, completion: @escaping (UIImage?) -> Void) {
        Task {
            if let data = try? await item?.loadTransferable(type: Data.self) {
                completion(UIImage(data: data))
            }
        }
    }
}
