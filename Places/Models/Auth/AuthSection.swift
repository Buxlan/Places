// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

/// Model object for a section in a tableview
struct AuthSection: Sectionable {
    var headerDescription: String?
    var footerDescription: String?
    var items: [AuthItem]
}

/// Model object for a cell in a tableview section
struct AuthItem: Itemable {
    var title: String?
    var detailTitle: String?
    var textColor: UIColor?
    let isEditable: Bool
    var hasNestedContent: Bool
    var isChecked: Bool
    var imageName: String?
    
    private var _image: UIImage?
    var image: UIImage? {
        get {
            _image ?? UIImage(named: imageName ?? title ?? "?")?
                .resizeImage(to: 32, aspectRatio: .current, with: .clear) }
        set {
            _image = newValue            
        }
    }
    
    init(title: String? = nil,
         imageName: String? = nil,
         detailTitle: String? = nil,
         textColor: UIColor? = .black,
         isEditable: Bool = false,
         hasNestedContent: Bool = false,
         isChecked: Bool = false,
         image: UIImage? = nil) {
        self.title = title
        self.imageName = imageName
        self.detailTitle = detailTitle
        self.textColor = textColor
        self.isEditable = isEditable
        self.hasNestedContent = hasNestedContent
        self.isChecked = isChecked
        self.image = image
    }
}
