/**
 * 塔罗牌数据模型
 * 定义塔罗牌的数据结构
 */
export interface TarotCard {
  id: number;           // 卡牌ID
  name: string;         // 卡牌名称
  image: Resource;      // 卡牌图片资源
  description: string;  // 卡牌含义简述
  fullDescription: string; // 卡牌详细描述
}

/**
 * 塔罗牌数据常量
 * 包含22张大阿卡纳牌的基本信息
 */
export const TAROT_CARDS: TarotCard[] = [
  {
    id: 0,
    name: "愚者",
    image: $r('app.media.card_00'),
    description: "新的开始，冒险精神，纯真与自由",
    fullDescription: "愚者代表着新的开始，拥有自由的精神和冒险的勇气。这张牌提醒你要保持开放的心态，勇敢地踏上新的旅程。"
  },
  {
    id: 1,
    name: "魔术师",
    image: $r('app.media.card_01'),
    description: "创造力，行动力，意志力，专注",
    fullDescription: "魔术师象征着创造力与行动力。你拥有将想法转化为现实的能力，关键在于专注和意志力。现在是开始行动的好时机。"
  },
  {
    id: 2,
    name: "女祭司",
    image: $r('app.media.card_02'),
    description: "直觉，内在智慧，潜意识，神秘",
    fullDescription: "女祭司代表着内在的智慧和直觉。倾听你内心的声音，相信你的直觉。答案可能隐藏在潜意识中，需要静心去感受。"
  },
  {
    id: 3,
    name: "皇后",
    image: $r('app.media.card_03'),
    description: "丰盛，母性，创造力，自然",
    fullDescription: "皇后象征着丰盛与创造力。这是一个充满爱与关怀的时期，你的努力将得到回报。享受生活的美好，感受自然的馈赠。"
  },
  {
    id: 4,
    name: "皇帝",
    image: $r('app.media.card_04'),
    description: "权威，秩序，稳定，领导力",
    fullDescription: "皇帝代表着权威与秩序。你需要建立稳定的基础，展现领导力。通过自律和规划，你能够实现目标并保持控制。"
  },
  {
    id: 5,
    name: "教皇",
    image: $r('app.media.card_05'),
    description: "传统，精神指导，学习，信仰",
    fullDescription: "教皇象征着传统与精神指导。寻求导师的帮助，学习传统的智慧。保持对信仰和价值观的坚持，它们会指引你前进。"
  },
  {
    id: 6,
    name: "恋人",
    image: $r('app.media.card_06'),
    description: "爱情，选择，和谐，结合",
    fullDescription: "恋人代表着爱情与选择。这可能意味着重要的决定，需要平衡理性与感性。在关系中寻求和谐，做出符合内心的选择。"
  },
  {
    id: 7,
    name: "战车",
    image: $r('app.media.card_07'),
    description: "胜利，意志力，控制，前进",
    fullDescription: "战车象征着胜利与前进。通过坚定的意志力和自我控制，你能够克服障碍，朝着目标前进。保持平衡，不要被情绪左右。"
  },
  {
    id: 8,
    name: "力量",
    image: $r('app.media.card_08'),
    description: "内在力量，耐心，温柔，勇气",
    fullDescription: "力量代表着内在的勇气与耐心。真正的力量来自内心的平静和温柔。用耐心和智慧面对挑战，而不是用蛮力。"
  },
  {
    id: 9,
    name: "隐者",
    image: $r('app.media.card_09'),
    description: "内省，寻求真理，孤独，指引",
    fullDescription: "隐者象征着内省与寻求真理。现在是独处和反思的时候，通过内省找到内心的指引。答案在你内心深处，需要静心去寻找。"
  },
  {
    id: 10,
    name: "命运之轮",
    image: $r('app.media.card_10'),
    description: "变化，命运，周期，转折",
    fullDescription: "命运之轮代表着变化与转折。生活是不断变化的，接受这些变化，它们会带来新的机遇。保持开放的心态，顺应自然的节奏。"
  },
  {
    id: 11,
    name: "正义",
    image: $r('app.media.card_11'),
    description: "平衡，公正，责任，因果",
    fullDescription: "正义象征着平衡与公正。你的行为会产生相应的结果，保持诚实和公正。做出负责任的决定，寻求内心的平衡。"
  },
  {
    id: 12,
    name: "倒吊人",
    image: $r('app.media.card_12'),
    description: "牺牲，等待，新视角，放下",
    fullDescription: "倒吊人代表着牺牲与等待。有时候需要放下执念，换个角度看问题。通过等待和反思，你会获得新的理解和智慧。"
  },
  {
    id: 13,
    name: "死神",
    image: $r('app.media.card_13'),
    description: "结束，转变，重生，放下",
    fullDescription: "死神象征着结束与转变。旧的必须结束，才能让新的开始。放下过去，接受变化，这会带来重生和新的可能性。"
  },
  {
    id: 14,
    name: "节制",
    image: $r('app.media.card_14'),
    description: "平衡，调和，耐心，融合",
    fullDescription: "节制代表着平衡与调和。在生活的各个方面寻求平衡，融合不同的元素。保持耐心，通过调和达到和谐的状态。"
  },
  {
    id: 15,
    name: "恶魔",
    image: $r('app.media.card_15'),
    description: "束缚，欲望，物质主义，觉醒",
    fullDescription: "恶魔象征着束缚与欲望。你可能被物质或欲望所束缚，需要觉醒并打破这些限制。认识到真正的自由来自内心的解放。"
  },
  {
    id: 16,
    name: "塔",
    image: $r('app.media.card_16'),
    description: "突然变化，启示，解放，重建",
    fullDescription: "塔代表着突然的变化与启示。旧的结构可能突然崩塌，但这会带来解放和新的开始。接受这些变化，重建更坚实的基础。"
  },
  {
    id: 17,
    name: "星星",
    image: $r('app.media.card_17'),
    description: "希望，灵感，指引，平静",
    fullDescription: "星星象征着希望与灵感。即使在困难时期，也要保持希望。相信未来，跟随内心的指引，平静地前行。"
  },
  {
    id: 18,
    name: "月亮",
    image: $r('app.media.card_18'),
    description: "幻觉，恐惧，潜意识，直觉",
    fullDescription: "月亮代表着幻觉与恐惧。你可能被恐惧或幻觉所困扰，需要面对内心的阴影。相信你的直觉，但也要保持理性。"
  },
  {
    id: 19,
    name: "太阳",
    image: $r('app.media.card_19'),
    description: "快乐，成功，活力，光明",
    fullDescription: "太阳象征着快乐与成功。这是一个充满活力和光明的时期，你的努力会得到回报。享受生活的美好，保持积极的心态。"
  },
  {
    id: 20,
    name: "审判",
    image: $r('app.media.card_20'),
    description: "觉醒，重生，反思，宽恕",
    fullDescription: "审判代表着觉醒与重生。现在是反思过去、宽恕自己和他人的时候。通过觉醒，你会获得新的理解和重生。"
  },
  {
    id: 21,
    name: "世界",
    image: $r('app.media.card_21'),
    description: "完成，成就，圆满，新开始",
    fullDescription: "世界象征着完成与成就。一个周期即将结束，你取得了圆满的成就。这是庆祝的时刻，也是新开始的准备。"
  }
];

/**
 * 随机抽取一张塔罗牌
 * @returns 随机选中的塔罗牌
 */
export function drawRandomCard(): TarotCard {
  const randomIndex = Math.floor(Math.random() * TAROT_CARDS.length);
  return TAROT_CARDS[randomIndex];
}

