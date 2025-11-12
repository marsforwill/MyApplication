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
 * 生成单张牌个性化解读
 */
function generateSingleCardInterpretation(question: string, card: TarotCard): string {
  const cardName = card.name;
  const cardDesc = card.fullDescription;

  // 根据问题关键词生成个性化解读
  const questionLower = question.toLowerCase();
  let personalizedIntro = '';

  if (questionLower.includes('爱情') || questionLower.includes('感情') || questionLower.includes('恋爱')) {
    personalizedIntro = `关于你的感情问题，${cardName}为你带来了这样的指引：`;
  } else if (questionLower.includes('工作') || questionLower.includes('事业') || questionLower.includes('职业')) {
    personalizedIntro = `关于你的事业发展，${cardName}揭示了这样的信息：`;
  } else if (questionLower.includes('学业') || questionLower.includes('学习') || questionLower.includes('考试')) {
    personalizedIntro = `关于你的学业问题，${cardName}给出了这样的建议：`;
  } else if (questionLower.includes('健康') || questionLower.includes('身体')) {
    personalizedIntro = `关于你的健康状况，${cardName}提醒你：`;
  } else if (questionLower.includes('财运') || questionLower.includes('金钱') || questionLower.includes('财务')) {
    personalizedIntro = `关于你的财务状况，${cardName}预示了：`;
  } else {
    personalizedIntro = `关于你的问题"${question}"，${cardName}为你带来了这样的启示：`;
  }

  return `${personalizedIntro}\n\n${cardDesc}\n\n结合你提出的问题，这张牌提醒你要关注内心的声音，相信自己的直觉。答案往往就在你心中，只是需要静下心来去感受。`;
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
  interpretation += `【过去 - ${pastCard.name}】\n`;
  interpretation += `${pastCard.fullDescription}\n`;
  interpretation += `这张牌反映了你过去的经历和基础，它为你现在的情况奠定了基础。\n\n`;

  // 现在
  interpretation += `【现在 - ${presentCard.name}】\n`;
  interpretation += `${presentCard.fullDescription}\n`;
  interpretation += `这是你当前所处的状态，需要你特别关注和把握。结合你的问题，这张牌提醒你要专注于当下。\n\n`;

  // 未来
  interpretation += `【未来 - ${futureCard.name}】\n`;
  interpretation += `${futureCard.fullDescription}\n`;
  interpretation += `这张牌预示了未来的可能走向。记住，未来并非完全确定，你的选择和行动会影响最终的结果。\n\n`;

  // 综合解读
  interpretation += `【综合解读】\n`;
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
  interpretation += `【现状 - ${situationCard.name}】\n`;
  interpretation += `${situationCard.fullDescription}\n`;
  interpretation += `这是你当前面临的情况，是理解整个问题的起点。\n\n`;

  // 挑战
  interpretation += `【挑战 - ${challengeCard.name}】\n`;
  interpretation += `${challengeCard.fullDescription}\n`;
  interpretation += `这是你需要面对的障碍或困难，了解它有助于你更好地应对。\n\n`;

  // 过去
  interpretation += `【过去 - ${pastCard.name}】\n`;
  interpretation += `${pastCard.fullDescription}\n`;
  interpretation += `过去的影响仍在发挥作用，理解过去有助于理解现在。\n\n`;

  // 未来
  interpretation += `【未来 - ${futureCard.name}】\n`;
  interpretation += `${futureCard.fullDescription}\n`;
  interpretation += `这是未来可能的发展方向，为你提供了前瞻性的指引。\n\n`;

  // 目标
  interpretation += `【目标 - ${goalCard.name}】\n`;
  interpretation += `${goalCard.fullDescription}\n`;
  interpretation += `这是你应该追求的目标或理想状态，为你指明了方向。\n\n`;

  // 方法
  interpretation += `【方法 - ${approachCard.name}】\n`;
  interpretation += `${approachCard.fullDescription}\n`;
  interpretation += `这是你应采取的方法或态度，帮助你达成目标。\n\n`;

  // 结果
  interpretation += `【结果 - ${outcomeCard.name}】\n`;
  interpretation += `${outcomeCard.fullDescription}\n`;
  interpretation += `这是最终可能的结果，记住结果会受到你行动的影响。\n\n`;

  // 综合解读
  interpretation += `【综合解读】\n`;
  interpretation += `关于"${question}"，这七张牌为你描绘了一幅完整的画面。`;
  interpretation += `现状揭示了起点，挑战提醒你注意障碍，过去提供了背景，未来指明了方向。`;
  interpretation += `目标是你应该追求的，方法是你的行动指南，结果则是可能达成的状态。`;
  interpretation += `综合这些信息，塔罗牌建议你：认清现状，直面挑战，从过去中学习，为未来做准备，明确目标，采取正确的方法，最终达成理想的结果。`;

  return interpretation;
}

