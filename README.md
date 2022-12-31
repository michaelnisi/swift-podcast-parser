# swift-podcast-parser

XML parsing is messy, especially parsing RSS and more spefically podcast feeds. The swift-podcast-parser package composes a bidirectional parser for podcast feeds on top of [swift-parsing](https://github.com/pointfreeco/swift-parsing) aiming to find a solid balance between correctness and tolerance.

## Podcast feeds

Apple podcast RSS feed [requirements](https://podcasters.apple.com/support/823-podcast-requirements) provide the framework for the rules in this parser. Although built for podcast feeds, **swift-podcast-parser** should be applicable to parse other types of RSS feeds.

## Tests

Download some transient data, before running the tests.

```
$ ./Scripts/download_smoke_test_feeds.swift
```

## License

[MIT](https://raw.github.com/michaelnisi/swift-podcast-parser/master/LICENSE)
