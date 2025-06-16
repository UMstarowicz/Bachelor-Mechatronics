load TR_DATA

Parameters.W1 = 9.5520; 
Parameters.W2 = -5.3751; 
Parameters.B = 1;

ErrorsA = 0;
ErrorsB = 0;

for k = 1:length(VA_DATA)
   if(InitialClassifier(VA_DATA(2,k),VA_DATA(3,k),Parameters) == 1)
      % Data point classified as A
      if(VA_DATA(1,k) == 1)
          % Data point classified correctly!
          plot(VA_DATA(2,k),VA_DATA(3,k),'ok'); hold on
      else
          plot(VA_DATA(2,k),VA_DATA(3,k),'or') ; hold on
          ErrorsA = ErrorsA + 1;
      end
   else
       % Data point classified as B
       if(VA_DATA(1,k) == 0)
        % Data point classified correctly!
          plot(VA_DATA(2,k),VA_DATA(3,k),'xk'); hold on
       else
          plot(VA_DATA(2,k),VA_DATA(3,k),'xr') ; hold on
          ErrorsB = ErrorsB + 1;
       end 
   end
end
xlabel('x');
ylabel('y');
ErrorsA
ErrorsB
ErrorsA+ErrorsB
 