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
//            UIView.setAnimationRepeatCount(2)
//            self.m_chatBotBtn.layer.transform = CATransform3DMakeRotation(CGFloat.pi, 1, 0, 0)
//            self.m_chatBotNotificationView.isHidden = false
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
        let dialog = AZDialogViewController(title: "ChatBot", message: "Do you need any help?")
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
        
        dialog.addAction(AZDialogAction(title: "Help 1") { (dialog) -> (Void) in
            //add your actions here.
            dialog.dismiss()
        })
        
        dialog.addAction(AZDialogAction(title: "Help 2") { (dialog) -> (Void) in
            //add your actions here.
            dialog.dismiss()
        })
        
        dialog.addAction(AZDialogAction(title: "Help 3") { (dialog) -> (Void) in
            //add your actions here.
            dialog.dismiss()
        })
        
        dialog.addAction(AZDialogAction(title: "Help 4") { (dialog) -> (Void) in
            //add your actions here.
            dialog.dismiss()
        })
        
        dialog.addAction(AZDialogAction(title: "Help 5") { (dialog) -> (Void) in
            //add your actions here.
            dialog.dismiss()
        })
        
        dialog.cancelEnabled = true
        dialog.cancelButtonStyle = { (button,height) in
//            button.tintColor = self.primaryColor
            button.setTitle("CANCEL", for: [])
            return true //must return true, otherwise cancel button won't show.
        }
        
        dialog.show(in: self)

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
