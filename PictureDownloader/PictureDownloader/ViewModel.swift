//
//  ViewModel.swift
//  PictureDownloader
//
//  Created by Andrei on 06.10.2021.
//

import Foundation
import Combine
import UIKit

class ViewModel {
    let networking = Networking()
    var imageArray: [CellImage] = []
    var indexArray: [Int] = []
    var subscription = Set<AnyCancellable>()
    var imageNotifier = PassthroughSubject<Void, Error>()
    var singleSubscription: AnyCancellable?
    let queue = DispatchQueue(label: "downloader", qos: .background, attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 25)
    func requestPicture(itemIndex: Int) {
        guard indexArray.contains(itemIndex) == false else {return}
        indexArray.append(itemIndex)
        queue.async {
            self.semaphore.wait()
            self.networking.requestURL()
            print("index \(itemIndex) placed in queue \(self.queue.label)")
            self.semaphore.signal()
        }
        print("requested for index: \(itemIndex)")
    }
    func subscribeForImages() {
        networking.imagePublisher
            .sink { error in
                print(error)
            } receiveValue: {[weak self] recievedImage in
                guard let self = self else {return}
                let imageObject = CellImage(image: recievedImage)
                self.imageArray.append(imageObject)
                self.imageNotifier.send()
            }
            .store(in: &subscription)
    }
    func replaceImage(index: Int) {
        self.networking.requestReplaceURL()
        self.singleSubscription = self.networking.replaceImagePublisher
            .sink { error in
                print(error)
            } receiveValue: {[weak self] recievedImage in
                guard let self = self else {return}
                self.imageArray[index].image = recievedImage
                self.imageNotifier.send()
                print("replace done")
            }
    }
}
