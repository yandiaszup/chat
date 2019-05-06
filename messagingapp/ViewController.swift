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
    
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var carImage: UIImageView!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var downLabel: UILabel!
    
    private let sendButton = UIButton()
    private let textField = UITextView()
    
    let chatBubleReuseId = "cell1"
    var yanzim = ["alaolasdjklahsdjklahsd","alaolasdjklahsdjklahsdjkahsdjkashdjkahsdalaolasdjklahsdjklahsdjkahsdjkashdjkahsd","alaolasdjklahsdjklahsdjkahsdjkashdjkahsdalaolasdjklahsdjklahsdjkahsdjkashdjkahsdalaolasdjklahsdjklahsdjkahsdjkashdjkahsdalaolasdjklahsdjklahsdjkahsdjkashdjkahsd"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ChatBubbleTableViewCell.self, forCellReuseIdentifier: chatBubleReuseId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.94, alpha:1)
        tableView.allowsSelection = false
        
        configureTopHeaderBuy()
        configureShadow()
        configureBottonBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardNotificationUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardNotificationDown), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        if textField.text.isEmpty {
            textField.text = "Digite sua mensagem"
            textField.textColor = UIColor.lightGray
        }
    }
    
    @objc func handleKeyBoardNotificationDown(notification: NSNotification){
        if let userInfo = notification.userInfo {
            
            let animationTime = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)
            
            self.bottonBarConstraint.constant  = 0
            UIView.animate(withDuration: animationTime as! TimeInterval, delay: 0, options: [.curveEaseIn], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func handleKeyBoardNotificationUp(notification: NSNotification){
                if let userInfo = notification.userInfo {
        
                    let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
                    let animationTime = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)
                    
                    if let height = keyboardFrame?.height {
                            self.bottonBarConstraint.constant -= height
                    }
                    
                    UIView.animate(withDuration: animationTime as! TimeInterval, delay: 0, options: [.curveEaseIn], animations: {
                            self.view.layoutIfNeeded()
                    }, completion: { (finished) in
                        let indexPath = NSIndexPath(row: self.yanzim.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
                        })
                }
    }
    
    func configureShadow(){
        topHeader.layer.shadowOffset = CGSize(width: 0, height: 4)
        topHeader.layer.shadowColor = UIColor(red:0.18, green:0.18, blue:0.22, alpha:0.16).cgColor
        topHeader.layer.shadowOpacity = 1
        topHeader.layer.shadowRadius = 3
    }
    
    func configureBottonBar(){
        
        bottonBar.addSubview(textField)
        bottonBar.addSubview(sendButton)
        bottonBar.backgroundColor = .white
        
        sendButton.backgroundColor = .red
        sendButton.addTarget(self, action: #selector(handleSendMessage), for:UIControl.Event.touchDown)
        
        textField.delegate = self
        textField.text = "Digite sua mensagem"
        textField.textColor = UIColor.lightGray
        if let font = textField.font {
            textField.font = UIFont(name: font.fontName, size: 12)
        }
    
        textField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [sendButton.widthAnchor.constraint(equalToConstant: 19.71),
                           sendButton.heightAnchor.constraint(equalToConstant: 16.02),
                           sendButton.trailingAnchor.constraint(equalTo: bottonBar.trailingAnchor, constant: -19.0),
                           sendButton.centerYAnchor.constraint(equalTo: bottonBar.centerYAnchor, constant: 0),
            
                           textField.topAnchor.constraint(equalTo: bottonBar.topAnchor, constant: 10),
                           textField.bottomAnchor.constraint(equalTo: bottonBar.bottomAnchor, constant: -10),
                           textField.leadingAnchor.constraint(equalTo: bottonBar.leadingAnchor, constant: 17),
                           textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -19),
                           
                           ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func handleSendMessage(){
        if let message = textField.text {
            if let formattedMessage = formatMessage(message: message) {
                    yanzim.append(formattedMessage)
                    let indexPath = NSIndexPath(row: yanzim.count - 1, section: 0)
                    tableView.insertRows(at: [indexPath as IndexPath], with: .right)
                    tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
                    textField.text = ""
            }
        }
    }
    
    func formatMessage(message: String) -> String?{
        if message != ""{
            let formattedMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
            if formattedMessage != ""{
                return formattedMessage
            }
        }
        return nil
    }
    
    func configureTopHeader(){
        topLabel.text = "Volkswagen Fusca"
        topLabel.font = UIFont(name: topLabel.font.fontName, size: 16)
        topLabel.textAlignment = .left
        
        downLabel.text = "Ver informações do vendedor"
        downLabel.textColor = UIColor(red:0.95, green:0.07, blue:0.24, alpha:1)
        downLabel.font = UIFont(name: downLabel.font.fontName, size: 12)
        downLabel.textAlignment = .left
        
        avatarImage.layer.cornerRadius = 22
        avatarImage.layer.masksToBounds = true
        
        avatarImage.backgroundColor = .gray
        arrow.backgroundColor = .gray
        
        carImage.isHidden = true
    }
    
    func configureTopHeaderBuy(){
        topLabel.text = "Lucia Maria"
        topLabel.font = UIFont(name: topLabel.font.fontName, size: 16)
        topLabel.textAlignment = .left
        
        downLabel.text = "CHEVROLET CRUZE 2017"
        downLabel.textColor = UIColor(red:0.18, green:0.18, blue:0.22, alpha:1)
        downLabel.font = UIFont(name: downLabel.font.fontName, size: 12)
        downLabel.textAlignment = .left
        
        avatarImage.layer.cornerRadius = avatarImage.frame.height/2
        avatarImage.layer.masksToBounds = true
        
        carImage.backgroundColor = .red
        carImage.layer.cornerRadius = carImage.frame.height/2
        carImage.layer.masksToBounds = true
        carImage.layer.borderWidth = 2
        carImage.layer.borderColor = UIColor.white.cgColor
        
        avatarImage.backgroundColor = .gray
        arrow.backgroundColor = .gray
    }
    
    // MARK : TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yanzim.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatBubleReuseId, for: indexPath) as! ChatBubbleTableViewCell
        cell.configure(text: yanzim[indexPath.row], type: ChatBubbleType.Sender)
        return cell
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }    
}
