//
//  DetailAlbumViewController.swift
//  KumparanTech-Test
//
//  Created by Ade Dwi Prayitno on 05/01/22.
//

import UIKit
import SDWebImage

class DetailAlbumViewController: UIViewController {
    @IBOutlet weak var colView: UICollectionView!
    
    var apiManager = ApiManager()
    var photos: [PhotoData] = []
    var albumID = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.delegate = self
        apiManager.fetchPhoto(albumId: albumID)
        
        colView.dataSource = self
//        colView.delegate = self
        colView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
    
}

extension DetailAlbumViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos[indexPath.row]
        let cell = colView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.imgView.sd_setImage(with: URL(string: photo.url),
                                 placeholderImage: UIImage(systemName: "photo"),
                                 options: .continueInBackground, completed: nil)
        cell.titleLabel.text = photo.title
        return cell
    }
}

extension DetailAlbumViewController: ApiManagerDelegate {
    func bindPost(_ posts: [Post]) {
        
    }
    
    func bindUser(_ users: [UserModel]) {
        
    }
    
    func bindUser(_ user: UserModel) {
        
    }
    
    func bindComment(_ comments: [CommentData]) {
        
    }
    
    func bindAlbum(_ albums: [AlbumData]) {
        
    }
    
    func bindPhoto(_ photos: [PhotoData]) {
        DispatchQueue.main.async{
            self.photos = photos
            self.colView.reloadData()
        }
    }
    
}
