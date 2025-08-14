private func BTL_FindIndexByLevel(arr: array<ref<LevelRewardDisplayData>>, lvl: Int32) -> Int32 {
  let i: Int32 = 0;
  while i < ArraySize(arr) {
    if arr[i].level == lvl { return i; }
    i += 1;
  }
  return -1;
}

private func BTL_PushIfUnique(out dst: array<ref<LevelRewardDisplayData>>, item: ref<LevelRewardDisplayData>) -> Void {
  let i: Int32 = 0;
  while i < ArraySize(dst) {
    if dst[i].level == item.level { return; }
    i += 1;
  }
  ArrayPush(dst, item);
}

private func BTL_SortByLevel(out arr: array<ref<LevelRewardDisplayData>>) -> Void {
  let n: Int32 = ArraySize(arr);
  if n <= 1 { return; }
  let i: Int32 = 0;
  while i < n - 1 {
    let j: Int32 = 0;
    while j < n - i - 1 {
      if arr[j].level > arr[j + 1].level {
        let tmp: ref<LevelRewardDisplayData> = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = tmp;
      }
      j += 1;
    }
    i += 1;
  }
}

// ----------------- UI patch -----------------
@wrapMethod(StatsStreetCredReward)
public final func SetData(rewardData: array<ref<LevelRewardDisplayData>>,
                          tooltipsManager: wref<gameuiTooltipsManager>,
                          currentLevel: Int32,
                          tooltipIndex: Int32,
                          const attributeName: script_ref<String>) -> Void {
  let tiers: array<Int32> = [75, 100, 150, 200, 250, 500];
  let pcts:  array<Int32> = [ 5,   5,   5,   5,   10,  15];

  let i: Int32 = 0;
  while i < ArraySize(tiers) {
    if BTL_FindIndexByLevel(rewardData, tiers[i]) < 0 {
      let r: ref<LevelRewardDisplayData> = new LevelRewardDisplayData();
      r.level = tiers[i];
      r.description = BTLLoc.SC_Desc(pcts[i], i);
      ArrayPush(rewardData, r);
    }
    i += 1;
  }

  BTL_SortByLevel(rewardData);

  let MAX_TILES: Int32 = 9;
  let finalList: array<ref<LevelRewardDisplayData>>;
  if currentLevel < 51 {
    let vanillaOrder: array<Int32> = [5,10,15,20,25,30,35,40,50];
    let v: Int32 = 0;
    while v < ArraySize(vanillaOrder) && ArraySize(finalList) < MAX_TILES {
      let idx: Int32 = BTL_FindIndexByLevel(rewardData, vanillaOrder[v]);
      if idx >= 0 { BTL_PushIfUnique(finalList, rewardData[idx]); }
      v += 1;
    }
    let f: Int32 = 0;
    while ArraySize(finalList) < MAX_TILES && f < ArraySize(rewardData) {
      BTL_PushIfUnique(finalList, rewardData[f]);
      f += 1;
    }
  } else {
    let count: Int32 = ArraySize(rewardData);
    let start: Int32 = (count - MAX_TILES) < 0 ? 0 : (count - MAX_TILES);
    let idx2: Int32 = start;
    if idx2 < count && rewardData[idx2].level == 30 { idx2 += 1; }
    while idx2 < count {
      ArrayPush(finalList, rewardData[idx2]);
      idx2 += 1;
    }
  }

  wrappedMethod(finalList, tooltipsManager, currentLevel, tooltipIndex, attributeName);
}

@addField(PlayerPuppet) private let BTL_extraBuyDiscMod: ref<gameStatModifierData>;
@addField(PlayerPuppet) private let BTL_extraBuyDiscPts: Int32;
@addField(PlayerPuppet) private let BTL_openVendorEID: EntityID;

private func BTL_ExtraPointsFromSC(sc: Int32) -> Int32 {
  let pts: Int32 = 0;
  if sc >= 75  { pts += 5; }
  if sc >= 100 { pts += 5; }
  if sc >= 150 { pts += 5; }
  if sc >= 200 { pts += 5; }
  if sc >= 250 { pts += 10; }
  if sc >= 500 { pts += 15; }
  return pts;
}

private func BTL_ReapplyExtraDiscount(player: wref<PlayerPuppet>) -> Void {
  if !IsDefined(player) { return; }

  let dev: wref<PlayerDevelopmentData> = PlayerDevelopmentSystem.GetData(player);
  if !IsDefined(dev) { return; }

  let sc: Int32 = dev.GetProficiencyLevel(gamedataProficiencyType.StreetCred);
  let wantPts: Int32 = BTL_ExtraPointsFromSC(sc);

  if player.BTL_extraBuyDiscPts != wantPts {
    let gi: GameInstance = player.GetGame();
    let stats: ref<StatsSystem> = GameInstance.GetStatsSystem(gi);
    let oid: StatsObjectID = Cast<StatsObjectID>(player.GetEntityID());

    if IsDefined(player.BTL_extraBuyDiscMod) {
      stats.RemoveModifier(oid, player.BTL_extraBuyDiscMod);
      player.BTL_extraBuyDiscMod = null;
    }

    player.BTL_extraBuyDiscPts = wantPts;

    if wantPts > 0 {
      let mod: ref<gameStatModifierData> =
        RPGManager.CreateStatModifier(gamedataStatType.VendorBuyPriceDiscount,
                                      gameStatModifierType.Additive,
                                      Cast<Float>(wantPts));
      stats.AddModifier(oid, mod);
      player.BTL_extraBuyDiscMod = mod;
    }
  }

  if EntityID.IsDefined(player.BTL_openVendorEID) {
    let vendObj: wref<GameObject> =
      GameInstance.FindEntityByID(player.GetGame(), player.BTL_openVendorEID) as GameObject;
    if IsDefined(vendObj) {
      GameInstance.GetTransactionSystem(player.GetGame()).ReinitializeStatsOnEntityItems(vendObj);
    }
  }
}

@wrapMethod(PlayerDevelopmentSystem)
private final func OnExperienceAdded(request: ref<AddExperience>) -> Void {
  let player: wref<PlayerPuppet> = request.owner as PlayerPuppet;
  let beforeSC: Int32 = IsDefined(player)
    ? PlayerDevelopmentSystem.GetData(player).GetProficiencyLevel(gamedataProficiencyType.StreetCred)
    : 0;
  wrappedMethod(request);

  if IsDefined(player) {
    let afterSC: Int32 = PlayerDevelopmentSystem.GetData(player).GetProficiencyLevel(gamedataProficiencyType.StreetCred);
    if afterSC != beforeSC {
      BTL_ReapplyExtraDiscount(player);
    }
  }
}

@wrapMethod(Vendor)
public final func OnVendorMenuOpen() -> Void {
  wrappedMethod();

  let vobj: wref<GameObject> = this.GetVendorObject();
  let player: wref<PlayerPuppet> = GetPlayer(this.m_gameInstance);
  if IsDefined(vobj) && IsDefined(player) {
    player.BTL_openVendorEID = vobj.GetEntityID();
    BTL_ReapplyExtraDiscount(player);
  }
}

@wrapMethod(Vendor)
public final func OnDeattach(owner: wref<GameObject>) -> Void {
  wrappedMethod(owner);
  let player: wref<PlayerPuppet> = GetPlayer(this.m_gameInstance);
  if IsDefined(player) {
    let tmp: EntityID;
    player.BTL_openVendorEID = tmp;
  }
}
