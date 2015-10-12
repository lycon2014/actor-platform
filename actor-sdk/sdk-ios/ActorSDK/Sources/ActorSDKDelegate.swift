//
//  Copyright (c) 2014-2015 Actor LLC. <https://actor.im>
//

import Foundation

/// Actor SDK Delegate that helps you customize logic of messenger
public protocol ActorSDKDelegate {
    
    /// Create initial Auth contoller. With Navigation controller (if needed).
    func actorControllerForAuthStart() -> UIViewController
    
    /// Create root logged in controller. With Navigation controller (if needed).
    func actorControllerForStart() -> UIViewController

    /// Create root controller after controller. With Navigation controller (if needed).
    func actorControllerAfterLogIn() -> UIViewController
    
    /// User profile controller
    func actorControllerForUser(uid: Int) -> AAViewController
    
    /// User profile controller
    func actorControllerForGroup(gid: Int) -> AAViewController
    
    /// Conversation controller
    func actorControllerForConversation(peer: ACPeer) -> UIViewController
    
    /// Configuration of bubble cells
    func actorConfigureBubbleLayouters(builtIn: [AABubbleLayouter]) -> [AABubbleLayouter]
    
    /// Called after header is created in settings page
    func actorSettingsHeaderDidCreated(controller: AASettingsViewController, section: AAManagedSection)

    /// Called after header is created in settings page
    func actorSettingsConfigurationWillCreated(controller: AASettingsViewController, section: AAManagedSection)

    /// Called after header is created in settings page
    func actorSettingsConfigurationDidCreated(controller: AASettingsViewController, section: AAManagedSection)
    
    /// Called after header is created in settings page
    func actorSettingsSupportWillCreated(controller: AASettingsViewController, section: AAManagedSection)
    
    /// Called after header is created in settings page
    func actorSettingsSupportDidCreated(controller: AASettingsViewController, section: AAManagedSection)
}

/// Default values of SDK Delegate
public extension ActorSDKDelegate {
    
    /// Default phone activation
    public func actorControllerForAuthStart() -> UIViewController {
        return AAAuthNavigationController(rootViewController: AAAuthPhoneViewController())
    }
    
    /// Default app layout
    public func actorControllerForStart() -> UIViewController {
        let tab = AARootTabViewController()
        tab.viewControllers = [
            AANavigationController(rootViewController: AAContactsViewController()),
            AANavigationController(rootViewController: AARecentViewController()),
            AANavigationController(rootViewController: AASettingsViewController())]
        tab.selectedIndex = 0
        tab.selectedIndex = 1
        
        let rootController : UIViewController
        if (AADevice.isiPad) {
            let splitController = AARootSplitViewController()
            splitController.viewControllers = [tab, AANoSelectionViewController()]
            rootController = splitController
        } else {
            rootController = tab
        }
        return rootController
    }
    
    public func actorControllerForUser(uid: Int) -> AAViewController {
        return AAUserViewController(uid: uid)
    }
    
    func actorControllerForGroup(gid: Int) -> AAViewController {
        return AAGroupViewController(gid: gid)
    }
    
    func actorControllerForConversation(peer: ACPeer) -> UIViewController {
        return ConversationViewController(peer: peer)
    }
    
    public func actorConfigureBubbleLayouters(builtIn: [AABubbleLayouter]) -> [AABubbleLayouter] {
        return builtIn
    }
    
    public func actorControllerAfterLogIn() -> UIViewController {
        return actorControllerForStart()
    }
    
    public func actorSettingsHeaderDidCreated(controller: AASettingsViewController, section: AAManagedSection) {
        
    }
    
    public func actorSettingsConfigurationWillCreated(controller: AASettingsViewController, section: AAManagedSection) {
        
    }
    
    public func actorSettingsConfigurationDidCreated(controller: AASettingsViewController, section: AAManagedSection) {
        
    }
    
    public func actorSettingsSupportWillCreated(controller: AASettingsViewController, section: AAManagedSection) {
        
    }
    
    public func actorSettingsSupportDidCreated(controller: AASettingsViewController, section: AAManagedSection) {
        
    }
}

/// Default empty implementation of SDK Delegate
class ActorSDKDelegateDefault: ActorSDKDelegate {
    
}