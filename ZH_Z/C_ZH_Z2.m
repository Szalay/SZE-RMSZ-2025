try
	zhStage = sldiagviewer.createStage( ...
		"Zárthelyi, Z csoport, 2. feladat", "ModelName", bdroot ...
		);
	
	rootDiagram = get_param(bdroot, 'Handle');
	
	maxStepOK = false;
	startTimeOK = false;
	stopTimeOK = false;
	
	meanOK = false;
	
	% Időzítés
	Dt_max = str2double(get_param(bdroot, 'MaxStep'));
	T_start = str2double(get_param(bdroot, 'StartTime'));
	T_stop = str2double(get_param(bdroot, 'StopTime'));
	if Dt_max == 100e-3
		maxStepOK = true;
	end
	if T_start == 0
		startTimeOK = true;
	end
	if T_stop == 25
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
			if (-20 * exp(-25/2.5)) * 1.05 <= m && m <= 0
				sldiagviewer.reportInfo('A középérték elfogadható!');
				meanOK = true;
			end
		end
	end
catch exception
	
end
