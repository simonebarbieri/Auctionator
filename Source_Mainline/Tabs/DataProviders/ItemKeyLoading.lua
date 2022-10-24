AuctionatorItemKeyLoadingMixin = {}

function AuctionatorItemKeyLoadingMixin:OnLoad()
  Auctionator.EventBus:Register(self, {Auctionator.AH.Events.ItemKeyInfo})

  self:SetOnEntryProcessedCallback(function(entry)
    Auctionator.AH.GetItemKeyInfo(entry.itemKey, function(itemKeyInfo, wasCached)
      self:ProcessItemKey(entry, itemKeyInfo)
      if wasCached then
        self:NotifyCacheUsed()
      end
    end)
  end)
end

function AuctionatorItemKeyLoadingMixin:ProcessItemKey(rowEntry, itemKeyInfo)
  local text = AuctionHouseUtil.GetItemDisplayTextFromItemKey(
    rowEntry.itemKey,
    itemKeyInfo,
    false
  )

  text = Auctionator.Utilities.ApplyProfessionQuality(text, rowEntry.itemKey.itemID)

  rowEntry.itemName = text
  rowEntry.name = Auctionator.Utilities.RemoveTextColor(text)
  rowEntry.iconTexture = itemKeyInfo.iconFileID
  rowEntry.noneAvailable = rowEntry.totalQuantity == 0

  self:SetDirty()
end
