//
//  ContentView.swift
//  CameraTutorialApp
//
//  Created by Ilmari Lehmusjärvi on 14.2.2022.
//

import SwiftUI

struct ContentView: View {
    @State var showActionSheet:Bool = false
    @State var showImagePicker:Bool = false
    @State var image:Image?
    @State var sourceType:Int = 0
    
    var body: some View {
        VStack{
            image?
                .resizable()
                .clipped()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 160)
            Text("Käytä kameraa nappulasta!")
                .overlay(
                    CameraButtonView(showActionSheet: $showActionSheet)
                        .offset(x: 0, y: 30)
                )
                .actionSheet(isPresented: $showActionSheet, content: {
    () -> ActionSheet in ActionSheet(title: Text("Select Image"), message: Text("Please select an image from the image gallery or use the camera"), buttons: [
        ActionSheet.Button.default(Text("Camera"), action: {
            self.sourceType = 0
            
        }),
        ActionSheet.Button.default(Text("Photo Gallery"), action: {
            self.sourceType = 1
            self.showImagePicker.toggle()
            
        }),
        ActionSheet.Button.cancel()
    ])
                    
                })
            
            if showImagePicker {
                ImagePicker(isVisibile: $showImagePicker, image: $image, sourceType: sourceType)
            }
        }
        .onAppear {self.image = image}

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

