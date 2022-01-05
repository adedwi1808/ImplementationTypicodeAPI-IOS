//
//  DetailPostViewController.swift
//  KumparanTech-Test
//
//  Created by Ade Dwi Prayitno on 04/01/22.
//

import UIKit

class DetailPostViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titlePost: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bodyPost: UILabel!
    
    var comments : [CommentData] = []
    var user:[UserModel] = []
    
    var detail = Detail(id: 0, userId: 0, title: "", user: "", body: "")
    
    var apiManager = ApiManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Clickable Label
        userName.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(clickLabel))
        tapGesture.numberOfTapsRequired = 1
        userName.addGestureRecognizer(tapGesture)
        
        apiManager.delegate = self
        apiManager.fetchComment(post: detail.id)
        
        titlePost.text = detail.title
        userName.text = detail.user
        bodyPost.text = detail.body
        
        tableView.dataSource = self
//        tableView.rowHeight = 120

        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
    }
    
    
}

//MARK: - Clickable Method
extension DetailPostViewController {
    @objc func clickLabel(){
        self.performSegue(withIdentifier: "DetailPostToUserDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! UserDetailViewController
        vc.userId = detail.userId
    }
}
//MARK: - TableView DataSource
extension DetailPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        cell.commentAuthor.text = comment.name
        cell.commentBody.text = comment.body
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    
}

//MARK: - ApiManagerDelegate
extension DetailPostViewController: ApiManagerDelegate {
    func bindPhoto(_ photos: [PhotoData]) {
        
    }
    
    func bindAlbum(_ albums: [AlbumData]) {
        
    }
    
    func bindUser(_ user: UserModel) {
            
    }
    
    func bindPost(_ posts: [Post]) {
        
    }
    
    func bindUser(_ users: [UserModel]) {
  
    }
    
    func bindComment(_ comments: [CommentData]) {
        DispatchQueue.main.async{
            self.comments += comments
            self.tableView.reloadData()
        }
    }
    
    
}

//MARK: - Detail Data Model
struct Detail {
    let id: Int
    let userId: Int
    let title: String
    let user: String
    let body: String
}
