function fbest1=mybas(x0)

eta=0.95;
c=10;%ratio between step and d0
%step=1;%case 1?choose step=step*eta; initial step set as the largest input range
step=1;%case 2: choose temp=temp*eta; step=temp+step0; for step size with a minimal resolution
step0=0.005;%case 2 %for step size with a minimal resolution
%t1=cputime;

%step0=0.999;
temp=step-step0;%case 2 %for step size with a minimal resolution
n=100;%iterations
k=20;%space dimension
%x=1*rand(k,1)%intial value初始化位置
x=x0;
%%
xbest=x0;
fbest=f(xbest);
fbest_store=fbest;
x_store=[0;x;fbest];
display(['0:','xbest=[',num2str(xbest'),'],fbest=',num2str(fbest)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%iteration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:n
    d0=step/c;
    dir=rands(k,1);%头在k维空间的朝向是随机的
    dir=dir/(eps+norm(dir));%方向向量归一化
    xleft=x+dir*d0/2;%空间中左须方向
    fleft=f(xleft);%左须方向的函数值
    xright=x-dir*d0/2;%右须方向
    fright=f(xright);%右须方向函数值
    x=x-step*dir*sign(fleft-fright);%头在空间中的位置//sign:fleft>fright->1,fleft=fright->0;else->-1
    f=f(x);
    %%%%%%%%%%%
    if f>fbest%改为找最大值
        xbest=x;
        fbest=f;
    end
    %%%%%%%%%%%
    x_store=cat(2,x_store,[i;x;f]);
    fbest_store=[fbest_store;fbest];
    display([num2str(i),':xbest=[',num2str(xbest'),'],fbest=',num2str(fbest)])
    %%%%%%%%%%%
    %step=step*eta;%case 1:choose step=step*eta; 
    temp=temp*eta;%case 2: choose temp=temp*eta; step=temp+step0;
    step=temp+step0;%case 2
    %lambda=2; step=1/(i^lambda)+step0;%case 3 Levy flight
end
fbest1 = fbest

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data visualization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure,clf(1),
% plot(x_store(1,:),x_store(end,:),'r-o')
% hold on,
% plot(x_store(1,:),fbest_store,'b-.')
% xlabel('iteration')
% ylabel('minimum value')
% title(['initstep0=',num2str(step0)]);toc
end
%t2=cputime;
%t=t2-t1



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%the function to be optimized;please modify this part for your own optimization problem. Here x is the input vector, y is the output scalar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y=f(x)
y=0.6224*x(1)*x(3)*x(4)+1.7781*x(2)*x(3).^2+3.1661*x(1).^2*x(4)+19.84*x(1).^2*x(3);
end
