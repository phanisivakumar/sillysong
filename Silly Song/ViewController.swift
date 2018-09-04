//
//  ViewController.swift
//  Silly Song
//
//  Created by Phani A on 9/8/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameFieldqqq: UIButton!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = "Want me to create a silly song on your name? Try now!"
    }

    @IBAction func displayLyrics(_ sender: Any) {
        
        //To prevent the case when user taps the textbox and double tap the lyrics area is causing to accept the space. Hence the following code.
        if nameField.text == "" {
            return
        }
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
    }
    
    //close the keyboard when user touch outside of the textbox
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//Extension method
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    //Extra method implemented to accept only characters in the text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let characterSet = CharacterSet.letters
        
        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true
    }
}

//Begin: Global functions
func shortNameFromName(_ name: String) -> String {
    
    let lowerCaseName = name.lowercased()
    let charSet = CharacterSet(charactersIn: "aeiou")
    
    if let rangeSet = lowerCaseName.rangeOfCharacter(from: charSet){
        return lowerCaseName.substring(from: rangeSet.lowerBound)
    }
    
    return lowerCaseName
    
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(fullName)
    return lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
}

//Template
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

//End: Global functions
