//
//  ContactsTableViewController.swift
//  ContactsTableView
//
//  Created by Candy on 2017/3/19.
//  Copyright © 2017年 CandyHu. All rights reserved.
//

import UIKit
import Contacts

class ContactsTableViewController: UITableViewController {

    // 使用tuple 來儲存聯絡人資料(名稱, 電話)
    let contacts = [("Candy", "0912345678"), ("Apple", "0987654321"), ("Cookie", "0928198234"), ("Cake", "0987465263"), ("Banana", "0916272364")]
    
    // 建立一個Array 用來儲存手機裡的聯絡人資料
    var contactsFromIphone: [CNContact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 抓取手機裡的聯絡人資料
        //getContacts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContacts() {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:  // 用戶已授權，允許訪問
            print("authorized")
        case .denied:
            print("denied")  // 用户拒絕授權
        case .notDetermined:
            print("notDetermined")  // 用户尚未進行授權
        case .restricted:
            print("restricted")  // 此應用程式沒有權限，且當前用戶無法改變權限，如:家長控制
        }
        
        guard status == .authorized else {
            return
        }
        // framework 中，儲存或搜尋聯絡人的物件
        let contactsStore = CNContactStore()
        // 要取得聯絡人的哪些資訊
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey]
        // 建立一個request 的物件
        let contactReq = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        // 搜尋聯絡人所需要的條件
        //let predicate = CNContact.predicateForContacts(matchingName: "丁")
        do {
            try contactsStore.enumerateContacts(with: contactReq) { (contact: CNContact, stop: UnsafeMutablePointer<ObjCBool>) in
                print(contact.familyName + contact.givenName)
                if contact.phoneNumbers.count > 0 {
                 print(contact.phoneNumbers[0].value.stringValue)
                }
                if contact.imageData != nil {
                    print("He has photo")
                }
                self.contactsFromIphone.append(contact)
            }
        } catch {
            print("Error")
        }
        
        // 利用predicate 搜尋通訊錄裡的人
       /* do {
            let results = try contactsStore.unifiedContacts(matching: predicate, keysToFetch: keys as [CNKeyDescriptor])
            for i in 0..<results.count {
                print(results[i].familyName + results[i].givenName )
            }
            
        } catch {
            
        }*/
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count //contactsFromIphone.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...

        // 使用預設的TableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].0
        cell.detailTextLabel?.text = contacts[indexPath.row].1
        cell.imageView?.image = UIImage(named: contacts[indexPath.row].0)
        
        return cell

        
        
        // 使用自訂的TableViewCell
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.nameLabel.text = contacts[indexPath.row].0
        cell.phoneLabel.text = contacts[indexPath.row].1
        cell.photoImageView.image = UIImage(named: contacts[indexPath.row].0)
        
        return cell*/
        
        
        // 使用自訂的TableViewCell 顯示手機通訊錄的聯絡人
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.nameLabel.text = contactsFromIphone[indexPath.row].familyName + contactsFromIphone[indexPath.row].givenName
        if contactsFromIphone[indexPath.row].phoneNumbers.count > 0 {
            cell.phoneLabel.text = contactsFromIphone[indexPath.row].phoneNumbers[0].value.stringValue
        }
        if contactsFromIphone[indexPath.row].imageData != nil {
            cell.photoImageView.image = UIImage(data: contactsFromIphone[indexPath.row].imageData!)
        }
        
        return cell*/

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 點選Cell，就讓Cell 出現勾勾
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // 取消點選Cell，就讓Cell 不要出現勾勾
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //三元運算子，如果?前的條件成立，則return 80，若不成立則回傳45
        return indexPath.row % 2 == 0 ? 80 : 45
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
