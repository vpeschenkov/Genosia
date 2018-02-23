//
// ValidatorInterface.swift
// Genosia
//
// Copyright 2018 Victor Peschenkov
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// o this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation

protocol ValidatorInterface {
    // MARK: VAriables
    var filePath: String! { get set }
    var fileHelper: FileHelperInterface! { get set }
    
    // MARK: Methods
    func validate() throws
}

extension ValidatorInterface {
    
    func parse() throws -> Content {
        // Reads
        let fileContent = try fileHelper.read(withFilePath: filePath)
        guard let data = fileContent.data(using: .utf8) else {
            throw AppError.filePathIsNil
        }
        
        // Decodes
        let decoder = JSONDecoder()
        guard let content = try? decoder.decode(Content.self, from: data) else {
            throw AppError.mappingError
        }
        
        return content
    }
}
