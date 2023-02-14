//
//  TipsList.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/05.
//

import Foundation

class TipsData {
    
    let goodTips1 = [
        "  1.   습관 점수표를 활용하라, 현재 습관을 써보고 \n     그것들을 인식하라.",
        "  2.   실행 의도를 이용하라. ‘나는 [언제] [어디서]\n     [어떤 행동]을 할 것이다.’ ",
        "  3.   습관 쌓기를 이용하라. ‘[현재의 습관]을 하고 나서 \n     [새로운 습관]을 할 것이다.’ ",
        "  4.   환경을 디자인하라. 좋은 습관의 신호를 분명하게, \n     눈에 보이게 만들어라."]
    let goodTips2 = [
        "  1.   유혹의 묶기를 이용하라. ‘하고 싶은 행동’을 \n     ‘해야 하는 행동'과 짝지어라.",
        "  2.   당신이 원하는 행동이 일반적인 집단에 들어가라.",
        "  3.   동기부여 의식을 만들어라. 어려운 습관을 행동으로 \n     옮기기 직전에 좋아하는 뭔가를 하라."]
    
    let goodTips3 = [
        "  1.   마찰을 줄여라. 당신과 좋은 습관 사이의 단계를\n     줄여라.",
        "  2.   환경을 갖춰라. 좋은 습관이 더 일어나기 쉽게 \n     환경을 준비하라.",
        "  3.   결정적 순간을 완전히 체득하라. 거대한 영향을 \n     가져올 작은 선택들을 강화하라.",
        "  4.   2분 규칙을 이용하라. 2분 또는 그 이하로 실행\n     할 수 있을 때까지 습관을 축소하라.",
        "  5.   습관을 자동화하라. 미래 행동을 이끌어내는 기술\n     과 장치에 투자하라."]
    let goodTips4 = [
        "  1.   강화 요인을 이용하라. 습관을 완수하면 즉시\n     스스로 보상하라.",
        "  2.   ‘아무것도 하지 않는 것'을 즐겨라. 나쁜 습관을\n     피할 수 있는 방법을 고안하라.",
        "  3.   습관 추적을 하라. 습관 추적을 계속하고 흐름을\n     깨뜨리지 마라.",
        "  4.   두번 거르지 마라. 한 번 걸렀을 때 즉시 궤도로\n     돌아가라."]
    
    let badTips1 = [
        "  1.   습관 점수표를 활용하라, 현재 습관을 써보고\n      그것들을 인식하라."]
    let badTips2 = [
        "  1.   마인드세트를 재구축하라. 나쁜 습관을 피했을 때\n      얻을 이득에 초점을 맞춰라."]
    let badTips3 = [
        "  1.   마찰을 증가시켜라. 당신과 나쁜 습관 사이의 단계\n      들을 늘려라.",
        "  2.   이행 장치를 이용하라. 당신에게 이득이 될 습관으로\n      미래 선택들을 제한하라."]
    let badTips4 = [
        "  1.   책임감 있는 파트너를 찾아라. 누군가에게 당신의\n     행동을 감시해달라고 부탁하라.",
        "  2.   습관 계약을 하라. 나쁜 습관의 대가를 공적이고\n     고통스러운 것으로 만들어라."]
    
    
    
    
    func getGoodTips (index : Int) -> String {
        var str = "\n"
        switch index {
        case 0:
            for string in goodTips1 {
                str += string + "\n\n"
            }
            return str
        case 1:
            for string in goodTips2 {
                str += string + "\n\n"
            }
            return str
        case 2:
            for string in goodTips3 {
                str += string + "\n\n"
            }
            return str
        case 3:
            for string in goodTips4 {
                str += string + "\n\n"
            }
            return str
        default:
            return str
        }
    }
    
    func getGoodTipsNum(index : Int) -> Int {
        switch index {
        case 0:
            return goodTips1.count
        case 1:
            return goodTips2.count
        case 2:
            return goodTips3.count
        case 3:
            return goodTips4.count
        default:
            return 4
        }
    }
    
    
    func getBadTips (index : Int) -> String {
        var str = "\n"
        switch index {
        case 0:
            for string in badTips1 {
                str += string + "\n\n"
            }
            return str
        case 1:
            for string in badTips2 {
                str += string + "\n\n"
            }
            return str
        case 2:
            for string in badTips3 {
                str += string + "\n\n"
            }
            return str
        case 3:
            for string in badTips4 {
                str += string + "\n\n"
            }
            return str
        default:
            return str
        }
    }
    
    func getBadTipsNum(index : Int) -> Int {
        switch index {
        case 0:
            return badTips1.count
        case 1:
            return badTips2.count
        case 2:
            return badTips3.count
        case 3:
            return badTips4.count
        default:
            return 4
        }
    }
    
    
}
