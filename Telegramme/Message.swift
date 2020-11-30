//
//  Message.swift
//  Telegramme
//
//  Created by Yeo Wen Cong on 30/11/20.
//
import Foundation

class Message{
    var date:Date
    var isSender:Bool
    var text:String
    
    init(isSender:Bool, text:String) {
        self.date = Date.init()
        self.isSender = isSender
        self.text = text
    }
    
    init(date:Date, isSender:Bool, text:String) {
        self.date = date
        self.isSender = isSender
        self.text = text
    }
}
