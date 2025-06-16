function [value] = Parametry_W1_W2_AG(Parameters)
load TR_DATA

% Parameters.W1 = FV(1);
% Parameters.W2 = FV(2);
% Parameters.B = FV(3);
ErrorsA = 0;
ErrorsB = 0;

for k = 1:length(TR_DATA)
 if(InitialClassifier(TR_DATA(2,k),TR_DATA(3,k),Parameters) == 1)
 % Data point classified as A
 if(TR_DATA(1,k) == 1)
 % Data point classified correctly!
%  plot(TR_DATA(2,k),TR_DATA(3,k),'ok'); hold on
 else
%  plot(TR_DATA(2,k),TR_DATA(3,k),'or') ; hold on
 ErrorsA = ErrorsA + 1;
 end
 else
 % Data point classified as B
 if(TR_DATA(1,k) == 0)
 % Data point classified correctly!
%  plot(TR_DATA(2,k),TR_DATA(3,k),'xk'); hold on
 else
%  plot(TR_DATA(2,k),TR_DATA(3,k),'xr') ; hold on
 ErrorsB = ErrorsB + 1;
 end
 end
end

xlabel('x');
ylabel('y');
ErrorsA;
ErrorsB;
value=ErrorsA+ErrorsB
end