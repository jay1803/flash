//
//  ShareViewController.swift
//  Share
//
//  Created by Max Zhang on 2022/5/21.
//

import UIKit
import Social
import MobileCoreServices
import RealmSwift

class ShareViewController: SLComposeServiceViewController {
    
    // MARK: - Properties
    private var realmManager = RealmManager(name: "flash")
    private var showReplySelection = "New note"
    
    // MARK: - PrivateFunctions
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placeholder = "Please enter description"
    }

    // MARK: - ShareViewController
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        let extensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        guard let itemProvider: NSItemProvider = extensionItem.attachments?.first else { return }
        let propertyList = String(kUTTypeURL)
        print(String(repeating: "+", count: 100))
        print(itemProvider)
        if itemProvider.hasItemConformingToTypeIdentifier(propertyList) {
            itemProvider.loadItem(forTypeIdentifier: propertyList, options: nil, completionHandler: { (item, error) -> Void in
                print(String(repeating: "+", count: 100))
                print(item, error)
                guard let sharedURL = item as? URL else { return }
                print(String(repeating: "+", count: 100))
                print(sharedURL)
                OperationQueue.main.addOperation {
                    let urlString = sharedURL.absoluteString
                    self.realmManager.add(entry: Entry(content: urlString))
                }
            })
        } else {
            print("error")
        }
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
