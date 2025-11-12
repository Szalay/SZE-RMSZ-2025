try
	zhStage = sldiagviewer.createStage( ...
		"Zárthelyi, Z csoport, 4. feladat", "ModelName", bdroot ...
		);
	
	rootDiagram = get_param(bdroot, 'Handle');
	
	maxStepOK = false;
	startTimeOK = false;
	stopTimeOK = false;
	
	meanOK = false;
	
	% Időzítés
	Dt_max = eval(get_param(bdroot, 'MaxStep'));
	T_start = str2double(get_param(bdroot, 'StartTime'));
	T_stop = str2double(get_param(bdroot, 'StopTime'));
	if Dt_max <= min(560*33e-9, 1/650)/25
		maxStepOK = true;
	end
	if T_start == 0
		startTimeOK = true;
	end
	if T_stop == 20e-3
		stopTimeOK = true;
	end
	
	if maxStepOK && startTimeOK && stopTimeOK
		sldiagviewer.reportInfo('Az időzítési beállítások megfelelőek!');
	end
	
	% Középérték
	meanBlock = getSimulinkBlockHandle([bdroot, '/Középérték']);
	if meanBlock ~= -1
		if isequal(get(meanBlock, 'BlockType'), 'Constant')
			m = str2double(get(meanBlock, 'Value'));
			if 1.99 <= m && m <= 2.01
				sldiagviewer.reportInfo('A középérték elfogadható!');
				meanOK = true;
			end
		end
	end
catch exception
	
end
