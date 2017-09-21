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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
        cell.titleLabel.text = imageList[indexPath.item].title ?? ""
        if imageList[indexPath.item].image != nil {
            cell.imageView.image = imageList[indexPath.item].image
        }
        else {
            // todo: load image
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
