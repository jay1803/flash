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
import UniformTypeIdentifiers.UTType

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
        let URLTypeIdentifier = String(kUTTypeURL)
        let imageTypeIdentifier = String(kUTTypeImage)
        if itemProvider.hasItemConformingToTypeIdentifier(URLTypeIdentifier) {
            itemProvider.loadItem(forTypeIdentifier: URLTypeIdentifier, options: nil, completionHandler: { (item, error) -> Void in
                guard let sharedURL = item as? URL else { return }
                OperationQueue.main.addOperation {
                    let urlString = sharedURL.absoluteString
                    var content = urlString
                    if self.contentText != nil {
                        content = "\(urlString)\n\(self.contentText!)"
                    }
                    self.realmManager.add(entry: Entry(content: content))
                }
            })
        } else if itemProvider.hasItemConformingToTypeIdentifier(imageTypeIdentifier) {
            itemProvider.loadItem(forTypeIdentifier: imageTypeIdentifier, options: nil, completionHandler: { (item, error) -> Void in
                guard let sharedURL = item as? URL else { return }
                do {
                    let imageData = try Data(contentsOf: sharedURL)
                    OperationQueue.main.addOperation {
                        guard let image = UIImage(data: imageData) else { return }
                        let imageName = UUID().uuidString
                        saveToJPG(image: image, name: imageName)
                        let attachment = Attachment()
                        attachment.fileName = imageName
                        attachment.fileType = "jpg"
                        var content = "image"
                        if let text = self.contentText {
                            content = text
                        }
                        let entry = Entry(content: content)
                        entry.attachments.append(attachment)
                        self.realmManager.add(entry: entry)
                    }
                } catch {
                    fatalError(error.localizedDescription)
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
