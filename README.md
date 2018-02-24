# Genosia

[![License][license-image]][license-url] [![Swift Version][swift-image]][swift-url]

**Genosia** is a generator to [Open Source iOS Apps](https://github.com/dkhamsing/open-source-ios-apps).

## Requirements

- Xcode 9
- OSX 10.11

## Getting Started
1. `git clone https://github.com/vpeschenkov/genosia.git`
2. `swift package generate-xcodeproj`
3. `swift build -c release`

## Commands
### `generate`
- `--path` A path to the `contents.json`. If the path isn't set, `genosia` tries to find the `contents.json` in the same folder.
- `--links` Use this flag to generate `links`.
- `--content` Use this flag to generate `*.MD` files.

#### Examples

```
genosia generate --links
genosia generate --content
```

### `validate`
- `--path` A path to the `contents.json`. If the path isn't set, `genosia` tries to find the `contents.json` in the same folder.
- `--content` Use this flag to validate `links` in the `content.json`.


#### Examples

```
genosia validate --content
```

## Contribute

We would love you for the contribution to **Genosia**, check the [`LICENSE`](https://github.com/vpeschenkov/genosia/blob/master/LICENSE) file for more info.

## Meta

Victor Peschenkov – [@vpeschenkov](https://twitter.com/vpeschenkov) – nerevarxx@gmail.com

Distributed under the MIT license. See [`LICENSE`](https://github.com/vpeschenkov/genosia/blob/master/LICENSE) for more information.

[swift-image]:https://img.shields.io/badge/Swift-4.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
