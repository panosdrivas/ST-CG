
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
  

    x=zeros(n,1);
    r_0=b1;
    p=r_0;
    
    count=0;
    cont=count+A1(1,1:3)*p(1:3)*p(1);
    count=count+A1(2,1:4)*p(1:4)*p(2);
    
    for i=3:n-2
      count=count+A1(i,i-2:i+2)*p(i-2:i+2)*p(i);
    end
    
    count=count+A1(n-1,n-3:n)*p(n-3:n)*p(n-1);
    count=count+A1(n,n-2:n)*p(n-2:n)*p(n);
    
    
    sum = 0;
    for i = 1:n
     sum = sum + r_0(i)*r_0(i);
    end
    
    a = sum/count;
    x=x+a*p;
    
    d_v=zeros(n,1);
    d_v(1)=A1(1,1:3)*x(1:3);
    d_v(2)=A1(2,1:4)*x(1:4);
    
    for i=3:n-2
      d_v(i)=A1(i,i-2:i+2)*x(i-2:i+2);
    end
    
    d_v(n-1)=A1(n-1,n-3:n)*x(n-3:n);
    d_v(n)=A1(n,n-2:n)*x(n-2:n);
    
    r_1=b1-d_v;
    k=1;
    
    while norm(r_1)>0.5*10^(-4) && k<n
        k=k+1;
        
        
        sum1 = 0;
        
        for i = 1:n
         sum1 = sum1 + r_1(i)*r_1(i);
        end
    
        sum2 = 0;
        for i = 1:n
         sum2 = sum2 + r_0(i)*r_0(i);
        end
    
        b = sum1/sum2;
  
        p=r_1+b*p;
        
        count=0;
        count=count+A1(1,1:3)*p(1:3)*p(1);
        count=count+A1(2,1:4)*p(1:4)*p(2);
        
        for i=3:n-2
          count=count+A1(i,i-2:i+2)*p(i-2:i+2)*p(i);
        end
        
        count=count+A1(n-1,n-3:n)*p(n-3:n)*p(n-1);
        count=count+A1(n,n-2:n)*p(n-2:n)*p(n);
        
        
        
        sum3 = 0;
        for i = 1:n
         sum3 = sum + r_1(i)*r_1(i);
        end
    
        a = sum3/count;
        x=x+a*p;
        
        d_v=zeros(n,1);
        d_v(1)=A1(1,1:3)*x(1:3);
        d_v(2)=A1(2,1:4)*x(1:4);
        
        for i=3:n-2
          d_v(i)=A1(i,i-2:i+2)*x(i-2:i+2);
        end
        
        d_v(n-1)=A1(n-1,n-3:n)*x(n-3:n);
        d_v(n)=A1(n,n-2:n)*x(n-2:n);
        
        r_0=r_1;
        r_1=b1-d_v;
    end
    
   k