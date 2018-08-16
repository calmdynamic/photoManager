//
//  SettingTableViewController.swift
//  FinalProject
//
//  Created by Jason Chih-Yuan on 2018-03-24.
//  Copyright © 2018 Jason Lai. All rights reserved.
//

import UIKit
import RealmSwift

class SettingTableViewController: UITableViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var folderTypeSaveLocation: UILabel!
    @IBOutlet weak var folderSaveLoation: UILabel!
   
    var selectedFolderType: String!
    var selectedFolderName: String!
    
    override func viewWillAppear(_ animated: Bool) {
        var isEmpty: Bool
        isEmpty = false
        var tempFolderType: Results<Type>?
        if let selectedFolderTypeName = self.defaults.string(forKey: "selectedFolderType"){
            tempFolderType = RealmService.shared.realm.objects(Type.self).filter("name = %@", selectedFolderTypeName)
            if(!(tempFolderType?.isEmpty)!){
                isEmpty = false
            }else{
                isEmpty = true
            }
        }
        var tempFolder: Results<Folder>?
        if let selectedFolderName = self.defaults.string(forKey: "selectedFolder"){
            tempFolder = RealmService.shared.realm.objects(Folder.self).filter("name = %@", selectedFolderName)
            if(!(tempFolder?.isEmpty)!){
                isEmpty = false
            }else{
                isEmpty = true
            }
        }
        
        if (isEmpty){
            tempFolderType = RealmService.shared.realm.objects(Type.self).filter("name = %@", "Default")
            tempFolder = RealmService.shared.realm.objects(Folder.self).filter("name = %@", "Default")
            defaults.set("Default", forKey: "selectedFolderType")
            defaults.set("Default", forKey: "selectedFolder")
            
        }
        

        folderTypeSaveLocation.text = self.defaults.string(forKey: "selectedFolderType")

        folderSaveLoation.text = self.defaults.string(forKey: "selectedFolder")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didUnwindFromFolderList(segue: UIStoryboardSegue){
        let folderList = segue.source as! FolderListViewController
        self.selectedFolderType = folderList.selectedFolderType.getName()
        self.selectedFolderName = folderList.selectedFolder.getName()
        self.folderTypeSaveLocation.text = selectedFolderType
        self.folderSaveLoation.text = selectedFolderName
        defaults.set(selectedFolderType, forKey: "selectedFolderType")
        defaults.set(selectedFolderName, forKey: "selectedFolder")
    }
    

}