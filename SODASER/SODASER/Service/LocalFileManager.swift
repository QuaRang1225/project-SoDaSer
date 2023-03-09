//
//  LocalFileManager.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/13.
//

import Foundation
import SwiftUI

class LocalFileManager{
    
    static let instance = LocalFileManager()
    
    func save(image:UIImage,imageName:String,folderName:String){
        createFolder(folderName: folderName)    //폴더 생성
        
        //이미지 경로 확보
        guard
            let data = image.pngData(),
            let url = getUrlImage(imageName: imageName, folderName: folderName)
        else {return}
        
        //이미지 경로에 저장
        do{
            try data.write(to: url)
        }catch let error{
            print("이미지 저장실패. 이미지 이름 \(imageName) : \(error.localizedDescription)")
        }
    }
    
    func getImage(imageName:String,folderName:String) -> UIImage?{
        guard
            let url = getUrlImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else {return nil}
        return UIImage(contentsOfFile: url.path)
    }
   
    
    
    private func createFolder(folderName:String){
        guard
            let url = getUrlFolder(folderName: folderName)
        else {return}
        if !FileManager.default.fileExists(atPath: url.path){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("저장공간 생성 실패. 폴더이름: \(folderName) : \(error.localizedDescription)")
            }
        }
    }
    
    private func getUrlFolder(folderName:String)-> URL?{
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{return nil}
        return url.appendingPathComponent(folderName)
    }
    
    private func getUrlImage(imageName:String,folderName:String) -> URL?{
        guard let folderUrl = getUrlFolder(folderName: folderName) else {return nil}
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
    
    
    func saveFile(stringData: String, fileName: String) {
            let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let sampleFileName = directory.appendingPathComponent(fileName)
            do {
                try stringData.write(to: sampleFileName, atomically: true, encoding: .utf8)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    func loadFile(name: String) -> String? {
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
            let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if let dirPath = paths.first {
                let file = URL(fileURLWithPath: dirPath).appendingPathComponent(name)
                if let data = try? Data(contentsOf: file) {
                    let dataString = String(data: data, encoding: .utf8)
                    return dataString
                }
                return nil
            }
            return nil
        }
}
