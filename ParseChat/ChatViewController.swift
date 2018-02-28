//
//  ChatViewController.swift
//  ParseChat
//
//  Created by TiAuna Dodd on 2/26/18.
//  Copyright © 2018 TiAuna Dodd. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var message: [PFObject] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var chatMessageField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        getMessages()
        collectionView.sizeToFit()
        //collectionView.estimatedRowHeight = 50
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        
      
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.getMessages()
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    
    func getMessages() {
        let query = PFQuery(className:"Message")
        query.findObjectsInBackground { (result: [PFObject]?, error: Error?) in
            self.message = result!
            self.collectionView.reloadData()
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return message.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let messageData = message[indexPath.item]
        cell.messageLabel.text = messageData["text"] as? String
       
        
        //cell.backgroundColor = .lightgray
        cell.layer.cornerRadius = 40
        cell.clipsToBounds = true
        
       
        
       // guard let messageInfo = message![indexPath.item] else { return cell }
      //  print(message[indexPath.item])
        return cell
        
    }
   
    
}
