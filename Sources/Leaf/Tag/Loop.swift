import Bits

public final class Loop: Tag {
    public init() {}

    public func render(
        parameters: [Data?],
        context: inout Data,
        indent: Int,
        body: [Syntax]?,
        renderer: Renderer
    ) throws -> Data? {
        guard case .dictionary(var dict) = context else {
            throw TagError.custom("context must be a dictionary to set it")
        }

        let body = try requireBody(body)
        let array = try requireArrayParameter(0, from: parameters)
        let key = try requireStringParameter(1, from: parameters)

        var string: String = ""

        for (i, item) in array.enumerated() {
            if i != 0 {
                string.append("\n")
                string.append(String(repeating: " ", count: indent))
            }
            dict[key] = item
            let temp = Data.dictionary(dict)
            let bytes = try renderer.render(body, context: temp)
            string.append(bytes.makeString())
        }

        return .string(string)
    }
}

