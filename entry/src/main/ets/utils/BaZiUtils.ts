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

  static analyze(date: Date): string[] {
    const yearPillar = this.getYearPillar(date);
    const monthPillar = this.getMonthPillar(date, yearPillar);
    const dayPillar = this.getDayPillar(date);
    const hourPillar = this.getHourPillar(date, dayPillar);

    return [yearPillar, monthPillar, dayPillar, hourPillar];
  }
}
