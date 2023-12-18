

 %feature('SetPrecision',24);
 %CREATE LINEAR SYSTEM A1X1 = B1
 n=100;
 A1=zeros(n,n);
 
 for i=1:n
  for j=1:n
    if (i==j)
      A1(i,j)=6;
    elseif (i==j+1 || j==i+1)
      A1(i,j)=-4;
    elseif (i==j+2 || j==i+2)
       A1(i,j)=1;
    end
   end
 end
 
  b1=zeros(n,1);
  
  b1(1)=3;
  b1(2)=-1;
  b1(3)=0;
  for i=4:n-3
    b1(i)=0;
  end
  b1(n-2)=0;
  b1(n-1)=-1;
  b1(n)=3;
  
    %{
    linaer system A2X2 =B2
   A2=zeros(n,n);
   for i=1:n
     for j=1:n
       if (i==j)
         A2(i,j)=7;
       elseif (i==j+1 || j==i+1)
          A2(i,j)=-4;
       elseif (i==j+2 || j==i+2)
           A2(i,j)=1;
       end
     end
   end
   
  b2=zeros(n,1);

  b2(1)=4;
  b2(2)=0;
  b2(3)=1;
  for i=4:n-3
   b2(i)=1;
  end
  b2(n-2)=1;
  b2(n-1)=0;
  b2(n)=4;
    
    %}
  
  x=zeros(n,1);
  r=b1;
  k=0;
  
  while norm(r)>0.5*10^(-4)
    
    k=k+1;
    
    count=0;
    count=count+ A1(1,1:3)*r(1:3)*r(1);
    count=count+ A1(2,1:4)*r(1:4)*r(2);
    
    for i=3:n-2
     count=count+ A1(i,i-2:i+2)*r(i-2:i+2)*r(i);
    end
    
    count=count+ A1(n-1,n-3:n)*r(n-3:n)*r(n-1);
    count=count+ A1(n,n-2:n)*r(n-2:n)*r(n);
    
    
    sum = 0;
    for i = 1:n
      sum = sum + r(i)*r(i);
    end
    
    a = sum/count;
    
    x=x+a*r;
    
    d_v=zeros(n,1);
    d_v(1)=A1(1,1:3)*x(1:3);
    d_v(2)=A1(2,1:4)*x(1:4);
    
    for i=3:n-2
      d_v(i)=A1(i,i-2:i+2)*x(i-2:i+2);
    end
    
    d_v(n-1)=A1(n-1,n-3:n)*x(n-3:n);
    d_v(n)=A1(n,n-2:n)*x(n-2:n);
    
    r=b1-d_v;
    
  end
  
 
 
 k