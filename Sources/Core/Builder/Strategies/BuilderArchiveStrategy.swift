//
// BuilderArchiveStrategy.swift
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

class BuilderArchiveStrategy: BuilderStrategyInterface {
    var filePath: String!
    var fileHelper: FileHelperInterface!
    var starsHelper: StarsHelperInterface!
    var countryHelper: CountyHelperInterface!
    
    // MARK: Implementation
    
    func build() throws {
        let content = try parse()
        let categories = content.categories.filter { category in
            return content.apps.filter(archiveFilter()).count > 0
        }
        
        var generated = ""
        // Title
        generated += "# \(content.title) Archive"
        generated += "\n\n"
        // Description
        generated += "This is an archive of the [main list](https://github.com/dkhamsing/open-source-ios-apps)"
        generated += " for projects that are no longer maintained / old."
        generated += "\n\n"
        // Apps by category
        for category in categories {
            var apps = content.apps.filter(archiveFilter()).sorted { $0.title < $1.title }
            apps = apps.filter { $0.categoryIds?.contains(category.id) ?? false }
            for app in apps {
                generated += generateApp(app)
                generated += "\n"
            }
        }
        generated += "\n"
        // Footer
        generated += "\(content.footer)"
        // Write
        try fileHelper.write(withFilePath: "ARCHIVE.MD", content: generated)
        print("ARCHIVE.MD 👍")
    }
    
    // MARK: Private
    
    private func generateApp(_ app: App) -> String {
        var generated = ""
        // Title
        generated += "- \(app.title)"
        // Source
        if let source = app.source {
            generated += "\(source)"
        }
        return generated
    }
}
