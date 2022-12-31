# swift-podcast-parser

XML parsing is messy, especially parsing RSS and more specifically podcast feeds – a domain where specifications are mere recommendations. The swift-podcast-parser package composes a bidirectional parser for podcast feeds on top of [swift-parsing](https://github.com/pointfreeco/swift-parsing) aiming to find a solid balance between correctness and tolerance.

## Podcast feeds

Apple podcast RSS feed [requirements](https://podcasters.apple.com/support/823-podcast-requirements) provide the framework for the rules in this parser. Although built for podcast feeds, **swift-podcast-parser** should be applicable to parse other types of RSS feeds. 

## Usage

With a `PodcastParser` you can parse and print.

### Parsing

Parsing produces an XML structure from an input String.

```swift
try PodcastParser().parse(input)
```

### Printing

Printing is the reverse operation of parsing in this context.

```swift
try PodcastParser().print(xml, into: &input)
```

## Tests

Download some transient data, before running the tests.

```
$ ./Scripts/download_smoke_test_feeds.swift
```

## Alternatives

Look at [swift-xml-parser](https://github.com/JaapWijnen/swift-xml-parser) for general XML parsing by which this parser was initially inspired.

## License

[MIT](https://raw.github.com/michaelnisi/swift-podcast-parser/master/LICENSE)
