export class BaZiUtils {
  private static readonly HEAVENLY_STEMS = ['甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸'];
  private static readonly EARTHLY_BRANCHES = ['子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'];
  private static readonly ZODIAC = ['鼠', '牛', '虎', '兔', '龙', '蛇', '马', '羊', '猴', '鸡', '狗', '猪'];

  // 1900-01-31 is a Lunar New Year, but for BaZi we often use Lichun (Start of Spring).
  // For simplicity in this demo, we will use a reference date for Day Pillar.
  // 1900-01-01 was a Jia-Xu (11) day? No, let's pick a known recent date.
  // 2024-01-01 was Jia-Zi (0) day? No.
  // Let's use a standard algorithm.
  // 1949-10-01: Jia-Zi year (no), Ji-Chou year.

  // Reference: 2000-01-01 was Wu-Wu (5-7) day.
  // Time: 12:00 PM.
  // JD for 2000-01-01 12:00 is 2451545.0

  static getHeavenlyStem(index: number): string {
    return this.HEAVENLY_STEMS[index % 10];
  }

  static getEarthlyBranch(index: number): string {
    return this.EARTHLY_BRANCHES[index % 12];
  }

  static getZodiac(year: number): string {
    return this.ZODIAC[(year - 4) % 12];
  }

  // Calculate Year Pillar (approximate, using Lichun as Feb 4th)
  static getYearPillar(date: Date): string {
    let year = date.getFullYear();
    const month = date.getMonth() + 1;
    const day = date.getDate();

    // If before Feb 4, count as previous year for BaZi
    if (month < 2 || (month === 2 && day < 4)) {
      year--;
    }

    // 1984 is Jia-Zi (0, 0)
    const offset = year - 1984;
    let stemIndex = (0 + offset) % 10;
    let branchIndex = (0 + offset) % 12;

    if (stemIndex < 0) {
      stemIndex += 10;
    }
    if (branchIndex < 0) {
      branchIndex += 12;
    }

    return this.HEAVENLY_STEMS[stemIndex] + this.EARTHLY_BRANCHES[branchIndex];
  }

  // Calculate Month Pillar
  static getMonthPillar(date: Date, yearPillar: string): string {
    // This is a simplified version. Accurate version requires Solar Terms.
    // We will assume the solar month starts around the 4th-8th.
    // Month branches are fixed: Feb (Tiger/Yin), Mar (Rabbit/Mao), etc.
    // Feb -> Yin (2), Mar -> Mao (3)... Jan -> Chou (1)

    let yearStemIndex = this.HEAVENLY_STEMS.indexOf(yearPillar.charAt(0));
    if (yearStemIndex === -1) {
      yearStemIndex = 0; // Default to first stem if not found
    }

    let month = date.getMonth() + 1; // 1-12
    const day = date.getDate();

    // Adjust for solar term (simplified: 4th of month)
    // If day < 4, it belongs to previous solar month
    let solarMonth = month;
    if (day < 4) {
      solarMonth--;
      if (solarMonth === 0) {
        solarMonth = 12;
      }
    }

    // Branch index: Feb (2) is Yin (2). Jan (1) is Chou (1).
    // Standard:
    // Feb (Lichun) -> Yin (2)
    // Mar (Jingzhe) -> Mao (3)
    // ...
    // Jan (Xiaohan) -> Chou (1)

    // Mapping solar month to branch index (0-11)
    // Solar Month 1 (Jan) -> Chou (1)
    // Solar Month 2 (Feb) -> Yin (2)
    // ...
    // Solar Month 11 (Nov) -> Zi (0)
    // Solar Month 12 (Dec) -> Chou (1) -- Wait, Zi is 11th month usually?
    // Let's stick to standard index:
    // Yin(2) is the first month of Spring.

    // Branch for Solar Month M:
    // M=2 (Feb) -> 2 (Yin)
    // M=1 (Jan) -> 1 (Chou)
    // M=12 (Dec) -> 0 (Zi) ? No, Zi is 11th month (Winter Solstice).
    // Let's use standard table:
    // Month 1 (Feb 4 - Mar 5): Yin (2)
    // Month 2 (Mar 6 - Apr 4): Mao (3)
    // ...
    // Month 11 (Dec 7 - Jan 5): Zi (0)
    // Month 12 (Jan 6 - Feb 3): Chou (1)

    let branchIndex = -1;
    if (solarMonth === 2) {
      branchIndex = 2;
    } else if (solarMonth === 3) {
      branchIndex = 3;
    } else if (solarMonth ===
      4) {
      branchIndex = 4;
    } else if (solarMonth === 5) {
      branchIndex = 5;
    } else if (solarMonth === 6) {
      branchIndex =
        6;
    } else if (solarMonth === 7) {
      branchIndex = 7;
    } else if (solarMonth === 8) {
      branchIndex = 8;
    } else if (solarMonth ===
      9) {
      branchIndex = 9;
    } else if (solarMonth === 10) {
      branchIndex = 10;
    } else if (solarMonth === 11) {
      branchIndex =
        11;
    } else if (solarMonth === 12) {
      branchIndex = 0;
    } // Zi
    else if (solarMonth === 1) {
      branchIndex = 1;
    } // Chou

    // Calculate Stem based on Year Stem
    // Year Stem -> Month 1 Stem
    // Jia/Ji (0/5) -> Bing (2)
    // Yi/Geng (1/6) -> Wu (4)
    // Bing/Xin (2/7) -> Geng (6)
    // Ding/Ren (3/8) -> Ren (8)
    // Wu/Gui (4/9) -> Jia (0)

    const yearStemMod = yearStemIndex % 5;
    let startStem = (yearStemMod * 2 + 2) % 10; // Formula for first month (Yin)

    // Offset from Yin month
    // Yin is index 2.
    // If branchIndex is 2, offset is 0.
    // If branchIndex is 3, offset is 1.
    // If branchIndex is 0 (Zi), offset is 10.
    // If branchIndex is 1 (Chou), offset is 11.

    let monthOffset = branchIndex - 2;
    if (monthOffset < 0) {
      monthOffset += 12;
    }

    let stemIndex = (startStem + monthOffset) % 10;

    return this.HEAVENLY_STEMS[stemIndex] + this.EARTHLY_BRANCHES[branchIndex];
  }

  // Calculate Day Pillar
  static getDayPillar(date: Date): string {
    // Reference: 2000-01-01 was Wu-Wu (Stem 4, Branch 6)
    const refDate = new Date(2000, 0, 1); // Jan 1, 2000
    const refStem = 4;
    const refBranch = 6;

    const diffTime = date.getTime() - refDate.getTime();
    const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));

    let stemIndex = (refStem + diffDays) % 10;
    let branchIndex = (refBranch + diffDays) % 12;

    if (stemIndex < 0) {
      stemIndex += 10;
    }
    if (branchIndex < 0) {
      branchIndex += 12;
    }

    return this.HEAVENLY_STEMS[stemIndex] + this.EARTHLY_BRANCHES[branchIndex];
  }

  // Calculate Hour Pillar
  static getHourPillar(date: Date, dayPillar: string): string {
    const hour = date.getHours();

    // Branch is determined by hour
    // 23-1: Zi (0)
    // 1-3: Chou (1)
    // ...
    let branchIndex = Math.floor((hour + 1) / 2) % 12;

    // Stem is determined by Day Stem
    // Day Stem -> Hour Zi Stem
    // Jia/Ji (0/5) -> Jia (0)
    // Yi/Geng (1/6) -> Bing (2)
    // Bing/Xin (2/7) -> Wu (4)
    // Ding/Ren (3/8) -> Geng (6)
    // Wu/Gui (4/9) -> Ren (8)

    let dayStemIndex = this.HEAVENLY_STEMS.indexOf(dayPillar.charAt(0));
    const dayStemMod = dayStemIndex % 5;
    let startStem = (dayStemMod * 2) % 10;

    let stemIndex = (startStem + branchIndex) % 10;

    return this.HEAVENLY_STEMS[stemIndex] + this.EARTHLY_BRANCHES[branchIndex];
  }

  private static readonly FIVE_ELEMENTS = {
    '甲': '木', '乙': '木',
    '丙': '火', '丁': '火',
    '戊': '土', '己': '土',
    '庚': '金', '辛': '金',
    '壬': '水', '癸': '水',
    '子': '水', '丑': '土',
    '寅': '木', '卯': '木',
    '辰': '土', '巳': '火',
    '午': '火', '未': '土',
    '申': '金', '酉': '金',
    '戌': '土', '亥': '水'
  };

  private static readonly DAY_MASTER_DESC = {
    '甲': '甲木日元：正直仁慈，进取心强，如大树般稳重。',
    '乙': '乙木日元：温柔含蓄，适应力强，如花草般柔韧。',
    '丙': '丙火日元：热情豪爽，积极乐观，如太阳般温暖。',
    '丁': '丁火日元：细腻温和，富有同情心，如烛火般照亮他人。',
    '戊': '戊土日元：诚实厚重，沉稳踏实，如高山般可靠。',
    '己': '己土日元：包容涵养，多才多艺，如田园般滋养万物。',
    '庚': '庚金日元：刚毅果断，讲义气，如刀剑般锋利。',
    '辛': '辛金日元：温润秀气，重感情，如珠宝般珍贵。',
    '壬': '壬水日元：聪明机智，宽宏大度，如江河般奔流不息。',
    '癸': '癸水日元：平静柔和，内敛深沉，如雨露般润泽万物。'
  };

  static getElement(char: string): string {
    return (this.FIVE_ELEMENTS as Record<string, string>)[char] || '';
  }

  static getFiveElementsStructure(pillars: string[]): Map<string, number> {
    const counts = new Map<string, number>();
    counts.set('金', 0);
    counts.set('木', 0);
    counts.set('水', 0);
    counts.set('火', 0);
    counts.set('土', 0);

    pillars.forEach(pillar => {
      const stem = pillar.charAt(0);
      const branch = pillar.charAt(1);

      const stemElement = this.getElement(stem);
      const branchElement = this.getElement(branch);

      if (stemElement) counts.set(stemElement, (counts.get(stemElement) || 0) + 1);
      if (branchElement) counts.set(branchElement, (counts.get(branchElement) || 0) + 1);
    });

    return counts;
  }

  static getDayMasterAnalysis(dayPillar: string): string {
    const dayStem = dayPillar.charAt(0);
    return (this.DAY_MASTER_DESC as Record<string, string>)[dayStem] || '未知日元';
  }

  static getWesternZodiac(date: Date): string {
    const month = date.getMonth() + 1;
    const day = date.getDate();

    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return "水瓶座";
    if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) return "双鱼座";
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return "白羊座";
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return "金牛座";
    if ((month == 5 && day >= 21) || (month == 6 && day <= 21)) return "双子座";
    if ((month == 6 && day >= 22) || (month == 7 && day <= 22)) return "巨蟹座";
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return "狮子座";
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return "处女座";
    if ((month == 9 && day >= 23) || (month == 10 && day <= 23)) return "天秤座";
    if ((month == 10 && day >= 24) || (month == 11 && day <= 22)) return "天蝎座";
    if ((month == 11 && day >= 23) || (month == 12 && day <= 21)) return "射手座";
    return "摩羯座";
  }

  static getLuckyInfo(date: Date): { color: string, number: number } {
    // Simple deterministic hash based on date
    const hash = date.getDate() + date.getMonth() + date.getFullYear();

    const colors = ['红色', '橙色', '黄色', '绿色', '青色', '蓝色', '紫色', '粉色', '白色', '金色'];
    const color = colors[hash % colors.length];
    const number = (hash % 9) + 1; // 1-9

    return { color, number };
  }

  static analyze(date: Date): BaZiResult {
    const yearPillar = this.getYearPillar(date);
    const monthPillar = this.getMonthPillar(date, yearPillar);
    const dayPillar = this.getDayPillar(date);
    const hourPillar = this.getHourPillar(date, dayPillar);

    const pillars = [yearPillar, monthPillar, dayPillar, hourPillar];
    const elementCounts = this.getFiveElementsStructure(pillars);
    const dayMasterAnalysis = this.getDayMasterAnalysis(dayPillar);

    const zodiac = this.getWesternZodiac(date);
    const luckyInfo = this.getLuckyInfo(date);

    return {
      pillars,
      elementCounts,
      dayMasterAnalysis,
      zodiac,
      luckyColor: luckyInfo.color,
      luckyNumber: luckyInfo.number
    };
  }
}

export interface BaZiResult {
  pillars: string[];
  elementCounts: Map<string, number>;
  dayMasterAnalysis: string;
  zodiac: string;
  luckyColor: string;
  luckyNumber: number;
}
