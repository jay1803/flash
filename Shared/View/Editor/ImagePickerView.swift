//
//  ImagePicker.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/10.
//

import SwiftUI
import UIKit
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var pickerResults: [UIImage]
    @Binding var isPresented: Bool
    private let picker: PHPickerViewController
    
    init(selectionLimit: Int, pickerResults: Binding<[UIImage]>, isPresented: Binding<Bool>) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = selectionLimit
        configuration.filter = .images
        self.picker = PHPickerViewController(configuration: configuration)
        self._pickerResults = pickerResults
        self._isPresented = isPresented
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> PHPickerViewController {
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    final class Coordinator: NSObject, PHPickerViewControllerDelegate {
        private let control: PhotoPicker
        
        init(_ control: PhotoPicker) {
            self.control = control
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { (newImage, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            self.control.pickerResults.append(newImage as! UIImage)
                        }
                    }
                } else {
                    print("Loaded Asset is not a Image")
                }
            }
            self.control.isPresented = false
        }
    }
}
