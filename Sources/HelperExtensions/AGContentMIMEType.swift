//
//  AGContentMIMEType.swift
//  XtraCredit
//
//  Created by DLR on 1/1/20.
//  Copyright © 2020 DLR. All rights reserved.
//

import UIKit

/// Holds file MIME, and introduces selected type MIME as constants
public struct AGContentMIMEType: RawRepresentable, Hashable, Equatable {
    public var rawValue: String
    public typealias RawValue = String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public var hashValue: Int { return rawValue.hashValue }
    public static func == (lhs: AGContentMIMEType, rhs: AGContentMIMEType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    /// Directory
    static public let directory = AGContentMIMEType(rawValue: "httpd/unix-directory")
    
    // Archive and Binary
    
    /// Binary stream and unknown types
    static public let stream = AGContentMIMEType(rawValue: "application/octet-stream")
    /// Protable document format
    static public let pdf = AGContentMIMEType(rawValue: "application/pdf")
    /// Zip archive
    static public let zip = AGContentMIMEType(rawValue: "application/zip")
    /// Rar archive
    static public let rarArchive = AGContentMIMEType(rawValue: "application/x-rar-compressed")
    /// 7-zip archive
    static public let lzma = AGContentMIMEType(rawValue: "application/x-7z-compressed")
    /// Adobe Flash
    static public let flash = AGContentMIMEType(rawValue: "application/x-shockwave-flash")
    /// ePub book
    static public let epub = AGContentMIMEType(rawValue: "application/epub+zip")
    /// Java archive (jar)
    static public let javaArchive = AGContentMIMEType(rawValue: "application/java-archive")
    
    // Texts
    
    /// Text file
    static public let plainText = AGContentMIMEType(rawValue: "text/plain")
    /// Coma-separated values
    static public let csv = AGContentMIMEType(rawValue: "text/csv")
    /// Hyper-text markup language
    static public let html = AGContentMIMEType(rawValue: "text/html")
    /// Common style sheet
    static public let css = AGContentMIMEType(rawValue: "text/css")
    /// eXtended Markup language
    static public let xml = AGContentMIMEType(rawValue: "text/xml")
    /// Javascript code file
    static public let javascript = AGContentMIMEType(rawValue: "application/javascript")
    /// Javascript notation
    static public let json = AGContentMIMEType(rawValue: "application/json")
    
    // Documents
    
    /// Rich text file (RTF)
    static public let richText = AGContentMIMEType(rawValue: "application/rtf")
    /// Excel 2013 (OOXML) document
    static public let excel = AGContentMIMEType(rawValue: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
    /// Powerpoint 2013 (OOXML) document
    static public let powerpoint = AGContentMIMEType(rawValue: "application/vnd.openxmlformats-officedocument.presentationml.slideshow")
    /// Word 2013 (OOXML) document
    static public let word = AGContentMIMEType(rawValue: "application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    
    // Images
    
    /// Bitmap
    static public let bmp = AGContentMIMEType(rawValue: "image/bmp")
    /// Graphics Interchange Format photo
    static public let gif = AGContentMIMEType(rawValue: "image/gif")
    /// JPEG photo
    static public let jpeg = AGContentMIMEType(rawValue: "image/jpeg")
    /// Portable network graphics
    static public let png = AGContentMIMEType(rawValue: "image/png")
    
    // Audio & Video
    
    /// MPEG Audio
    static public let mpegAudio = AGContentMIMEType(rawValue: "audio/mpeg")
    /// MPEG Video
    static public let mpeg = AGContentMIMEType(rawValue: "video/mpeg")
    /// MPEG4 Audio
    static public let mpeg4Audio = AGContentMIMEType(rawValue: "audio/mp4")
    /// MPEG4 Video
    static public let mpeg4 = AGContentMIMEType(rawValue: "video/mp4")
    /// OGG Audio
    static public let ogg = AGContentMIMEType(rawValue: "audio/ogg")
    /// Advanced Audio Coding
    static public let aac = AGContentMIMEType(rawValue: "audio/x-aac")
    /// Microsoft Audio Video Interleaved
    static public let avi = AGContentMIMEType(rawValue: "video/x-msvideo")
    /// Microsoft Wave audio
    static public let wav = AGContentMIMEType(rawValue: "audio/x-wav")
    /// Apple QuickTime format
    static public let quicktime = AGContentMIMEType(rawValue: "video/quicktime")
    /// 3GPP
    static public let threegp = AGContentMIMEType(rawValue: "video/3gpp")
    /// Adobe Flash video
    static public let flashVideo = AGContentMIMEType(rawValue: "video/x-flv")
    /// Adobe Flash video
    static public let flv = AGContentMIMEType.flashVideo
    
    // Google Drive
    
    /// Google Drive: Folder
    static public let googleFolder = AGContentMIMEType(rawValue: "application/vnd.google-apps.folder")
    /// Google Drive: Document (word processor)
    static public let googleDocument = AGContentMIMEType(rawValue: "application/vnd.google-apps.document")
    /// Google Drive: Sheets (spreadsheet)
    static public let googleSheets = AGContentMIMEType(rawValue: "application/vnd.google-apps.spreadsheet")
    /// Google Drive: Slides (presentation)
    static public let googleSlides = AGContentMIMEType(rawValue: "application/vnd.google-apps.presentation")
    /// Google Drive: Drawing (vector draw)
    static public let googleDrawing = AGContentMIMEType(rawValue: "application/vnd.google-apps.drawing")
    /// Google Drive: Audio
    static public let googleAudio = AGContentMIMEType(rawValue: "application/vnd.google-apps.audio")
    /// Google Drive: Video
    static public let googleVideo = AGContentMIMEType(rawValue: "application/vnd.google-apps.video")
}
