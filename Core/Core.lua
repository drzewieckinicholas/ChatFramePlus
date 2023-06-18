local AddonName, Private = ...

local ChatFramePlus = LibStub("AceAddon-3.0"):GetAddon(AddonName)

function ChatFramePlus:OnInitialize()
    print(AddonName .. ":OnInitialize")
end

function ChatFramePlus:OnEnable()
    print(AddonName .. ":OnEnable")
end

function ChatFramePlus:OnDisable()
    print(AddonName .. ":OnDisable")
end
