dx=1/8;
dy=1/8;

nrow=1+2/dx;
ncol=1+2/dy;
U=1;

A=zeros(nrow,ncol);
for r=2:nrow-1
    for c=2:ncol-1
        A(r,c)=U;
        U=U+1;
    end
end

for r=2:nrow-1
    A(r,1)=U;
    U=U+1;
end
for r=2:nrow-1
    A(r,ncol)=U;
    U=U+1;
end
for c=1:ncol
    if (c-1)*dx<1
    A(1,c)=(-1)*(c-1)*dx;
    else
    A(1,c)=(-1)*(2-(c-1)*dx);
    end
end
disp(A);
%DEFINO MATRIZ CON ECUACIONES
N=ncol*(nrow-2);
B=zeros(N,N+1);
%Fi a la izquierda
cont=(ncol-2)*(nrow-2)+1;
for r=2:nrow-1
    B(cont,A(r,1))=-4;
    B(cont,A(r,2))=2;
    if A(r-1,1)~=0
        B(cont,A(r-1,1))=B(cont,A(r-1,1))+1;
    end
    if A(r+1,1)~=0
        B(cont,A(r+1,1))=B(cont,A(r+1,1))+1;
    end
    cont=cont+1;
end
%Fi a la derecha
for r=2:nrow-1
    B(cont,A(r,ncol))=-4;
    B(cont,A(r,ncol-1))=2;
    if A(r-1,ncol)~=0
        B(cont,A(r-1,ncol))=B(cont,A(r-1,ncol))+1;
    end
    if A(r+1,1)~=0
        B(cont,A(r+1,ncol))=B(cont,A(r+1,ncol))+1;
    end
    cont=cont+1;
end
%Medio
cont=1;
for r=2:nrow-1
    for c=2:ncol-1
        B(cont,A(r,c))=B(cont,A(r,c))-4;
        if A(r,c-1)>0
        B(cont,A(r,c-1))=B(cont,A(r,c-1))+1;
        else
            B(cont,N+1)=B(cont,N+1)+A(r,c-1);
        end
        if A(r,c+1)>0
        B(cont,A(r,c+1))=B(cont,A(r,c+1))+1;
        else
            B(cont,N+1)=B(cont,N+1)+A(r,c+1);
        end
        if A(r-1,c)>0
        B(cont,A(r-1,c))=B(cont,A(r-1,c))+1;
        else
            B(cont,N+1)=B(cont,N+1)+A(r-1,c);
        end
        if A(r+1,c)>0
        B(cont,A(r+1,c))=B(cont,A(r+1,c))+1;
        else
            B(cont,N+1)=B(cont,N+1)+A(r+1,c);
        end
        cont=cont+1;
    end
end
disp(B);

C=rref(B);
disp(C);
%%

s = ' ';
pos1=(ncol-2)*(nrow-2);
contu=1;
posrow=1;
%%funcion
for j=0:nrow-1
        fprintf(' %g %s 2 %s %g', j*dx, s, s, function1(j*dx));
    fprintf('\n');
end
fprintf('\n');
%%fprintf('%g',pos);
for j=1:nrow-2
    fprintf(' %g %s %g %s %g', 0, s, ((2/dx)-j)*dy, s, C(pos1+posrow,end));
    fprintf('\n');
    for i=1:ncol-2
        fprintf(' %g %s %g %s %g', i*dx, s, ((2/dx)-j)*dy, s, C(contu,end));
        fprintf('\n');
        contu=contu+1;
    end
    fprintf(' %g %s %g %s %g', 2, s, ((2/dx)-j)*dy, s, C(pos1+posrow,end));
    posrow=posrow+1;
    fprintf('\n');
    fprintf('\n');
end
%%ceros
for j=0:nrow-1
        fprintf(' %g %s 0 %s 0', j*dx, s, s);
    fprintf('\n');
end

function fdx = function1(x)
    if x<1
        fdx=x;
        else
        fdx=2-x;
    end
end
