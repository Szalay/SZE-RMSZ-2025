%[text] # Laplace-transzformáció
syms t s

f = cos(t);
F = laplace(f, t, s) %[output:96a9735e]

%%
%[text] ## Egyszerű függvények
syms t s
syms omega tau

f = [
	dirac(t);
	heaviside(t);		% Egységugrás
	exp(-t/tau);
	cos(omega*t);
	sin(omega*t)
];

F = laplace(f, t, s);

[f, F] %[output:4fae7002]

%%
%[text] ## Szinuszos jelek
syms R phi A B t omega

expand(R*cos(omega*t + phi)) %[output:922b5eea]

% R cos(w t + q) -> A cos(w t) + B sin(w t)
M = solve( ...
	[R*cos(phi) == A, -R*sin(phi) == B], ...
	[R, phi] ...
	);

M.R %[output:4214049b]
M.phi %[output:49de8126]
% phi = atan(-B/A)
%%
%[text] ## Összetettebb függvények
syms t s
syms omega tau Y_0 K U_0

f = [
	Y_0 * exp(-t/tau);
	K*U_0*(1 - exp(-t/tau));
	A*cos(omega*t) + B*sin(omega*t);
	exp(-t/tau)*cos(omega*t);
	exp(-t/tau)*sin(omega*t);
	exp(-t/tau)*(A*cos(omega*t) + B*sin(omega*t))
];

F = laplace(f, t, s);

for i = 1:length(f) %[output:group:8ff1a17c]
	[f(i), F(i), expand(simplify(F(i)))] %[output:42ef07e0] %[output:5168a2c4] %[output:8a83e638] %[output:46128895] %[output:4ea7531c] %[output:7398e5d9]
end %[output:group:8ff1a17c]

%%
%[text] ## Az ERR válasza szinuszos bemenetre
syms y(t)

ERR = [ ...
	tau*diff(y, t) + y == ...
	K*(A*cos(omega*t) + B*sin(omega*t)), ...
	y(0) == Y_0 ...
];
dsolve(ERR) %[output:4a89d042]


ERR = [ ...
	tau*diff(y, t) + y == ...
	K*R*cos(omega*t + phi), ...
	y(0) == Y_0 ...
];
dsolve(ERR) %[output:60e2fd92]

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":51.7}
%---
%[output:96a9735e]
%   data: {"dataType":"symbolic","outputData":{"name":"F","value":"\\frac{s}{s^2 +1}"}}
%---
%[output:4fae7002]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{cc}\n{\\delta }\\left(t\\right) & 1\\\\\n\\mathrm{heaviside}\\left(t\\right) & \\frac{1}{s}\\\\\n{\\mathrm{e}}^{-\\frac{t}{\\tau }}  & \\frac{1}{s+\\frac{1}{\\tau }}\\\\\n\\cos \\left(\\omega \\,t\\right) & \\frac{s}{\\omega^2 +s^2 }\\\\\n\\sin \\left(\\omega \\,t\\right) & \\frac{\\omega }{\\omega^2 +s^2 }\n\\end{array}\\right)"}}
%---
%[output:922b5eea]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"R\\,\\cos \\left(\\omega \\,t\\right)\\,\\cos \\left(\\phi \\right)-R\\,\\sin \\left(\\omega \\,t\\right)\\,\\sin \\left(\\phi \\right)"}}
%---
%[output:4214049b]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{c}\n\\sqrt{A^2 +B^2 }\\\\\n-\\sqrt{A^2 +B^2 }\n\\end{array}\\right)"}}
%---
%[output:49de8126]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{c}\n2\\,\\mathrm{atan}\\left(\\frac{A-\\sqrt{A^2 +B^2 }}{B}\\right)\\\\\n2\\,\\mathrm{atan}\\left(\\frac{A+\\sqrt{A^2 +B^2 }}{B}\\right)\n\\end{array}\\right)"}}
%---
%[output:42ef07e0]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{ccc}\nY_0 \\,{\\mathrm{e}}^{-\\frac{t}{\\tau }}  & \\frac{Y_0 }{s+\\frac{1}{\\tau }} & \\frac{Y_0 \\,\\tau }{s\\,\\tau +1}\n\\end{array}\\right)"}}
%---
%[output:5168a2c4]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{ccc}\n-K\\,U_0 \\,{\\left({\\mathrm{e}}^{-\\frac{t}{\\tau }} -1\\right)} & -K\\,U_0 \\,{\\left(\\frac{1}{s+\\frac{1}{\\tau }}-\\frac{1}{s}\\right)} & \\frac{K\\,U_0 }{\\tau \\,s^2 +s}\n\\end{array}\\right)"}}
%---
%[output:8a83e638]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{ccc}\nA\\,\\cos \\left(\\omega \\,t\\right)+B\\,\\sin \\left(\\omega \\,t\\right) & \\frac{B\\,\\omega }{\\omega^2 +s^2 }+\\frac{A\\,s}{\\omega^2 +s^2 } & \\frac{B\\,\\omega }{\\omega^2 +s^2 }+\\frac{A\\,s}{\\omega^2 +s^2 }\n\\end{array}\\right)"}}
%---
%[output:46128895]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{ccc}\n{\\mathrm{e}}^{-\\frac{t}{\\tau }} \\,\\cos \\left(\\omega \\,t\\right) & \\frac{s+\\frac{1}{\\tau }}{{{\\left(s+\\frac{1}{\\tau }\\right)}}^2 +\\omega^2 } & \\frac{s}{\\frac{2\\,s}{\\tau }+\\omega^2 +s^2 +\\frac{1}{\\tau^2 }}+\\frac{1}{2\\,s+\\omega^2 \\,\\tau +s^2 \\,\\tau +\\frac{1}{\\tau }}\n\\end{array}\\right)"}}
%---
%[output:4ea7531c]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{ccc}\n{\\mathrm{e}}^{-\\frac{t}{\\tau }} \\,\\sin \\left(\\omega \\,t\\right) & \\frac{\\omega }{{{\\left(s+\\frac{1}{\\tau }\\right)}}^2 +\\omega^2 } & \\frac{\\omega }{\\frac{2\\,s}{\\tau }+\\omega^2 +s^2 +\\frac{1}{\\tau^2 }}\n\\end{array}\\right)"}}
%---
%[output:7398e5d9]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\begin{array}{l}\n\\left(\\begin{array}{ccc}\n{\\mathrm{e}}^{-\\frac{t}{\\tau }} \\,{\\left(A\\,\\cos \\left(\\omega \\,t\\right)+B\\,\\sin \\left(\\omega \\,t\\right)\\right)} & \\frac{B\\,\\omega }{\\sigma_2 }+\\frac{A\\,{\\left(s+\\frac{1}{\\tau }\\right)}}{\\sigma_2 } & \\frac{A}{2\\,s+\\omega^2 \\,\\tau +s^2 \\,\\tau +\\frac{1}{\\tau }}+\\frac{B\\,\\omega }{\\sigma_1 }+\\frac{A\\,s}{\\sigma_1 }\n\\end{array}\\right)\\\\\n\\mathrm{}\\\\\n\\textrm{where}\\\\\n\\mathrm{}\\\\\n\\;\\;\\sigma_1 =\\frac{2\\,s}{\\tau }+\\omega^2 +s^2 +\\frac{1}{\\tau^2 }\\\\\n\\mathrm{}\\\\\n\\;\\;\\sigma_2 ={{\\left(s+\\frac{1}{\\tau }\\right)}}^2 +\\omega^2 \n\\end{array}"}}
%---
%[output:4a89d042]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"{\\mathrm{e}}^{-\\frac{t}{\\tau }} \\,{\\left(Y_0 -\\frac{K\\,{\\left(A-B\\,\\omega \\,\\tau \\right)}}{\\omega^2 \\,\\tau^2 +1}\\right)}+\\frac{K\\,{\\left(A\\,\\cos \\left(\\omega \\,t\\right)+B\\,\\sin \\left(\\omega \\,t\\right)-B\\,\\omega \\,\\tau \\,\\cos \\left(\\omega \\,t\\right)+A\\,\\omega \\,\\tau \\,\\sin \\left(\\omega \\,t\\right)\\right)}}{\\omega^2 \\,\\tau^2 +1}"}}
%---
%[output:60e2fd92]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"{\\mathrm{e}}^{-\\frac{t}{\\tau }} \\,{\\left(Y_0 -\\frac{K\\,R\\,{\\left(\\cos \\left(\\phi \\right)+\\omega \\,\\tau \\,\\sin \\left(\\phi \\right)\\right)}}{\\omega^2 \\,\\tau^2 +1}\\right)}+\\frac{K\\,R\\,{\\left(\\cos \\left(\\phi +\\omega \\,t\\right)+\\omega \\,\\tau \\,\\sin \\left(\\phi +\\omega \\,t\\right)\\right)}}{\\omega^2 \\,\\tau^2 +1}"}}
%---
