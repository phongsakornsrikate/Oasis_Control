//
//  PostTableViewCell.swift
//  U-CITY
//
//  Created by JayJay on 1/5/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase


class PostTableViewCell: UITableViewCell {
    
    let database = Database.database().reference()
   
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var sharedLabel
    : UILabel!
    @IBOutlet weak var createAt: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var haveFunLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var haveFunBtn: UIButton!
    
    @IBOutlet weak var imageHavefun: UIImageView!
    @IBOutlet weak var postIDLabel: UILabel!
    let Call =  FeedViewController()
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
       
    }
    
    //var statusHavefunClicked = true
 
    @IBAction func haveFunClicked(_ sender: Any) {
        if(postIDLabel.text != nil){
        let postID = postIDLabel.text
        let userUID = Auth.auth().currentUser?.uid
            var statusHavefun = String()
            let databaseReference = Database.database().reference().child("Post").child(postID!).child("statusPostID")
           databaseReference.child(userUID!).observeSingleEvent(of: .value, with: { Snapshot in
                if let statusObj = Snapshot.value as? [String: AnyObject]{
                    statusHavefun = statusObj["statusHavefun"] as! String
                  //  print("\n\n\n\(statusHavefun)\n\n\n")
                }
                })
            
           
            let databaseRef = Database.database().reference().child("Post").child(postID!)
            databaseRef.child("Havefun").observeSingleEvent(of: .value, with: { Snapshot in
                if let HavefunObj = Snapshot.value as? [String: AnyObject]{
                    let NumberOfHaveFun = HavefunObj["NumberOfHaveFun"] as! String
                   
                    let statusHavefunClicked = Bool(statusHavefun)
                        //print("\n\n\n\(postID!)\n\n\n")
                    
                        var NumberOfHaveFunInt = (NumberOfHaveFun as NSString).integerValue
                        if(statusHavefunClicked == true){
                            NumberOfHaveFunInt = NumberOfHaveFunInt-1
                            // print("\n\n\n\(NumberOfHaveFunInt )\n\n\n")
                            let NumberOfHaveFunString = String(NumberOfHaveFunInt)
                            let statusHavefun = "false"
                            self.database.child("Post").child(postID!).child("Havefun").child("NumberOfHaveFun").setValue(NumberOfHaveFunString)
                            self.database.child("Post").child(postID!).child("statusPostID").child(userUID!).child("statusHavefun").setValue(statusHavefun)
                            //self.imageHavefun.image = UIImage(named: "smile (1)")
                            
                       }
                      else{
                          NumberOfHaveFunInt = NumberOfHaveFunInt+1
                             //print("\n\n\n\(NumberOfHaveFunInt )\n\n\n")
                          let NumberOfHaveFunString = String(NumberOfHaveFunInt)
                          let statusHavefun = "true"
                            self.database.child("Post").child(postID!).child("Havefun").child("NumberOfHaveFun").setValue(NumberOfHaveFunString)
                            self.database.child("Post").child(postID!).child("statusPostID").child(userUID!).child("statusHavefun").setValue(statusHavefun)
                               // self.imageHavefun.image = UIImage(named: "smile")
                            
                       }

                
                }
            })
        
        
        }
        else{
            print("error")
        }
    }
    
    @IBAction func commentClicked(_ sender: Any) {
    }
    
    @IBAction func sharedClicked(_ sender: Any) {
    }
    
    
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIImage{
    func getCropRatio() -> CGFloat{
        var widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}
