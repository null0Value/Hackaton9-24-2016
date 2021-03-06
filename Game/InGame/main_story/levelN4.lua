-- Require Modules
local moduleRender = require "image_renderer"
local moduleUtil = require "utility"
-- End of Require Modules

-- Variable Declaration
local scene = moduleUtil.storyboard.newScene()
local background
local dialogBox
local text
local screenGroup 
local obsCount = 0
local count = 0
local gamepad = {}
local platforms = {}
local allBord = {}
local isColide = false
local conText
local conDialogBox
local count = 0

local conTextYes
local conTextbutNo
local conTextbutSubmit
local butYes
local butNo
local butSubmit
-- End of Variable Declaration

-- Start Physics
moduleUtil.physics.start()
moduleUtil.physics.setGravity( 0,9.8)
-- End of Start Physics

local btnC1Att = {
			x = display.contentWidth/2 - (display.contentWidth/6),
			y = 300,
			width = display.contentWidth/2 - (display.contentWidth/6),
			height = display.contentHeight/12

		}
local btnC2Att = {
		x = display.contentWidth/2 + (display.contentWidth/6),
		y = 300,
		width = display.contentWidth/2 - (display.contentWidth/6),
		height = display.contentHeight/12

	}
local btSubAtt = {
		x = display.contentWidth/2,
		y = 265,
		width = display.contentWidth/2,
		height = display.contentHeight/12

	}

-- Function that adds Obstacles
local function createArrayData(name,x,y,width,height)
	print(obsCount)
	obsAtt = {
		name = name, --name of the PNG file
		x = x,
		y = y,
		width = width,
		height = height
	}
	platforms["obs"..obsCount] = moduleRender.allRounder("PL","InGame","obstacles",obsAtt)
	obsCount = obsCount + 1
end
-- End of function

-- Create Scene
function scene:createScene(event)
	screenGroup = self.view
	screenGroup.id = "screen"

	-- Scene Background
	background = moduleRender.allRounder("BG","InGame","backgroundLevel","NA")
	background.alpha = 1
	-- End of Scene Background

	-- Border
	border = {"top","left","right","bottom"}
	allBord = moduleRender.borders(border)
	-- End of Border

	-- Character Setup
	charRace2Att = {
		name = "charr", --name of the PNG file
		x = display.contentWidth/16,
		y = display.contentHeight/2.5,
		width = 30,
		height = 38
	
	}
	race2 = moduleRender.allRounder("CH","Characters","R2",charRace2Att)
	race2.alpha = 1


	charRace2Att = {
		name = "gaimon", --name of the PNG file
		x = display.contentWidth/2.25,
		y = display.contentHeight/1.65,
		width = 46,
		height = 60
	}
	race3 = moduleRender.allRounder("CH","Characters","R3",charRace2Att)
	race3.alpha1 = 1
	-- End of Character Setup

	-- Game Pads
	gamepad = moduleUtil.gamepad()
	-- End of Game Pads

	-- Obstacles
	createArrayData("small_platform",
					display.contentWidth/16,
					display.contentHeight/2,
					display.contentWidth/20,
					display.contentHeight/14)

	createArrayData("small_platform",
					display.contentWidth/6,
					display.contentHeight/1.7,
					display.contentWidth/20,
					display.contentHeight/14)

	createArrayData("holder_log",
					display.contentWidth/3.2,
					display.contentHeight/1.48,
					display.contentWidth/8,
					display.contentHeight/6)

	createArrayData("semilarge_platform",
					display.contentWidth/3.9,
					display.contentHeight/1.2,
					display.contentWidth/15,
					display.contentHeight/3)


	createArrayData("log",
					display.contentWidth/3.15,
					display.contentHeight/1.39,
					display.contentWidth/25,
					display.contentHeight/16)

	createArrayData("log",
					display.contentWidth/2.81,
					display.contentHeight/1.38,
					display.contentWidth/25,
					display.contentHeight/16)

	createArrayData("log",
					display.contentWidth/2.54,
					display.contentHeight/1.37,
					display.contentWidth/25,
					display.contentHeight/16)

	createArrayData("log",
					display.contentWidth/2.32,
					display.contentHeight/1.36,
					display.contentWidth/25,
					display.contentHeight/16)
	createArrayData("log",
					display.contentWidth/1.97,
					display.contentHeight/1.37,
					display.contentWidth/25,
					display.contentHeight/16)

	createArrayData("log",
					display.contentWidth/2.13,
					display.contentHeight/1.36,
					display.contentWidth/25,
					display.contentHeight/16)
	createArrayData("log",
					display.contentWidth/1.71,
					display.contentHeight/1.39,
					display.contentWidth/25,
					display.contentHeight/16)
	createArrayData("log",
					display.contentWidth/1.83,
					display.contentHeight/1.38,
					display.contentWidth/25,
					display.contentHeight/16)

	createArrayData("rightHolder",
					display.contentWidth - (display.contentWidth/2.44),
					display.contentHeight/1.48,
					display.contentWidth/8,
					display.contentHeight/6)

	createArrayData("semilarge_platform",
					display.contentWidth/1.55,
					display.contentHeight/1.2,
					display.contentWidth/15,
					display.contentHeight/3)

	createArrayData("small_platform",
					display.contentWidth/1.25,
					display.contentHeight/1.44,
					display.contentWidth/20,
					display.contentHeight/14)

	createArrayData("semilarge_platform",
					display.contentWidth/1,
					display.contentHeight/1.2,
					display.contentWidth/6,
					display.contentHeight/3)


	-- End of Obstacles

	--button
	 butYes = moduleRender.allRounder("BT","InGame","but",btnC1Att)
	 butNo = moduleRender.allRounder("BT","InGame","but",btnC2Att)
	 butSubmit = moduleRender.allRounder("BT","InGame","but",btSubAtt)
	 butYes.alpha = 0
	 butNo.alpha = 0
	 butSubmit.alpha = 0
	 --button text
	conTextYes = moduleUtil.text("Yes",23)
	conTextYes.x = btnC1Att["x"]
	conTextYes.y = btnC1Att["y"]
	conTextYes.alpha = 0
	conTextbutNo = moduleUtil.text("No",23)
	conTextbutNo.x = btnC2Att["x"]
	conTextbutNo.y = btnC2Att["y"]
	conTextbutNo.alpha = 0
	conTextbutSubmit = moduleUtil.text("Submit",23)
	conTextbutSubmit.x = btSubAtt["x"]
	conTextbutSubmit.y = btSubAtt["y"]
	conTextbutSubmit.alpha = 0
	
	conText = moduleUtil.text("R2: We are here to seek help to mediate our situation at camp, \n some one took over our forgering spot")
	conText.alpha = 0
	
	-- Dialog Box
	conDialogBox = moduleRender.allRounder("DB","InGame","Dialog","NA")
	conDialogBox.height = display.contentHeight/5
	conDialogBox.alpha = 0

	-- End of Dialog Box

	screenGroup:insert(background)
	for i=0,obsCount do
		if platforms["obs"..i] ~= nil and i ~= 2 and i ~=12 then
			screenGroup:insert(platforms["obs"..i])
		end
	end

	for b = 1, table.getn(allBord), 1 do
		screenGroup:insert(allBord[b])
	end


	screenGroup:insert(race2)
	screenGroup:insert(race3)
	screenGroup:insert(conDialogBox)
	screenGroup:insert(conText)
	
	screenGroup:insert(butYes)
	screenGroup:insert(butNo)
	screenGroup:insert(butSubmit)
	screenGroup:insert(conTextYes)
	screenGroup:insert(conTextbutNo)
	screenGroup:insert(conTextbutSubmit)
	
end
--End of Create Scene

-- Utitlity function
local function scrollThings(self,event)
	self.rotation = 0
	if self.pad == "left"  then   -----right x axis-------
		print(">>"..self.x)
		self.x = self.x - 4
	elseif self.pad == "right"  then   -----right x axis-------
		print(">>"..self.x)
		self.x = self.x + 4
	end
end

local function straight(self,event)
	self.rotation = 0
end

local function walker(event)
	if event.phase == "began" then
	local attribute = {
		width = 30,
		height = 38,
		numFramesInSheet = 3,
		name = "walking",
		start = 1,
		count = 3,
		time = 300,
		loopCount = 0,
		loopDirection = "forward"
	}
	local char = {
	
			{
				x = race2.x,
				y = race2.y
			}
		
		}
		event.target.alpha = 1
	
		if event.target == gamepad["left"] then
			screenGroup:remove(race2)
			race2 = moduleRender.gif("Assets/Characters/R2/Sprite/left.png",attribute,char)
			race2.pad = "left"
			screenGroup:insert(race2)
			moduleUtil.physics.addBody(race2,{friction=50,bounce=0 })
			race2.enterFrame = scrollThings               
			Runtime:addEventListener("enterFrame", race2)
			race2:play()
		elseif event.target == gamepad["right"] then 
			screenGroup:remove(race2)
			race2 = moduleRender.gif("Assets/Characters/R2/Sprite/right.png",attribute,char)
			race2.pad = "right"
			screenGroup:insert(race2)
			moduleUtil.physics.addBody(race2,{friction=0.3,bounce=0 })
			race2.enterFrame = scrollThings               
			Runtime:addEventListener("enterFrame", race2)
			race2:play()
		elseif event.target == gamepad["mid"] then
			--race2.y = race2.y - 100
			transition.to( race2, { time=100,y= race2.y-100})
		
		end
	elseif event.phase == "ended" then
		if event.target == gamepad["right"] or event.target == gamepad["left"]  then
		--race2:pause()
		end
		event.target.alpha = 0.5
		Runtime:removeEventListener("enterFrame", race2)
		race2.enterFrame = straight               
		Runtime:addEventListener("enterFrame", race2)
	end
end
-- End of Utility Function

-- Function, after collision of two races
local function showDialog(self,event)
	
	if event.other == race2 and isColide == false then
		isColide = true
		print("Colide")
	end
	if isColide then
		conText.alpha = 1
		conDialogBox.alpha = 1
	end
end
-- End Function

-- Function, change dialog after clicking dialogBox
local function changeDialog(event)

	if event.phase == "began" then
		count = count +1
		if count == 1 then
			screenGroup:remove(conText)
			conText = moduleUtil.text("R3: I understand your situation and I'm willing to help, \n but first you must solve these riddles.")
			screenGroup:insert(conText)
		elseif count == 2 then
			screenGroup:remove(conText)
			conText = moduleUtil.text("Are You Ready?")
			screenGroup:insert(conText)
			 butYes.alpha = 1
			 butNo.alpha = 1
			 butSubmit.alpha = 0
			 --button text
			conTextYes.alpha = 1
			conTextbutNo.alpha = 1
			conTextbutSubmit.alpha = 0
		end
	end
end
-- End Function

-- Function that will teleport character if drop below
local function teleporter(self,event)

	if  event.target == allBord[1] then -- left border
		transition.to(event.other, {x = event.other.x,y = display.contentHeight/2.5, time=0})
	elseif event.target == allBord[2] then
		--moduleUtil.storyboard.gotoScene("Game.InGame.main_story.levelN")
	elseif event.target == allBord[3] then
		for i=0,obsCount do
			if platforms["obs"..i] ~= nil then
				platforms["obs"..i].alpha = 0
			end
		end
		gamepad["left"].alpha = 0
	gamepad["right"].alpha = 0
	gamepad["mid"].alpha = 0
		moduleUtil.storyboard.gotoScene("Game.InGame.main_story.lastPart")
	elseif event.target == allBord[4] then
		transition.to(event.other, {x = display.contentWidth/16,y = display.contentHeight/2.5, time=0})
	end

end
-- End of Function
local function pick(event)
	if event.phase =="began" then
		print(count)
		if event.target == butYes then
			if count == 2 then
				screenGroup:remove(conText)
				screenGroup:remove(conTextYes)
				screenGroup:remove(conTextbutNo)
				conText = moduleUtil.text("1. You bury me when i'm alive, \n and dig me up when i die. What am I?")
				conTextYes = moduleUtil.text("Plant")
				conTextYes.x = btnC1Att["x"]
				conTextYes.y = btnC1Att["y"]
				conTextbutNo = moduleUtil.text("Tree")
				conTextbutNo.x = btnC2Att["x"]
				conTextbutNo.y = btnC2Att["y"]
				screenGroup:insert(conText)
				screenGroup:insert(conTextYes)
				screenGroup:insert(conTextbutNo)
			elseif count == 3 then
				screenGroup:remove(conText)
				conText = moduleUtil.text("You're Correct. Trully you are worthy of my help")
				screenGroup:insert(conText)
				conTextYes.alpha = 0
				conTextbutNo.alpha = 0
				butYes.alpha = 0
				butNo.alpha = 0
				transition.to(conDialogBox,{time=1000,alpha=0})
				transition.to(conText,{time=1000,alpha=0})
				race3.alpha = 0
				race3.isBodyActive = false
				race3:removeEventListener("collision",race3)
				race3:removeSelf()
				race3 = nil
			end
			
		-- Buggy 
		elseif event.target == butNo then
			if count == 2 then
				conDialogBox.alpha = 0
				isColide = false
				conText.alpha = 0
				conTextYes.alpha = 0
				conTextbutNo.alpha = 0
				butYes.alpha = 0
				butNo.alpha = 0
				count = 0
			elseif count == 3 then
				count = 0
				screenGroup:remove(conText)
				conText = moduleUtil.text("You're Wrong. Please try again")
				screenGroup:insert(conText)

				conTextYes.alpha = 0
				conTextbutNo.alpha = 0
				butYes.alpha = 0
				butNo.alpha = 0
			end
			
		end
	end
end
-- Enter Scene
function scene:enterScene(event)
	for i=1,10 do
		print(i)
	end
	for i=0,obsCount do
		if platforms["obs"..i] ~= nil and i ~= 2 and i ~=12 then
			moduleUtil.physics.addBody(platforms["obs"..i],"static",{ bounce=0 })
		end
	end



	moduleUtil.physics.addBody(race3,{bounce=0 })
	moduleUtil.physics.addBody(race2,{bounce=0 })
	for a = 1, table.getn(allBord), 1 do
		moduleUtil.physics.addBody(allBord[a],"static",{friction=50,bounce=0 })
		allBord[a].collision = teleporter           
		allBord[a]:addEventListener( "collision", allBord[a])
	end
	gamepad["left"]:addEventListener("touch", walker)
	gamepad["right"]:addEventListener("touch", walker)
	gamepad["mid"]:addEventListener("touch", walker)
	race3.collision = showDialog
	race3:addEventListener("collision",race3)
	conDialogBox:addEventListener("touch",changeDialog)
	butYes:addEventListener("touch",pick)
	butNo:addEventListener("touch",pick)
end
-- End of Enter Scene


-- Exit Scene
function scene:exitScene(event)

end
-- End of Exit Scene


-- Destroy Scene
function scene:destroyScene(event)


end

-- End of Destroy Scene

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene