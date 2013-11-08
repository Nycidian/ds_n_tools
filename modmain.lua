


local require = GLOBAL.require
local GetWorld = GLOBAL.GetWorld
local GetPlayer = GLOBAL.GetPlayer
local table = require("table")
local math = require("math")
local SpawnPrefab = GLOBAL.SpawnPrefab
local string = require("string")

local Screen = require "widgets/screen"
local AnimButton = require "widgets/animbutton"
local Spinner = require "widgets/spinner"
local ImageButton = require "widgets/imagebutton"
local TextButton = require "widgets/textbutton"
local Text = require "widgets/text"
local Image = require "widgets/image"
local NumericSpinner = require "widgets/numericspinner"
local Widget = require "widgets/widget"
local UIAnim = require "widgets/uianim"
local Menu = require "widgets/menu"
local PopupDialogScreen = require "screens/popupdialog"

--require "strings"
--require "io"

local Widget = require "widgets/widget"


local function spawnMulti( n, name )
	if n >= 1 then
		
		local prefab = SpawnPrefab(name)
		GetPlayer().components.inventory:GiveItem(prefab)
		
		return spawnMulti( n-1, name )
	else end
end

local function AddN_Tools( inst )

	GLOBAL.RunScript("consolecommands")
	
	inst:DoTaskInTime( 0.001, function() 

		local N_Tools = require "widgets/n_tools"

		local controls = inst.HUD.controls

			--[[
				menu_switch
				top_menu_one
				top_menu_two
				center_root
					display
					display_D
			--]]

			menu_switch = controls:AddChild(Widget("menu_switch"))
			
	    	menu_switch:SetScaleMode(2)
	    	menu_switch:SetHAnchor(1)
	    	menu_switch:SetVAnchor(1)
	    	menu_switch:SetMaxPropUpscale(1.25)
	    	menu_switch:SetScale(1,1,1)
	    	

			top_menu_one = controls:AddChild(Widget("top_menu_one"))
			
	    	top_menu_one:SetScaleMode(2)
	    	top_menu_one:SetHAnchor(1)
	    	top_menu_one:SetVAnchor(1)
	    	top_menu_one:SetMaxPropUpscale(1.25)
	    	top_menu_one:SetScale(1,1,1)
	    	top_menu_one:Show()


	    	top_menu_two = controls:AddChild(Widget("top_menu_two"))
			
	    	top_menu_two:SetScaleMode(2)
	    	top_menu_two:SetHAnchor(1)
	    	top_menu_two:SetVAnchor(1)
	    	top_menu_two:SetMaxPropUpscale(1.25)
	    	top_menu_two:SetScale(1,1,1)
	    	top_menu_two:Hide()


	    	dig_menu = controls:AddChild(Widget("dig_menu"))
			
	    	dig_menu:SetScaleMode(2)
	    	dig_menu:SetHAnchor(0)
	    	dig_menu:SetVAnchor(1)
	    	dig_menu:SetMaxPropUpscale(1.25)
	    	dig_menu:SetScale(1,1,1)
	    	dig_menu:Hide()

	    	
	    	wish_menu = controls:AddChild(Widget("wish_menu"))
			
	    	wish_menu:SetScaleMode(2)
	    	wish_menu:SetHAnchor(0)
	    	wish_menu:SetVAnchor(1)
	    	wish_menu:SetMaxPropUpscale(1.25)
	    	wish_menu:SetScale(1,1,1)
	    	wish_menu:Hide()
			

			center_root = controls:AddChild(Widget("center_root"))
			
	    	center_root:SetScaleMode(2)
	    	center_root:SetHAnchor(1)
	    	center_root:SetVAnchor(0)
	    	center_root:SetMaxPropUpscale(1.25)
	    	center_root:SetScale(1,1,1)
	    	center_root:Hide()


	    	display = center_root:AddChild(Widget("display"))

	    	display:SetScaleMode(2)
	    	display:SetHAnchor(0)
	    	display:SetVAnchor(0)
	    	display:SetMaxPropUpscale(1.25)
	    	display:SetScale(.7,.7,.7)


	    	display_D = center_root:AddChild(Widget("display_D"))

	    	display_D:SetScaleMode(2)
	    	display_D:SetHAnchor(0)
	    	display_D:SetVAnchor(0)
	    	display_D:SetMaxPropUpscale(1.25)
	    	display_D:SetScale(.7,.7,.7)


	    	local function N_Func_Switch(inst)

				--for key,value in pairs(controls.center_root.shown) do print(key,value) end
				if not top_menu_one.shown and not top_menu_two.shown then

					top_menu_one:Show()
					top_menu_two:Hide()
					n_tools_switch.togglebutton:SetText("Switch Tools")
					--GLOBAL.SetPause(true)

				elseif top_menu_one.shown and not top_menu_two.shown then

					top_menu_one:Hide()
					top_menu_two:Show()
					n_tools_switch.togglebutton:SetText("Close N Tools")
					--GLOBAL.SetPause(true)
				else
					top_menu_one:Hide()
					top_menu_two:Hide()
					
					if dig_menu.shown then
						dig_menu:Hide()
						center_root:Hide()
						display_D:Hide()
						GLOBAL.SetPause(false)
					end
					if wish_menu.shown then
						wish_menu:Hide()
						center_root:Hide()
						GLOBAL.SetPause(false)
					end
					--GLOBAL.SetPause(false)
					n_tools_switch.togglebutton:SetText("Open N Tools")
				end
				
			end

			local X_BTN_OFFSET = 55
			local Y_BTN_OFFSET = 25
			local BTN_OFFSET = 10


			local x_btn_switch = X_BTN_OFFSET + BTN_OFFSET
			local y_btn_switch = Y_BTN_OFFSET + BTN_OFFSET

			------------------------------------------------------------------
			-----------------------Menu Switch Button-------------------------
			------------------------------------------------------------------
			n_tools_switch = menu_switch:AddChild( N_Tools() )
			n_tools_switch:SetPosition(x_btn_switch , -y_btn_switch)
			n_tools_switch.togglebutton:SetOnClick(N_Func_Switch)
			n_tools_switch.togglebutton:SetText("Open N Tools")
			------------------------------------------------------------------
			------------------------------------------------------------------
			------------------------------------------------------------------
			
			local function N_Func_1()
				GLOBAL:GetClock():NextPhase()
			end

			local function N_Func_2(inst)
				for x = 1, 5 do GLOBAL:GetClock():MakeNextDay() end
				inst.components.hunger:DoDelta(inst.components.hunger.max)
			end

			local function N_Func_3(inst)

				if GLOBAL:GetSeasonManager().precip then
					GLOBAL:GetSeasonManager():StopPrecip()
					n_tools_3.togglebutton:SetText("Start Precip")
				else
					GLOBAL:GetSeasonManager():StartPrecip()
					n_tools_3.togglebutton:SetText("Stop Precip")
				end

			end

			local function N_Func_4(inst)
				
				inst.components.builder:GiveAllRecipes()
				if inst.components.builder.freebuildmode then
					n_tools_4.togglebutton:SetText("Lock Build")
				else
					n_tools_4.togglebutton:SetText("Unlock Build")
				end
			end

			local function N_Func_5(inst)
				
				if not inst.components.health.invincible then
					inst.components.health.invincible = true
					n_tools_5.togglebutton:SetText("Go Vulnerable")
					--print(inst.components.health.invincible)
					vulnerable = false
				else
					inst.components.health.invincible = false
					n_tools_5.togglebutton:SetText("Go Invincible")
					--print(inst.components.health.invincible)
					vulnerable = true
				end
			end

			local function N_Func_6(inst)

				if inst.components.sanity.sane then
					inst.components.sanity:DoDelta(-(inst.components.sanity.max))
					n_tools_6.togglebutton:SetText("Go Sane")
					sane = false
				else
					inst.components.sanity:DoDelta(inst.components.sanity.max)
					n_tools_6.togglebutton:SetText("Go Insane")
					sane = true
				end

			end

			local function N_Func_7(inst)

				--for key,value in pairs(controls.center_root.shown) do print(key,value) end

				if dig_menu.shown then

					dig_menu:Hide()
					center_root:Hide()
					GLOBAL.SetPause(false)
					display_D:Hide()
					
				else
					Advance( inst )
					dig_menu:Show()
					center_root:Show()
					display_D:Show()
					wish_menu:Hide()
					GLOBAL.SetPause(true)
				end
				
			end

			local function N_Func_8(inst)

				--for key,value in pairs(controls.center_root.shown) do print(key,value) end

				if wish_menu.shown then

					wish_menu:Hide()
					center_root:Hide()
					GLOBAL.SetPause(false)
				else
					display:KillAllChildren()
					display_D:Hide()
					dig_menu:Hide()
					wish_menu:Show()
					center_root:Show()
					GLOBAL.SetPause(true)
					wishButtons( inst )
				end
				
			end

		local x_add = 110
		local x_pos = x_btn_switch + x_add
		local y_pos = y_btn_switch 
		



		n_tools_1 = top_menu_one:AddChild( N_Tools() )
		n_tools_1:SetPosition(x_pos , -y_pos )
		n_tools_1.togglebutton:SetOnClick(N_Func_1)
		n_tools_1.togglebutton:SetText("Time Jump")

		n_tools_7 = top_menu_two:AddChild( N_Tools() )
		n_tools_7:SetPosition(x_pos , -y_pos )
		n_tools_7.togglebutton:SetOnClick( function() N_Func_7(inst) end)
		n_tools_7.togglebutton:SetText("Dig")

		x_pos = x_pos + x_add

		n_tools_2 = top_menu_one:AddChild( N_Tools() )
		n_tools_2:SetPosition(x_pos , -y_pos )
		n_tools_2.togglebutton:SetOnClick( function() N_Func_2(inst) end)
		n_tools_2.togglebutton:SetText("Time Jump +")

		n_tools_8 = top_menu_two:AddChild( N_Tools() )
		n_tools_8:SetPosition(x_pos , -y_pos )
		n_tools_8.togglebutton:SetOnClick( function() N_Func_8(inst) end)
		n_tools_8.togglebutton:SetText("Wish")

		x_pos = x_pos + x_add

		n_tools_3 = top_menu_one:AddChild( N_Tools() )
		n_tools_3:SetPosition(x_pos , -y_pos )
		n_tools_3.togglebutton:SetOnClick( function() N_Func_3(inst) end)
		n_tools_3.togglebutton:SetText("Start Precip")

		x_pos = x_pos + x_add

		n_tools_4 = top_menu_one:AddChild( N_Tools() )
		n_tools_4:SetPosition(x_pos , -y_pos )
		n_tools_4.togglebutton:SetOnClick( function() N_Func_4(inst) end)
		n_tools_4.togglebutton:SetText("Unlock Build")

		x_pos = x_pos + x_add

		n_tools_5 = top_menu_one:AddChild( N_Tools() )
		n_tools_5:SetPosition(x_pos , -y_pos )
		n_tools_5.togglebutton:SetOnClick( function() N_Func_5(inst) end)
		n_tools_5.togglebutton:SetText("Go Invincible")

		x_pos = x_pos + x_add

		n_tools_6 = top_menu_one:AddChild( N_Tools() )
		n_tools_6:SetPosition(x_pos , -y_pos )
		n_tools_6.togglebutton:SetOnClick( function() N_Func_6(inst) end)
		n_tools_6.togglebutton:SetText("Go Insane")


		
		
		local typeVar = "string"
		local enterVar = {GLOBAL}
		local enterVarName = {"Global"}

		--local typeVarDisplayD = {number = true, boolean=true, thread = false, table = false, userdata = false, string = true}

		local varTable = {}
		local varTableLen = 0

		local black = {0,0,0}
		local brown = {.5,.3,0}
		local orange = {.8,.25,0}
		local red = {.4,0,0}
		local purple = {.5,0,.5}
		local blue = {0,0,.75}
		local bgrn = {0,.5,.5}
		local green = {0,.4,0}
		local grey = {.35,.35,.35}

		local tableWhere = 1
		local TABLE_COL = 5
		local TABLE_ROW = 4
		local TABLE_TOTAL = TABLE_COL*TABLE_ROW

		local X_POS = -450
		local Y_POS = -170

		local X_POS_MOVE = 220
		local Y_POS_MOVE = 110

		text_display = display_D:AddChild(Text("stint-ucr", 25))
		text_display:SetPosition(0, (Y_POS - 120), 0)
		text_display:SetRegionSize( 1000, 100)
		text_display:EnableWordWrap(true)

		function Advance( inst )

			display:KillAllChildren()


			local tempLength  = TABLE_TOTAL

			if (varTableLen - (tableWhere - 1)) < tempLength then
				tempLength = varTableLen - tableWhere + 1
			end

			
			
		
			for x=tableWhere, tableWhere+tempLength-1,1 do 

				local col_count = math.floor((x-tableWhere)/TABLE_ROW)

				

				local x_pos_temp = X_POS + (col_count*X_POS_MOVE)
				local y_pos_temp = Y_POS + (Y_POS_MOVE*((x-tableWhere) - (col_count*TABLE_ROW)))

				--print(col_count, x_pos_temp, y_pos_temp)

				--print( varTable[x].var, varTable[x].entry ) 
				display.x = display:AddChild( N_Tools() )
				display.x.togglebutton:SetPosition(x_pos_temp , y_pos_temp )
				display.x.togglebutton:SetScale(1.4,1.4,1.4)
				display.x.togglebutton:SetTextSize(15)
				if typeVar ~= "table" and typeVar ~="function" and typeVar ~="userdata" and typeVar ~="thread" then
					display.x.togglebutton:SetOnClick( function(inst)
						local pass = varTable[x].entry
						if type(pass) == "boolean" then
							if pass then
								pass = "true"
							else
								pass = "false"
							end
						end
						text_display:SetString(varTable[x].var.." = "..pass)
					end)
				end
				
				if typeVar == "table" then
					
					display.x.togglebutton:SetOnClick( function()

						if varTable[x].var == "inst" then

							table.remove(enterVar, 1)
						
							table.remove(enterVarName, 1)
						else
							table.insert(enterVar, 1,varTable[x].entry)
						
							table.insert(enterVarName, 1,varTable[x].var)
						end

						--enterVar = enterVar
						dig_var.togglebutton:SetText(enterVarName[1])

						tableWhere = 1

						varTable = {}



						local function tableLength(T)
							local count = 0
							for key,value in pairs(T) do 
								if type(value) == typeVar then
									count = count + 1
									varTable[count] = {var=key,entry=value}
								end
							end
							return count
						end

						varTableLen = tableLength( enterVar[1] )

						local sort_func = function( a,b ) return a.var < b.var end
						table.sort( varTable, sort_func )


						return Advance(inst)
						
					end)
				end
				pass = varTable[x].var
				if type(pass) ~= "table" and type(pass) ~="function" and type(pass) ~="userdata" and type(pass) ~="thread" and type(pass) ~="boolean" then
					display.x.togglebutton:SetText(pass)
				else
					print("Error",type(pass))
				end
				
			end
			
		end

		local function Forward( inst )



			tableWhere = tableWhere + TABLE_TOTAL

			if (varTableLen - tableWhere + 1) <= 0 then
				tableWhere = 1
			end

			print(tableWhere)

				
		end
		
		local function Back( inst )

			
			if tableWhere >= 1 and tableWhere <= TABLE_TOTAL then
				tableWhere = varTableLen -(varTableLen % TABLE_TOTAL)

			elseif varTableLen >= TABLE_TOTAL then
				tableWhere = tableWhere - TABLE_TOTAL
			else 
				tableWhere = 1
			end

			if tableWhere < 1 then
				tableWhere = 1
			end

			print(tableWhere)
				
		end
		
		local function Dig( inst )


				tableWhere = 1

				varTable = {}

				local function tableLength(T)
					local count = 0
					for key,value in pairs(T) do 
						if type(value) == typeVar then
							count = count + 1
							varTable[count] = {var=key,entry=value}
						end
					end
					return count
				end

				varTableLen = tableLength( enterVar[1] )

				local sort_func = function( a,b ) return a.var < b.var end
				table.sort( varTable, sort_func )

				Advance( inst )
				
		end
		
		--[[
		local wishCount = 0
		local wishWhere = 1
		local wishTable = {}

		local function wishSort( inst )
			

			local function checkPrefab(prefab)

				if prefab == nil then
					
					return false
				end
				local FN = false
				for key,value in pairs(prefab) do
					if key == "fn" then
						FN = true
					end	
				end

				local ANIM = false
				for key,value in pairs(prefab) do
					if key == "assets" then
						for key,value in pairs(value) do
							for key,value in pairs(value) do
								if key == "type" and value == "ANIM" then
									ANIM = true
								end	
							end
						end
					end	
				end


	    		if FN and ANIM then
				    local inst = prefab.fn(TheSim)
				    
				    if inst ~= nil then
				            
				        return true
				    else
				  		print( "Does not exist", name )
				    	return false
				 
				    end
				    
				end
			end


			local a = {}
			local cnt = 0
			for key,value in pairs(GLOBAL.Prefabs) do 
				
				
				if not string.find(key, "MOD..") and key ~= "rubble" and key ~= "rubble_med" and key ~= "rubble_low" and key ~= "global" and key ~= "devtool" then
					
					cnt = cnt + 1
					wishTable[cnt] = {key,value}
					
				end
				
			end

			for _,value in pairs(a) do 
				
				if checkPrefab(value[2]) then
					wishCount = wishCount + 1
					wishTable[wishCount] = {value[1],value[2]}
				end
					
			end

			local sort_func = function( a,b ) return a[2].name < b[2].name end
			table.sort( wishTable, sort_func )

		end

		wishSort( inst )
		local function wish( inst )


			for n = 1, 40, 1 do 

			print( n, wishTable[n][1], wishTable[n][2] )
			spawnMulti(inst, 1, wishTable[n][1])
			
			end
				
			

		end
		--]]

		function wishButtons( inst )

			local display_wish = {}

			local wish_list = {

			{"Harvest", {"rocks",40},{"twigs",40},{"cutgrass",40},{"cutreeds",40},{"log",20},{"goldnugget",20}},
			{"Animal 1", {"fireflies",40},{"bee",20},{"rabbit",4},{"honeycomb",20},{"houndstooth",40},{"silk",40}},
			{"Animal 2", {"beefalowool",40},{"trunk_winter",20},{"trunk_summer",20},{"pigskin",40},{"poop",20},{"poop",20}},
			{"War", {"blowdart_pipe",4},{"ruins_bat",1},{"ruinshat",1},{"armorruins",1},{"trap_teeth",10},{"beemine",4}},
			{"Travel", {"krampus_sack",1},{"cane",1},{"minerhat",1},{"beefalohat",1},{"trunkvest_winter",1},{"meat_dried",20}},
			{"Raw Meat 1", {"meat",20},{"monstermeat",40},{"smallmeat",40},{"drumstick",20},{"fish",40},{"bird_egg",40}},
			{"Raw Meat 2", {"froglegs",40},{"eel",40},{"batwing",20},{"trunk_summer",20},{"trunk_winter",20},{"tallbirdegg",4}},
			
			{"Raw Produce 1", {"corn",40},{"carrot",40},{"eggplant",20},{"red_cap",40},{"green_cap",40},{"berries",40}},
			{"Raw Produce 2", {"pumpkin",40},{"blue_cap",40},{"dragonfruit",40},{"pomegranate",40},{"cave_banana",40},{"durian",20}},
			{"Other Food 1", {"meat_dried",20},{"smallmeat_dried",40},{"honey",40},{"monstermeat_dried",20},{"butter",40},{"twigs",40}},
			{"Other Food 2", {"mandrake",4},{"cutlichen",6},{"cutlichen",3},{"cutlichen",3},{"cutlichen",3},{"cutlichen",5}},
			
			{"Weazley Stuff", {"spoiled_food",40},{"poop",20},{"pigskin",40},{"guano",20},{"beefalowool",40},{"crow",4}},
			
			}

			local wish_list_Lngth = 12
				
			for x=0, wish_list_Lngth-1 ,1 do 

				local col_count = math.floor(x/TABLE_ROW)

				local x_pos_temp = X_POS + (col_count*X_POS_MOVE)
				local y_pos_temp = Y_POS + (Y_POS_MOVE*((x) - (col_count*TABLE_ROW)))

				display_wish[x] = display:AddChild( N_Tools() )
				display_wish[x].togglebutton:SetPosition(x_pos_temp , y_pos_temp )
				display_wish[x].togglebutton:SetScale(1.4,1.4,1.4)
				display_wish[x].togglebutton:SetTextSize(30)
				display_wish[x].togglebutton:SetOnClick( function()
					
					spawnMulti( wish_list[x+1][2][2], wish_list[x+1][2][1] )
					spawnMulti( wish_list[x+1][3][2], wish_list[x+1][3][1] )
					spawnMulti( wish_list[x+1][4][2], wish_list[x+1][4][1] )
					spawnMulti( wish_list[x+1][5][2], wish_list[x+1][5][1] )
					spawnMulti( wish_list[x+1][6][2], wish_list[x+1][6][1] )
					spawnMulti( wish_list[x+1][7][2], wish_list[x+1][7][1] )
				end)
				display_wish[x].togglebutton:SetText(wish_list[x+1][1])

			end

		end


		local function setVar( inst )
			
		
			if enterVar[1] == GLOBAL then
				table.insert(enterVar, 1,GetWorld())	
				table.insert(enterVarName, 1,"World")
				dig_var.togglebutton:SetText("World")
			elseif enterVar[1] == GetWorld() then
				table.insert(enterVar, 1,GetPlayer())
				table.insert(enterVarName, 1,"Character")
				dig_var.togglebutton:SetText("Character")
			else
				enterVar = {GLOBAL}
				enterVarName = {"Global"}
				dig_var.togglebutton:SetText("Global")
			end

			Dig(inst)
		end
		


		local function typeVarChange( inst )
				text_display:SetString("")

				if typeVar == "string" then
					typeVar = "number"
					dig_varType.togglebutton:SetText("Number")
					dig_varType.togglebutton:SetTextColour(brown[1],brown[2],brown[3],1)
					dig_varType.togglebutton:SetTextFocusColour(brown[1],brown[2],brown[3],1)

				elseif typeVar == "number" then
					typeVar = "boolean"
					dig_varType.togglebutton:SetText("Boolean")
					dig_varType.togglebutton:SetTextColour(orange[1],orange[2],orange[3],1)
					dig_varType.togglebutton:SetTextFocusColour(orange[1],orange[2],orange[3],1)

				elseif typeVar == "boolean" then
					
					typeVar = "thread"
					dig_varType.togglebutton:SetText("Thread")
					dig_varType.togglebutton:SetTextColour(red[1],red[2],red[3],1)
					dig_varType.togglebutton:SetTextFocusColour(red[1],red[2],red[3],1)
					

				elseif typeVar == "thread" then

					typeVar = "table"
					dig_varType.togglebutton:SetText("Table")
					dig_varType.togglebutton:SetTextColour(purple[1],purple[2],purple[3],1)
					dig_varType.togglebutton:SetTextFocusColour(purple[1],purple[2],purple[3],1)


				elseif typeVar == "table" then

					typeVar = "userdata"
					dig_varType.togglebutton:SetText("User Data")
					dig_varType.togglebutton:SetTextColour(blue[1],blue[2],blue[3],1)
					dig_varType.togglebutton:SetTextFocusColour(blue[1],blue[2],blue[3],1)

				elseif typeVar == "userdata" then

					typeVar = "function"
					dig_varType.togglebutton:SetText("Function")
					dig_varType.togglebutton:SetTextColour(green[1],green[2],green[3],1)
					dig_varType.togglebutton:SetTextFocusColour(green[1],green[2],green[3],1)
					
				elseif typeVar == "function" then

					typeVar = "nil"
					dig_varType.togglebutton:SetText("Nil")
					dig_varType.togglebutton:SetTextColour(grey[1],grey[2],grey[3],1)
					dig_varType.togglebutton:SetTextFocusColour(grey[1],grey[2],grey[3],1)
					
				else
					typeVar = "string"
					dig_varType.togglebutton:SetText("String")
					dig_varType.togglebutton:SetTextColour(black[1],black[2],black[3],1)
					dig_varType.togglebutton:SetTextFocusColour(black[1],black[2],black[3],1)
					
				end
				
				Dig(inst)
				
		end

		------------------------------------------------------------------
		-----------------------Secondary Menus----------------------------
		------------------------------------------------------------------

		x_pos = X_POS 
		y_pos = y_btn_switch + 75

		dig_varType = dig_menu:AddChild( N_Tools() )
		dig_varType:SetPosition( x_pos , -y_pos )
		dig_varType.togglebutton:SetOnClick( function() typeVarChange(inst) end)
		dig_varType.togglebutton:SetText("String")
		dig_varType.togglebutton:SetScale(1.4,1.4,1.4)
		
		--[[
		wish_btn = wish_menu:AddChild( N_Tools() )
		wish_btn:SetPosition( x_pos , -y_pos )
		wish_btn.togglebutton:SetOnClick( function() wish(inst) end)
		wish_btn.togglebutton:SetText("Make a Wish")
		wish_btn.togglebutton:SetScale(1,1,1)
		--]]

		x_pos = x_pos + X_POS_MOVE

		dig_var = dig_menu:AddChild( N_Tools() )
		dig_var:SetPosition( x_pos , -y_pos )
		dig_var.togglebutton:SetOnClick( function() setVar(inst) end)
		dig_var.togglebutton:SetText("Global")
		dig_var.togglebutton:SetScale(1.4,1.4,1.4)

		x_pos = x_pos + X_POS_MOVE

		dig_up = dig_menu:AddChild( N_Tools() )
		dig_up.togglebutton:SetPosition(x_pos , -y_pos )
		dig_up.togglebutton:SetOnClick( function() 
			if enterVarName[1] ~= "Global" then
				table.remove(enterVar, 1)		
				table.remove(enterVarName, 1)
				dig_var.togglebutton:SetText(enterVarName[1])
				tableWhere = 1
				Dig( inst, enterVar[1] )
			end
		end)
		dig_up.togglebutton:SetText("Up")
		dig_up.togglebutton:SetScale(1.4,1.4,1.4)

		x_pos = x_pos + X_POS_MOVE

		controls.dig_back = dig_menu:AddChild( N_Tools() )
		controls.dig_back:SetPosition( x_pos , -y_pos )
		controls.dig_back.togglebutton:SetOnClick( function() 
				Back(inst)
				Advance( inst )
			end)
		controls.dig_back.togglebutton:SetText("Back")
		controls.dig_back.togglebutton:SetScale(1.4,1.4,1.4)
		
		x_pos = x_pos + X_POS_MOVE

		controls.dig_forward = dig_menu:AddChild( N_Tools() )
		controls.dig_forward:SetPosition( x_pos , -y_pos )
		controls.dig_forward.togglebutton:SetOnClick( function() 
				Forward(inst) 
				Advance( inst )
			end)
		controls.dig_forward.togglebutton:SetText("Forward")
		controls.dig_forward.togglebutton:SetScale(1.4,1.4,1.4)
		
		Dig(inst)
	
	end)
	
end

AddSimPostInit( AddN_Tools )


