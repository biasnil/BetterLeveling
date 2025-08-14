public class BTLLoc extends IScriptable {

  public static func L_orS(skey: String, fallback: String) -> String {
    let sr: script_ref<String> = skey;
    let s: String = GetLocalizedText(sr);
    if StrLen(s) == 0 || Equals(s, skey) { return fallback; }
    return s;
  }

  public static func DetectLocaleTag() -> CName {
    let enName: String = GetLocalizedTextByKey(n"UI-Settings-Language-English");
    if Equals(enName, "English")       { return n"en-us"; }
    if Equals(enName, "Английский")    { return n"ru-ru"; }
    if Equals(enName, "Anglais")       { return n"fr-fr"; }
    if Equals(enName, "Englisch")      { return n"de-de"; }
    if Equals(enName, "英语") || Equals(enName, "英文")
                                      { return n"zh-cn"; }
    if Equals(enName, "Inglés")        { return n"es-es"; }
    if Equals(enName, "英語")           { return n"ja-jp"; }
    if Equals(enName, "영어")           { return n"ko-kr"; }
    return n"en-us";
  }

  private static func FB_Before(loc: CName) -> String {
    return "+";
  }

  private static func FB_After(loc: CName) -> String {
    let l: String = NameToString(loc);
    if Equals(l, "ru-ru") { return "% скидки у всех торговцев. "; }
    if Equals(l, "fr-fr") { return "% de remise chez tous les vendeurs. "; }
    if Equals(l, "zh-cn") { return "% 折扣，适用于所有商贩。 "; }
    if Equals(l, "de-de") { return "% Rabatt bei allen Händlern. "; }
    return "% discount at all vendors. ";
  }

  private static func FB_Line(idx: Int32, loc: CName) -> String {
    let l: String = NameToString(loc);

    if Equals(l, "ru-ru") {
      switch idx {
        case 0: return "Неплохо, когда к тебе относятся как к Джонни Сильверхэнду, да, Ви?";
        case 1: return "Уровень славы Дэвида";
        case 2: return "Жаль, что Джеки не видит нас сейчас";
        case 3: return "Они восхищаются тобой или боятся?";
        case 4: return "Уровень славы Адама Смешера";
        case 5: return "Сколько времени нужно, чтобы стать настолько знаменитым?";
      }
    }

    if Equals(l, "fr-fr") {
      switch idx {
        case 0: return "Ça doit être sympa d’avoir droit au traitement « Johnny Silverhand », hein, V ?";
        case 1: return "Le niveau de notoriété de David";
        case 2: return "Si seulement Jackie pouvait nous voir maintenant";
        case 3: return "Ils t’admirent ou ils te craignent ?";
        case 4: return "Le niveau de notoriété d’Adam Smasher";
        case 5: return "Combien de temps faut-il pour être aussi célèbre ?";
      }
    }

    if Equals(l, "zh-cn") {
      switch idx {
        case 0: return "享受“强尼·银手”待遇的感觉不错吧，V？";
        case 1: return "大卫级别的名气";
        case 2: return "要是杰克现在能看到我们就好了";
        case 3: return "他们是崇拜你，还是害怕你？";
        case 4: return "亚当·重锤级别的名气";
        case 5: return "得花多少时间才能这么有名？";
      }
    }

    if Equals(l, "de-de") {
      switch idx {
        case 0: return "Muss sich gut anfühlen, die Johnny-Silverhand-Behandlung zu bekommen, was, V?";
        case 1: return "Davids Bekanntheitsgrad";
        case 2: return "Wenn Jackie uns jetzt sehen könnte";
        case 3: return "Bewundern sie dich oder fürchten sie dich?";
        case 4: return "Adam Smashers Bekanntheitsgrad";
        case 5: return "Wie viel Zeit braucht man, um so berühmt zu sein?";
      }
    }

    switch idx {
      case 0: return "Must be good to have the Johnny Silverhand treatment huh, V?";
      case 1: return "David's level of fame";
      case 2: return "If only Jackie could see us now";
      case 3: return "Do they admire you or fear you?";
      case 4: return "Adam Smasher's level of fame";
      case 5: return "How much time do you have to be this famous?";
    }
    return "";
  }

  private static func K_Before() -> String = "BTL.SC.Discount.BeforePct";
  private static func K_After()  -> String = "BTL.SC.Discount.AfterPct";
  private static func K_Line(idx: Int32) -> String = "BTL.SC.Line." + IntToString(idx + 1);

  public static func SC_Desc(pct: Int32, idx: Int32) -> String {
    let loc: CName = BTLLoc.DetectLocaleTag();
    let desc: String = 
        BTLLoc.L_orS(BTLLoc.K_Before(), BTLLoc.FB_Before(loc))
      + IntToString(pct)
      + BTLLoc.L_orS(BTLLoc.K_After(),  BTLLoc.FB_After(loc))
      + " "
      + BTLLoc.L_orS(BTLLoc.K_Line(idx), BTLLoc.FB_Line(idx, loc));
    return desc;
  }
}
