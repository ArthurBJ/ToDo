//
//  Resources.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 05.10.2023.
//

import UIKit

enum Resources {
    
    static var mainTableReuseId = "tableReuseId"
    static var detailTableReuseId = "DetailPageTableViewCell"
    
    enum Colors {
        static var backgroundColor = UIColor(hexString: "#FFFDFF")
        static var inActiveButton = UIColor(hexString: "#9F9E9F")
        static var activeButton = UIColor(hexString: "#016DFB")
        static var titleFontColor = UIColor(hexString: "#000000")
        static var descriptionFontColor = UIColor(hexString: "#AEAEAE")
        
        static var doneSwipe = UIColor(hexString: "#2DBD4E")
        static var deleteSwipe = UIColor(hexString: "#FD3229")
        static var changeSwipe = UIColor(hexString: "#FDC400")
    }
    
    enum Images {
        static var addCategory = UIImage(systemName: "plus")
        static var backButton = UIImage(systemName: "arrowshape.backward.fill")
        
        static var checkBox = UIImage(systemName: "circle")
        static var checkBoxDone = UIImage(systemName: "circle.fill")
    }
    
    enum Strings {
        static var toDoTitle = "ToDo"
    }
}
