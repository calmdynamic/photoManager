//
//  FolderTypeListViewController.swift
//  FinalProject
//
//  Created by Jason Chih-Yuan on 2018-03-22.
//  Copyright © 2018 Jason Lai. All rights reserved.
//

import UIKit

class FolderTypeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var folderTypes: [Type]!
    let identifier = "listCell"
    let segueIdentfier = "folderTypeListToFolderList"
    
    var previousControllerName = ""
    
    var isFolderTypeOnly:Bool?
    
    var selectedFolderType: Type!
    
    @IBOutlet var doneBtn: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        

        let tempFolderTypes = RealmService.shared.realm.objects(Type.self)
        
        folderTypes = [Type]()
        for i in tempFolderTypes{
            folderTypes.append(i)
        }
        
        self.tableView.reloadData()
        
        
        if isFolderTypeOnly == nil || isFolderTypeOnly == false {
            navigationItem.rightBarButtonItem = nil
        }else{
            navigationItem.rightBarButtonItem = self.doneBtn
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        doneBtn.isEnabled = false
        tableView.dataSource = self
        tableView.delegate = self 
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentfier{
            let folderListVC = segue.destination as! FolderListViewController
            
            let indexpath = self.tableView?.indexPathForSelectedRow

            let selectedFolderType = self.folderTypes[(indexpath?.item)!]

            folderListVC.selectedFolderType = selectedFolderType
            folderListVC.previousControllerName = self.previousControllerName

        }
    }
    

    @IBAction func doneBtn(_ sender: UIBarButtonItem) {

        
    }
    
    
    @IBAction func cancelBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension FolderTypeListViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.folderTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ListTableViewCell
        if self.folderTypes[indexPath.item].getName() == "Default"{
             cell.listLabel.text = "\(self.folderTypes[indexPath.item].getName())"
            cell.listImage.image = #imageLiteral(resourceName: "folder_Details")
        }else{
        
            cell.listLabel.text = self.folderTypes[indexPath.item].getFolderCount()==0 ? "\(self.folderTypes[indexPath.item].getName()) [Empty]" : "\(self.folderTypes[indexPath.item].getName()) [\(self.folderTypes[indexPath.item].getFolderCount())]"
      
            cell.listImage.image = #imageLiteral(resourceName: "folder_Category")
        }
        cell.isUserInteractionEnabled = self.folderTypes[indexPath.item].getFolderCount()==0 ? false:true
        cell.listLabel.textColor = self.folderTypes[indexPath.item].getFolderCount()==0 ? UIColor.gray : UIColor.black
        return cell
    }

    
    
    
}
extension FolderTypeListViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedFolderType = self.folderTypes[indexPath.item]
        doneBtn.isEnabled = true
        
        if self.isFolderTypeOnly == nil || self.isFolderTypeOnly == false{
            self.performSegue(withIdentifier: self.segueIdentfier, sender: nil)
            
        }
        
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }

}
