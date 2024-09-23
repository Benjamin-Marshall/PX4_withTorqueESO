clearvars; clc; 

%% Vars
syms x y z xd yd zd xdd ydd zdd Ixx Iyy Izz;
syms xm ym zm xdm ydm zdm;
syms tx ty tz; % inputs
angle = [x y z].';
angleRate = [xd yd zd].';
angularAcc = [xdd ydd zdd].';

state = [angle;angleRate;angularAcc];
measurement = [xm; ym; zm; xdm; ydm; zdm];

inertiaVars = [Ixx; Iyy; Izz];


%% Matrices

A = [zeros(3), eye(3), zeros(3);zeros(3,6),eye(3);zeros(3,9)];
B = [zeros(3);[inertiaVars(1),0,0;0,inertiaVars(2),0;0,0,inertiaVars(3)];zeros(3)];
C = [eye(3),zeros(3,6);zeros(3),eye(3),zeros(3)];
Gain = sym('L',[9,6]);

%% Overall

stateDot = A*state + B*[tx;ty;tz] + Gain*(measurement - C*state)

LReal = place(A.',C.',-[10*ones(3,1) ones(3,1) ones(3,1).*.1]);