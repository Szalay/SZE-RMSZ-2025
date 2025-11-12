classdef ZHZ < handle
	
	methods (Static)
		
		function ProtectEvaluators(list)
			if nargin == 0 || isempty(list)
				list = 1:5;
			end
			
			if any(ismember(list, 1))
				delete('E_ZH_Z1.slxp');
				
				pmCallback = Simulink.ProtectedModel.Callback( ...
					'PreAccess', 'SIM', 'C_ZH_Z1.m' ...
					);
				
				Simulink.ModelReference.protect('E_ZH_Z1', 'Callbacks', {pmCallback});
			end
			
			if any(ismember(list, 2))
				delete('E_ZH_Z2.slxp');
				
				pmCallback = Simulink.ProtectedModel.Callback( ...
					'PreAccess', 'SIM', 'C_ZH_Z2.m' ...
					);
				
				Simulink.ModelReference.protect('E_ZH_Z2', 'Callbacks', {pmCallback});
			end
			
			if any(ismember(list, 3))
				delete('E_ZH_Z3.slxp');
				
				pmCallback = Simulink.ProtectedModel.Callback( ...
					'PreAccess', 'SIM', 'C_ZH_Z3.m' ...
					);
				
				Simulink.ModelReference.protect('E_ZH_Z3', 'Callbacks', {pmCallback});
			end
			
			if any(ismember(list, 4))
				delete('E_ZH_Z4.slxp');
				
				pmCallback = Simulink.ProtectedModel.Callback( ...
					'PreAccess', 'SIM', 'C_ZH_Z4.m' ...
					);
				
				Simulink.ModelReference.protect('E_ZH_Z4', 'Callbacks', {pmCallback});
			end
			
			if any(ismember(list, 5))
				delete('E_ZH_Z5.slxp');
				
				pmCallback = Simulink.ProtectedModel.Callback( ...
					'PreAccess', 'SIM', 'C_ZH_Z5.m' ...
					);
				
				Simulink.ModelReference.protect('E_ZH_Z5', 'Callbacks', {pmCallback});
			end
		end
		
		function s = ReadSourceCode(file, fromLine, toLine)
			sourceCode = readlines(file);
			
			s = strjoin(strtrim(sourceCode(fromLine:toLine)), newline);
		end
		
	end
	
end