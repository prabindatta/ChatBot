//
//  Dashboard.swift
//  ChatBot
//
//  Created by Prabin K Datta on 30/11/17.
//  Copyright © 2017 Prabin K Datta. All rights reserved.
//

import UIKit
import AZDialogView

class Dashboard: UIViewController, ChatBotCustomPopoverDelegate {
    @IBOutlet weak var m_chatBotImg: UIImageView!
    @IBOutlet weak var m_chatBotBtn: UIButton!
    @IBOutlet weak var m_chatBotView: UIView!
    @IBOutlet var m_chatBotNotificationView: UIView!
    var chatbots: Array<ChatBot>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.rotateView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupView() {
        self.navigationItem.title = "Dashboard"
        self.navigationItem.hidesBackButton = true
        
        let logoutBarBtn:UIBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogoutBtn))
        self.navigationItem.rightBarButtonItem = logoutBarBtn
    }
    
    func rotateView() {
        let popoverController: ChatBotCustomPopover = ChatBotCustomPopover()
        popoverController.sourceView = self.m_chatBotView
        popoverController.sourceRect = CGRect(x: self.m_chatBotView.bounds.minX, y: self.m_chatBotView.bounds.minY, width: 60, height: 60)
        popoverController.contentSize = CGSize(width: 240, height: 46)
        popoverController.arrowDirection = .down
        popoverController.delegate = self
        
        self.present(popoverController, animated: true) {
            popoverController.insertContentIntoPopover(content: { (popover: ChatBotCustomPopover, popoverPresentedSize: CGSize, popoverArrowHeight: CGFloat) in
                Bundle.main.loadNibNamed("ChatbotNotificationView", owner: self, options: nil)
                self.m_chatBotNotificationView.sizeToFit()
                print("x: \(popover.view.bounds.midX) y: \(popover.view.bounds.midY)")
                self.m_chatBotNotificationView.center = CGPoint(x: popover.view.bounds.midX, y: popover.view.bounds.midY)
                popover.view.addSubview(self.m_chatBotNotificationView)
            })
        }
        
        UIView.animate(withDuration: 0.9, delay: 0.0, options: [.curveLinear,.repeat, .autoreverse], animations: { () -> Void in
            self.m_chatBotImg.transform = CGAffineTransform(scaleX: 0,y: 0)
            self.m_chatBotImg.transform = CGAffineTransform(scaleX: -1,y: 1)
        }) { (finished) -> Void in
//            self.rotateView()
        }
    }
    
    @objc func didTapLogoutBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapChatBotBtn(_ sender: Any) {
        
        Client.chatBot().getChatBotList(begin: { () -> Void in
//            if !self.isCurrentViewActive() {
//                self.fetching = false
//                return
//            }
        }, success: { (result) -> Void in
            objc_sync_enter(self)
            self.chatbots = result.items
            objc_sync_exit(self)

            DispatchQueue.main.async {
                self.showDialog(true, self.chatbots![0])
            }
            
        }, error: { (statusCode, errorResponse) -> Void in
//            if !self.isCurrentViewActive() {
//                self.fetching = false
//                return
//            }
//
//            self.m_TableView.reloadData()
        }, complete: { () -> Void in
            // Leave Empty
        })
    }
    
    func showDialog(_ loopDialop: Bool, _ data: ChatBot) {
        let dialog = AZDialogViewController(title: "ChatBot", message: data.chatbotQues)
        dialog.dismissDirection = .bottom
        dialog.dismissWithOutsideTouch = true
        dialog.showSeparator = false
        dialog.separatorColor = UIColor.blue
        dialog.allowDragGesture = false

        dialog.imageHandler = { (imageView) in
            imageView.image = UIImage(named: "chatbot")
            imageView.contentMode = .scaleAspectFill
            return true //must return true, otherwise image won't show.
        }
        
        for answer_data in data.chatbotAnswers {
            dialog.addAction(AZDialogAction(title: answer_data.answer) { (dialog) -> (Void) in
                //add your actions here.
                dialog.dismiss(animated: true, completion: {
                    if answer_data.childCode != 0 {
                        let index = self.findIndex(child: answer_data.childCode)
                        self.showDialog(false, self.chatbots![index])
                    }
                })
                
            })
        }
        
        dialog.cancelEnabled = true
        dialog.cancelButtonStyle = { (button,height) in
            //            button.tintColor = self.primaryColor
            button.setTitle("CANCEL", for: [])
            return true //must return true, otherwise cancel button won't show.
        }
        
        dialog.show(in: self)
    }
    
    func findIndex(child: NSInteger) -> NSInteger {
        for (index, value) in self.chatbots!.enumerated() {
            if value.chatbotCode == child {
                return index
            }
        }
        return 0
    }
    
    //MARK: ChatBotCustomPopoverDelegate
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func popoverPresentationController(popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverToRect rect: CGRect, inView view: UIView) {
        
    }
}
