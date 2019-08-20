//
//  DocumentsDirectoryHandler.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-20.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import Foundation

class DocumentsDirectoryHandler {
    
    static let shared = DocumentsDirectoryHandler()
    
    private var documentsDirectoryURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    private func filePath(_ fileName: String) -> String? {
        return documentsDirectoryURL?.appendingPathComponent(fileName).path
    }
    
    @discardableResult
    func createFile<T: Codable>(_ fileName: String, object: T) -> Bool{
        guard let filePath = filePath(fileName) else { return false }
        
        do {
            let data = try JSONEncoder().encode(object)
            FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
            
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    func removeFile(_ fileName: String) -> Bool {
        guard let filePath = filePath(fileName) else { return false }
        
        guard FileManager.default.fileExists(atPath: filePath) else { return false }
        
        do {
            try FileManager.default.removeItem(atPath: filePath)
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    func getContents<T: Codable>(_ fileName: String) -> T? {
        guard let filePath = filePath(fileName) else { return nil }
        
        guard FileManager.default.fileExists(atPath: filePath) else { return nil }
        
        guard let data = FileManager.default.contents(atPath: filePath) else { return nil }
        
        do {
            let val = try JSONDecoder().decode(T.self, from: data)
            return val
        } catch {
            return nil
        }
    }
}
