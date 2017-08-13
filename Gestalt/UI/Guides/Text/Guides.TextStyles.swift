import Foundation
import UIKit


// MARK: - TextStyles


extension Guides.TextStyle {
    
    // MARK: - Task Headline
    enum taskHeadline {
        
        //Planned
        enum planned {
            case selected, deselected
            
            var style: Guides.TextStyle {
                
                switch self {
                case .selected: return {
                    
                    var δStyle = Guides.TextStyle.basic
                    δStyle.font = Guides.Font.taskHeadline
                    δStyle.fontColor = Guides.Color.processItemSelectedTitle
                    
                    return δStyle
                    }()
                    
                case.deselected: return {
                    
                    var δStyle = Guides.TextStyle.basic
                    δStyle.font = Guides.Font.taskHeadline
                    δStyle.fontColor = Guides.Color.processItemDeselectedTitle
                    
                    return δStyle
                    }()
                }
            }
        }
        
        //Running
        enum running {
            case selected, deselected
            
            var style: Guides.TextStyle {
                
                switch self {
                case .selected: return {
                    
                    var δStyle = Guides.TextStyle.basic
                    δStyle.font = Guides.Font.taskHeadline
                    δStyle.fontColor = Guides.Color.processItemSelectedTitle
                    
                    return δStyle
                    }()
                    
                case.deselected: return {
                    
                    var δStyle = Guides.TextStyle.basic
                    δStyle.font = Guides.Font.taskHeadline
                    δStyle.fontColor = Guides.Color.processItemDeselectedTitle
                    
                    return δStyle
                    }()
                }
            }
        }
        
        //Suspended
        enum suspended {
            case selected, deselected
            
            var style: Guides.TextStyle {
                
                switch self {
                case .selected: return {
                    
                    var δStyle = Guides.TextStyle.basic
                    δStyle.font = Guides.Font.taskHeadline
                    δStyle.fontColor = Guides.Color.processItemSelectedTitle
                    
                    return δStyle
                    }()
                    
                case.deselected: return {
                    
                    var δStyle = Guides.TextStyle.basic
                    δStyle.font = Guides.Font.taskHeadline
                    δStyle.fontColor = Guides.Color.processItemDeselectedTitle
                    
                    return δStyle
                    }()
                }
            }
        }
        
        //Completed
        enum completed {
            case selected, deselected
            
            var style: Guides.TextStyle {
                
                switch self {
                case .selected: return {
                    
                    var δStyle = Guides.TextStyle.basic
                    δStyle.font = Guides.Font.taskHeadline
                    δStyle.fontColor = Guides.Color.processItemSelectedTitle
                    δStyle.strikethroughStyle = 2
                    δStyle.strikethroughColorAttributeName = Guides.Color.processItemSelectedTitle
                    
                    return δStyle
                    }()
                    
                case.deselected: return {
                    
                    var δStyle = Guides.TextStyle.basic
                    δStyle.font = Guides.Font.taskHeadline
                    δStyle.fontColor = Guides.Color.processItemDeselectedTitle
                    δStyle.strikethroughStyle = 2
                    δStyle.strikethroughColorAttributeName = Guides.Color.processItemDeselectedTitle
                    
                    
                    return δStyle
                    }()
                }
            }
        }
        
        //Canceled
        enum canceled {
            case selected, deselected
            
            var style: Guides.TextStyle {
                
                switch self {
                case .selected: return {
                    
                    var δStyle = Guides.TextStyle.basic
                    δStyle.font = Guides.Font.taskHeadline
                    δStyle.fontColor = Guides.Color.processItemSelectedTitle
                    
                    return δStyle
                    }()
                    
                case.deselected: return {
                    
                    var δStyle = Guides.TextStyle.basic
                    δStyle.font = Guides.Font.taskHeadline
                    δStyle.fontColor = Guides.Color.processItemDeselectedTitle
                    
                    return δStyle
                    }()
                }
            }
        }
    }
    
    // MARK: - Goal Headline
    enum goalHeadline {
        
        case planned
        case running
        case suspended
        case completed
        case canceled
        
        var style: Guides.TextStyle {
            
            switch self {
            case .planned: return {
                
                var δStyle = Guides.TextStyle.basic
                δStyle.font = Guides.Font.goalHeadline
                δStyle.fontColor = Guides.Color.goalText
                
                return δStyle
                }()
                
            case .running: return {
                
                var δStyle = Guides.TextStyle.basic
                δStyle.font = Guides.Font.goalHeadline
                δStyle.fontColor = Guides.Color.goalText
                
                return δStyle
                }()
                
            case .suspended: return {
                
                var δStyle = Guides.TextStyle.basic
                δStyle.font = Guides.Font.goalHeadline
                δStyle.fontColor = Guides.Color.goalText
                
                return δStyle
                }()
                
            case .completed: return {
                
                var δStyle = Guides.TextStyle.basic
                δStyle.font = Guides.Font.goalHeadline
                δStyle.fontColor = Guides.Color.goalText
                δStyle.strikethroughStyle = 2
                δStyle.strikethroughColorAttributeName = Guides.Color.goalText
                
                return δStyle
                }()
                
            case .canceled: return {
                
                var δStyle = Guides.TextStyle.basic
                δStyle.font = Guides.Font.goalHeadline
                δStyle.fontColor = Guides.Color.goalText
                
                return δStyle
                }()
            }
        }
    }
}

