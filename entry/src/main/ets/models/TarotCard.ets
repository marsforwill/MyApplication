/**
 * 卡牌类型
 */
export enum CardType {
  MAJOR = 'major',      // 大阿卡纳
  MINOR = 'minor'       // 小阿卡纳
}

/**
 * 小阿卡纳花色
 */
export enum Suit {
  WANDS = 'wands',      // 权杖
  CUPS = 'cups',        // 圣杯
  SWORDS = 'swords',    // 宝剑
  PENTACLES = 'pentacles' // 星币
}

/**
 * 塔罗牌数据模型
 * 定义塔罗牌的数据结构
 */
export interface TarotCard {
  id: number;           // 卡牌ID (0-21: 大阿卡纳, 22-77: 小阿卡纳)
  name: string;         // 卡牌名称
  image: Resource;      // 卡牌图片资源
  description: string;  // 卡牌含义简述
  fullDescription: string; // 卡牌详细描述
  type: CardType;       // 卡牌类型（大阿卡纳/小阿卡纳）
  suit?: Suit;          // 花色（仅小阿卡纳有）
  number?: number;      // 数字（1-10，仅小阿卡纳数字牌有）
  courtRank?: string;   // 宫廷牌等级（侍从/骑士/皇后/国王，仅小阿卡纳宫廷牌有）
}

/**
 * 塔罗牌数据常量
 * 包含78张塔罗牌（22张大阿卡纳 + 56张小阿卡纳）
 */

// 辅助函数：获取小阿卡纳中文图片文件名
function getMinorCardImageFileName(suit: Suit, number?: number, courtRank?: string): string {
  const suitMap: Record<Suit, string> = {
    [Suit.WANDS]: '权杖',
    [Suit.CUPS]: '圣杯',
    [Suit.SWORDS]: '宝剑',
    [Suit.PENTACLES]: '星币'
  };
  if (courtRank) {
    // 宫廷牌：侍从/骑士/皇后/国王
    return `${suitMap[suit]}${courtRank}`;
  }
  if (number === 1) {
    // Ace 特例
    return `${suitMap[suit]}Ace`;
  }
  // 数字牌
  return `${suitMap[suit]}${number}`;
}

// 修改后的 getCardImage 支持大阿卡纳/小阿卡纳
function getCardImage(card: TarotCard): Resource {
  if (card.type === CardType.MAJOR) {
    // 大阿卡纳
    const idStr = card.id < 10 ? '0' + card.id : card.id.toString();
    return $r('app.media.card_' + idStr);
  } else if (card.type === CardType.MINOR && card.suit) {
    const fileName = getMinorCardImageFileName(card.suit, card.number, card.courtRank);
    return $r('app.media.' + fileName);
  }
  return $r('app.media.card_back');
}

export const TAROT_CARDS: TarotCard[] = [
  // ========== 大阿卡纳牌 (0-21) ==========
  {
    id: 0,
    name: "愚者",
    image: $r('app.media.card_00'),
    description: "新的开始，冒险精神，纯真与自由",
    fullDescription: "愚者代表着新的开始，拥有自由的精神和冒险的勇气。这张牌提醒你要保持开放的心态，勇敢地踏上新的旅程。在人生的十字路口，不要害怕未知，相信自己的直觉，勇敢地迈出第一步。",
    type: CardType.MAJOR
  },
  {
    id: 1,
    name: "魔术师",
    image: $r('app.media.card_01'),
    description: "创造力，行动力，意志力，专注",
    fullDescription: "魔术师象征着创造力与行动力。你拥有将想法转化为现实的能力，关键在于专注和意志力。现在是开始行动的好时机。集中你的能量，明确你的目标，运用你手中的工具和资源，将愿景变为现实。",
    type: CardType.MAJOR
  },
  {
    id: 2,
    name: "女祭司",
    image: $r('app.media.card_02'),
    description: "直觉，内在智慧，潜意识，神秘",
    fullDescription: "女祭司代表着内在的智慧和直觉。倾听你内心的声音，相信你的直觉。答案可能隐藏在潜意识中，需要静心去感受。在做出决定之前，给自己一些独处的时间，通过冥想或反思来连接内在的智慧。",
    type: CardType.MAJOR
  },
  {
    id: 3,
    name: "皇后",
    image: $r('app.media.card_03'),
    description: "丰盛，母性，创造力，自然",
    fullDescription: "皇后象征着丰盛与创造力。这是一个充满爱与关怀的时期，你的努力将得到回报。享受生活的美好，感受自然的馈赠。这张牌鼓励你培养创造力，关爱自己和他人，在物质和精神层面都获得满足。",
    type: CardType.MAJOR
  },
  {
    id: 4,
    name: "皇帝",
    image: $r('app.media.card_04'),
    description: "权威，秩序，稳定，领导力",
    fullDescription: "皇帝代表着权威与秩序。你需要建立稳定的基础，展现领导力。通过自律和规划，你能够实现目标并保持控制。建立清晰的规则和界限，承担责任，用理性和策略来解决问题。",
    type: CardType.MAJOR
  },
  {
    id: 5,
    name: "教皇",
    image: $r('app.media.card_05'),
    description: "传统，精神指导，学习，信仰",
    fullDescription: "教皇象征着传统与精神指导。寻求导师的帮助，学习传统的智慧。保持对信仰和价值观的坚持，它们会指引你前进。考虑接受正式的教育或培训，寻找精神导师，遵循既定的规则和传统。",
    type: CardType.MAJOR
  },
  {
    id: 6,
    name: "恋人",
    image: $r('app.media.card_06'),
    description: "爱情，选择，和谐，结合",
    fullDescription: "恋人代表着爱情与选择。这可能意味着重要的决定，需要平衡理性与感性。在关系中寻求和谐，做出符合内心的选择。这张牌提醒你在做重要决定时，要平衡头脑和心灵，选择与你的价值观一致的道路。",
    type: CardType.MAJOR
  },
  {
    id: 7,
    name: "战车",
    image: $r('app.media.card_07'),
    description: "胜利，意志力，控制，前进",
    fullDescription: "战车象征着胜利与前进。通过坚定的意志力和自我控制，你能够克服障碍，朝着目标前进。保持平衡，不要被情绪左右。运用你的意志力和决心来克服挑战，但要确保内在的冲突得到解决。",
    type: CardType.MAJOR
  },
  {
    id: 8,
    name: "力量",
    image: $r('app.media.card_08'),
    description: "内在力量，耐心，温柔，勇气",
    fullDescription: "力量代表着内在的勇气与耐心。真正的力量来自内心的平静和温柔。用耐心和智慧面对挑战，而不是用蛮力。通过温柔、耐心和内在的平静来克服困难，真正的力量来自内心的平衡。",
    type: CardType.MAJOR
  },
  {
    id: 9,
    name: "隐者",
    image: $r('app.media.card_09'),
    description: "内省，寻求真理，孤独，指引",
    fullDescription: "隐者象征着内省与寻求真理。现在是独处和反思的时候，通过内省找到内心的指引。答案在你内心深处，需要静心去寻找。给自己时间独处，进行深度思考，寻找内在的智慧和指引。",
    type: CardType.MAJOR
  },
  {
    id: 10,
    name: "命运之轮",
    image: $r('app.media.card_10'),
    description: "变化，命运，周期，转折",
    fullDescription: "命运之轮代表着变化与转折。生活是不断变化的，接受这些变化，它们会带来新的机遇。保持开放的心态，顺应自然的节奏。变化是不可避免的，接受生活的起伏，相信一切都有其时机和意义。",
    type: CardType.MAJOR
  },
  {
    id: 11,
    name: "正义",
    image: $r('app.media.card_11'),
    description: "平衡，公正，责任，因果",
    fullDescription: "正义象征着平衡与公正。你的行为会产生相应的结果，保持诚实和公正。做出负责任的决定，寻求内心的平衡。考虑你的行为的后果，做出公正的决定，为自己的选择承担责任。",
    type: CardType.MAJOR
  },
  {
    id: 12,
    name: "倒吊人",
    image: $r('app.media.card_12'),
    description: "牺牲，等待，新视角，放下",
    fullDescription: "倒吊人代表着牺牲与等待。有时候需要放下执念，换个角度看问题。通过等待和反思，你会获得新的理解和智慧。接受现状，换个角度看问题，有时候暂停行动比强行推进更有智慧。",
    type: CardType.MAJOR
  },
  {
    id: 13,
    name: "死神",
    image: $r('app.media.card_13'),
    description: "结束，转变，重生，放下",
    fullDescription: "死神象征着结束与转变。旧的必须结束，才能让新的开始。放下过去，接受变化，这会带来重生和新的可能性。结束是新的开始的前奏，放下不再服务于你的东西，为新的成长腾出空间。",
    type: CardType.MAJOR
  },
  {
    id: 14,
    name: "节制",
    image: $r('app.media.card_14'),
    description: "平衡，调和，耐心，融合",
    fullDescription: "节制代表着平衡与调和。在生活的各个方面寻求平衡，融合不同的元素。保持耐心，通过调和达到和谐的状态。找到不同方面的平衡，融合看似对立的元素，通过耐心和调节达到和谐。",
    type: CardType.MAJOR
  },
  {
    id: 15,
    name: "恶魔",
    image: $r('app.media.card_15'),
    description: "束缚，欲望，物质主义，觉醒",
    fullDescription: "恶魔象征着束缚与欲望。你可能被物质或欲望所束缚，需要觉醒并打破这些限制。认识到真正的自由来自内心的解放。审视你的束缚和依赖，认识到你有选择，真正的自由来自内心的觉醒。",
    type: CardType.MAJOR
  },
  {
    id: 16,
    name: "塔",
    image: $r('app.media.card_16'),
    description: "突然变化，启示，解放，重建",
    fullDescription: "塔代表着突然的变化与启示。旧的结构可能突然崩塌，但这会带来解放和新的开始。接受这些变化，重建更坚实的基础。虽然变化可能突然和剧烈，但这是必要的破坏，为更真实和稳固的基础让路。",
    type: CardType.MAJOR
  },
  {
    id: 17,
    name: "星星",
    image: $r('app.media.card_17'),
    description: "希望，灵感，指引，平静",
    fullDescription: "星星象征着希望与灵感。即使在困难时期，也要保持希望。相信未来，跟随内心的指引，平静地前行。保持希望和信念，相信更好的未来，让内在的灵感指引你前进。",
    type: CardType.MAJOR
  },
  {
    id: 18,
    name: "月亮",
    image: $r('app.media.card_18'),
    description: "幻觉，恐惧，潜意识，直觉",
    fullDescription: "月亮代表着幻觉与恐惧。你可能被恐惧或幻觉所困扰，需要面对内心的阴影。相信你的直觉，但也要保持理性。面对你的恐惧和潜意识，区分真实和幻觉，通过理解内在的阴影来获得成长。",
    type: CardType.MAJOR
  },
  {
    id: 19,
    name: "太阳",
    image: $r('app.media.card_19'),
    description: "快乐，成功，活力，光明",
    fullDescription: "太阳象征着快乐与成功。这是一个充满活力和光明的时期，你的努力会得到回报。享受生活的美好，保持积极的心态。这是一个充满喜悦、成功和活力的时期，享受生活的美好，保持乐观和开放的心态。",
    type: CardType.MAJOR
  },
  {
    id: 20,
    name: "审判",
    image: $r('app.media.card_20'),
    description: "觉醒，重生，反思，宽恕",
    fullDescription: "审判代表着觉醒与重生。现在是反思过去、宽恕自己和他人的时候。通过觉醒，你会获得新的理解和重生。这是一个反思和评估的时期，通过宽恕和觉醒，你会获得新的开始和更深的理解。",
    type: CardType.MAJOR
  },
  {
    id: 21,
    name: "世界",
    image: $r('app.media.card_21'),
    description: "完成，成就，圆满，新开始",
    fullDescription: "世界象征着完成与成就。一个周期即将结束，你取得了圆满的成就。这是庆祝的时刻，也是新开始的准备。你已经完成了一个重要的周期，取得了成就，现在是庆祝和准备新开始的时候。",
    type: CardType.MAJOR
  },

  // ========== 小阿卡纳牌 (22-77) ==========
  // 权杖（Wands）- 火元素，代表行动、创造力、激情
  // 权杖数字牌 (22-31)
  {
    id: 22,
    name: "权杖一",
    image: $r('app.media.card_wands_01'),
    description: "新开始，创造力，灵感，行动",
    fullDescription: "权杖一代表着新的开始和创造力的迸发。这是一个充满能量和热情的时期，新的想法和项目正在萌芽。抓住这个机会，将你的灵感转化为行动。这是开始新项目、追求新目标的绝佳时机，相信你的直觉，勇敢地迈出第一步。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    number: 1
  },
  {
    id: 23,
    name: "权杖二",
    image: $r('app.media.card_wands_02'),
    description: "规划，选择，未来展望，等待",
    fullDescription: "权杖二代表着规划和未来展望。你正在考虑未来的方向，需要做出重要的选择。虽然你拥有资源和能力，但现在需要仔细规划。评估你的选择，考虑长期目标，不要急于行动，等待合适的时机。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    number: 2
  },
  {
    id: 24,
    name: "权杖三",
    image: $r('app.media.card_wands_03'),
    description: "探索，远见，领导力，扩张",
    fullDescription: "权杖三代表着探索和远见。你已经建立了基础，现在可以展望更广阔的未来。这是一个扩张和探索的时期，你的领导力正在显现。保持远见，继续前进，你的努力将带来更大的成功和认可。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    number: 3
  },
  {
    id: 25,
    name: "权杖四",
    image: $r('app.media.card_wands_04'),
    description: "庆祝，稳定，和谐，成就",
    fullDescription: "权杖四代表着庆祝和稳定。你取得了阶段性的成就，现在是庆祝和享受成果的时候。这是一个和谐稳定的时期，你的努力得到了回报。与家人朋友分享你的成功，享受这个充满喜悦和满足的时刻。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    number: 4
  },
  {
    id: 26,
    name: "权杖五",
    image: $r('app.media.card_wands_05'),
    description: "竞争，冲突，挑战，成长",
    fullDescription: "权杖五代表着竞争和冲突。你可能面临挑战或竞争，但这也是成长的机会。通过面对这些挑战，你会变得更强大。不要害怕冲突，将其视为学习和成长的机会，保持你的立场，但也要保持开放的心态。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    number: 5
  },
  {
    id: 27,
    name: "权杖六",
    image: $r('app.media.card_wands_06'),
    description: "胜利，成功，认可，前进",
    fullDescription: "权杖六代表着胜利和成功。你的努力得到了认可，你正在朝着目标前进。这是一个充满自信和成就感的时期。继续前进，保持你的优势，你的成功会激励他人，也会为你带来更多的机会。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    number: 6
  },
  {
    id: 28,
    name: "权杖七",
    image: $r('app.media.card_wands_07'),
    description: "挑战，防御，坚持，勇气",
    fullDescription: "权杖七代表着挑战和坚持。你可能面临挑战或反对，但你有能力应对。保持你的立场，坚持你的信念，不要轻易放弃。这是考验你决心和勇气的时刻，相信自己的能力，勇敢地面对挑战。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    number: 7
  },
  {
    id: 29,
    name: "权杖八",
    image: $r('app.media.card_wands_08'),
    description: "快速行动，进展，速度，变化",
    fullDescription: "权杖八代表着快速行动和进展。事情正在快速推进，变化来得很快。这是一个充满动力的时期，你的计划正在迅速实现。保持灵活，适应快速的变化，抓住机会，不要让犹豫阻碍你的前进。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    number: 8
  },
  {
    id: 30,
    name: "权杖九",
    image: $r('app.media.card_wands_09'),
    description: "坚持，韧性，最后努力，耐力",
    fullDescription: "权杖九代表着坚持和韧性。你已经走了很长的路，虽然疲惫，但仍在坚持。这是最后的努力阶段，不要放弃。你已经付出了很多，胜利就在眼前。保持你的决心，运用你的经验，继续前进。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    number: 9
  },
  {
    id: 31,
    name: "权杖十",
    image: $r('app.media.card_wands_10'),
    description: "负担，责任，压力，完成",
    fullDescription: "权杖十代表着负担和责任。你可能承担了过多的责任，感到压力很大。虽然你接近完成，但负担很重。考虑分担责任，不要独自承担一切。你已经很接近目标了，但需要找到平衡，避免过度劳累。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    number: 10
  },
  // 权杖宫廷牌 (32-35)
  {
    id: 32,
    name: "权杖侍从",
    image: $r('app.media.card_wands_page'),
    description: "新消息，探索，热情，学习",
    fullDescription: "权杖侍从代表着新消息和探索精神。你可能收到关于新机会或新项目的消息，或者你正在探索新的可能性。保持开放和热情，愿意学习和尝试新事物。这是一个充满好奇心和探索精神的时期。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    courtRank: "侍从"
  },
  {
    id: 33,
    name: "权杖骑士",
    image: $r('app.media.card_wands_knight'),
    description: "行动，冒险，冲动，追求",
    fullDescription: "权杖骑士代表着行动和冒险。你充满能量和热情，准备采取行动。这是一个追求目标和冒险的时期，但要注意不要过于冲动。保持你的热情，但也要有计划和策略，避免鲁莽行事。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    courtRank: "骑士"
  },
  {
    id: 34,
    name: "权杖皇后",
    image: $r('app.media.card_wands_queen'),
    description: "自信，独立，创造力，热情",
    fullDescription: "权杖皇后代表着自信和独立。你是一个充满创造力和热情的人，拥有强烈的独立精神。你能够激励他人，用自己的方式实现目标。保持你的自信和热情，继续追求你的梦想，你的能量会感染周围的人。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    courtRank: "皇后"
  },
  {
    id: 35,
    name: "权杖国王",
    image: $r('app.media.card_wands_king'),
    description: "领导力，远见，创业精神，成就",
    fullDescription: "权杖国王代表着领导力和远见。你是一个天生的领导者，拥有远见和创业精神。你能够激励团队，实现宏伟的目标。运用你的领导力和经验，继续追求更大的成就，你的远见和决心会带来成功。",
    type: CardType.MINOR,
    suit: Suit.WANDS,
    courtRank: "国王"
  },

  // 圣杯（Cups）- 水元素，代表情感、直觉、关系
  // 圣杯数字牌 (36-45)
  {
    id: 36,
    name: "圣杯一",
    image: $r('app.media.card_cups_01'),
    description: "新感情，情感开始，直觉，爱",
    fullDescription: "圣杯一代表着新的情感开始。这可能意味着新的感情、友谊或情感连接。你的心是开放的，情感正在流动。这是一个充满爱和情感满足的时期，相信你的直觉，让情感自然地流动。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    number: 1
  },
  {
    id: 37,
    name: "圣杯二",
    image: $r('app.media.card_cups_02'),
    description: "伙伴关系，爱情，合作，平衡",
    fullDescription: "圣杯二代表着伙伴关系和爱情。这可能意味着一段新的关系或现有关系的深化。这是一种平等、和谐和相互支持的关系。珍惜这种连接，通过合作和沟通来加深关系，保持平衡和相互尊重。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    number: 2
  },
  {
    id: 38,
    name: "圣杯三",
    image: $r('app.media.card_cups_03'),
    description: "友谊，庆祝，社交，快乐",
    fullDescription: "圣杯三代表着友谊和庆祝。这是一个充满快乐和社交活动的时期，你与朋友和同事的关系很好。享受这些美好的时光，庆祝你的成就，与重要的人分享快乐。这是建立和加强社交联系的绝佳时机。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    number: 3
  },
  {
    id: 39,
    name: "圣杯四",
    image: $r('app.media.card_cups_04'),
    description: "沉思，不满，机会，内省",
    fullDescription: "圣杯四代表着沉思和内省。你可能对现状感到不满，正在思考新的可能性。虽然有机会出现，但你可能在犹豫。花时间反思你的真正需求，不要错过新的机会，但也要确保它符合你的价值观。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    number: 4
  },
  {
    id: 40,
    name: "圣杯五",
    image: $r('app.media.card_cups_05'),
    description: "失落，悲伤，遗憾，接受",
    fullDescription: "圣杯五代表着失落和悲伤。你可能因为失去某些东西而感到悲伤，但不要忘记你仍然拥有的。虽然你专注于失去的，但还有希望和机会在身边。接受这些情感，但也要看到仍然存在的可能性。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    number: 5
  },
  {
    id: 41,
    name: "圣杯六",
    image: $r('app.media.card_cups_06'),
    description: "回忆，童年，纯真，给予",
    fullDescription: "圣杯六代表着回忆和纯真。这可能与过去的美好回忆有关，或者你正在给予他人帮助和支持。这是一个充满温暖和关怀的时期，珍惜这些美好的回忆，也愿意给予他人帮助。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    number: 6
  },
  {
    id: 42,
    name: "圣杯七",
    image: $r('app.media.card_cups_07'),
    description: "幻想，选择，梦想，现实",
    fullDescription: "圣杯七代表着幻想和选择。你可能有很多梦想和选择，但需要区分幻想和现实。虽然有很多可能性，但你需要做出实际的选择。审视你的选择，确定哪些是真正可行的，哪些只是幻想。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    number: 7
  },
  {
    id: 43,
    name: "圣杯八",
    image: $r('app.media.card_cups_08'),
    description: "离开，寻找，放弃，追求",
    fullDescription: "圣杯八代表着离开和寻找。你可能正在离开不再满足你的情况，去寻找更深层的意义。虽然离开可能困难，但这是为了追求更高的目标。相信你的直觉，勇敢地离开舒适区，追求真正让你满足的东西。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    number: 8
  },
  {
    id: 44,
    name: "圣杯九",
    image: $r('app.media.card_cups_09'),
    description: "满足，愿望实现，快乐，成就",
    fullDescription: "圣杯九代表着满足和愿望实现。你的情感需求得到了满足，你感到快乐和满足。这是一个充满成就感和情感满足的时期。享受这个美好的时刻，你的愿望正在实现，继续追求让你快乐的事物。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    number: 9
  },
  {
    id: 45,
    name: "圣杯十",
    image: $r('app.media.card_cups_10'),
    description: "家庭幸福，情感满足，和谐，圆满",
    fullDescription: "圣杯十代表着家庭幸福和情感满足。这是一个充满爱、和谐和满足的时期，你的情感生活非常圆满。与家人和爱人分享这些美好的时光，珍惜这些珍贵的连接，这是情感生活的最高境界。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    number: 10
  },
  // 圣杯宫廷牌 (46-49)
  {
    id: 46,
    name: "圣杯侍从",
    image: $r('app.media.card_cups_page'),
    description: "情感消息，直觉，纯真，新开始",
    fullDescription: "圣杯侍从代表着情感消息和直觉。你可能收到关于感情或情感方面的消息，或者你正在发展新的情感连接。相信你的直觉，保持开放和纯真的心，新的情感机会正在出现。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    courtRank: "侍从"
  },
  {
    id: 47,
    name: "圣杯骑士",
    image: $r('app.media.card_cups_knight'),
    description: "浪漫，追求，理想主义，情感",
    fullDescription: "圣杯骑士代表着浪漫和追求。你可能正在追求一段浪漫的关系，或者你是一个理想主义和浪漫的人。你充满情感和热情，愿意为爱情和理想付出。保持你的理想主义，但也要保持现实，追求真正的情感连接。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    courtRank: "骑士"
  },
  {
    id: 48,
    name: "圣杯皇后",
    image: $r('app.media.card_cups_queen'),
    description: "直觉，同情，情感智慧，关怀",
    fullDescription: "圣杯皇后代表着直觉和情感智慧。你拥有强大的直觉和同情心，能够理解和关怀他人。你是一个情感丰富和智慧的人，能够为他人提供情感支持。运用你的直觉和同情心，继续为他人提供支持和关怀。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    courtRank: "皇后"
  },
  {
    id: 49,
    name: "圣杯国王",
    image: $r('app.media.card_cups_king'),
    description: "情感成熟，同情，支持，智慧",
    fullDescription: "圣杯国王代表着情感成熟和智慧。你是一个情感成熟和智慧的人，能够为他人提供支持和指导。你拥有强大的直觉和同情心，能够理解和支持他人的情感需求。运用你的情感智慧，继续为他人提供支持和指导。",
    type: CardType.MINOR,
    suit: Suit.CUPS,
    courtRank: "国王"
  },

  // 宝剑（Swords）- 风元素，代表思想、沟通、冲突
  // 宝剑数字牌 (50-59)
  {
    id: 50,
    name: "宝剑一",
    image: $r('app.media.card_swords_01'),
    description: "新想法，清晰，突破，真理",
    fullDescription: "宝剑一代表着新想法和清晰。一个新的想法或洞察正在出现，带来了清晰和突破。这是一个充满智慧和清晰思维的时期。运用你的智慧，追求真理，这个新的想法可能会带来重要的突破。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    number: 1
  },
  {
    id: 51,
    name: "宝剑二",
    image: $r('app.media.card_swords_02'),
    description: "选择，犹豫，平衡，决定",
    fullDescription: "宝剑二代表着选择和犹豫。你可能面临一个重要的决定，正在权衡不同的选择。虽然你感到犹豫，但需要做出决定。仔细考虑你的选择，但不要过度分析，相信你的判断，做出决定。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    number: 2
  },
  {
    id: 52,
    name: "宝剑三",
    image: $r('app.media.card_swords_03'),
    description: "心痛，悲伤，失落，接受",
    fullDescription: "宝剑三代表着心痛和悲伤。你可能正在经历情感上的痛苦或失落，感到心痛。虽然这很痛苦，但这是成长的一部分。允许自己感受这些情感，接受痛苦，但也要知道这会过去，你会变得更强大。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    number: 3
  },
  {
    id: 53,
    name: "宝剑四",
    image: $r('app.media.card_swords_04'),
    description: "休息，恢复，内省，暂停",
    fullDescription: "宝剑四代表着休息和恢复。你可能需要暂停和休息，从冲突或压力中恢复。这是一个内省和恢复的时期。给自己时间休息和恢复，通过内省来找到内心的平静，为未来的行动做好准备。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    number: 4
  },
  {
    id: 54,
    name: "宝剑五",
    image: $r('app.media.card_swords_05'),
    description: "冲突，竞争，分歧，损失",
    fullDescription: "宝剑五代表着冲突和竞争。你可能卷入冲突或竞争，可能有分歧和损失。虽然你可能在冲突中获胜，但代价可能很高。考虑冲突的后果，寻找和平解决的方法，避免不必要的争斗。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    number: 5
  },
  {
    id: 55,
    name: "宝剑六",
    image: $r('app.media.card_swords_06'),
    description: "过渡，离开，寻求帮助，希望",
    fullDescription: "宝剑六代表着过渡和离开。你可能正在离开困难的情况，寻求更好的未来。虽然过程可能困难，但有希望。接受帮助，相信你会找到更好的地方，这个过渡会带来积极的变化。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    number: 6
  },
  {
    id: 56,
    name: "宝剑七",
    image: $r('app.media.card_swords_07'),
    description: "欺骗，策略，秘密，风险",
    fullDescription: "宝剑七代表着欺骗和策略。可能有欺骗或秘密的行为，或者你需要使用策略。但要小心，欺骗可能会带来风险。保持诚实，使用正当的策略，避免欺骗和秘密行为，诚实会带来更好的结果。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    number: 7
  },
  {
    id: 57,
    name: "宝剑八",
    image: $r('app.media.card_swords_08'),
    description: "束缚，限制，自我限制，解放",
    fullDescription: "宝剑八代表着束缚和限制。你可能感到被束缚或限制，但这些限制可能是自我强加的。你拥有解放自己的能力。审视你的限制，认识到很多限制是自我强加的，你有能力打破这些束缚。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    number: 8
  },
  {
    id: 58,
    name: "宝剑九",
    image: $r('app.media.card_swords_09'),
    description: "焦虑，噩梦，恐惧，担忧",
    fullDescription: "宝剑九代表着焦虑和恐惧。你可能被焦虑、恐惧或担忧所困扰，感到痛苦。这些恐惧可能是过度的或非理性的。面对你的恐惧，寻求支持，认识到很多担忧是过度的，你有能力克服这些恐惧。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    number: 9
  },
  {
    id: 59,
    name: "宝剑十",
    image: $r('app.media.card_swords_10'),
    description: "结束，痛苦，释放，新开始",
    fullDescription: "宝剑十代表着结束和痛苦。一个困难的时期即将结束，虽然痛苦，但这是必要的结束。痛苦会过去，新的开始即将到来。接受这个结束，释放痛苦，为新的开始做好准备，黎明就在眼前。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    number: 10
  },
  // 宝剑宫廷牌 (60-63)
  {
    id: 60,
    name: "宝剑侍从",
    image: $r('app.media.card_swords_page'),
    description: "新想法，好奇心，学习，消息",
    fullDescription: "宝剑侍从代表着新想法和好奇心。你可能收到新的消息或想法，或者你正在学习新事物。保持好奇心和开放的心态，这个新的想法或消息可能会带来重要的洞察。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    courtRank: "侍从"
  },
  {
    id: 61,
    name: "宝剑骑士",
    image: $r('app.media.card_swords_knight'),
    description: "行动，冲动，直接，追求",
    fullDescription: "宝剑骑士代表着行动和直接。你充满能量，准备采取行动，但可能过于冲动。你追求目标时很直接，但要注意不要过于鲁莽。保持你的热情，但也要有策略，避免冲动行事。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    courtRank: "骑士"
  },
  {
    id: 62,
    name: "宝剑皇后",
    image: $r('app.media.card_swords_queen'),
    description: "清晰，独立，诚实，智慧",
    fullDescription: "宝剑皇后代表着清晰和独立。你是一个独立、诚实和智慧的人，拥有清晰的思维。你能够客观地看待事物，做出明智的决定。运用你的智慧和清晰思维，继续追求真理和独立。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    courtRank: "皇后"
  },
  {
    id: 63,
    name: "宝剑国王",
    image: $r('app.media.card_swords_king'),
    description: "权威，真理，公正，领导力",
    fullDescription: "宝剑国王代表着权威和真理。你是一个公正、智慧和权威的领导者，追求真理和公正。你能够做出明智的决定，为他人提供指导。运用你的智慧和权威，继续追求真理和公正，为他人树立榜样。",
    type: CardType.MINOR,
    suit: Suit.SWORDS,
    courtRank: "国王"
  },

  // 星币（Pentacles）- 土元素，代表物质、金钱、工作
  // 星币数字牌 (64-73)
  {
    id: 64,
    name: "星币一",
    image: $r('app.media.card_pentacles_01'),
    description: "新机会，物质开始，潜力，投资",
    fullDescription: "星币一代表着新的物质机会。一个新的财务或工作机会正在出现，带来了物质上的潜力。这是一个投资和开始的绝佳时机。抓住这个机会，明智地投资你的时间和资源，这个新的开始会带来物质上的回报。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    number: 1
  },
  {
    id: 65,
    name: "星币二",
    image: $r('app.media.card_pentacles_02'),
    description: "平衡，优先事项，资源管理，选择",
    fullDescription: "星币二代表着平衡和资源管理。你可能需要在不同的优先事项之间找到平衡，管理你的资源。虽然你有多项任务，但需要找到平衡。仔细管理你的资源，确定优先事项，找到工作和生活的平衡。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    number: 2
  },
  {
    id: 66,
    name: "星币三",
    image: $r('app.media.card_pentacles_03'),
    description: "合作，技能，学习，团队",
    fullDescription: "星币三代表着合作和技能。你可能正在与团队合作，学习新技能，或者你的技能得到了认可。这是一个合作和学习的时期。继续发展你的技能，与团队合作，你的努力会得到认可和回报。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    number: 3
  },
  {
    id: 67,
    name: "星币四",
    image: $r('app.media.card_pentacles_04'),
    description: "安全，控制，保守，稳定",
    fullDescription: "星币四代表着安全和稳定。你可能在财务或物质方面感到安全，但可能过于保守和控制。虽然稳定是好的，但也要保持灵活性。找到安全感和开放之间的平衡，不要过于保守，也要愿意分享和投资。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    number: 4
  },
  {
    id: 68,
    name: "星币五",
    image: $r('app.media.card_pentacles_05'),
    description: "财务困难，孤立，贫困，支持",
    fullDescription: "星币五代表着财务困难。你可能面临财务或物质上的困难，感到孤立。虽然困难，但仍有希望和支持。寻求帮助，不要独自承担，困难是暂时的，通过努力和支持，你会度过这个困难时期。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    number: 5
  },
  {
    id: 69,
    name: "星币六",
    image: $r('app.media.card_pentacles_06'),
    description: "给予，分享，平衡，慷慨",
    fullDescription: "星币六代表着给予和分享。你可能在给予或接受帮助，分享资源，或者你拥有足够的资源来帮助他人。这是一个平衡和慷慨的时期。如果你有能力，慷慨地帮助他人；如果你需要帮助，不要害怕接受。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    number: 6
  },
  {
    id: 70,
    name: "星币七",
    image: $r('app.media.card_pentacles_07'),
    description: "评估，规划，耐心，投资",
    fullDescription: "星币七代表着评估和规划。你可能正在评估你的进展，规划未来，或者你的投资正在成长。这是一个需要耐心的时期。继续你的努力，保持耐心，你的投资和努力会带来回报，但要继续规划和评估。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    number: 7
  },
  {
    id: 71,
    name: "星币八",
    image: $r('app.media.card_pentacles_08'),
    description: "技能，努力，专注，进步",
    fullDescription: "星币八代表着技能和努力。你正在通过努力和专注来发展技能，取得进步。这是一个需要持续努力的时期。继续专注于你的工作，发展你的技能，你的努力会带来长期的回报和成功。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    number: 8
  },
  {
    id: 72,
    name: "星币九",
    image: $r('app.media.card_pentacles_09'),
    description: "独立，自给自足，享受，成就",
    fullDescription: "星币九代表着独立和自给自足。你已经取得了物质上的成功，能够自给自足，享受你的成就。这是一个充满满足和独立的时期。享受你的成就，但也要保持谦逊，继续努力，你的成功会带来更多的机会。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    number: 9
  },
  {
    id: 73,
    name: "星币十",
    image: $r('app.media.card_pentacles_10'),
    description: "财富，家庭，稳定，传承",
    fullDescription: "星币十代表着财富和家庭稳定。你可能在财务上非常成功，家庭稳定，或者你正在建立长期的财富和传承。这是一个充满物质满足和家庭幸福的时期。珍惜你的财富和家庭，继续建立稳定的基础，为未来做准备。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    number: 10
  },
  // 星币宫廷牌 (74-77)
  {
    id: 74,
    name: "星币侍从",
    image: $r('app.media.card_pentacles_page'),
    description: "学习，机会，潜力，新开始",
    fullDescription: "星币侍从代表着学习和新机会。你可能正在学习新技能，或者一个新的工作或财务机会正在出现。这是一个充满潜力的时期。抓住学习的机会，发展你的技能，这个新的开始会带来物质上的回报。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    courtRank: "侍从"
  },
  {
    id: 75,
    name: "星币骑士",
    image: $r('app.media.card_pentacles_01'),
    description: "努力，责任，稳定，追求",
    fullDescription: "星币骑士代表着努力和责任。你正在努力工作，承担责任，追求物质上的稳定和成功。这是一个需要持续努力的时期。保持你的努力和责任感，继续追求你的目标，你的坚持会带来成功。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    courtRank: "骑士"
  },
  {
    id: 76,
    name: "星币皇后",
    image: $r('app.media.card_pentacles_queen'),
    description: "实用，慷慨，稳定，关怀",
    fullDescription: "星币皇后代表着实用和慷慨。你是一个实用、慷慨和稳定的人，能够管理资源，关怀他人。你拥有物质上的安全感，也愿意分享。运用你的实用智慧和慷慨，继续为他人提供支持和关怀。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    courtRank: "皇后"
  },
  {
    id: 77,
    name: "星币国王",
    image: $r('app.media.card_pentacles_king'),
    description: "成功，稳定，领导力，财富",
    fullDescription: "星币国王代表着成功和稳定。你是一个成功、稳定和富有的领导者，拥有物质上的成就和智慧。你能够管理资源，为他人提供支持和指导。运用你的成功和智慧，继续建立稳定的基础，为他人树立榜样。",
    type: CardType.MINOR,
    suit: Suit.PENTACLES,
    courtRank: "国王"
  }
];

/**
 * 牌阵类型
 */
export enum SpreadType {
  SINGLE = 1,    // 单张牌
  THREE = 3,     // 三张牌
  SEVEN = 7      // 七张牌
}

/**
 * 牌阵位置含义（三张牌）
 */
export interface ThreeCardPosition {
  position: 'past' | 'present' | 'future';
  label: string;
}

/**
 * 牌阵位置含义（七张牌）
 */
export interface SevenCardPosition {
  position: 'situation' | 'challenge' | 'past' | 'future' | 'goal' | 'approach' | 'outcome';
  label: string;
}

/**
 * 抽中的卡牌及其位置信息
 */
export interface DrawnCard {
  card: TarotCard;
  position?: string;  // 位置标签（如"过去"、"现在"、"未来"等）
  positionLabel?: string; // 位置说明
}

/**
 * 占卜结果
 */
export interface ReadingResult {
  question: string;           // 用户问题
  spreadType: SpreadType;     // 牌阵类型
  cards: DrawnCard[];         // 抽中的卡牌
  interpretation: string;     // 个性化解读
}

/**
 * 三张牌位置定义
 */
const THREE_CARD_POSITIONS: ThreeCardPosition[] = [
  { position: 'past', label: '过去' },
  { position: 'present', label: '现在' },
  { position: 'future', label: '未来' }
];

/**
 * 七张牌位置定义
 */
const SEVEN_CARD_POSITIONS: SevenCardPosition[] = [
  { position: 'situation', label: '现状' },
  { position: 'challenge', label: '挑战' },
  { position: 'past', label: '过去' },
  { position: 'future', label: '未来' },
  { position: 'goal', label: '目标' },
  { position: 'approach', label: '方法' },
  { position: 'outcome', label: '结果' }
];

/**
 * 随机抽取一张塔罗牌（不重复）
 * @param drawnIds 已抽取的卡牌ID列表
 * @returns 随机选中的塔罗牌
 */
export function drawRandomCard(drawnIds: number[] = []): TarotCard {
  const availableCards = TAROT_CARDS.filter(card => !drawnIds.includes(card.id));
  if (availableCards.length === 0) {
    // 如果所有牌都被抽过，重置
    const randomIndex = Math.floor(Math.random() * TAROT_CARDS.length);
    return TAROT_CARDS[randomIndex];
  }
  const randomIndex = Math.floor(Math.random() * availableCards.length);
  return availableCards[randomIndex];
}

/**
 * 抽取多张塔罗牌
 * @param count 抽取数量
 * @returns 抽中的卡牌数组
 */
export function drawMultipleCards(count: number): TarotCard[] {
  const cards: TarotCard[] = [];
  const drawnIds: number[] = [];

  for (let i = 0; i < count; i++) {
    const card = drawRandomCard(drawnIds);
    cards.push(card);
    drawnIds.push(card.id);
  }

  return cards;
}

/**
 * 生成三张牌占卜结果
 * @param question 用户问题
 * @param cards 抽中的三张牌
 * @returns 占卜结果
 */
export function generateThreeCardReading(question: string, cards: TarotCard[]): ReadingResult {
  const drawnCards: DrawnCard[] = cards.slice(0, THREE_CARD_POSITIONS.length).map((card, index): DrawnCard => {
    const positionInfo = THREE_CARD_POSITIONS[index];
    return {
      card,
      position: positionInfo.position,
      positionLabel: positionInfo.label
    };
  });

  // 生成个性化解读
  const interpretation = generateThreeCardInterpretation(question, drawnCards);

  return {
    question: question,
    spreadType: SpreadType.THREE,
    cards: drawnCards,
    interpretation: interpretation
  };
}

/**
 * 生成七张牌占卜结果
 * @param question 用户问题
 * @param cards 抽中的七张牌
 * @returns 占卜结果
 */
export function generateSevenCardReading(question: string, cards: TarotCard[]): ReadingResult {
  const drawnCards: DrawnCard[] = cards.slice(0, SEVEN_CARD_POSITIONS.length).map((card, index): DrawnCard => {
    const positionInfo = SEVEN_CARD_POSITIONS[index];
    return {
      card,
      position: positionInfo.position,
      positionLabel: positionInfo.label
    };
  });

  // 生成个性化解读
  const interpretation = generateSevenCardInterpretation(question, drawnCards);

  return {
    question: question,
    spreadType: SpreadType.SEVEN,
    cards: drawnCards,
    interpretation: interpretation
  };
}

/**
 * 生成单张牌占卜结果
 * @param question 用户问题
 * @param card 抽中的卡牌
 * @returns 占卜结果
 */
export function generateSingleCardReading(question: string, card: TarotCard): ReadingResult {
  const interpretation = generateSingleCardInterpretation(question, card);

  return {
    question: question,
    spreadType: SpreadType.SINGLE,
    cards: [{ card }],
    interpretation: interpretation
  };
}

/**
 * 获取卡牌类型描述
 */
function getCardTypeDescription(card: TarotCard): string {
  if (card.type === CardType.MAJOR) {
    return '大阿卡纳牌';
  } else if (card.suit === Suit.WANDS) {
    return '权杖牌（火元素，代表行动、创造力、激情）';
  } else if (card.suit === Suit.CUPS) {
    return '圣杯牌（水元素，代表情感、直觉、关系）';
  } else if (card.suit === Suit.SWORDS) {
    return '宝剑牌（风元素，代表思想、沟通、冲突）';
  } else if (card.suit === Suit.PENTACLES) {
    return '星币牌（土元素，代表物质、金钱、工作）';
  }
  return '塔罗牌';
}

/**
 * 根据问题类型和卡牌类型生成精准的解读建议
 */
function getContextualAdvice(question: string, card: TarotCard): string {
  const questionLower = question.toLowerCase();
  const isLove = questionLower.includes('爱情') || questionLower.includes('感情') || questionLower.includes('恋爱') || questionLower.includes('关系');
  const isWork = questionLower.includes('工作') || questionLower.includes('事业') || questionLower.includes('职业') || questionLower.includes('职场');
  const isStudy = questionLower.includes('学业') || questionLower.includes('学习') || questionLower.includes('考试') || questionLower.includes('教育');
  const isHealth = questionLower.includes('健康') || questionLower.includes('身体') || questionLower.includes('疾病');
  const isMoney = questionLower.includes('财运') || questionLower.includes('金钱') || questionLower.includes('财务') || questionLower.includes('投资');

  // 根据卡牌类型和问题类型生成精准建议
  if (card.type === CardType.MAJOR) {
    // 大阿卡纳牌 - 深层意义和人生课题
    if (isLove) {
      return '这张大阿卡纳牌揭示了你在感情方面的深层课题。它提醒你关注感情的本质和意义，而不仅仅是表面的关系。';
    } else if (isWork) {
      return '这张大阿卡纳牌反映了你事业发展的核心主题。它指向你职业道路上的重要转折点或人生使命。';
    } else if (isMoney) {
      return '这张大阿卡纳牌揭示了你在物质和财富方面的深层课题。它提醒你财富与精神成长的关系。';
    }
    return '这张大阿卡纳牌揭示了问题的核心本质，它指向你人生中的重要课题和成长方向。';
  } else if (card.suit === Suit.WANDS) {
    // 权杖牌 - 行动和创造力
    if (isWork || isStudy) {
      return '权杖牌强调行动和创造力。关于你的问题，这张牌建议你采取主动，将想法转化为行动，用你的热情和创造力来推动进展。';
    } else if (isLove) {
      return '权杖牌在感情中代表热情和行动。这张牌提醒你在关系中保持活力和热情，主动表达你的感受，不要让关系变得停滞。';
    }
    return '权杖牌代表火元素，强调行动、创造力和热情。关于你的问题，这张牌建议你采取主动，用你的能量和热情来推动事情发展。';
  } else if (card.suit === Suit.CUPS) {
    // 圣杯牌 - 情感和直觉
    if (isLove) {
      return '圣杯牌在感情中特别重要，代表情感连接和直觉。这张牌提醒你关注情感的真实需求，相信你的直觉，让情感自然地流动。';
    } else if (isWork) {
      return '圣杯牌在工作中的意义是关注团队合作和情感智慧。这张牌建议你重视人际关系，用同理心和直觉来处理工作事务。';
    }
    return '圣杯牌代表水元素，强调情感、直觉和关系。关于你的问题，这张牌建议你关注情感层面，相信你的直觉，重视人际关系。';
  } else if (card.suit === Suit.SWORDS) {
    // 宝剑牌 - 思想和沟通
    if (isWork || isStudy) {
      return '宝剑牌强调清晰的思维和沟通。关于你的问题，这张牌建议你用理性和清晰的思维来分析情况，通过有效的沟通来解决问题。';
    } else if (isLove) {
      return '宝剑牌在感情中提醒你注意沟通和诚实。这张牌建议你诚实地表达自己的想法和感受，通过清晰的沟通来解决关系中的问题。';
    }
    return '宝剑牌代表风元素，强调思想、沟通和真理。关于你的问题，这张牌建议你用清晰的思维来分析，通过诚实和有效的沟通来解决问题。';
  } else if (card.suit === Suit.PENTACLES) {
    // 星币牌 - 物质和实际
    if (isMoney || isWork) {
      return '星币牌在财务和工作中特别重要，代表实际的努力和物质回报。这张牌建议你专注于实际的工作，通过持续的努力来获得物质上的成功。';
    } else if (isHealth) {
      return '星币牌在健康方面提醒你关注身体的实际需求。这张牌建议你重视身体的健康，通过实际的行动来改善身体状况。';
    }
    return '星币牌代表土元素，强调实际、稳定和物质。关于你的问题，这张牌建议你关注实际层面，通过持续的努力和稳定的行动来获得成果。';
  }

  return '结合你提出的问题，这张牌提醒你要关注内心的声音，相信自己的直觉。答案往往就在你心中，只是需要静下心来去感受。';
}

/**
 * 生成单张牌个性化解读
 */
function generateSingleCardInterpretation(question: string, card: TarotCard): string {
  const cardName = card.name;
  const cardDesc = card.fullDescription;
  const cardTypeDesc = getCardTypeDescription(card);

  // 根据问题关键词生成个性化解读
  const questionLower = question.toLowerCase();
  let personalizedIntro = '';

  if (questionLower.includes('爱情') || questionLower.includes('感情') || questionLower.includes('恋爱')) {
    personalizedIntro = `关于你的感情问题，${cardName}（${cardTypeDesc}）为你带来了这样的指引：`;
  } else if (questionLower.includes('工作') || questionLower.includes('事业') || questionLower.includes('职业')) {
    personalizedIntro = `关于你的事业发展，${cardName}（${cardTypeDesc}）揭示了这样的信息：`;
  } else if (questionLower.includes('学业') || questionLower.includes('学习') || questionLower.includes('考试')) {
    personalizedIntro = `关于你的学业问题，${cardName}（${cardTypeDesc}）给出了这样的建议：`;
  } else if (questionLower.includes('健康') || questionLower.includes('身体')) {
    personalizedIntro = `关于你的健康状况，${cardName}（${cardTypeDesc}）提醒你：`;
  } else if (questionLower.includes('财运') || questionLower.includes('金钱') || questionLower.includes('财务')) {
    personalizedIntro = `关于你的财务状况，${cardName}（${cardTypeDesc}）预示了：`;
  } else {
    personalizedIntro = `关于你的问题"${question}"，${cardName}（${cardTypeDesc}）为你带来了这样的启示：`;
  }

  const contextualAdvice = getContextualAdvice(question, card);

  return `${personalizedIntro}\n\n${cardDesc}\n\n${contextualAdvice}`;
}

/**
 * 生成三张牌个性化解读
 */
function generateThreeCardInterpretation(question: string, cards: DrawnCard[]): string {
  const pastCard = cards.find(c => c.position === 'past')?.card;
  const presentCard = cards.find(c => c.position === 'present')?.card;
  const futureCard = cards.find(c => c.position === 'future')?.card;

  if (!pastCard || !presentCard || !futureCard) {
    return '解读生成错误';
  }

  const questionLower = question.toLowerCase();
  let contextIntro = '';

  if (questionLower.includes('爱情') || questionLower.includes('感情')) {
    contextIntro = '关于你的感情问题，三张牌为你揭示了感情的发展轨迹：';
  } else if (questionLower.includes('工作') || questionLower.includes('事业')) {
    contextIntro = '关于你的事业发展，三张牌展现了事业的演变过程：';
  } else if (questionLower.includes('学业') || questionLower.includes('学习')) {
    contextIntro = '关于你的学业问题，三张牌描绘了学习的历程：';
  } else {
    contextIntro = `关于你的问题"${question}"，三张牌为你展现了时间线上的指引：`;
  }

  let interpretation = `${contextIntro}\n\n`;

  // 过去
  const pastTypeDesc = getCardTypeDescription(pastCard);
  interpretation += `【过去 - ${pastCard.name}（${pastTypeDesc}）】\n`;
  interpretation += `${pastCard.fullDescription}\n`;
  const pastAdvice = getContextualAdvice(question, pastCard);
  interpretation += `这张牌反映了你过去的经历和基础。${pastAdvice}\n\n`;

  // 现在
  const presentTypeDesc = getCardTypeDescription(presentCard);
  interpretation += `【现在 - ${presentCard.name}（${presentTypeDesc}）】\n`;
  interpretation += `${presentCard.fullDescription}\n`;
  const presentAdvice = getContextualAdvice(question, presentCard);
  interpretation += `这是你当前所处的状态。${presentAdvice}\n\n`;

  // 未来
  const futureTypeDesc = getCardTypeDescription(futureCard);
  interpretation += `【未来 - ${futureCard.name}（${futureTypeDesc}）】\n`;
  interpretation += `${futureCard.fullDescription}\n`;
  const futureAdvice = getContextualAdvice(question, futureCard);
  interpretation += `这张牌预示了未来的可能走向。${futureAdvice}记住，未来并非完全确定，你的选择和行动会影响最终的结果。\n\n`;

  // 综合解读 - 分析牌阵的能量流动
  interpretation += `【综合解读】\n`;
  
  // 分析牌阵中的元素分布
  const cardTypes = [pastCard, presentCard, futureCard].map(c => c.type);
  const majorCount = cardTypes.filter(t => t === CardType.MAJOR).length;
  const minorCount = 3 - majorCount;
  
  if (majorCount >= 2) {
    interpretation += `这三张牌中有${majorCount}张大阿卡纳牌，表明这是一个涉及深层人生课题的重要时期。`;
  } else if (minorCount === 3) {
    interpretation += `这三张牌都是小阿卡纳牌，表明问题更多涉及日常生活的实际层面。`;
  }
  
  // 分析花色分布（如果都是小阿卡纳）
  if (minorCount === 3) {
    const suits = [pastCard, presentCard, futureCard].map(c => c.suit).filter(s => s !== undefined);
    const uniqueSuits = new Set(suits);
    if (uniqueSuits.size === 1) {
      const suit = suits[0];
      if (suit === Suit.WANDS) {
        interpretation += `三张牌都是权杖牌，强调行动、创造力和热情的重要性。`;
      } else if (suit === Suit.CUPS) {
        interpretation += `三张牌都是圣杯牌，强调情感、直觉和关系的重要性。`;
      } else if (suit === Suit.SWORDS) {
        interpretation += `三张牌都是宝剑牌，强调思维、沟通和清晰的重要性。`;
      } else if (suit === Suit.PENTACLES) {
        interpretation += `三张牌都是星币牌，强调实际、稳定和物质的重要性。`;
      }
    }
  }
  
  interpretation += `从过去到未来，这三张牌形成了一个完整的故事。过去的影响仍在，现在的选择很重要，未来的方向已经显现。`;
  interpretation += `关于"${question}"，塔罗牌建议你：回顾过去，把握现在，为未来做好准备。相信自己的判断，勇敢地向前迈进。`;

  return interpretation;
}

/**
 * 生成七张牌个性化解读
 */
function generateSevenCardInterpretation(question: string, cards: DrawnCard[]): string {
  const situationCard = cards.find(c => c.position === 'situation')?.card;
  const challengeCard = cards.find(c => c.position === 'challenge')?.card;
  const pastCard = cards.find(c => c.position === 'past')?.card;
  const futureCard = cards.find(c => c.position === 'future')?.card;
  const goalCard = cards.find(c => c.position === 'goal')?.card;
  const approachCard = cards.find(c => c.position === 'approach')?.card;
  const outcomeCard = cards.find(c => c.position === 'outcome')?.card;

  if (!situationCard || !challengeCard || !pastCard || !futureCard || !goalCard || !approachCard || !outcomeCard) {
    return '解读生成错误';
  }

  const questionLower = question.toLowerCase();
  let contextIntro = '';

  if (questionLower.includes('爱情') || questionLower.includes('感情')) {
    contextIntro = '关于你的感情问题，七张牌为你提供了全面的指引：';
  } else if (questionLower.includes('工作') || questionLower.includes('事业')) {
    contextIntro = '关于你的事业发展，七张牌为你揭示了完整的图景：';
  } else {
    contextIntro = `关于你的问题"${question}"，七张牌为你展开了详细的占卜：`;
  }

  let interpretation = `${contextIntro}\n\n`;

  // 现状
  const situationTypeDesc = getCardTypeDescription(situationCard);
  interpretation += `【现状 - ${situationCard.name}（${situationTypeDesc}）】\n`;
  interpretation += `${situationCard.fullDescription}\n`;
  const situationAdvice = getContextualAdvice(question, situationCard);
  interpretation += `这是你当前面临的情况。${situationAdvice}\n\n`;

  // 挑战
  const challengeTypeDesc = getCardTypeDescription(challengeCard);
  interpretation += `【挑战 - ${challengeCard.name}（${challengeTypeDesc}）】\n`;
  interpretation += `${challengeCard.fullDescription}\n`;
  const challengeAdvice = getContextualAdvice(question, challengeCard);
  interpretation += `这是你需要面对的障碍或困难。${challengeAdvice}\n\n`;

  // 过去
  const pastTypeDesc = getCardTypeDescription(pastCard);
  interpretation += `【过去 - ${pastCard.name}（${pastTypeDesc}）】\n`;
  interpretation += `${pastCard.fullDescription}\n`;
  const pastAdvice = getContextualAdvice(question, pastCard);
  interpretation += `过去的影响仍在发挥作用。${pastAdvice}\n\n`;

  // 未来
  const futureTypeDesc = getCardTypeDescription(futureCard);
  interpretation += `【未来 - ${futureCard.name}（${futureTypeDesc}）】\n`;
  interpretation += `${futureCard.fullDescription}\n`;
  const futureAdvice = getContextualAdvice(question, futureCard);
  interpretation += `这是未来可能的发展方向。${futureAdvice}\n\n`;

  // 目标
  const goalTypeDesc = getCardTypeDescription(goalCard);
  interpretation += `【目标 - ${goalCard.name}（${goalTypeDesc}）】\n`;
  interpretation += `${goalCard.fullDescription}\n`;
  const goalAdvice = getContextualAdvice(question, goalCard);
  interpretation += `这是你应该追求的目标或理想状态。${goalAdvice}\n\n`;

  // 方法
  const approachTypeDesc = getCardTypeDescription(approachCard);
  interpretation += `【方法 - ${approachCard.name}（${approachTypeDesc}）】\n`;
  interpretation += `${approachCard.fullDescription}\n`;
  const approachAdvice = getContextualAdvice(question, approachCard);
  interpretation += `这是你应采取的方法或态度。${approachAdvice}\n\n`;

  // 结果
  const outcomeTypeDesc = getCardTypeDescription(outcomeCard);
  interpretation += `【结果 - ${outcomeCard.name}（${outcomeTypeDesc}）】\n`;
  interpretation += `${outcomeCard.fullDescription}\n`;
  const outcomeAdvice = getContextualAdvice(question, outcomeCard);
  interpretation += `这是最终可能的结果。${outcomeAdvice}记住，结果会受到你行动的影响。\n\n`;

  // 综合解读 - 分析牌阵的能量分布
  interpretation += `【综合解读】\n`;
  
  // 分析大阿卡纳和小阿卡纳的分布
  const allCards = [situationCard, challengeCard, pastCard, futureCard, goalCard, approachCard, outcomeCard];
  const majorCards = allCards.filter(c => c.type === CardType.MAJOR);
  const minorCards = allCards.filter(c => c.type === CardType.MINOR);
  
  if (majorCards.length >= 4) {
    interpretation += `这七张牌中有${majorCards.length}张大阿卡纳牌，表明这是一个涉及深层人生课题和重要转折的时期。`;
  } else if (minorCards.length >= 5) {
    interpretation += `这七张牌中有${minorCards.length}张小阿卡纳牌，表明问题更多涉及日常生活的实际层面和具体行动。`;
  }
  
  // 分析小阿卡纳的花色分布
  if (minorCards.length > 0) {
    const suits = minorCards.map(c => c.suit).filter(s => s !== undefined) as Suit[];
    const suitCounts: Record<string, number> = {};
    suits.forEach(suit => {
      if (suit) {
        suitCounts[suit] = (suitCounts[suit] || 0) + 1;
      }
    });
    
    const suitKeys = Object.keys(suitCounts);
    if (suitKeys.length > 0) {
      const maxSuit = suitKeys.reduce((a, b) => suitCounts[a] > suitCounts[b] ? a : b);
      const maxCount = suitCounts[maxSuit];
      
      if (maxCount >= 3) {
        if (maxSuit === Suit.WANDS) {
          interpretation += `牌阵中权杖牌较多，强调行动、创造力和热情在解决这个问题中的重要性。`;
        } else if (maxSuit === Suit.CUPS) {
          interpretation += `牌阵中圣杯牌较多，强调情感、直觉和关系在解决这个问题中的重要性。`;
        } else if (maxSuit === Suit.SWORDS) {
          interpretation += `牌阵中宝剑牌较多，强调思维、沟通和清晰在解决这个问题中的重要性。`;
        } else if (maxSuit === Suit.PENTACLES) {
          interpretation += `牌阵中星币牌较多，强调实际、稳定和物质在解决这个问题中的重要性。`;
        }
      }
    }
  }
  
  interpretation += `关于"${question}"，这七张牌为你描绘了一幅完整的画面。`;
  interpretation += `现状揭示了起点，挑战提醒你注意障碍，过去提供了背景，未来指明了方向。`;
  interpretation += `目标是你应该追求的，方法是你的行动指南，结果则是可能达成的状态。`;
  interpretation += `综合这些信息，塔罗牌建议你：认清现状，直面挑战，从过去中学习，为未来做准备，明确目标，采取正确的方法，最终达成理想的结果。`;

  return interpretation;
}

