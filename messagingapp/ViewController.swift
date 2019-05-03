//
//  ViewController.swift
//  messagingapp
//
//  Created by Yan Dias on 03/05/19.
//  Copyright © 2019 Yan Dias. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topHeader: UIView!
    @IBOutlet weak var bottonBar: UIView!
    @IBOutlet weak var bottonBarConstraint: NSLayoutConstraint!
    
    let chatBubleReuseId = "cell1"
    let yanzim = ["alaolasdjklahsdjklahsd","alaolasdjklahsdjklahsdjkahsdjkashdjkahsdalaolasdjklahsdjklahsdjkahsdjkashdjkahsd","alaolasdjklahsdjklahsdjkahsdjkashdjkahsdalaolasdjklahsdjklahsdjkahsdjkashdjkahsdalaolasdjklahsdjklahsdjkahsdjkashdjkahsdalaolasdjklahsdjklahsdjkahsdjkashdjkahsd"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ChatBubbleTableViewCell.self, forCellReuseIdentifier: chatBubleReuseId)
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.94, alpha:1)
        
        configureTopHeader()
        configureShadow()
        configureBottonBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyBoardNotification(notification: NSNotification){
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let animationTime = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)
            let currrve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)

            
            self.bottonBarConstraint.constant = (-keyboardFrame!.height)
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseIn], animations: {
                self.bottonBar.layoutIfNeeded()
            }, completion: nil)
            print(bottonBarConstraint.constant)
            print(keyboardFrame?.height)
            print(animationTime)
            print(currrve)
        }
    }
    
    func configureShadow(){
        topHeader.layer.shadowOffset = CGSize(width: 0, height: 4)
        topHeader.layer.shadowColor = UIColor(red:0.18, green:0.18, blue:0.22, alpha:0.16).cgColor
        topHeader.layer.shadowOpacity = 1
        topHeader.layer.shadowRadius = 3
    }
    
    func configureBottonBar(){
        
        let textField = UITextView()
        
        bottonBar.addSubview(textField)
        bottonBar.backgroundColor = .gray
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [textField.topAnchor.constraint(equalTo: bottonBar.topAnchor, constant: 10),
                           textField.bottomAnchor.constraint(equalTo: bottonBar.bottomAnchor, constant: -10),
                           textField.leadingAnchor.constraint(equalTo: bottonBar.leadingAnchor, constant: 17),
                           textField.trailingAnchor.constraint(equalTo: bottonBar.trailingAnchor, constant: -17),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    func configureTopHeader(){
        let arrow = UIImageView()
        let avatarImage = UIImageView()
        
        let carLabel = UILabel()
        let vendorInformationLabel = UILabel()
        
        carLabel.text = "Volkswagen Fusca"
        carLabel.font = UIFont(name: carLabel.font.fontName, size: 16)
        carLabel.textAlignment = .left
        
        vendorInformationLabel.text = "Ver informações do vendedor"
        vendorInformationLabel.textColor = UIColor(red:0.95, green:0.07, blue:0.24, alpha:1)
        vendorInformationLabel.font = UIFont(name: vendorInformationLabel.font.fontName, size: 12)
        vendorInformationLabel.textAlignment = .left
        
        topHeader.addSubview(arrow)
        topHeader.addSubview(avatarImage)
        topHeader.addSubview(carLabel)
        topHeader.addSubview(vendorInformationLabel)
        
        avatarImage.layer.cornerRadius = 22
        avatarImage.layer.masksToBounds = true
        
        avatarImage.backgroundColor = .gray
        arrow.backgroundColor = .gray
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        carLabel.translatesAutoresizingMaskIntoConstraints = false
        vendorInformationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [arrow.widthAnchor.constraint(equalToConstant: 24),
                           arrow.heightAnchor.constraint(equalToConstant: 24),
                           arrow.leadingAnchor.constraint(equalTo: topHeader.leadingAnchor, constant: 13),
                           arrow.centerYAnchor.constraint(equalTo: topHeader.centerYAnchor, constant: 0),
                           
                           avatarImage.widthAnchor.constraint(equalToConstant: 44),
                           avatarImage.heightAnchor.constraint(equalToConstant: 44),
                           avatarImage.leadingAnchor.constraint(equalTo: arrow.trailingAnchor, constant: 15),
                           avatarImage.centerYAnchor.constraint(equalTo: topHeader.centerYAnchor, constant: 0),
        
                           carLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 20),
                           carLabel.trailingAnchor.constraint(equalTo: topHeader.trailingAnchor, constant: -13),
                           carLabel.topAnchor.constraint(equalTo: topHeader.topAnchor, constant: 15),
                           carLabel.heightAnchor.constraint(equalToConstant: 24),
                           
                           vendorInformationLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 20),
                           vendorInformationLabel.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: 0),
                           vendorInformationLabel.heightAnchor.constraint(equalToConstant: 17),
                           vendorInformationLabel.trailingAnchor.constraint(equalTo: topHeader.trailingAnchor, constant: -13),
                           ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
    // MARK : TableView Mathods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatBubleReuseId, for: indexPath) as! ChatBubbleTableViewCell
        
        cell.configure(text: yanzim[indexPath.row], type: ChatBubbleType.Sender)
        return cell
    }
    
    
    


}

