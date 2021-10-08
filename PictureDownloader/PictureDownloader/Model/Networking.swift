//
//  Networking.swift
//  PictureDownloader
//
//  Created by Andrei on 06.10.2021.
//

import Foundation
import Combine
import Alamofire
import AlamofireImage
import UIKit

class Networking {
    private let baseURL = URL(string: "https://picsum.photos/500")!
    let imagePublisher = PassthroughSubject<UIImage, AFError>()
    let replaceImagePublisher = PassthroughSubject<UIImage, AFError>()
    func requestURL() {
        AF.request(baseURL)
            .responseJSON { response in
                guard let imageURL = response.response?.url else {print("Cannot get image URL"); return}
                self.requestImage(url: imageURL)
                return
            }
    }
    func requestImage(url: URL) {
        AF.request(url)
            .responseImage { response in
                if case .success(let image) = response.result {
                    self.imagePublisher.send(image)
                }
            }
    }
    func requestReplaceURL() {
        AF.request(baseURL)
            .responseJSON { response in
                guard let imageURL = response.response?.url else {print("Cannot get image URL"); return}
                self.requestReplaceImage(url: imageURL)
                return
            }
    }
    func requestReplaceImage(url: URL) {
        AF.request(url)
            .responseImage { response in
                if case .success(let image) = response.result {
                    self.replaceImagePublisher.send(image)
                }
            }
    }
}
