//
//  StorageService.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 26.07.2021.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class StorageService {
    static let shared = StorageService()
    
    let storage = Storage.storage()
    
    
    var avatarsRef: StorageReference{
        return storage.reference(withPath: "avatars")
    }
    
    private var currentUserId: String{
        return Auth.auth().currentUser!.uid
    }
    
    
    func upload(photo:UIImage, competion: @escaping (Result<URL,Error>)->Void) {
    
        guard  let scaledImage = photo.scaledToSafeUploadSize,
               let imageData = scaledImage.jpegData(compressionQuality: 0.4)
        else {return}
        let metadata =  StorageMetadata()
        metadata.contentType = "image/jpeg"
        avatarsRef.child(currentUserId).putData(imageData, metadata: metadata) { (metadata, error) in
            guard let metadata = metadata else {
                competion(.failure(error!))
                return
            }
            let imageRef = self.avatarsRef.child(self.currentUserId)
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    competion(.failure(error!))
                      return
            }
                competion(.success(downloadURL))
        }
    }
}
}
