//
//  FilmTableView.swift
//  GetDataFromApi
//
//  Created by admin on 22/12/2021.
//

import UIKit

class FilmTableView: UITableViewController {
    var dataFromApi : [data] = []
    var Name = " "
    override func viewDidLoad() {
        super.viewDidLoad()
      
        getApi(key:"films/")
        Name = "title"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataFromApi.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         
        cell.textLabel?.text = dataFromApi[indexPath.row].name
        
        return cell
    }
   
    func getApi(key:String){
         let urlSession = URLSession.shared
         guard let url = URL.init(string:"https://swapi.dev/api/\(key)") else { return }
        
         let task = urlSession.dataTask(with: url) { data, response, error in
             self.parseData(data: data!)
        
     }
     task.resume()
 }
     func parseData(data: Data){
         do {
        
      let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
             if let results = json["results"] as? [[String:Any]]{
             for result in results {
                 parsingApi(obj: result)
             }
             }
        
     } catch {
         print(error.localizedDescription)
     }
     }
     func parsingApi(obj: [String:Any]){
        guard let name = obj[Name] as? String else {
                  return
              }
        
         let d = data.init(name: name)
         dataFromApi.append(d)
         
         DispatchQueue.main.async {
             self.tableView.reloadData()
         }
     }
}


