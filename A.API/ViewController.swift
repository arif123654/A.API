//
//  ViewController.swift
//  A.API
//
//  Created by apple on 2/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {

    //MARK:- Utilities
    var items = ["Burger","Guiter","Shrimp"]
    @IBOutlet weak var TableViewController: UITableView!
    var model = [Model]()
    var imgURL = [String]()
    
    
    
    
    //MARK:-Init
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewController.delegate = self
        TableViewController.dataSource = self
        data()
        // Do any additional setup after loading the view.
    }

    
    
    
    //MARK:- Data Parsing
    func data(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            if error == nil {
                do{
                    let myData = try!JSONDecoder().decode([Model].self, from: data!)
                 
                    DispatchQueue.main.async {
                    
                        for item in myData{
                         
                         
                            self.imgURL.append(item.thumbnailUrl)
                        }
                        self.TableViewController.reloadData()
                    }
                }catch{
                    print(":( Nothing Found")
                }
            }
        }.resume()
    }

}


//MARK:- Table View
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgURL.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewController.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        if let imgUrl = imgURL[indexPath.row] as? String {
            if let url = URL(string: imgUrl){
                cell.tableImageView.af_setImage(withURL: url)
            }
        }
        
        return cell
    }
    
    
}
