//
//  ImageCollectionViewController.swift
//  ImageBrowser
//
//  Created by Dan Shepherd on 21/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class ImageCollectionViewController: UICollectionViewController, ImageViewProviderDelegate {

    var imageViewProvider : ImageViewProvider?
    var imageList: [ImageViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadImageList()
    }
    
    func loadImageList() {
        self.imageViewProvider = FlickrImageViewProvider(delegate : self)
        DispatchQueue.global(qos: .background).async {
            self.imageViewProvider?.loadImageList()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ImageViewProviderDelegate methods
    func imageListLoadComplete(imageList: [ImageViewModel]) {
        DispatchQueue.main.async {
            self.imageList = imageList
            self.collectionView?.reloadData()
        }
    }
    
    func imageListLoadError(error: Error?) {
        // Todo: handle error properly, for now just print the error
        DispatchQueue.main.async {
            print(error.debugDescription)
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.imageList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        // Configure the cell
        cell.titleLabel.text = self.imageList[indexPath.item].title ?? ""
        if let image = self.imageList[indexPath.item].image {
            cell.backgroundView = UIImageView(image: image)
        }
        else {
            if let url = self.imageList[indexPath.item].imageURL {
                DispatchQueue.global(qos: .background).async {
                    Util.loadImage(url: url, completion: { [unowned self] (image, respone, error) in
                        DispatchQueue.main.sync {
                            self.imageList[indexPath.item].image = image
                            collectionView.reloadItems(at: [indexPath])
                        }
                    })
                }
            }
        }
        return cell
    }
}
