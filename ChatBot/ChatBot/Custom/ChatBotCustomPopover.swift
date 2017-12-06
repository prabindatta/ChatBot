//
//  PKDCustomerPopover.swift
//  ChatBot
//
//  Created by Prabin K Datta on 01/12/17.
//  Copyright © 2017 Prabin K Datta. All rights reserved.
//

import Foundation

protocol ChatBotCustomPopoverDelegate {
    /*!
     Popover notifies the delegate, that the popover needs to reposition it's location.
     */
    func popoverPresentationController(popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverToRect rect: CGRect, inView view: UIView);
    
    /*!
     Popover asks the delegate, whether it should dismiss itself.
     */
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool;
    
    /*!
     Popover notifies the delegate, that popover did dismiss itself.
     */
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController);
    
}


class ChatBotCustomPopover: UIViewController, UIPopoverPresentationControllerDelegate {
    // Popover's delegate.
    var delegate: ChatBotCustomPopoverDelegate?
    
    // Use this property to configure where popover's arrow should be pointing.
    var arrowDirection: UIPopoverArrowDirection?
    
    // The view containing the anchor rectangle for the popover.
    var sourceView: UIView?
    
    // The rectangle in the specified view in which to anchor the popover.
    var sourceRect: CGRect?
    
    // The preferred size for the popover’s view.
    var contentSize: CGSize?
    
    // The color of the popover’s backdrop view.
    var backgroundColor: UIColor?
    
    // An array of views that the user can interact with while the popover is visible.
    var passthroughViews: NSArray?
    
    //The margins that define the portion of the screen in which it is permissible to display the popover.
    var popoverLayoutMargins: UIEdgeInsets?
    
    
    /*!
     Use this method to put your custom views into popover.
     @param content Use this block to supply your custom elements, that will be shown inside popover element.
     @param popover Reference to ARSPopover, so you could add element to it's subview.
     @param popoverPresentedSize Popover's size after it is being presented.
     @param popoverArrowHeight Height of the arrow.
     
     @warning Be sure to call insertContentIntoPopover: only after you have presented it, otherwise popoverPresentationSize frame might be of wrong size.
     
     @code
     [popoverController insertContentIntoPopover:^(ARSPopover *popover) {
     UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     [button setTitle:@"Works?" forState:UIControlStateNormal];
     [button sizeToFit];
     [button setCenter:CGPointMake(50, 25)];
     [button addTarget:popover
     action:@selector(closePopover)
     forControlEvents:UIControlEventTouchUpInside];
     
     [popover.view addSubview:button];
     }];
     @endcode
     
     */
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initializePopover()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializePopover()
    }
    
    func initializePopover() {
        self.modalPresentationStyle = .popover;
        self.popoverPresentationController?.delegate = self;
    }
    
    //MARK: Actions
    func insertContentIntoPopover(content: (_ popover: ChatBotCustomPopover, _ popoverPresentedSize: CGSize ,_ popoverArrowHeight: CGFloat ) -> Void) {
        let presentationArrowHeight: CGFloat = 12.0;
        let width: CGFloat  = (self.popoverPresentationController?.frameOfPresentedViewInContainerView.size.width)!
        let height: CGFloat = (self.popoverPresentationController?.frameOfPresentedViewInContainerView.size.height)!
        let popoverSize: CGSize = CGSize(width: width, height: height)
        
        content(self, popoverSize, presentationArrowHeight)
    }
    
    /*!
     Helpers method, invoking wich will close the popover.
     */
    @objc func closePopover() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Popover Presentation Controller Delegate
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {

        self.popoverPresentationController?.sourceView = self.sourceView != nil ? self.sourceView : self.view
        self.popoverPresentationController?.sourceRect = self.sourceRect!
        self.preferredContentSize = self.contentSize!
        
        popoverPresentationController.permittedArrowDirections = self.arrowDirection!
        popoverPresentationController.passthroughViews = self.passthroughViews as? [UIView] ?? nil
        popoverPresentationController.backgroundColor = self.backgroundColor ?? nil
//        popoverPresentationController.popoverLayoutMargins = self.popoverLayoutMargins
    }
    
    func popoverPresentationController(_ popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverTo rect: UnsafeMutablePointer<CGRect>, in view: AutoreleasingUnsafeMutablePointer<UIView>) {
        let lrect: CGRect = rect.pointee
        let lview: UIView = view.pointee
        self.delegate?.popoverPresentationController(popoverPresentationController: popoverPresentationController, willRepositionPopoverToRect: lrect, inView: lview)
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return (self.delegate?.popoverPresentationControllerShouldDismissPopover(popoverPresentationController: popoverPresentationController))!
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        self.delegate?.popoverPresentationControllerDidDismissPopover(popoverPresentationController: popoverPresentationController)
    }
    
    //MARK: Adaptive Presentation Controller Delegate
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
}
