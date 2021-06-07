//
//  commentViewController.swift
//  Instagram
//
//  Created by 八重樫裕太 on 2021/05/31.
//

import UIKit
import FirebaseUI
import Firebase

class CommentViewController: UIViewController {
    
    var cellData: PostData!
    var id:String!
    
    
    @IBOutlet weak var postImageView2: UIImageView!
    @IBOutlet weak var postCommentLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func postCommentButton(_ sender: Any) {
        
        let postRef = Firestore.firestore().collection(Const.PostPath).document(id).collection("comments").document()
        
        
        if commentTextField.text == "" {
            print("DEBUG_PRINT:コメントが未入力です")
            return
        }else{
            // FireStoreに投稿データを保存する
            let name = Auth.auth().currentUser?.displayName
            let postDic = [
                "name" : name!,
                "comment" : self.commentTextField.text!
            ] as [String : Any]
            postRef.setData(postDic,completion: {error in
                print(error)
            })
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImageView2.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(id + ".jpg")
        postImageView2.sd_setImage(with: imageRef)
        
        postCommentLabel.text = cellData.name! + ":" + cellData.caption!  // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

