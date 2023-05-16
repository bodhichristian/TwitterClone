//
//  ImagePicker.swift
//  TwitterClone
//
//  Created by christian on 4/25/23.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage? // Stores user-selected image
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker // Reference to parent ImagePicker
        
        init(_ parent: ImagePicker) { // Initialize with reference
            self.parent = parent
        }
        
        // Delegate method called when the user finishes picking images
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Dismiss picker view controller
            picker.dismiss(animated: true)
            // Retrieve the first selected item provider
            guard let provider = results.first?.itemProvider else { return }
            // Check if item provider tcan load UIImage objects
            if provider.canLoadObject(ofClass: UIImage.self) {
                // Load the UIImage object from the item provider
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    // Set the parent's image property to the loaded image
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    // Creates and configures the PHPickerViewController
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images // Image selection filter
        
        // Create a new instance of PHPickerViewController with the configuration
        let picker = PHPickerViewController(configuration: config)
        // Set the delegate to the coordinator
        picker.delegate = context.coordinator
        // Return configured picker
        return picker
    }
    
    // Updates the PHPickerViewController
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // No implementation needed
    }
    // Creates and returns the coordinator object for this ImagePicker instance
    func makeCoordinator() -> Coordinator {
        // Initialize the coordinator with self as the parent ImagePicker
        Coordinator(self)
    }
}
