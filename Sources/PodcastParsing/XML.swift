//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-podcast-parser open source project
//
// Copyright (c) 2023 Michael Nisi and collaborators
// Licensed under MIT License
//
// See https://github.com/michaelnisi/swift-podcast-parser/blob/main/LICENSE for license information
//
//===----------------------------------------------------------------------===/

import Collections

public struct XML: Equatable {
  public struct Element: Equatable {
    public let name: String
    public let attributes: OrderedDictionary<String, String>
    public let content: [Node]
  }
  
  public enum Node: Equatable {
    case element(Element)
    case text(String)
    case comment(String)
    case cdata(String)
  }
  
  public typealias Prolog = OrderedDictionary<String, String>
  public typealias Stylesheet = OrderedDictionary<String, String>
  
  public let prolog: Prolog
  public let stylesheet: Stylesheet
  public let root: Element
}

extension XML: CustomStringConvertible {
  public var description: String {
    "prolog: \(prolog), stylesheet: \(stylesheet), root: \(root)"
  }
}

extension XML.Element: CustomStringConvertible {
  public var description: String {
    "name: \(name), attributes: \(attributes), content: \(content))"
  }
}

extension XML.Node: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .element(element):
      return element.description
    case let .text(string), let .comment(string), let .cdata(string):
      return string
    }
  }
}
