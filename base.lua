function courseplay.prerequisitesPresent(specializations)
	return true;
end



function courseplay:load(xmlFile)
	-- global array for courses, no refreshing needed any more
	if courseplay_courses == nil then
  	  courseplay_courses = {}
  	  courseplay:load_courses(self)
	end
	
	self.locales = {}
	local aNameSearch = {"vehicle.name." .. g_languageShort, "vehicle.name.en", "vehicle.name", "vehicle#type"};
	
	if not steerable_overwritten then	  
	  steerable_overwritten = true
	  if Steerable.load ~= nil then
		local orgSteerableLoad = Steerable.load
		print("overwriting steerable.load")
		Steerable.load = function(self,xmlFile)
		orgSteerableLoad(self,xmlFile)

		for nIndex,sXMLPath in pairs(aNameSearch) do 
		  self.name = getXMLString(xmlFile, sXMLPath);
		  if self.name ~= nil then break; end;
		end;
		if self.name == nil then self.name = g_i18n:getText("UNKNOWN") end;
		end;
	  end;

	  if Attachable.load ~= nil then
		print("overwriting Attachable.load")
		 local orgAttachableLoad = Attachable.load

		 Attachable.load = function(self,xmlFile)
		 orgAttachableLoad(self,xmlFile)

		 for nIndex,sXMLPath in pairs(aNameSearch) do 
		   self.name = getXMLString(xmlFile, sXMLPath);
		   if self.name ~= nil then break; end;
		 end;
		if self.name == nil then self.name = g_i18n:getText("UNKNOWN") end;
		end
	  end;
	
	end
	
	if self.name == nil then
	  for nIndex,sXMLPath in pairs(aNameSearch) do 
	    self.name = getXMLString(xmlFile, sXMLPath);
	    if self.name ~= nil then break; end;
	  end;
	  if self.name == nil then self.name = g_i18n:getText("UNKNOWN") end;
	end
	
	-- dirty workaround for localization - don't try this at home!
	
	self.locales.CPMaxHireables = g_i18n:getText("CPMaxHireables")
	self.locales.CPFollowTractor= g_i18n:getText("CPFollowTractor")
	self.locales.CPWaitForWaypoint= g_i18n:getText("CPWaitForWaypoint")
	self.locales.CPWaitUntilCombineTurned= g_i18n:getText("CPWaitUntilCombineTurned")
	self.locales.CPDriveToWP= g_i18n:getText("CPDriveToWP")
	self.locales.CPTurningTo= g_i18n:getText("CPTurningTo")
	self.locales.CPCombineWantsMeToStop= g_i18n:getText("CPCombineWantsMeToStop")
	self.locales.CPDriveToCombine= g_i18n:getText("CPDriveToCombine")
	self.locales.CPDriveNextCombine= g_i18n:getText("CPDriveNextCombine")
	self.locales.CPDriveBehinCombine= g_i18n:getText("CPDriveBehinCombine")
	self.locales.CPCombineTurning= g_i18n:getText("CPCombineTurning")
	self.locales.CPloading= g_i18n:getText("CPloading")
	self.locales.CPTriggerReached= g_i18n:getText("CPTriggerReached")
	self.locales.CPSteering= g_i18n:getText("CPSteering")
	self.locales.CPManageCourses= g_i18n:getText("CPManageCourses")
	self.locales.CPCourseAdded= g_i18n:getText("CPCourseAdded")
	self.locales.CPCombiSettings= g_i18n:getText("CPCombiSettings")
	self.locales.CPManageCombines= g_i18n:getText("CPManageCombines")
	self.locales.CPSpeedLimit= g_i18n:getText("CPSpeedLimit")	
	self.locales.CPTurnSpeed = g_i18n:getText("CPTurnSpeed")
	self.locales.CPCourse = g_i18n:getText("CPCourse")
	self.locales.CPNoCourseLoaded = g_i18n:getText("CPNoCourseLoaded")
	self.locales.CPWaypoint = g_i18n:getText("CPWaypoint")
	self.locales.CPNoWaypoint = g_i18n:getText("CPNoWaypoint")
	self.locales.CPWorkEnd = g_i18n:getText("CPWorkEnd")
	self.locales.CPFieldSpeed = g_i18n:getText("CPFieldSpeed")
	self.locales.CPMaxSpeed = g_i18n:getText("CPMaxSpeed")	
	self.locales.CPFindAuto = g_i18n:getText("CPFindAuto")
	self.locales.CPFindManual = g_i18n:getText("CPFindManual")
	self.locales.CPActual = g_i18n:getText("CPActual")
	self.locales.CPSelectCombine = g_i18n:getText("CPSelectCombine")
	self.locales.CPCombineSearch = g_i18n:getText("CPCombineSearch")
	self.locales.CPNone = g_i18n:getText("CPNone")
	self.locales.CPPipeOffset = g_i18n:getText("CPPipeOffset")
	self.locales.CPTurnRadius = g_i18n:getText("CPTurnRadius")
	self.locales.CPRequiredFillLevel = g_i18n:getText("CPRequiredFillLevel")
	self.locales.CPCombineOffset = g_i18n:getText("CPCombineOffset")
	self.locales.CPUnloading = g_i18n:getText("CPUnloading")
	self.locales.CPInTraffic = g_i18n:getText("CPInTraffic")
	self.locales.CPReachedOverloadPoint = g_i18n:getText("CPReachedOverloadPoint")
	self.locales.CPReachedWaitPoint = g_i18n:getText("CPReachedWaitPoint")
	self.locales.CPCourseName = g_i18n:getText("CPLoadCourse")
	self.locales.CPCourseName = g_i18n:getText("CPCourseName")
	self.locales.CPDistance = g_i18n:getText("CPDistance")
	self.locales.HudControl = g_i18n:getText("HudControl")
	self.locales.CourseReset = g_i18n:getText("CourseReset")
	self.locales.CoursePlayStart = g_i18n:getText("CoursePlayStart")
	self.locales.CourseWaitpointStart = g_i18n:getText("CourseWaitpointStart")
	self.locales.CoursePlayStop = g_i18n:getText("CoursePlayStop")
	self.locales.NoWaitforfill = g_i18n:getText("NoWaitforfill")
	self.locales.NoWaitforfillAt = g_i18n:getText("NoWaitforfillAt")
	self.locales.PointRecordStart = g_i18n:getText("PointRecordStart")
	self.locales.CourseLoad = g_i18n:getText("CourseLoad")
	self.locales.ModusSet = g_i18n:getText("ModusSet")
	self.locales.PointRecordStop = g_i18n:getText("PointRecordStop")
	self.locales.CourseWaitpointSet = g_i18n:getText("CourseWaitpointSet")
	self.locales.CourseCrossingSet = g_i18n:getText("CourseCrossingSet")
	self.locales.PointRecordInterrupt = g_i18n:getText("PointRecordInterrupt")
	self.locales.PointRecordContinue = g_i18n:getText("PointRecordContinue")
	self.locales.PointRecordDelete = g_i18n:getText("PointRecordDelete")	
	self.locales.CourseDel = g_i18n:getText("CourseDel")
	self.locales.CourseSave = g_i18n:getText("CourseSave")
	self.locales.CourseMode1 = g_i18n:getText("CourseMode1")
	self.locales.CourseMode2 = g_i18n:getText("CourseMode2")
	self.locales.CourseMode3 = g_i18n:getText("CourseMode3")
	self.locales.CourseMode4 = g_i18n:getText("CourseMode4")
	self.locales.CourseMode5 = g_i18n:getText("CourseMode5")
	self.locales.CourseMode6 = g_i18n:getText("CourseMode6")
	self.locales.CPFuelWarning = g_i18n:getText("CPFuelWarning")
    self.locales.CPNoFuelStop = g_i18n:getText("CPNoFuelStop")
	self.locales.CPWrongTrailer = g_i18n:getText("CPWrongTrailer")
    self.locales.CoursePlayCallPlayer = g_i18n:getText("CoursePlayCallPlayer")
    self.locales.CoursePlayCalledPlayer = g_i18n:getText("CoursePlayCalledPlayer")
    self.locales.CoursePlayPlayer = g_i18n:getText("CoursePlayPlayer")
    self.locales.CoursePlayPlayerStart = g_i18n:getText("CoursePlayPlayerStart")
    self.locales.CoursePlayPlayerStop = g_i18n:getText("CoursePlayPlayerStop")
    self.locales.CoursePlayPlayerSwitchSide = g_i18n:getText("CoursePlayPlayerSwitchSide")
    self.locales.CoursePlayPlayerSendHome = g_i18n:getText("CoursePlayPlayerSendHome")
    self.locales.CPCombineMangament = g_i18n:getText("CPCombineMangament")
    self.locales.CPSettings = g_i18n:getText("CPSettings")
    self.locales.CPWpOffsetX = g_i18n:getText("CPWpOffsetX")
    self.locales.CPWpOffsetZ = g_i18n:getText("CPWpOffsetZ")
	self.locales.CPWaterDrive = g_i18n:getText("CPWaterDrive")
	self.locales.WaitPoints = g_i18n:getText("WaitPoints")
	self.locales.CrossPoints = g_i18n:getText("CrossPoints")

	self.lastGui = nil
	self.currentGui = nil
	self.input_gui = "emptyGui";	

	self.recordnumber = 1
	self.tmr = 1
	self.timeout = 1
	self.timer = 0
	self.drive_slow_timer = 0
	self.courseplay_position = nil
	self.waitPoints = 0
	self.crossPoints = 0
	
	-- saves the shortest distance to the next waypoint (for recocnizing circling)
	self.shortest_dist = nil
	
	-- clickable buttons
	self.buttons = {}
	
	-- waypoints are stored in here
	self.Waypoints = {}
	
	-- TODO still needed?
	self.play = false
	-- total number of course players
	self.working_course_player_num = nil
	
	-- info text on tractor
	self.info_text = nil
	
	-- global info text - also displayed when not in vehicle
	self.global_info_text = nil
	self.testhe = false
	
	-- ai mode: 1 abfahrer, 2 kombiniert
	self.ai_mode = 1
	self.follow_mode = 1
	self.ai_state = 1
	self.next_ai_state = nil
	self.startWork = nil
	self.stopWork = nil
	self.abortWork = nil
	self.wait = true
	self.waitTimer = nil
	-- our arrow is displaying dirction to waypoints
	self.ArrowPath = Utils.getFilename("../aacourseplay/img/arrow.png", self.baseDirectory);
	self.ArrowOverlay = Overlay:new("Arrow", self.ArrowPath, 0.4, 0.08, 0.250, 0.250);
	self.ArrowOverlay:render()
	
	-- kegel der route	
	local baseDirectory = getAppBasePath()
	local i3dNode = Utils.loadSharedI3DFile("data/maps/models/objects/beerKeg/beerKeg.i3d", baseDirectory)
	local itemNode = getChildAt(i3dNode, 0)
	link(getRootNode(), itemNode)
	setRigidBodyType(itemNode, "NoRigidBody")
	setTranslation(itemNode, 0, 0, 0)
	setVisibility(itemNode, false)
	delete(i3dNode)
	self.sign = itemNode
	-- visual waypoints saved in this
	self.signs = {}
	
	-- course name for saving
	self.current_course_name = nil
	self.direction = nil
	-- forced waypoints	
	self.target_x = nil
	self.target_y = nil
	self.target_z = nil
	
	self.next_targets = {}
	
	-- speed limits
	self.max_speed_level = nil
	self.max_speed = 50 / 3600
	self.turn_speed = 10 / 3600
	self.field_speed = 24 / 3600
	self.sl = 3
	self.tools_dirty = false
	
	self.orgRpm = nil
	
	-- traffic collision	
	self.onTrafficCollisionTrigger = courseplay.onTrafficCollisionTrigger;
	self.aiTrafficCollisionTrigger = Utils.indexToObject(self.components, getXMLString(xmlFile, "vehicle.aiTrafficCollisionTrigger#index"));
	
	self.numCollidingVehicles = 0;
	self.numToolsCollidingVehicles = {};
	self.trafficCollisionIgnoreList = {};
	for k,v in pairs(self.components) do
	  self.trafficCollisionIgnoreList[v.node] = true;
	end;	
	
	-- tipTrigger
	self.findTipTriggerCallback = courseplay.findTipTriggerCallback;
	
	
	-- tippers
	self.tippers = {}
	self.tipper_attached = false	
	self.currentTrailerToFill = nil
	self.lastTrailerToFillDistance = nil
	self.unloaded = false	
	self.loaded  = false
	self.unloading_tipper = nil
	self.last_fill_level = nil
	
	-- for user input like saving
	self.user_input_active = false
	self.user_input_message = nil
	self.user_input = nil
	self.save_name = false
	
	
	self.selected_course_number = 0
	self.course_Del = false	
	
	-- combines	
	self.reachable_combines = {}
	self.active_combine = nil
	self.combine_offset = 8
	self.chopper_offset = 8
	self.tipper_offset = 8
	self.auto_mode = nil
	self.forced_side = nil
	self.forced_to_stop = false
	
	self.allow_following = false
	self.required_fill_level_for_follow = 50
	self.required_fill_level_for_drive_on = 90
	
	self.turn_factor = nil
	self.turn_radius = 17
	
	self.WpOffsetX = 0
	self.WpOffsetZ = 0
	-- loading saved courses from xml
	
	
	
	self.mouse_enabled = false	

	-- HUD  	-- Function in Signs
	self.hudInfoBasePosX = 0.433; -- 0.755
	self.hudInfoBaseWidth = 0.319; 
	self.hudInfoBasePosY = 0.005;  -- 0.210
	self.hudInfoBaseHeight = 0.287;
	
	self.infoPanelPath = Utils.getFilename("../aacourseplay/img/hud_bg.png", self.baseDirectory);
	self.hudInfoBaseOverlay = Overlay:new("hudInfoBaseOverlay", self.infoPanelPath, self.hudInfoBasePosX, self.hudInfoBasePosY, self.hudInfoBaseWidth, self.hudInfoBaseHeight);
	
	self.min_hud_page = 1
	if courseplay:is_a_combine(self) then
	  self.min_hud_page = 0
	end
	
	self.showHudInfoBase = self.min_hud_page;
	
	self.hudpage = {}	
	self.hudpage[0]  = {}
	self.hudpage[0][1]  = {}
	self.hudpage[0][2]  = {}
	self.hudpage[0][3]  = {}
	self.hudpage[0][4]  = {}
	self.hudpage[1]  = {}
    self.hudpage[1][1]  = {}
    self.hudpage[1][2]  = {}
    self.hudpage[2] = {}
    self.hudpage[2][1]  = {}
    self.hudpage[2][2]  = {}
	self.hudpage[3] = {}
    self.hudpage[3][1]  = {}
    self.hudpage[3][2]  = {}
    self.hudpage[4] = {}
    self.hudpage[4][1]  = {}
    self.hudpage[4][2]  = {}
    self.hudpage[5] = {}
    self.hudpage[5][1]  = {}
    self.hudpage[5][2]  = {}
    self.hudpage[6] = {}
	self.hudpage[6][1]  = {}
    self.hudpage[6][2]  = {}
    self.hudinfo = {}
    
    self.show_hud = false
    
    self.search_combine = true
    self.saved_combine  = nil
    self.selected_combine_number = 0
    
    -- buttons for hud    
    courseplay:register_button(self, nil, "navigate_left.png", "switch_hud_page", -1, self.hudInfoBasePosX + 0.035, self.hudInfoBasePosY + 0.242, 0.020, 0.020)
    courseplay:register_button(self, nil, "navigate_right.png", "switch_hud_page", 1, self.hudInfoBasePosX + 0.280, self.hudInfoBasePosY + 0.242, 0.020, 0.020)
    
    courseplay:register_button(self, nil, "delete.png", "close_hud", 1, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY + 0.255, 0.016, 0.016)
    
    courseplay:register_button(self, nil, "disk_blue.png", "save_course", 1, self.hudInfoBasePosX + 0.280, self.hudInfoBasePosY + 0.050, 0.016, 0.016)
    
    courseplay:register_button(self, 0, "blank.png", "row1", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.207, 0.32, 0.015)
    courseplay:register_button(self, 0, "blank.png", "row2", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.185, 0.32, 0.015)
    courseplay:register_button(self, 0, "blank.png", "row3", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.164, 0.32, 0.015)
    courseplay:register_button(self, 0, "blank.png", "row4", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.143, 0.32, 0.015)
    
    courseplay:register_button(self, 1, "blank.png", "row1", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.207, 0.32, 0.015)
    courseplay:register_button(self, 1, "blank.png", "row2", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.185, 0.32, 0.015)
    courseplay:register_button(self, 1, "blank.png", "row3", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.164, 0.32, 0.015)
    courseplay:register_button(self, 1, "blank.png", "row4", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.143, 0.32, 0.015)
    
    courseplay:register_button(self, 2, "blank.png", "row1", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.207, 0.32, 0.015)
    courseplay:register_button(self, 2, "blank.png", "row2", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.185, 0.32, 0.015)
    courseplay:register_button(self, 2, "blank.png", "row3", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.164, 0.32, 0.015)
    
    
    -- courseplay:register_button(self, 2, "refresh.png",   "refresh_courses", nil, self.hudInfoBasePosX + 0.247, self.hudInfoBasePosY +0.235, 0.020, 0.020)
    courseplay:register_button(self, 2, "navigate_up.png",   "change_selected_course", -5, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY +0.222, 0.020, 0.020)
    courseplay:register_button(self, 2, "navigate_down.png", "change_selected_course", 5, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY +0.120, 0.020, 0.020)
    
    for i = 1, 5, 1 do    
      local posy = self.hudInfoBasePosY + 0.205 - (i-1) * 0.021
      courseplay:register_button(self, -2, "folder.png",   "load_course", i, self.hudInfoBasePosX + 0.235, posy, 0.014, 0.014, i)
      courseplay:register_button(self, -2, "delete.png",   "clear_course", i, self.hudInfoBasePosX + 0.258, posy, 0.014, 0.014, i)
    end
    
    courseplay:register_button(self, 3, "navigate_minus.png", "change_combine_offset", -0.1, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY + 0.210, 0.010, 0.010)
    courseplay:register_button(self, 3, "navigate_plus.png", "change_combine_offset", 0.1, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.210, 0.010, 0.010)
    
    courseplay:register_button(self, 3, "navigate_minus.png", "change_required_fill_level", -5, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY +0.188, 0.010, 0.010)
    courseplay:register_button(self, 3, "navigate_plus.png", "change_required_fill_level", 5, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.188, 0.010, 0.010)
    
    courseplay:register_button(self, 3, "navigate_minus.png", "change_turn_radius", -1, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY +0.167, 0.010, 0.010)
    courseplay:register_button(self, 3, "navigate_plus.png", "change_turn_radius", 1, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.167, 0.010, 0.010)
    
    courseplay:register_button(self, 3, "navigate_minus.png", "change_tipper_offset", -0.5, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY + 0.146, 0.010, 0.010)
    courseplay:register_button(self, 3, "navigate_plus.png", "change_tipper_offset", 0.5, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.146, 0.010, 0.010)
    
    courseplay:register_button(self, 3, "navigate_minus.png", "change_required_fill_level_for_drive_on", -5, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY + 0.123, 0.010, 0.010)
    courseplay:register_button(self, 3, "navigate_plus.png", "change_required_fill_level_for_drive_on", 5, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.123, 0.010, 0.010)
    
    courseplay:register_button(self, 4, "navigate_up.png", "switch_combine", -1, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY +0.210, 0.010, 0.010)
    courseplay:register_button(self, 4, "navigate_down.png", "switch_combine", 1, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.210, 0.010, 0.010)
	
    courseplay:register_button(self, 4, "navigate_minus.png", "change_num_ai_helpers", -1, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY + 0.146, 0.010, 0.010)
    courseplay:register_button(self, 4, "navigate_plus.png", "change_num_ai_helpers", 1, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.146, 0.010, 0.010)
        
    courseplay:register_button(self, 4, "blank.png", "switch_search_combine", nil, self.hudInfoBasePosX-0.05, self.hudInfoBasePosY + 0.185, 0.32, 0.015)
    
    courseplay:register_button(self, 5, "navigate_minus.png", "change_turn_speed", -1, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY +0.210, 0.010, 0.010)
    courseplay:register_button(self, 5, "navigate_plus.png", "change_turn_speed", 1, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.210, 0.010, 0.010)
    
    courseplay:register_button(self, 5, "navigate_minus.png", "change_field_speed", -1, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY +0.188, 0.010, 0.010)
    courseplay:register_button(self, 5, "navigate_plus.png", "change_field_speed", 1, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.188, 0.010, 0.010)
    
    courseplay:register_button(self, 5, "navigate_minus.png", "change_max_speed", -1, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY +0.167, 0.010, 0.010)
    courseplay:register_button(self, 5, "navigate_plus.png", "change_max_speed", 1, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.167, 0.010, 0.010)
    
    courseplay:register_button(self, 6, "navigate_minus.png", "changeWpOffsetX", -0.5, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY + 0.210, 0.010, 0.010)
    courseplay:register_button(self, 6, "navigate_plus.png", "changeWpOffsetX", 0.5, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.210, 0.010, 0.010)
    
    courseplay:register_button(self, 6, "navigate_minus.png", "changeWpOffsetZ", -0.5, self.hudInfoBasePosX + 0.285, self.hudInfoBasePosY + 0.188, 0.010, 0.010)
    courseplay:register_button(self, 6, "navigate_plus.png", "changeWpOffsetZ", 0.5, self.hudInfoBasePosX + 0.300, self.hudInfoBasePosY +0.188, 0.010, 0.010)

    self.fold_move_direction = 1
end	


function courseplay:onLeave()
  if self.mouse_enabled then
    InputBinding.setShowMouseCursor(false);
  end
end

function courseplay:onEnter()
	if self.mouse_enabled then
    	InputBinding.setShowMouseCursor(true);
  	end
end

-- displays help text, user_input 	
function courseplay:draw()
	courseplay:loadHud(self)
		
	if self.dcheck and table.getn(self.Waypoints) > 1 then
	  courseplay:dcheck(self);
	end
	
	if self.mouse_enabled then 
	  InputBinding.setShowMouseCursor(self.mouse_enabled)
	end

    courseplay:showHud(self)
 
end

-- is been called everey frame
function courseplay:update(dt)
	--attached or detached implement?
	if self.tools_dirty then
	  courseplay:reset_tools(self)
	end
	
	--if self.user_input_active == true then
	--  if self.currentGui == nil then
	--    g_gui:loadGui(Utils.getFilename("../aacourseplay/emptyGui.xml", self.baseDirectory), self.input_gui);
	--    g_gui:showGui(self.input_gui);
	--    self.currentGui = self.input_gui
	--  end
    --else
    --  if self.currentGui == self.input_gui then
    --    g_gui:showGui("");
    --  end
    --end
    
    if self.user_input_message then
      courseplay:user_input(self);
    end

	-- show visual waypoints only when in vehicle
	if self.isEntered then
		courseplay:sign_visibility(self, true)
	else
		courseplay:sign_visibility(self, false)
	end
	
	-- we are in record mode
	if self.record then 
		courseplay:record(self);
	end
		
	-- we are in drive mode
	if self.drive then
		courseplay:drive(self, dt);
	end	
	
	courseplay:infotext(self);
	self.timer = self.timer + 1
	

end		

function courseplay:delete()
	if self.aiTrafficCollisionTrigger ~= nil then
		removeTrigger(self.aiTrafficCollisionTrigger);
	end	
end;	

function courseplay:set_timeout(self, interval)
  self.timeout = self.timer + interval
end


function courseplay:get_locale(self, key)
  return self.locales[key]
end


function courseplay:loadFromAttributesAndNodes(xmlFile, key, resetVehicles)
	if not resetVehicles then
		self.max_speed = Utils.getNoNil(getXMLFloat(xmlFile,key..string.format("#max_speed")),50 / 3600);
		self.turn_speed = Utils.getNoNil(getXMLFloat(xmlFile,key..string.format("#turn_speed")),10 / 3600);
		self.field_speed = Utils.getNoNil(getXMLFloat(xmlFile,key..string.format("#field_speed")),24 / 3600);
		self.tipper_offset = Utils.getNoNil(getXMLFloat(xmlFile,key..string.format("#tipper_off")),8);
		self.combine_offset = Utils.getNoNil(getXMLFloat(xmlFile,key..string.format("#combine_off")),8);
		self.required_fill_level_for_follow = Utils.getNoNil(getXMLInt(xmlFile,key..string.format("#fill_follow")),50);
		self.required_fill_level_for_drive_on = Utils.getNoNil(getXMLInt(xmlFile,key..string.format("#fill_drive")),90);
		self.WpOffsetX = Utils.getNoNil(getXMLFloat(xmlFile,key..string.format("#OffsetX")),0);
		self.WpOffsetZ = Utils.getNoNil(getXMLFloat(xmlFile,key..string.format("#OffsetZ")),0);
		self.turn_radius = Utils.getNoNil(getXMLInt(xmlFile,key..string.format("#turn")),17);
		self.current_course_name = Utils.getNoNil(getXMLString(xmlFile,key..string.format("#CourseName")),self.locales.CPNoCourseLoaded);
		if self.current_course_name == "nil" then
			self.current_course_name = nil
		end	
		self.ai_mode = Utils.getNoNil(getXMLInt(xmlFile,key..string.format("#ai_mode")),1);
  	end
	return BaseMission.VEHICLE_LOAD_OK;
end


function courseplay:getSaveAttributesAndNodes(nodeIdent)

        local attributes =
		' max_speed="'..tostring(self.max_speed)..'"'..
		' turn_speed="'..tostring(self.turn_speed)..'"'..
        ' field_speed="'..tostring(self.field_speed)..'"'..
        ' tipper_off="'..tostring(self.tipper_offset)..'"'..
        ' combine_off="'..tostring(self.combine_offset)..'"'..
        ' fill_follow="'..tostring(self.required_fill_level_for_follow)..'"'..
        ' fill_drive="'..tostring(self.required_fill_level_for_drive_on)..'"'..
        ' OffsetX="'..tostring(self.WpOffsetX)..'"'..
        ' OffsetZ="'..tostring(self.WpOffsetZ)..'"'..
        ' turn="'..tostring(self.turn_radius)..'"'..
        ' CourseName="'..tostring(self.current_course_name)..'"'..
		' ai_mode="'..tostring(self.ai_mode)..'"';
    return attributes, nil;
end
