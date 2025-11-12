try
	zhStage = sldiagviewer.createStage( ...
		"Zárthelyi, Z csoport, 3. feladat", "ModelName", bdroot ...
		);
	
	rootDiagram = get_param(bdroot, 'Handle');
	
	maxStepOK = false;
	startTimeOK = false;
	stopTimeOK = false;
	
	amplitudeOK = false;
	
	% Időzítés
	Dt_max = str2double(get_param(bdroot, 'MaxStep'));
	T_start = str2double(get_param(bdroot, 'StartTime'));
	T_stop = str2double(get_param(bdroot, 'StopTime'));
	if Dt_max <= min(0.1/0.5, 1/10)/25
		maxStepOK = true;
	end
	if T_start == 0
		startTimeOK = true;
	end
	if T_stop == 2
		stopTimeOK = true;
	end
	
	if maxStepOK && startTimeOK && stopTimeOK
		sldiagviewer.reportInfo('Az időzítési beállítások megfelelőek!');
	end
	
	% A kvázistacioner megoldás amplitúdója
	amplitudeBlock = getSimulinkBlockHandle([bdroot, '/A_S(phi(t)) (°)']);
	if amplitudeBlock ~= -1
		if isequal(get(amplitudeBlock, 'BlockType'), 'Constant')
			A_S_phi = str2double(get(amplitudeBlock, 'Value'));
			if 108.5 <= A_S_phi && A_S_phi <= 109.5
				sldiagviewer.reportInfo( ...
					'A kvázistacioner megoldás amplitúdója elfogadható!' ...
					);
				amplitudeOK = true;
			end
		end
	end
catch exception
	
end
