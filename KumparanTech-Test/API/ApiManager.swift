//
//  ApiManager.swift
//  KumparanTech-Test
//
//  Created by Ade Dwi Prayitno on 04/01/22.
//

import Foundation

protocol ApiManagerDelegate {
    func bindPost(_ posts: [Post])
    func bindUser(_ users: [UserModel])
    func bindUser(_ user: UserModel)
    func bindComment(_ comments: [CommentData])
    func bindAlbum(_ albums: [AlbumData])
    func bindPhoto(_ photos: [PhotoData])
}

struct ApiManager {
    let urlString = "https://jsonplaceholder.typicode.com"
    var delegate: ApiManagerDelegate?
    mutating func fetchPost(){
        let url  = "\(urlString)/posts"
        let x=0
        peformRequest(with: url, x)
    }
    
    mutating func fetchUser(){
        let url = "\(urlString)/users"
        let x=1
        peformRequest(with: url, x)
    }
    
    mutating func fetchComment(post: Int){
        let url = "\(urlString)/posts/\(post)/comments"
        let x=2
        peformRequest(with: url, x)
    }
    
    mutating func fetchUser(userId: Int){
        let url = "\(urlString)/users/\(userId)"
        let x=3
        peformRequest(with: url, x)
    }
    
    mutating func fetchAlbum(userId: Int){
        let url = "\(urlString)/users/\(userId)/albums"
        let x=4
        peformRequest(with: url, x)
    }
    
    mutating func fetchPhoto(albumId: Int){
        let url = "\(urlString)/albums/\(albumId)/photos"
        let x=5
        peformRequest(with: url, x)
    }
    
    func peformRequest(with urlString: String,_ mode: Int){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task  = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    DispatchQueue.main.async {
                        switch mode {
                        case 0:
                            if let res = self.parseJSON(posts: safeData){
                                self.delegate?.bindPost(res)
                            }
                        case 1:
                            if let res = self.parseJSON(users: safeData){
                                self.delegate?.bindUser(res)
                            }
                        case 2:
                            if let res = self.parseJSON(comments: safeData){
                                self.delegate?.bindComment(res)
                            }
                        case 3:
                            if let res = self.parseJSON(user: safeData){
                                self.delegate?.bindUser(res)
                            }
                        case 4:
                            if let res = self.parseJSON(albums: safeData){
                                self.delegate?.bindAlbum(res)
                            }
                        case 5:
                            if let res = self.parseJSON(photos: safeData){
                                self.delegate?.bindPhoto(res)
                            }
                        default:
                            print("err Mode")
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(posts: Data) -> [Post]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([Post].self, from: posts)
            return decodedData
        } catch  {
            print(error)
            return nil
        }
    }
    
    func parseJSON(users: Data) -> [UserModel]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([UserData].self, from: users)
            var user : [UserModel] = []
            for i in 0...decodedData.count - 1 {
                let id = decodedData[i].id
                let name = decodedData[i].name
                let email = decodedData[i].email
                let address = String("\(decodedData[i].address.street) , \(decodedData[i].address.suite) , \(decodedData[i].address.city) , \(decodedData[i].address.zipcode)")
                let companyName = decodedData[i].company.name
                let a = UserModel(userId: id, name: name, email: email, address: address, company: companyName)
                user.append(a)
            }

            return user
        } catch  {
            print(error)
            return nil
        }
    }
    
    func parseJSON(user: Data) -> UserModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(UserData.self, from: user)
            
            
                let id = decodedData.id
                let name = decodedData.name
                let email = decodedData.email
                let address = String("\(decodedData.address.street) , \(decodedData.address.suite) , \(decodedData.address.city) , \(decodedData.address.zipcode)")
                let companyName = decodedData.company.name
                let user = UserModel(userId: id, name: name, email: email, address: address, company: companyName)

            return user
        } catch  {
            print(error)
            return nil
        }
    }
    
    func parseJSON(comments: Data) -> [CommentData]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([CommentData].self, from: comments)
            return decodedData
        } catch  {
            print(error)
            return nil
        }
    }
    
    func parseJSON(albums: Data) -> [AlbumData]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([AlbumData].self, from: albums)
            return decodedData
        } catch  {
            print(error)
            return nil
        }
    }
    
    func parseJSON(photos: Data) -> [PhotoData]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([PhotoData].self, from: photos)
            return decodedData
        } catch  {
            print(error)
            return nil
        }
    }
    
}
