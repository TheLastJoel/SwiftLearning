//
//  AsyncLetBootcamp5.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Joel Bearn on 30/09/2022.
//

import SwiftUI

struct AsyncLetBootcamp5: View {
    
    @State private var images: [UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let url = URL(string: "https://picsum.photos/1000")!
    
    var body: some View {
        NavigationView{
            ZStack{
                if images.count == 0 {
                    ProgressView()
                }
                else{
                    ScrollView{
                        LazyVGrid(columns: columns) {

                                ForEach(images, id: \.self){ image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                }

                        }
                    }
                }
            }
            .navigationTitle("Async let 🥳")
            .onAppear{
                /*
                Task{
                    do{
                        let image1 = try await fetchImage()
                        self.images.append(image1)
                        let image2 = try await fetchImage()
                        self.images.append(image2)
                        
                    } catch{
                        
                    }
                }
                
                Task{
                    do{
                        let image3 = try await fetchImage()
                        self.images.append(image3)
                        let image4 = try await fetchImage()
                        self.images.append(image4)
                    } catch{
                        
                    }
                }
                 */
                
                Task{
                    
                    
                    do{
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                        async let fetchImage1 = fetchImage()
//                        async let fetchTitle1 = fetchTitle()
//
//                        let (image, title) = await(try fetchImage1,fetchTitle1)
                        
                        async let fetchImage2 = fetchImage()
                        async let fetchImage3 = fetchImage()
                        async let fetchImage4 = fetchImage()

                        let (image1,image2,image3,image4) = await (try fetchImage1,try fetchImage2,try fetchImage3,try fetchImage4)

                        self.images.append(contentsOf: [image1,image2,image3,image4])
                        
                    } catch{
                        
                    }
                }
            }
        }
    }
    
    func fetchImage() async throws -> UIImage{
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            if let image = UIImage(data: data){
                return image
            }
            else{
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
    
    func fetchTitle() async -> String{
        return "NEW TITLE"
    }
    
}

struct AsyncLetBootcamp5_Previews: PreviewProvider {
    static var previews: some View {
        AsyncLetBootcamp5()
    }
}
