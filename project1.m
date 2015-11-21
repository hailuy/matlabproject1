A = 0.003;
B = 0.002;
h = 0.001;
F = 50;
k1 = 40;
k2 = 4;
E = 190;
I = 0.0005;

m =[0 0 0 0 0 0 0 0 0 0 0 -6 0 0 0 6;
 0 0 0 0 0 0 0 0 0 0 -2 -6*B 0 0 2 6*B;
 0 0 0 0 0 0 0 0 0 -1 -2*B -3*B*B 0 1 2*B 3*B*B;
 0 0 0 0 0 0 0 0 -1 -B -B*B -B*B*B 1 B B*B B*B*B;
 0 0 0 -6 0 0 0 6 0 0 0 0 0 0 0 0;
 0 0 -2 6*B 0 0 2 -6*B 0 0 0 0 0 0 0 0;
 0 -1 2*B -3*B*B 0 1 -2*B 3*B*B 0 0 0 0 0 0 0 0;
 -1 B -B*B B*B*B 1 -B B*B B*B*B 0 0 0 0 0 0 0 0;
 0 0 0 0 0 0 0 -6 0 0 0 6 0 0 0 0;
 0 0 0 0 0 0 -2 0 0 0 2 0 0 0 0 0;
 0 0 0 0 0 -1 0 0 0 1 0 0 0 0 0 0;
 0 0 0 0 -1 0 0 0 1 0 0 0 0 0 0 0;
 0 0 1 -3*A 0 0 0 0 0 0 0 0 0 0 0 0;
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 3*A;
 k1 -k1*A k1*A*A -k1*A*A*A+6*E*I 0 0 0 0 0 0 0 0 0 0 0 0;
 0 0 0 0 0 0 0 0 0 0 0 0 k1 k1*A k1*A*A k1*A*A*A-6*E*I ];
 
p = [-F/(E*I) 0 0 0 -F/(E*I) 0 0 0  k2/(E*I) 0 0 0  0 0 0 0]';
n = inv(m)*p;

x0 = linspace(-A,-B,2000);
x1 = linspace(-B,0,2000);
x2 = linspace(0,B,2000);
x3 = linspace(B,A,2000);
u0 = n(1) + n(2) * x0 + n(3) * x0.^2 + n(4) * x0.^3;
u1 = n(5) + n(6) * x1 + n(7) * x1.^2 + n(8) * x1.^3;
u2 = n(9) + n(10) * x2 + n(11) * x2.^2 + n(12) * x2.^3;
u3 = n(13) + n(14) * x3 + n(15) * x3.^2 + n(16) * x3.^3;
v0 = (h/2) * (2 * n(3) + 6 * n(4) * x0);
v1 = (h/2) * (2 * n(7) + 6 * n(8) * x1);
v2 = (h/2) * (2 * n(11) + 6 * n(12) * x2);
v3 = (h/2) * (2 * n(15) + 6 * n(16) * x3);

subplot(2,1,1);
hold on;
plot(x0,u0,'linewidth',2,'color','r');
plot(x1,u1,'linewidth',2,'color','b');
plot(x2,u2,'linewidth',2,'color','r');
plot(x3,u3,'linewidth',2,'color','b');
title(sprintf('displacement'));
if ~exist('OCTAVE_VERSION')
% Running matlab
options={'Interpreter','latex','FontSize',12};
ylabel('$change$',options{:},'HorizontalAlignment','right')
xlabel('$x$',options{:})
else
% Running octave
options={'Interpreter','tex','FontSize',12};
ylabel('change',options{:},'HorizontalAlignment','right');
xlabel('x',options{:});
end
hold off;

subplot(2,1,2);
hold on;
plot(x0,v0,'linewidth',2,'color','r');
plot(x1,v1,'linewidth',2,'color','b');
plot(x2,v2,'linewidth',2,'color','r');
plot(x3,v3,'linewidth',2,'color','b');
title(sprintf('strain'));
if ~exist('OCTAVE_VERSION')
% Running matlab
options={'Interpreter','latex','FontSize',12};
ylabel('$change2$',options{:},'HorizontalAlignment','right')
xlabel('$x$',options{:})
else
% Running octave
options={'Interpreter','tex','FontSize',12};
ylabel('change2',options{:},'HorizontalAlignment','right');
xlabel('x',options{:});
end
hold off;