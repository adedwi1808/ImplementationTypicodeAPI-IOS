//
//  HomeViewController.swift
//  KumparanTech-Test
//
//  Created by Ade Dwi Prayitno on 03/01/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    var users: [UserModel] = []
    
    var apiManager = ApiManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.delegate = self

        
        apiManager.fetchUser()
        apiManager.fetchPost()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }
}

//MARK: - TableView DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        cell.title.text = post.title
        cell.body.text = post.body
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if !users.isEmpty {
            for i in 0...users.count - 1 {
                if post.userId == users[i].userId {
                    cell.nameAndCom.text = String("\(users[i].name) @\(users[i].company)")
                    break
                }
            }
        }
        
        
        return cell
    }
}

//MARK: - TableView Delegate
extension HomeViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "postToDetailPost", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailPostViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            let post = posts[indexPath.row]
            var user = ""
            var userId = 0
            if !users.isEmpty {
                for i in 0...users.count - 1 {
                    if post.userId == users[i].userId {
                        userId = users[i].userId
                        user = users[i].name
                        break
                    }
                }
            }
            
            let id = post.id
            let title = post.title
            let body = post.body
            vc.detail = Detail(id: id, userId: userId, title: title, user: user, body: body)
        }
    }
}

//MARK: - ApiManagerDelegate
extension HomeViewController: ApiManagerDelegate {
    func bindPhoto(_ photos: [PhotoData]) {
        
    }
        
    func bindAlbum(_ albums: [AlbumData]) {
        
    }
    
    func bindUser(_ user: UserModel) {
        
    }
    
    func bindComment(_ comments: [CommentData]) {
  
    }
    
    func bindUser(_ users: [UserModel]) {
        DispatchQueue.main.async{
            self.users += users
            self.tableView.reloadData()
        }
    }
    
    func bindPost(_ posts: [Post]) {
        DispatchQueue.main.async{
            self.posts += posts
            self.tableView.reloadData()
        }
    }
}
