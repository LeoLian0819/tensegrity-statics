%Static force analysis for a regular non-minimal tensegrity prism.
%By Yuhao Lian, UC San Diego
clear;
%Number of bars
alpha=pi/3; 
%twist angle of the prism 
%if the tensegrity prism is non-minimal, alpha then has a interval of [pi/2-pi/prism_p,pi/2]
%if the it's minimal, alpha has a fixed value of pi/2-pi/prism_p

Q(:,1)=[0;0;0];
Q(:,2)=[0;1;0];
Q(:,3)=[1;1;0];
Q(:,4)=[1;0;0];
Q(:,5)=[-sqrt(2)/2*cos(alpha-pi/4)+1/2;sqrt(2)/2*sin(alpha-pi/4)+1/2;1];
Q(:,6)=[1/2+sqrt(2)/2*sin(alpha-pi/4);1/2+sqrt(2)/2*cos(alpha-pi/4);1];
Q(:,7)=[1/2+sqrt(2)/2*cos(alpha-pi/4);1/2-sqrt(2)/2*sin(alpha-pi/4);1];
Q(:,8)=[1/2-sqrt(2)/2*sin(alpha-pi/4);1/2-sqrt(2)/2*cos(alpha-pi/4);1];
P=[];
[dim,q]=size(Q), p=size(P,2),n=q+p;

%Connectivity Matrix
%bars
C(1,1)=1; C(1,6)=-1;
C(2,2)=1; C(2,7)=-1;
C(3,3)=1; C(3,8)=-1;
C(4,4)=1; C(4,5)=-1;
b=4;
%strings
C(b+1,1)=1; C(b+1,2)=-1;
C(b+2,2)=1; C(b+2,3)=-1;
C(b+3,3)=1; C(b+3,4)=-1;
C(b+4,4)=1; C(b+4,1)=-1;
C(b+5,5)=1; C(b+5,6)=-1;
C(b+6,6)=1; C(b+6,7)=-1;
C(b+7,7)=1; C(b+7,8)=-1;
C(b+8,8)=1; C(b+8,5)=-1;
C(b+9,1)=1; C(b+9,5)=-1;
C(b+10,2)=1; C(b+10,6)=-1;
C(b+11,3)=1; C(b+11,7)=-1;
C(b+12,4)=1; C(b+12,8)=-1;
s=12;
m=b+s;
U(1:dim,1:8)=0;
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,2.0); grid on;

