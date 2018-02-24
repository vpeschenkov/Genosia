//
// BuilderDefaultStrategy.swift
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

class BuilderReadmeStrategy: BuilderStrategyInterface {
    var filePath: String!
    var fileHelper: FileHelperInterface!
    var starsHelper: StarsHelperInterface!
    var countryHelper: CountyHelperInterface!
    
    // MARK: Implementation
    
    func build() throws {
        let content = try parse()
        var generated = ""
        // Title
        generated += "# \(content.title)"
        generated += "\n\n"
        // Description
        generated += "\(content.description)"
        generated += "\n\n"
        // Subtitle
        generated += "\(content.subtitle)"
        generated += "\n\n"
        // Badges
        let date = dateFormatter.string(from: Date()).replacingOccurrences(of: " ", with: "%20")
        generated += "![](https://img.shields.io/badge/Projects-\(content.apps.count)-green.svg)"
        generated += " "
        generated += "[![](https://img.shields.io/badge/Twitter-@opensourceios-blue.svg)](https://twitter.com/opensourceios)"
        generated += " "
        generated += "![](https://img.shields.io/badge/Updated-\(date)-lightgrey.svg)"
        // Jump to
        generated += "\n\n"
        generated += "Jump to"
        generated += "\n\n"
        // List of categories
        for category in content.categories {
            generated += "- [\(category.title)](#\(category.id))"
            generated += "\n"
            for children in content.categories where children.parent == category.id {
                generated += "  - [\(children.title)](#\(children.id))"
                generated += "\n"
            }
        }
        generated += "- [Thanks](#thanks)"
        generated += "\n"
        generated += "- [Contact](#contact)"
        generated += "\n\n"
        generated += "\(content.header)"
        generated += "\n\n"
        // Apps by category
        for category in content.categories {
            generated += "## \(category.title)"
            generated += "\n\n"
            generated += "[back to top](#readme)"
            generated += "\n\n"
            var apps = content.apps.filter { ($0.categoryIds?.contains(category.id)) ?? false }
            apps.sort { $0.title < $1.title }
            for app in apps {
                generated += generateApp(app)
            }
        }
        // Footer
        generated += "\(content.footer)"
        // Write
        try fileHelper.write(withFilePath: "README.MD", content: generated)
        print("README.MD 👍")
    }
    
    // MARK: Private
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter
    }()
    
    private func generateApp(_ app: App) -> String {
        var generated = ""
        // Title
        generated += "- \(app.title)"
        // Description
        if let description = app.description {
            generated +=  ": \(description)"
        }
        // Itunes
        if let itunes = app.itunes {
            generated += " "
            generated += "[` App Store`](\(itunes))"
            generated += "\n"
        } else {
            generated += "\n"
        }
        // Details
        generated += "  <details>\n"
        generated += "\n"
        generated += "    <summary>"
        // Tags
        if let tags = app.tags {
            for tag in tags {
                generated += "\n"
                generated += "      <code>#\(tag.lowercased())</code> "
            }
        }
        else {
            generated += "\n"
            generated += " <code>swift</code>"
        }
        // Language
        if let language = app.language {
            generated += countryHelper.emoji(withCountyAbbreviation: language)
        }
        // Stars
        if let stars = app.stars {
            generated += starsHelper.emoji(withStarsCount: stars)
        }
        // Summary
        generated += "\n"
        generated += "    </summary>\n"
        // Source
        if let source = app.source {
            generated += "\n"
            generated += "    \(source)"
        }
        // Homepage
        if let homepage = app.homepage {
            generated += "\n"
            generated += "    \(homepage)"
        }
        // Added
        if let dateAdded = app.dateAdded {
            let date = dateFormatter.date(from: dateAdded)
            if let date = date {
                generated += "\n"
                generated += "    Added \(dateFormatter.string(from: date))"
            }
        }
        // License
        if let license = app.license {
            if license == "other" {
                generated += "License: other"
            }
            generated += "\n"
            generated += "    License: [`\(license)`](http://choosealicense.com/licenses/\(license)/)"
        }
        // Screenshots
        if let screenshots = app.screenshots {
            generated += "\n"
            generated += "    <div>"
            for (index, screenshot) in screenshots.enumerated() {
                generated += "\n"
                generated += "      <img height='300' alt='\(app.title)-image-\(index)' src='\(screenshot)'>"
            }
            generated += "\n"
            generated += "    <div>"
        }
        generated += "\n"
        generated += "  </details>"
        generated += "\n\n"
        return generated
    }
}
