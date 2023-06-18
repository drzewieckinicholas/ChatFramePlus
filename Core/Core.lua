local AddonName, Private = ...

local ChatFramePlus = LibStub("AceAddon-3.0"):GetAddon(AddonName)

function ChatFramePlus:OnInitialize()
    print("ChatFramePlus:OnEnable")
end

function ChatFramePlus:OnEnable()
    print("ChatFramePlus:OnEnable")
end

function ChatFramePlus:OnDisable()
    print("ChatFramePlus:OnDisable")
end
