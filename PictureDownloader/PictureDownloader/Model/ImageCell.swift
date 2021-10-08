//
//  ImageCell.swift
//  PictureDownloader
//
//  Created by Andrei on 06.10.2021.
//

import Foundation
import UIKit
import Combine

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    static let reuseIdentifier = "ImageCell"
    func configure (image: UIImage) {
        spinner.stopAnimating()
        imageView.layer.cornerRadius = imageView.frame.height / 5
        imageView.image = image
        imageView.layer.borderWidth = 0
    }
    func configure() {
        imageView.image = nil
        if spinner.isAnimating == false {
            spinner.startAnimating()
        }
        imageView.layer.cornerRadius = imageView.frame.height / 5
        imageView.layer.borderWidth = 1
        var color = UIColor()
        color = .systemGray5
        imageView.layer.borderColor = color.cgColor
    }
}
