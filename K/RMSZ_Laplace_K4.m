%[text] # Laplace-transzformáció
syms t s

f = cos(t);
F = laplace(f, t, s) %[output:923af893]

%%
%[text] ## Egyszerű függvények
syms t s
syms tau omega

f = [
	dirac(t);
	heaviside(t);		% Egységugrás
	exp(-t/tau);		% e^(-t/tau)
	cos(omega*t);
	sin(omega*t)
];

F = laplace(f, t, s);

[f, F] %[output:079356b3]

%%
%[text] ## Összetettebb függvények
syms t s
syms tau Y_0 K U_0

f = [
	Y_0 * exp(-t/tau);
	K*U_0*(1 - exp(-t/tau));
	A*cos(omega*t) + B*sin(omega*t);
	exp(-t/tau)*cos(omega*t);
	exp(-t/tau)*sin(omega*t);
	exp(-t/tau)*(A*cos(omega*t) + B*sin(omega*t))
];

F = laplace(f, t, s);

for i = 1:length(f) %[output:group:0f7a6d55]
	[f(i), F(i), simplify(F(i))] %[output:4cee9e6c] %[output:114f4a36] %[output:576390e8] %[output:8483d6e2] %[output:0e8a306e] %[output:6bdac118]
end %[output:group:0f7a6d55]

%%
%[text] ## Szinuszos jelek
syms t A B R phi omega

% A fázisban eltolt szinuszos jel szétbontható 
% koszinusz és szinusz lineáris kombinációjára
expand(R*cos(omega*t + phi)) %[output:5564366d]

syms a b c
expand(a*(b+c)) %[output:47bb0172]

M = factor(a*b + a*c);
M(1)*M(2) %[output:0781a2b5]

assume(R > 0);
M = solve([R*cos(phi) == A, -R*sin(phi) == B], [R, phi]); %[output:22769b87]
M.R %[output:5d15a32f]
M.phi %[output:881edc1f]

%%
%[text] ## Az ERR válasza szinuszos bemenetre
syms y(t)

ERR = [
	tau*diff(y, t) + y == K*(A*cos(omega*t) + B*sin(omega*t)),
	y(0) == Y_0
];
dsolve(ERR) %[output:307d59ec]

ERR = [
	tau*diff(y, t) + y == K*R*cos(omega*t + phi), 
	y(0) == Y_0
];
dsolve(ERR) %[output:6d1b770c]


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":57.5}
%---
%[output:923af893]
%   data: {"dataType":"symbolic","outputData":{"name":"F","value":"\\frac{s}{s^2 +1}"}}
%---
%[output:079356b3]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{cc}\n{\\delta }\\left(t\\right) & 1\\\\\n\\mathrm{heaviside}\\left(t\\right) & \\frac{1}{s}\\\\\n{\\mathrm{e}}^{-\\frac{t}{\\tau }}  & \\frac{1}{s+\\frac{1}{\\tau }}\\\\\n\\cos \\left(\\omega \\,t\\right) & \\frac{s}{\\omega^2 +s^2 }\\\\\n\\sin \\left(\\omega \\,t\\right) & \\frac{\\omega }{\\omega^2 +s^2 }\n\\end{array}\\right)"}}
%---
%[output:4cee9e6c]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{ccc}\nY_0 \\,{\\mathrm{e}}^{-\\frac{t}{\\tau }}  & \\frac{Y_0 }{s+\\frac{1}{\\tau }} & \\frac{Y_0 \\,\\tau }{s\\,\\tau +1}\n\\end{array}\\right)"}}
%---
%[output:114f4a36]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{ccc}\n-K\\,U_0 \\,{\\left({\\mathrm{e}}^{-\\frac{t}{\\tau }} -1\\right)} & -K\\,U_0 \\,{\\left(\\frac{1}{s+\\frac{1}{\\tau }}-\\frac{1}{s}\\right)} & \\frac{K\\,U_0 }{\\tau \\,s^2 +s}\n\\end{array}\\right)"}}
%---
%[output:576390e8]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{ccc}\nA\\,\\cos \\left(\\omega \\,t\\right)+B\\,\\sin \\left(\\omega \\,t\\right) & \\frac{B\\,\\omega }{\\omega^2 +s^2 }+\\frac{A\\,s}{\\omega^2 +s^2 } & \\frac{B\\,\\omega +A\\,s}{\\omega^2 +s^2 }\n\\end{array}\\right)"}}
%---
%[output:8483d6e2]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{ccc}\n{\\mathrm{e}}^{-\\frac{t}{\\tau }} \\,\\cos \\left(\\omega \\,t\\right) & \\frac{s+\\frac{1}{\\tau }}{{{\\left(s+\\frac{1}{\\tau }\\right)}}^2 +\\omega^2 } & \\frac{s+\\frac{1}{\\tau }}{{{\\left(s+\\frac{1}{\\tau }\\right)}}^2 +\\omega^2 }\n\\end{array}\\right)"}}
%---
%[output:0e8a306e]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\left(\\begin{array}{ccc}\n{\\mathrm{e}}^{-\\frac{t}{\\tau }} \\,\\sin \\left(\\omega \\,t\\right) & \\frac{\\omega }{{{\\left(s+\\frac{1}{\\tau }\\right)}}^2 +\\omega^2 } & \\frac{\\omega }{{{\\left(s+\\frac{1}{\\tau }\\right)}}^2 +\\omega^2 }\n\\end{array}\\right)"}}
%---
%[output:6bdac118]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\begin{array}{l}\n\\left(\\begin{array}{ccc}\n{\\mathrm{e}}^{-\\frac{t}{\\tau }} \\,{\\left(A\\,\\cos \\left(\\omega \\,t\\right)+B\\,\\sin \\left(\\omega \\,t\\right)\\right)} & \\sigma_1  & \\sigma_1 \n\\end{array}\\right)\\\\\n\\mathrm{}\\\\\n\\textrm{where}\\\\\n\\mathrm{}\\\\\n\\;\\;\\sigma_1 =\\frac{B\\,\\omega }{{{\\left(s+\\frac{1}{\\tau }\\right)}}^2 +\\omega^2 }+\\frac{A\\,{\\left(s+\\frac{1}{\\tau }\\right)}}{{{\\left(s+\\frac{1}{\\tau }\\right)}}^2 +\\omega^2 }\n\\end{array}"}}
%---
%[output:5564366d]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"R\\,\\cos \\left(\\omega \\,t\\right)\\,\\cos \\left(\\phi \\right)-R\\,\\sin \\left(\\omega \\,t\\right)\\,\\sin \\left(\\phi \\right)"}}
%---
%[output:47bb0172]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"a\\,b+a\\,c"}}
%---
%[output:0781a2b5]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"a\\,{\\left(b+c\\right)}"}}
%---
%[output:22769b87]
%   data: {"dataType":"warning","outputData":{"text":"Warning: Solutions are only valid under certain conditions. To include parameters and conditions in the solution, specify the 'ReturnConditions' value as 'true'."}}
%---
%[output:5d15a32f]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"\\sqrt{A^2 +B^2 }"}}
%---
%[output:881edc1f]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"2\\,\\mathrm{atan}\\left(\\frac{A-\\sqrt{A^2 +B^2 }}{B}\\right)"}}
%---
%[output:307d59ec]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"{\\mathrm{e}}^{-\\frac{t}{\\tau }} \\,{\\left(Y_0 -\\frac{K\\,{\\left(A-B\\,\\omega \\,\\tau \\right)}}{\\omega^2 \\,\\tau^2 +1}\\right)}+\\frac{K\\,{\\left(A\\,\\cos \\left(\\omega \\,t\\right)+B\\,\\sin \\left(\\omega \\,t\\right)-B\\,\\omega \\,\\tau \\,\\cos \\left(\\omega \\,t\\right)+A\\,\\omega \\,\\tau \\,\\sin \\left(\\omega \\,t\\right)\\right)}}{\\omega^2 \\,\\tau^2 +1}"}}
%---
%[output:6d1b770c]
%   data: {"dataType":"symbolic","outputData":{"name":"ans","value":"{\\mathrm{e}}^{-\\frac{t}{\\tau }} \\,{\\left(Y_0 -\\frac{K\\,R\\,{\\left(\\cos \\left(\\phi \\right)+\\omega \\,\\tau \\,\\sin \\left(\\phi \\right)\\right)}}{\\omega^2 \\,\\tau^2 +1}\\right)}+\\frac{K\\,R\\,{\\left(\\cos \\left(\\phi +\\omega \\,t\\right)+\\omega \\,\\tau \\,\\sin \\left(\\phi +\\omega \\,t\\right)\\right)}}{\\omega^2 \\,\\tau^2 +1}"}}
%---
