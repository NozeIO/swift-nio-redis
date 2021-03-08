# SwiftNIO Redis Client

![Swift5](https://img.shields.io/badge/swift-5-blue.svg)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![tuxOS](https://img.shields.io/badge/os-tuxOS-green.svg?style=flat)
![Travis](https://travis-ci.org/NozeIO/swift-nio-redis-client.svg?branch=master)

SwiftNIO Redis is a Swift package that contains a high performance 
[Redis protocol](https://redis.io/topics/protocol)
implementation for
[SwiftNIO](https://github.com/apple/swift-nio).
This is a **standalone project** and has no other dependencies but
[SwiftNIO](https://github.com/apple/swift-nio).

Apart from the protocol implementation which can encode and decode
[RESP](https://redis.io/topics/protocol) (REdis Serialization Protocol),
we also provide a [Redis client module](Sources/Redis/README.md)
build on top.

What is Redis?
[Redis](https://redis.io/) is a highly scalable in-memory data structure store,
used as a database, cache and message broker.
For example it can be used to implement a session store backing a web backend
using its "expiring keys" feature,
or it can be used as a relay to implement a chat server using its builtin
[PubSub](https://redis.io/topics/pubsub)
features.

This Swift package contains a simple Redis client based on the
protocol implementation
[swift-nio-redis](https://github.com/SwiftNIOExtras/swift-nio-redis).
We also provide an actual [Redis Server](https://github.com/NozeIO/redi-s)
written in Swift, using SwiftNIO and SwiftNIO Redis.


## Importing the module using Swift Package Manager

An example `Package.swift `importing the necessary modules:

```swift
// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "RedisTests",
    dependencies: [
        .package(url: "https://github.com/NozeIO/swift-nio-redis-client.git", 
                 from: "0.10.0")
    ],
    targets: [
        .target(name: "MyClientTool",
                dependencies: [ "Redis" ])
    ]
)
```


## Using the Redis client module

The
[Redis](Sources/Redis/README.md)
client module is modeled after the Node.js
[node_redis](https://github.com/NodeRedis/node_redis)
module,
but it also supports NIO like Promise/Future based methods in addition
to the Node.js `(err,result)` style callbacks. Choose your poison.

### Simple KVS use example:

```swift
import Redis

let client = Redis.createClient()

client.set ("counter", 0, expire: 2)
client.incr("counter", by: 10)
client.get ("counter") { err, value in
    print("Reply:", value)
}
client.keys("*") { err, reply in
    guard let keys = reply else { return print("got no keys!") }
    print("all keys in store:", keys.joined(separator: ","))
}
```

Using NIO Promises:

```swift
client
    .set ("counter", 0, expire: 2)
    .then {
        client.incr("counter", by: 10)
    }
    .then {
        client.get("counter")
    }
    .map {
        print("counter is:", $0)
    }
```


## Status

The
[protocol implementation](https://github.com/SwiftNIOExtras/swift-nio-redis)
is considered complete. There are a few open ends
in the `telnet` variant, yet the regular binary protocol is considered done.

The
[Redis client module](Sources/Redis/)
has a few more open ends, but seems to work fine.


### Who

Brought to you by
[ZeeZide](http://zeezide.de).
We like
[feedback](https://twitter.com/ar_institute),
GitHub stars,
cool [contract work](http://zeezide.com/en/services/services.html),
presumably any form of praise you can think of.
