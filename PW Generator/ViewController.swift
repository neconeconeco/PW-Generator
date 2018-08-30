//
//  ViewController.swift
//  PW Generator
//
//  Created by 郭子乐 on 2018/8/30.
//  Copyright © 2018年 郭子乐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var str1: UITextField!
    
    @IBOutlet weak var str2: UITextField!
    
    @IBOutlet weak var pw_len: UITextField!
    
    @IBOutlet weak var pw: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func genPW(_ sender: Any) {
        let str = str1.text! + str2.text!
        
        if let l = Int(pw_len.text!){
            if l>0 {
                pw.text = String(str.getMd5().prefix(l))
            }
            else {
                pw.text = "pw_len should >0"
            }
        }
        else {
            pw.text = "pw_len should be int"
        }
    }
    
}

extension String {
    //md5加密算法
    func getMd5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(hash)
    }
}

