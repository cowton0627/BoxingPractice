//
//  ViewController.swift
//  BoxingPractice
//
//  Created by Chun-Li Cheng on 2023/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var bindingBtn: UIButton!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var anotherBindingBtn: UIButton!
    
    @IBOutlet weak var myLabel: UILabel!
    
    // KVO
//    var observation: NSKeyValueObservation?
//    @objc private dynamic var isSelected: Bool = false
    
    // KVC
//    @objc private dynamic var isSelected: Bool = false
//    {
//        didSet {
//            if isSelected {
//                bindingBtn.setTitle("選中", for: .normal)
//            } else {
//                bindingBtn.setTitle("未選", for: .normal)
//            }
//        }
//    }
    
    // Notification Center
//    private var isSelected = false
    
    // Boxing
    private var isSelected = Box(false)
    private var isChanged = Box(false)
//    var box = Box(3)
//    var boxbox = Box("string")
    
//    private let boxedInt = Box(123)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Data Binding，Boxing
//        let boxedInt = Box(123)
//        boxedInt.bind { _ in
////            self.bindingBtn.titleLabel?.text = "\(self.boxedInt.value)"
//            self.bindingBtn.setTitle("\(self.boxedInt.value)", for: .normal)
//        }
//        boxedInt.value = 456
    
        isSelected.bind { isSelected in
            if isSelected {
                self.bindingBtn.setTitle("選中", for: .normal)
            } else {
                self.bindingBtn.setTitle("未選", for: .normal)
            }
        }

        isSelected.bind { selected in
            if selected {
                self.anotherBindingBtn.setImage(UIImage(systemName: "plus"), for: .normal)
            } else {
                self.anotherBindingBtn.setImage(UIImage(systemName: "minus"), for: .normal)
            }
        }
        
//        isChanged.bind { changed in
//            if changed {
//                self.bindingBtn.setImage(UIImage(systemName: "plus"), for: .normal)
//            } else {
//                self.bindingBtn.setImage(UIImage(systemName: "minus"), for: .normal)
//            }
//        }
        
//        var boxbox = BoxBox(value: 3)
        
//        boxbox.listener = { newValue in
//            print("Value changed to: \(newValue)")
//            self.myLabel.text = "\(newValue)"
//        }
        
//        boxbox.bind { intValue in
//            print("value changed to: \(intValue)")
//            self.myLabel.text = "\(intValue)"
//        }
        
//        boxbox.value = 5
//        boxbox.value = 6
        
//        print(box.value)
//        print(boxbox.value)
        
        // KVO
//        observation = observe(\.isSelected, options: [.new], changeHandler: { (object, change) in
//            if let newValue = change.newValue {
//                print("isSelected changed to: \(newValue)")
//
//                if newValue {
//                    self.bindingBtn.setTitle("選中", for: .normal)
//                } else {
//                    self.bindingBtn.setTitle("未選", for: .normal)
//                }
//            }
//        })
        
        // Notification Center
//        NotificationCenter.default.addObserver(self, selector: #selector(stateChanged), name: Notification.Name("isSelectedToggle"), object: nil)
    }
    
    // Notification Center
//    @objc func stateChanged(noti: Notification) {
//        if isSelected {
//            bindingBtn.setTitle("選中", for: .normal)
//        } else {
//            bindingBtn.setTitle("未選", for: .normal)
//        }
//    }

    @IBAction func bindingBtnTapped(_ sender: UIButton) {
        isSelected.value.toggle()
        
        // KVC、KVO
//        let currentSelectedValue = value(forKey: "isSelected") as? Bool ?? false
//        setValue(!currentSelectedValue, forKey: "isSelected")
        
        // Notification Center
//        isSelected.toggle()
//        NotificationCenter.default.post(name: Notification.Name("isSelectedToggle"), object: nil)
    }
    
    @IBAction func anotherBindingBtnTapped(_ sender: UIButton) {
        isChanged.value.toggle()
//        boxedInt.value = 456
    }
    
    
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        myLabel.text = "\(sender.value)"
    }
    
}

final class Box<T> {
    typealias Listener = (T) -> Void
    
//    private(set) var listener: Listener?
    var listener: Listener?         // Single Binding
//    var listeners: [Listener] = []  // Multi Binding
    
    var value: T {
        didSet {
            // Multi Binding
//            listeners.forEach({ listener in
//                listener(value)
//            })
            // Single Binding
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping Listener) {
        self.listener = listener            // Single Binding
//        self.listeners.append(listener)     // Multi Binding
        listener(value)
    }
}

//class BoxBox<T> {
//    var value: T {
//        didSet {
//            listener?(value)
//        }
//    }
//
//    var listener: ((T) -> Void)?
//
//    init(value: T) {
//        self.value = value
//    }
//
//    func bind(listener: @escaping (T) -> Void) {
//        self.listener = listener
//        listener(value)
//    }
//}


