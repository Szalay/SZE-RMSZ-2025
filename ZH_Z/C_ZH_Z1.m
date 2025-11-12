try
	zhStage = sldiagviewer.createStage( ...
		"Zárthelyi, Z csoport, 1. feladat", "ModelName", bdroot ...
		);
	
	sinOK = false;
	amplitudeOK = false;
	sumOK = false;
	gainOK = false;
	connectionOK = false;
	initialValueOK = false;
	
	sinBlock = getSimulinkBlockHandle([bdroot, '/sin']);
	if sinBlock ~= -1
		if isequal(get(sinBlock, 'BlockType'), 'Trigonometry')
			if isequal(get(sinBlock, 'Operator'), 'sin')
				sldiagviewer.reportInfo('A szinusz függvény javítva!');
				sinOK = true;
			end
		end
	end
	
	amplitudeBlock = getSimulinkBlockHandle([bdroot, '/A']);
	if amplitudeBlock ~= -1
		if isequal(get(amplitudeBlock, 'BlockType'), 'Gain')
			if str2double(get(amplitudeBlock, 'Gain')) == 2
				sldiagviewer.reportInfo('Az amplitúdó szorzó blokk javítva!');
				amplitudeOK = true;
			end
		end
	end
	
	sumBlock = getSimulinkBlockHandle([bdroot, '/Elsőrendű rendszer/Sum']);
	if sumBlock ~= -1
		if isequal(get(sumBlock, 'BlockType'), 'Sum')
			if isequal(get(sumBlock, 'Inputs'), '|+-')
				sldiagviewer.reportInfo('Az összegző blokk javítva!');
				sumOK = true;
			end
		end
	end
	
	gainBlock = getSimulinkBlockHandle( ...
		[bdroot, sprintf('/Elsőrendű rendszer/Állandósult \nállapoti \nerősítés')] ...
		);
	if gainBlock ~= -1
		if isequal(get(gainBlock, 'BlockType'), 'Gain')
			if isequal(get(gainBlock, 'Gain'), 'K')
				sldiagviewer.reportInfo('Az állandósult állapoti erősítés javítva!');
				gainOK = true;
			end
		end
	end
	
	inputBlock = getSimulinkBlockHandle([bdroot, '/Elsőrendű rendszer/u']);
	if inputBlock ~= -1
		if isequal(get(inputBlock, 'BlockType'), 'Inport')
			pc = get(gainBlock, 'PortConnectivity');
			if inputBlock == pc(1).SrcBlock
				sldiagviewer.reportInfo('Az u és a K közötti összeköttetés javítva!');
				connectionOK = true;
			end 
		end
	end
	
	integratorBlock = getSimulinkBlockHandle([bdroot, '/Elsőrendű rendszer/Kimenet']);
	if integratorBlock ~= -1
		if isequal(get(integratorBlock, 'BlockType'), 'Integrator')
			if isequal(get(integratorBlock, 'InitialConditionSource'), 'internal')
				if isequal(get(integratorBlock, 'InitialCondition'), 'y_0')
					sldiagviewer.reportInfo('A kezdeti érték javítva!');
					initialValueOK = true;
				end
			end
		end
	end
	
	flags = [sinOK, amplitudeOK, sumOK, gainOK, connectionOK, initialValueOK];
	
	if ~any(flags)
		sldiagviewer.reportError("Úgy tűnik, egy hiba sem lett még javítva!");
	else
		sldiagviewer.reportInfo(newline);
		sldiagviewer.reportInfo("A várható eredmény: " + sum(flags) + " pont.");
	end
catch exception
	
end
