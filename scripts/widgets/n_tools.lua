local Widget = require "widgets/widget"
local ImageButton = require "widgets/imagebutton"

local N_Tools = Class(Widget, function(self)
    Widget._ctor(self, "N_Tools")
	
	self.owner = GetPlayer()
	
    self.togglebutton = self:AddChild(ImageButton())
    self.togglebutton:SetScale(.7,.7,.7)
	
end)
return N_Tools