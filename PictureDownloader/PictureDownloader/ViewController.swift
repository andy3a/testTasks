//
//  ViewController.swift
//  PictureDownloader
//
//  Created by Andrei on 06.10.2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var refreshButton: UIButton!
    var subscriptions = Set<AnyCancellable>()
    var imagesToBeShown = 0
    var viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlert()
        setUpCollectionView()
        setUpSubscription()
        setUpRefreshButton()
    }
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        viewModel.imageArray = []
        viewModel.indexArray = []
        showAlert()
    }
}

extension ViewController {
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView.collectionViewLayout = layout
        collectionView.isUserInteractionEnabled = true
    }
    private func setUpSubscription() {
        viewModel.subscribeForImages()
        viewModel.imageNotifier
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
    }
    private func setUpRefreshButton() {
        refreshButton.layer.cornerRadius = refreshButton.frame.width / 2
    }
    private func showAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Hi", message: "Choose the number of pictures", preferredStyle: .alert)
            alert.addTextField { answer in
                answer.keyboardType = .numberPad
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
                if textField.text != "",
                   textField.text?.first != "0" {
                    self.imagesToBeShown = (textField.text! as NSString).integerValue
                    print(self.imagesToBeShown)
                    self.collectionView.reloadData()
                } else {
                    self.showErrorAlert()
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Enter the number", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Understood", style: .destructive, handler: {_ in
            self.showAlert()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.imageArray[indexPath.item].image = nil
        collectionView.reloadData()
        viewModel.replaceImage(index: indexPath.item)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesToBeShown
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCell.reuseIdentifier,
                for: indexPath) as? ImageCell else {
                    return UICollectionViewCell()
                }
            if viewModel.imageArray.indices.contains(indexPath.item),
               viewModel.imageArray[indexPath.item].image != nil {
                cell.configure(image: viewModel.imageArray[indexPath.item].image!)
                return cell
            } else {
                viewModel.requestPicture(itemIndex: indexPath.item)
                cell.configure()
                return cell
            }
        }
}
