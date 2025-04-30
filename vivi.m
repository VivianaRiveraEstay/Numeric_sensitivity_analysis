function dY = vivi(~,Y,P)
%% Parametros del modelo:
r0=P(1);
s0=P(2);
K=P(3);
n=P(4);
c=P(5);
d1=P(6);
d2=P(7);
b=P(8);
theta1=P(9);
theta2=P(10);
theta3=P(11);
theta4=P(12);
p=P(13);
q0=P(14);
e=P(15);
cx=P(16);
cy=P(17);
cz=P(18);
G1=P(19);
G2=P(20);
G3=P(21);

%El modelo
%% Lista de Ecuaciones
dY=zeros(6,1);
%Ecuaciones considerenao depredación, competencia y trade off theta 1 y theta 2
%dY(1) = r0*exp(-cx*Y(4)^(2))*Y(1)*(1-Y(1)/K)-d*Y(1)*Y(2)/(1+exp(theta1*(Y(4)-Y(5))))-alpha*d*Y(1)*Y(3)/(1+exp(theta2*(Y(4)-Y(6))));
%dY(2) = p0*exp(-cy*Y(5)^(2))*d*Y(1)*Y(2)/(1+exp(theta1*(Y(4)-Y(5))))-q*Y(2)-beta*b*Y(2)*Y(3)/(exp(theta1*(Y(5)-Y(6))));
%dY(3) = s0*exp(-cz*Y(6)^(2))*Y(3)*(1-Y(3)/(c+(n*alpha*d*Y(1)/(1+exp(theta2*(Y(4)-Y(6)))))))-b*Y(2)*Y(3)/(exp(theta2*(Y(6)-Y(5))));
%dY(4) = G1*(Y(4)-1)*(0-Y(4))*((theta1*d*Y(2)*exp(theta1*(Y(4)-Y(5))))/(1+exp(theta1*(Y(4)-Y(5))))^(2)+(theta2*alpha*d*Y(3)*exp(theta2*(Y(4)-Y(6))))/(1+exp(theta2*(Y(4)-Y(6))))^(2)-2*cx*r0*Y(4)*exp(-cx*Y(4)^(2))*(1-Y(1)/K));
%dY(5) = G2*(Y(5)-1)*(0-Y(5))*((theta1*p0*d*Y(1)*exp(theta1*(Y(4)-Y(5)))*exp(-cy*Y(5)^(2)))/(1+exp(theta1*(Y(4)-Y(5))))^(2)-2*cy*p0*d*Y(1)*Y(5)*exp(-cy*Y(5)^(2))/(1+exp(theta1*(Y(4)-Y(5))))+beta*b*theta1*Y(3)*exp(theta1*(Y(5)-Y(6)))/(1+exp(theta1*(Y(5)-Y(6))))^(2));
%dY(6) = G3*(Y(6)-1)*(0-Y(6))*( (s0*n*alpha*d*theta2*Y(1)*Y(3)*exp(-cz*Y(6)^(2))*exp(theta2*(Y(4)-Y(6))))/(((1+exp(theta2*(Y(4)-Y(6))))^(2))*(c+(n*alpha*d*Y(1))/(1+exp(theta2*(Y(4)-Y(6)))))^(2))-2*cz*s0*Y(6)*exp(-cz*Y(6)^(2))*(1-Y(3)/(c+(n*alpha*d*Y(1))/(1+exp(theta2*(Y(4)-Y(6))))))+b*theta2*Y(2)*exp(theta2*(Y(6)-Y(5)))/(1+exp(theta2*(Y(6)-Y(5))))^(2));
%Ecuaciones considerenao depredación, competencia y trade off theta 1,
%theta 2, theta3 y theta4
dY(1) = r0*exp(-cx*Y(4)^(2))*Y(1)*(1-Y(1)/K)-d1*Y(1)*Y(2)/(1+exp(theta1*(Y(4)-Y(5))))-d2*Y(1)*Y(3)/(1+exp(theta2*(Y(4)-Y(6))));
dY(2) = p*d1*Y(1)*Y(2)/(1+exp(theta1*(Y(4)-Y(5))))-q0*exp(cy*Y(5)^(2))*Y(2)-b*Y(2)*Y(3)/(exp(theta3*(Y(5)-Y(6))));
dY(3) = s0*exp(-cz*Y(6)^(2))*Y(3)*(1-Y(3)/(c+(n*d2*Y(1)/(1+exp(theta2*(Y(4)-Y(6)))))))-b*Y(2)*Y(3)/(exp(theta4*(Y(6)-Y(5))));
dY(4) = G1*exp(-e/Y(4))*((theta1*d1*Y(2)*exp(theta1*(Y(4)-Y(5))))/(1+exp(theta1*(Y(4)-Y(5))))^(2)+(theta2*d2*Y(3)*exp(theta2*(Y(4)-Y(6))))/(1+exp(theta2*(Y(4)-Y(6))))^(2)-2*cx*r0*Y(4)*exp(-cx*Y(4)^(2))*(1-Y(1)/K));
dY(5) = G2*exp(-e/Y(5))*((p*theta1*d1*Y(1)*exp(theta1*(Y(4)-Y(5))))/(1+exp(theta1*(Y(4)-Y(5))))^(2)-q0*2*cy*Y(5)*exp(cy*Y(5)^(2))+b*theta3*Y(3)*exp(theta3*(Y(5)-Y(6)))/(1+exp(theta3*(Y(5)-Y(6))))^(2));
dY(6) = G3*exp(-e/Y(6))*((s0*n*d2*theta2*Y(1)*Y(3)*exp(-cz*Y(6)^(2))*exp(theta2*(Y(4)-Y(6))))/(((1+exp(theta2*(Y(4)-Y(6))))^(2))*(c+(n*d2*Y(1))/(1+exp(theta2*(Y(4)-Y(6)))))^(2))-2*cz*s0*Y(6)*exp(-cz*Y(6)^(2))*(1-Y(3)/(c+(n*d2*Y(1))/(1+exp(theta2*(Y(4)-Y(6))))))+b*theta4*Y(2)*exp(theta4*(Y(6)-Y(5)))/(1+exp(theta4*(Y(6)-Y(5))))^(2));
end



