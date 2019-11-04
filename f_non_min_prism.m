%Static analysis of a tensegrity non_minimal_prism with k bars
%Created by Yuhao Lian with help of Muhan Zhao and Professor Thomas Bewley
%at UC San Diego

%This function requires input of 
%1. How many bars used to construct the prism? 
%2. What's the radii of the top/bottom polygon? (Assuming they have the
%same radii. The construction of prism with different radii in the
%future maybe added.
%3. Twist angle.
%The output constructs, analyzes and plots the tensegrity prism constructed
%from user input.

function f_non_min_prism(k,rad,alpha)
%check if alphi is within range
if alpha>pi/2 || alpha<pi/2-pi/k
    disp("Double check twist angle alpha. Make sure pi/2-pi/k<=alpha<=pi/2");
    return
end

%bottom k-sided polygon
for i=0:k-1
    Q(:,i+1)=[rad*cos(2*pi*i/k);rad*sin(2*pi*i/k);0];
end
%top polygon with same shape but have a twist angle alpha
for i=k:2*k-1
    Q(:,i+1)=[rad*cos(2*pi*i/k+alpha);rad*sin(2*pi*i/k+alpha);2];
end
%because tensegrity prism doesn't have fixed nodes, so P=[] and p=0
P=[];
[dim,q]=size(Q), p=size(P,2),n=q+p;
%A minimal prism has 3k members and a non-minimal prism has 4k members
%where the diagonals are connected
b=k;s=4*k;m=b+s;
C(m,n)=0;
%bars
for i=1:k-1
    C(i,i)=1; C(i,i+k+1)=-1;
end
C(k,k)=1; C(k,k+1)=-1;
%strings
%strings constructing top and bottom polygons
for i=1:k-1
    C(k+i,i)=1; C(k+i,i+1)=-1;
end
C(2*k,1)=1; C(2*k,k)=-1;
for i=1:k-1
    C(2*k+i,i+k)=1; C(2*k+i,i+k+1)=-1;
end
C(3*k,k+1)=1; C(3*k,2*k)=-1;
for i=1:k
    C(3*k+i,i)=1; C(3*k+i,i+k)=-1;
end
C(4*k+1,1)=1; C(4*k+1,2*k)=-1;
%above 3k strings are minimal strings
%below are diagonal strings
for i=2:k-1
    C(4*k+i,i)=1; C(4*k+i,i+k-1)=-1;
end
C(5*k,k)=1; C(5*k,2*k-1)=-1;
U(1:dim,1:n)=0;
%U(dim,1:k)=1;
%U(dim,k+1:2*k)=-1;
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1.0); grid on;




