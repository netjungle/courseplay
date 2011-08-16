function courseplay:handle_mode4(self,allowedToDrive, workArea, workSpeed,  fill_level, last_recordnumber)
	local workTool = self.tippers[1] -- to do, quick, dirty and unsafe
    local IsFoldable = SpecializationUtil.hasSpecialization(Foldable, workTool.specializations)

		workArea = (self.recordnumber > self.startWork) and (self.recordnumber < self.stopWork)
		-- Beginn Work
		if last_recordnumber == self.startWork and fill_level ~= 0 then
			if self.abortWork ~= nil then
				self.recordnumber = self.abortWork - 2
			end
		end
		-- last point reached restart
		if self.abortWork ~= nil then
			if (last_recordnumber == self.abortWork - 2 )and fill_level ~= 0 then
			self.abortWork = nil
			end
		end
		-- safe last point
		if fill_level == 0 and workArea and self.abortWork == nil then
			self.abortWork = self.recordnumber
			self.recordnumber = self.stopWork - 4
		--	print(string.format("Abort: %d StopWork: %d",self.abortWork,self.stopWork))
        end



		-- stop while folding	

		if IsFoldable then
		  for k,foldingPart in pairs(workTool.foldingParts) do
		  	local charSet = foldingPart.animCharSet;
		  	local animTime = nil
		  	 if charSet ~= 0 then
		  	   animTime = getAnimTrackTime(charSet, 0);
		  	 else
		  	   animTime = workTool:getRealAnimationTime(foldingPart.animationName);
		  	 end;

		  	 if animTime ~= nil then
		  	   if workTool.foldMoveDirection > 0.1 then
		  	     if animTime < foldingPart.animDuration then
		  	        allowedToDrive = false;
		  	     end
		  	   else
		  	 	  if animTime > 0 then
		  	 	    allowedToDrive = false;
		  	 	  end
		  	   end
		  	 end

		  end		  
		end

		local is_ux5200 = workTool.state ~= nil and workTool.state.isTurnedOn ~= nil
		
		if workArea and fill_level ~= 0 and self.abortWork == nil then
		  workSpeed = true	  
		  if is_ux5200 then		    
		    if workTool.state.isTurnedOn ~= true then
		  	  workTool:setIsTurnedOn(true,false)
		  	  workTool:setStateEvent("state", "markOn", true)
		  	  
		  	  workTool:setStateEvent("Speed", "ex", 1.0)
		  	  workTool:setStateEvent("Speed", "trsp", 1.0)
		  	  workTool:setStateEvent("Go", "trsp", true)
		  	  workTool:setStateEvent("Go", "hubmast", false)
		  	  workTool:setStateEvent("Done", "hubmast", true)
		  	  workTool:setStateEvent("Go", "hubmast", false)
		  	  workTool:setStateEvent("Go", "ex", true)
		  	  workTool:setStateEvent("Done", "ex", true)
		  	end
		  else
			  if IsFoldable then
			    workTool:setFoldDirection(self.fold_move_direction*-1)		  
			  end
			  if allowedToDrive then
			    workTool:setIsTurnedOn(true,false)
			  end
		  end
        else
         workSpeed = false
         if is_ux5200 then
		   if workTool.state.isTurnedOn ~= false then
		     workTool:setStateEvent("Done", "ex", true)
		     workTool:setStateEvent("Go", "ex", false)
		     workTool:setStateEvent("Done", "hubmast", true)
		     workTool:setStateEvent("Go", "hubmast", false)
		     workTool:setStateEvent("Go", "trsp", false)
		     workTool:setStateEvent("Speed", "trsp", 1.0)
		     workTool:setStateEvent("Speed", "ex", 1.0)
		     workTool:setStateEvent("state", "markOn", false)		     
		     workTool:setIsTurnedOn(false,false)
		   end
         else
	         if IsFoldable then
	           workTool:setFoldDirection(self.fold_move_direction)
			 end
	         workTool:setIsTurnedOn(false,false)
	     end
       end 
       
       if not allowedToDrive then
       	 workTool:setIsTurnedOn(false,false)
       end       

	return allowedToDrive, workArea, workSpeed
end