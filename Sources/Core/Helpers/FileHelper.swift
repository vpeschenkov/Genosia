//
// FileHelper.swift
// genosia
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

class FileHelper: FileHelperInterface {
    func read(withFilePath filePath: String) throws -> String  {
        do {
            if #available(OSX 10.11, *) {
                let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
                let content = try String(contentsOf: URL(fileURLWithPath: filePath, relativeTo: url))
                return content
            } else {
                throw AppError.readFileError
            }
        }
        catch {
            throw AppError.readFileError
        }
    }
    
    func write(withFilePath filePath: String, content: String) throws {
        do {
            try content.write(to: URL(fileURLWithPath: filePath), atomically: true, encoding: .utf8)
        }
        catch {
            throw AppError.writeFileError
        }
    }
}
