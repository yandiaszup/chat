//
//  ViewController.swift
//  messagingapp
//
//  Created by Yan Dias on 03/05/19.
//  Copyright © 2019 Yan Dias. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topHeader: UIView! {
        didSet {
            topHeader.layer.shadowOffset = CGSize(width: 0, height: 4)
            topHeader.layer.shadowColor = UIColor(red:0.18, green:0.18, blue:0.22, alpha:0.16).cgColor
            topHeader.layer.shadowOpacity = 1
            topHeader.layer.shadowRadius = 3
        }
    }
    
    @IBOutlet weak var bottonBar: UIView!
    @IBOutlet weak var bottonBarConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            avatarImage.layer.cornerRadius = 22
            avatarImage.layer.masksToBounds = true
            avatarImage.backgroundColor = .gray
        }
    }
    
    @IBOutlet weak var topLabel: UILabel!
    
    private let sendButton = UIButton()
    private let messageTextView = UITextView()
    
    let chatBubleReuseId = "cell"
    var sections = ["hoje"]
    var messagesList = [[("Lorem ipsum dolor sit amet, consectetur adipiscing elit.",true),("Nam molestie bibendum ante, vehicula tincidunt turpis placerat non. Aenean varius molestie lobortis. Nulla venenatis ut eros nec hendrerit",false),("Nam molestie bibendum ante, vehicula tincidunt turpis placerat non. Aenean varius molestie lobortis. Nulla venenatis ut eros nec hendrerit",true),("Nam molestie bibendum ante, vehicula tincidunt turpis placerat non. Aenean varius molestie lobortis. Nulla venenatis ut eros nec hendrerit",false)],[("Praesent et molestie ante. Etiam id vulputate mi. Cras id luctus urna. Donec vitae enim porttitor mi euismod dignissim. Vivamus turpis dolor, aliquam non risus a, gravida pharetra leo.",true),("Praesent et molestie ante.",false)]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dummyViewHeight = CGFloat(40)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
        self.tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.94, alpha:1)
        tableView.allowsSelection = false

        configureTopHeader()
        configureBottonBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardNotificationUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardNotificationDown), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        tableView.keyboardDismissMode = .interactive
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        if messageTextView.text.isEmpty {
            messageTextView.text = "Digite sua mensagem"
            messageTextView.textColor = UIColor.lightGray
            setSendButtonCollor(enabled: false)
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
                        let indexPath = NSIndexPath(row: self.messagesList.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
                        })
                }
    }
    
    func configureBottonBar(){
        
        bottonBar.addSubview(messageTextView)
        bottonBar.addSubview(sendButton)
        bottonBar.backgroundColor = .white
        sendButton.addTarget(self, action: #selector(handleSendMessage), for:UIControl.Event.touchDown)
        
        let image = UIImage(named: "Ícone_Enviar")?.withRenderingMode(.alwaysTemplate)
        sendButton.setImage(image, for: .normal)
        setSendButtonCollor(enabled: false)
        
        messageTextView.delegate = self
        messageTextView.text = "Digite sua mensagem"
        messageTextView.textColor = UIColor.lightGray
        
        if let font = messageTextView.font {
            messageTextView.font = UIFont(name: font.fontName, size: 12)
        }
    
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [sendButton.widthAnchor.constraint(equalToConstant: 40.0),
                           sendButton.heightAnchor.constraint(equalToConstant: 40.0),
                           sendButton.trailingAnchor.constraint(equalTo: bottonBar.trailingAnchor, constant: -19.0),
                           sendButton.centerYAnchor.constraint(equalTo: bottonBar.centerYAnchor, constant: 0),
            
                           messageTextView.topAnchor.constraint(equalTo: bottonBar.topAnchor, constant: 10),
                           messageTextView.bottomAnchor.constraint(equalTo: bottonBar.bottomAnchor, constant: -10),
                           messageTextView.leadingAnchor.constraint(equalTo: bottonBar.leadingAnchor, constant: 17),
                           messageTextView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -19),
                           
                           ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func handleSendMessage(){
        if messageTextView.text != "Digite sua mensagem"{
            if let message = messageTextView.text {
                if let formattedMessage = formatMessage(message: message) {
                    messagesList[1].append((formattedMessage,false))
                    let indexPath = NSIndexPath(row: messagesList[1].count - 1, section: 1)
                    tableView.insertRows(at: [indexPath as IndexPath], with: .right)
                    tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
                    messageTextView.text = ""
                    setSendButtonCollor(enabled: false)
                }
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
    
    func configureTopHeader() {
        avatarImage.layer.cornerRadius = 22
        avatarImage.layer.masksToBounds = true
        avatarImage.backgroundColor = .gray
        topLabel.text = "Yan Lucas"
    }
    
    // MARK : TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messagesList[indexPath.section][indexPath.row].1 {
            let cell = Bundle.main.loadNibNamed("ReceiverChatTableViewCell", owner: self, options: nil)?.first as! ReceiverChatTableViewCell
            cell.setup(message: messagesList[indexPath.section][indexPath.row].0)
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("SenderhatTableViewCell", owner: self, options: nil)?.first as! SenderhatTableViewCell
            cell.setup(message: messagesList[indexPath.section][indexPath.row].0)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "hoje"
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            setSendButtonCollor(enabled: false)
        } else {
            setSendButtonCollor(enabled: true)
        }
    }
    
    func setSendButtonCollor(enabled: Bool){
        if enabled {
            sendButton.tintColor = .black
        } else {
            sendButton.tintColor = .lightGray
        }
    }
    
    func createHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 17))
        headerView.backgroundColor = .clear
        let date = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 17))
        headerView.addSubview(date)
        date.text = "Hoje"
        date.textAlignment = .center
        date.font = UIFont(name: date.font.fontName, size: 12)
        date.translatesAutoresizingMaskIntoConstraints = false
        date.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 0).isActive = true
        date.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 0).isActive = true
        return headerView
    }
}

