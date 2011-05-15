-- records waypoints for course
function courseplay:record(self)
	local cx,cy,cz = getWorldTranslation(self.rootNode);
	local x,y,z = localDirectionToWorld(self.rootNode, 0, 0, 1);
	local length = Utils.vector2Length(x,z);
	local dX = x/length
	local dZ = z/length
	local newangle = math.deg(math.atan2(dX,dZ))
	local fwd = self.direction


	if self.recordnumber < 2 then
		self.rotatedTime = 0
	end
	
	if self.recordnumber > 2 then
		local oldcx ,oldcz ,oldangle= self.Waypoints[self.recordnumber - 1].cx,self.Waypoints[self.recordnumber - 1].cz,self.Waypoints[self.recordnumber - 1].angle
		anglediff = math.abs(newangle - oldangle)
		self.dist = courseplay:distance(cx ,cz ,oldcx ,oldcz)
		if self.direction then
		 	if self.dist > 1 and (anglediff > 2 or dist > 5)  then
				self.tmr = 101
			end
		else
			if self.dist > 5 and (anglediff > 5 or dist > 10) then
				self.tmr = 101
			end
		end
	end 

	if self.recordnumber == 2 then
		local oldcx ,oldcz = self.Waypoints[1].cx,self.Waypoints[1].cz

		self.dist = courseplay:distance(cx ,cz ,oldcx ,oldcz)
		if self.dist > 10 then
			self.tmr = 101
		else
		   self.tmr = 1
		end
	end	
	
	if self.recordnumber == 3 then
		local oldcx ,oldcz = self.Waypoints[2].cx,self.Waypoints[2].cz

		self.dist = courseplay:distance(cx ,cz ,oldcx ,oldcz)
		if self.dist > 20 then
			self.tmr = 101
		else
			self.tmr = 1
		end
	end
	 
	if self.tmr > 100 then 
		self.Waypoints[self.recordnumber] = {cx = cx ,cz = cz ,angle = newangle, wait = false, rev = self.direction}
		if self.recordnumber < 4 then
			courseplay:addsign(self, cx, cy,cz)
		end
		self.tmr = 1
		self.recordnumber = self.recordnumber + 1
	end
end;


function courseplay:set_waitpoint(self)
	local cx,cy,cz = getWorldTranslation(self.rootNode);
	local x,y,z = localDirectionToWorld(self.rootNode, 0, 0, 1);
	local length = Utils.vector2Length(x,z);
	local dX = x/length
	local dZ = z/length
	local newangle = math.deg(math.atan2(dX,dZ)) 
  self.Waypoints[self.recordnumber] = {cx = cx ,cz = cz ,angle = newangle, wait = true, rev = self.direction}
  self.tmr = 1
  self.recordnumber = self.recordnumber + 1
  self.waitPoints = self.waitPoints + 1
  courseplay:addsign(self, cx, cy,cz)  
end

-- set Waypoint before change direction
function courseplay:set_direction(self)
	local cx,cy,cz = getWorldTranslation(self.rootNode);
	local x,y,z = localDirectionToWorld(self.rootNode, 0, 0, 1);
	local length = Utils.vector2Length(x,z);
	local dX = x/length
	local dZ = z/length
	local newangle = math.deg(math.atan2(dX,dZ))
	local fwd = nil
  	self.Waypoints[self.recordnumber] = {cx = cx ,cz = cz ,angle = newangle, wait = false, rev = self.direction}
	self.direction = not self.direction
  	self.tmr = 1
  	self.recordnumber = self.recordnumber + 1
  	courseplay:addsign(self, cx, cy,cz)
end
-- starts course recording -- just setting variables
function courseplay:start_record(self)
    courseplay:reset_course(self)
	
	self.record = true
	self.drive  = false

	self.recordnumber = 1
	self.waitPoints = 0
	self.tmr = 101
	self.direction = false
end		

-- stops course recording -- just setting variables
function courseplay:stop_record(self)
	self.record = false
	self.record_pause = false
	self.drive  = false	
	self.dcheck = false
	self.play = true
	self.maxnumber = self.recordnumber - 1
	self.recordnumber = 1
	self.back = false
end		

-- interrupts course recording -- just setting variables
function courseplay:interrupt_record(self)
	if self.recordnumber > 3 then
		self.record_pause = true
		self.record = false
        courseplay:sign_visibility(self, false)
		self.dcheck = true
		-- Show last 2 waypoints, in order to find position for continue
		local cx ,cz = self.Waypoints[self.recordnumber - 1].cx, self.Waypoints[self.recordnumber - 1].cz
		courseplay:addsign(self, cx, 0, cz)
		cx ,cz = self.Waypoints[self.recordnumber - 2].cx, self.Waypoints[self.recordnumber - 2].cz
		courseplay:addsign(self, cx, 0, cz)
	end	
end

-- continues course recording -- just setting variables
function courseplay:continue_record(self)
	self.record_pause = false
	self.record = true

	self.dcheck = false
	courseplay:sign_visibility(self, false)
	self.signs = {}
	for k,wp in pairs(self.Waypoints) do
  	  if k <= 3 or wp.wait == true then
  		courseplay:addsign(self, wp.cx, 0, wp.cz)
  	  end
   	end
end	

-- delete last waypoint
function courseplay:delete_waypoint(self)
	if self.recordnumber > 3 then
		self.recordnumber = self.recordnumber - 1
		self.tmr = 1
		--table.remove(self.signs,table.getn(self.signs))
		courseplay:sign_visibility(self, false)
		self.signs = {}
		for k,wp in pairs(self.Waypoints) do
  	  		if k <= 3 or wp.wait == true then
  				courseplay:addsign(self, wp.cx, 0, wp.cz)
  	 		end
   		end
		if 	self.Waypoints[self.recordnumber].wait then
				self.waitPoints = self.waitPoints - 1
		end	
		self.Waypoints[self.recordnumber] = nil
		-- Show last 2 waypoints, in order to find position for continue
		local cx ,cz = self.Waypoints[self.recordnumber - 1].cx, self.Waypoints[self.recordnumber - 1].cz
		courseplay:addsign(self, cx, 0, cz)
		cx ,cz = self.Waypoints[self.recordnumber - 2].cx, self.Waypoints[self.recordnumber - 2].cz
		courseplay:addsign(self, cx, 0, cz)
	end	
end

-- resets actual course -- just setting variables
function courseplay:reset_course(self)	
	self.recordnumber = 1
	self.target_x, self.target_y, self.target_z = nil, nil, nil
	if self.active_combine ~= nil then
	  courseplay:unregister_at_combine(self, self.active_combine)
	end
	self.next_targets = {}
	self.current_course_name = nil
--self.ai_mode = 1
	self.ai_state = 1
	self.tmr = 1
	self.Waypoints = {}
	courseplay:sign_visibility(self, false)
	self.signs = {}
	self.play = false
	self.back = false
	self.abortWork = nil
	self.waitPoints =  0
end	