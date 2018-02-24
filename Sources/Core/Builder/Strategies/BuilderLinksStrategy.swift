//
// BuilderLinksStrategy.swift
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

class BuilderLinksStrategy: BuilderStrategyInterface {
    var filePath: String!
    var fileHelper: FileHelperInterface!
    var starsHelper: StarsHelperInterface!
    var countryHelper: CountyHelperInterface!
    
    // MARK: Implementation
    
    func build() throws {
        let content = try parse()
        let activeApps = content.apps.filter(activeFilter())
        
        var info = [String]()
        var uniques = [String]()
        for app in activeApps {
            if let source = app.source {
                uniques.append(source.absoluteString)
            }
            if let screenshots = app.screenshots {
                for screenshot in screenshots {
                    uniques.append(screenshot.absoluteString)
                }
            }
            if let itunes = app.itunes {
                info.append(itunes.absoluteString)
            }
        }
        
        for (index, link) in uniques.enumerated() {
            print("\(index) \(link)")
        }
        
        try fileHelper.write(withFilePath: "check-unique.txt", content: uniques.joined(separator: "\n"))
        try fileHelper.write(withFilePath: "check-info.txt", content: info.joined(separator: "\n"))
        
        var links = [String]()
        for app in activeApps {
            links.append(app.title)
            if let homepage = app.homepage {
                links.append(homepage)
            }
            if let description = app.description {
                links.append(description)
            }
        }
        
        for category in content.categories {
            links.append(category.title)
        }
        
        for (index, link) in links.enumerated() {
            print("\(index) \(link)")
        }
        
        try fileHelper.write(withFilePath: "check-links.txt", content: links.joined(separator: "\n"))
    }
}
