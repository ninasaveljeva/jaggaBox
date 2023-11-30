//
//  MockupData.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 13/11/2023.
//

import Foundation

struct MockupData {
    static let gifsList: [GifObject] =
    [
        GifObject(id: "YsTs5ltWtEhnq", type: "gif", url: "http://giphy.com/gifs/confused-flying-YsTs5ltWtEhnq", title: "Happy Dancing GIF Happy Dancing GIf", alt_text: "Barney the Purple Dinosaur blows out birthday candles.",
                  images: ImageObject(fixed_width_small:
                                        ImageSmall(height: "178", width: "100", url: "https://media3.giphy.com/media/PDFBlzNPTl8gwlgrKn/100w.gif?cid=29f1826emmrgm18zvcp6t1ozwhtjwcf90w0ulvtsnzx8iazr&ep=v1_gifs_trending&rid=100w.gif&ct=g"),
                                      fixed_width: ImageFixedWidth(height: "356", width: "200", url: "https://media3.giphy.com/media/PDFBlzNPTl8gwlgrKn/200w.gif?cid=29f1826emmrgm18zvcp6t1ozwhtjwcf90w0ulvtsnzx8iazr&ep=v1_gifs_trending&rid=200w.gif&ct=g"))
                 ),
        GifObject(id: "YsTs5ltWtEhnq", type: "gif", url: "http://giphy.com/gifs/confused-flying-YsTs5ltWtEhnq", title: "Happy Dancing GIF", alt_text: "Barney the Purple Dinosaur blows out birthday candles.",
                  images: ImageObject(fixed_width_small:
                                        ImageSmall(height: "100", width: "100", url: "https://media3.giphy.com/media/xUOrw4tlQfCTGmD5Kw/100w.gif?cid=29f1826emmrgm18zvcp6t1ozwhtjwcf90w0ulvtsnzx8iazr&ep=v1_gifs_trending&rid=100w.gif&ct=g"), fixed_width: ImageFixedWidth(height: "200", width: "200", url: "https://media3.giphy.com/media/xUOrw4tlQfCTGmD5Kw/200w.gif?cid=29f1826emmrgm18zvcp6t1ozwhtjwcf90w0ulvtsnzx8iazr&ep=v1_gifs_trending&rid=200w.gif&ct=g"))
                 )
        
    ]
}
