/**
 Copyright (c) 2014, Kyle Fuller
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/**
    The associated context used in rendering
*/
public final class Context {
    public internal(set) var queue: [Node] = []

    public init(_ node: Node) {
        self.queue.append(node)
    }

    // TODO: Subscripts

    public func get(key: String) -> Node? {
        return queue.lazy.reversed().flatMap { $0[key] } .first
    }

    public func get(path: String) -> Node? {
        let components = path.components(separatedBy: ".")
        return get(path: components)
    }

    public func get(path: [String]) -> Node? {
        return queue.lazy.reversed().flatMap { next in next[path] } .first
    }

    public func push(_ fuzzy: Node) {
        queue.append(fuzzy)
    }

    @discardableResult
    public func pop() -> Node? {
        guard !queue.isEmpty else { return nil }
        return queue.removeLast()
    }
}


extension Context {
    internal func renderedSelf() throws -> Bytes? {
        return try get(path: "self")?.rendered()
    }
}
