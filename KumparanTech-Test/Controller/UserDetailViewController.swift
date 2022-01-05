//
//  UserDetailViewController.swift
//  KumparanTech-Test
//
//  Created by Ade Dwi Prayitno on 05/01/22.
//

import UIKit
import SDWebImage

class UserDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var apiManager = ApiManager()
    var albums: [AlbumData] = []
    var photo: [PhotoData] = []
    //Default UserID
    var userId = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.delegate = self
        apiManager.fetchUser(userId: userId)
        apiManager.fetchAlbum(userId: userId)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
    }
    
}
//MARK: - TableView DataSource
extension UserDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = albums[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if !photo.isEmpty {
        DispatchQueue.main.async {
            cell.imgView.sd_setImage(with: URL(string: self.photo[indexPath.row].thumbnailUrl), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
            }
        }
        cell.titleLabel.text = album.title
        return cell
    }
    
    
}

//MARK: - TableView Delegate
extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "UserDetailToPhotos", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailAlbumViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            let album = albums[indexPath.row]
            
            vc.albumID = album.id
        }
    }
}


//MARK: - ApiManagerDelegate
extension UserDetailViewController: ApiManagerDelegate {
    func bindPhoto(_ photos: [PhotoData]) {
        DispatchQueue.main.async{
            self.photo += photos
            self.tableView.reloadData()
        }
    }
    
    func bindAlbum(_ albums: [AlbumData]) {
        DispatchQueue.main.async{
            self.albums = albums
            for i in 0...self.albums.count-1 {
                self.apiManager.fetchPhoto(albumId: self.albums[i].id)
            }
            self.tableView.reloadData()
        }
    }
    
    func bindUser(_ user: UserModel) {
        DispatchQueue.main.async{
            self.nameLabel.text = user.name
            self.emailLabel.text = user.email
            self.companyLabel.text = user.company
            self.addressLabel.text = user.address
        }
    }
    
    func bindPost(_ posts: [Post]) {
        
    }
    
    func bindUser(_ users: [UserModel]) {
        
    }
    
    func bindComment(_ comments: [CommentData]) {
        
    }
}

