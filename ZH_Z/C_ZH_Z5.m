try
	zhStage = sldiagviewer.createStage( ...
		"Zárthelyi, Z csoport, 5. feladat", "ModelName", bdroot ...
		);
	
	rootDiagram = get_param(bdroot, 'Handle');
	
	maxStepOK = false;
	startTimeOK = false;
	stopTimeOK = false;
	
	meanOK = false;
	
	% Paraméterek
	R = 2;
	L = 500e-6;
	tau = 25e-6;
	t_H = 5e-3;
	
	C = tau^2/L;
	
	% 2 xi tau = R C = R tau^2/L
	xi = R*tau/(2*L);
	
	% Időzítés
	Dt_max = eval(get_param(bdroot, 'MaxStep'));
	T_start = str2double(get_param(bdroot, 'StartTime'));
	T_stop = str2double(get_param(bdroot, 'StopTime'));
	if Dt_max <= min(tau, 1/20000)/25
		maxStepOK = true;
	end
	if T_start == 0
		startTimeOK = true;
	end
	if 8e-3 <= T_stop && T_stop <= 20e-3
		stopTimeOK = true;
	end
	
	if maxStepOK && startTimeOK && stopTimeOK
		sldiagviewer.reportInfo('Az időzítési beállítások megfelelőek!');
	end
catch exception
	
end
