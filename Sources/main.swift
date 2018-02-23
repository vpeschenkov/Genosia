//
// main.swift
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

import SwiftCLI
import Foundation

class GenerationCommand: Command {
    let name = "generate"
    let shortDescription = "Generates README.MD, STORE.MD & ARCHIVE.MD"
    let content = Flag("--content", description: "To generate *.MD files")
    let links = Flag("--links", description: "To generate link files")
    let path = Key<String>("-p", "--path", description: "The path to the contents.json")
    
    func execute() throws  {
        do {
            if content.value {
                let strategies = [
                    BuilderReadmeStrategy(),
                    BuilderArchiveStrategy(),
                    BuilderAppStoreStrategy()
                    ] as [Any]
                for strategy in strategies {
                    let builder = Builder()
                    builder.filePath = path.value ?? "contents.json"
                    builder.fileHelper = FileHelper()
                    builder.starsHelper = StarsHelper()
                    builder.countryHelper = CountyHelper()
                    builder.strategy = (strategy as! BuilderStrategyInterface)
                    try builder.build()
                }
                print("👍  CONTENT GENERATION IS DONE")
            }
            
            if links.value {
                let strategies = [
                    BuilderLinksStrategy()
                    ] as [Any]
                for strategy in strategies {
                    let builder = Builder()
                    builder.filePath = path.value ?? "contents.json"
                    builder.fileHelper = FileHelper()
                    builder.starsHelper = StarsHelper()
                    builder.countryHelper = CountyHelper()
                    builder.strategy = (strategy as! BuilderStrategyInterface)
                    try builder.build()
                }
                print("👍  LINKS GENERATION IS DONE")
            }
        }
        catch let error {
            print(error.localizedDescription)
            if let error = error as? AppError {
                exit(error.code())
            }
            exit(1)
        }
    }
}

class ValidationCommand: Command {
    let name = "validate"
    let shortDescription = "Validates categories"
    let content = Flag("--content", description: "To generate *.MD files")
    let path = Key<String>("-p", "--path", description: "The path to the contents.json")
    
    func execute() throws  {
        do {
            if content.value {
                let validator = CategoriesValidator()
                validator.filePath = path.value ?? "contents.json"
                validator.fileHelper = FileHelper()
                try validator.validate()
                print("👍  VALIDATION IS DONE")
            }
        }
        catch let error {
            if let error = error as? AppError {
                exit(error.code())
            }
            exit(1)
        }
    }
}

let cli = CLI(name: "genosia")
cli.commands = [
    GenerationCommand(),
    ValidationCommand()
]
exit(cli.go())
