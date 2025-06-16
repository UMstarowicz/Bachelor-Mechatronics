
load VA_DATA

Parameters.W1 = [-4.462272075526664,2.283116981609598,2.051330411182291,2.637589919797073,1.302114707188261,4.179578460020863,2.101629183827509];
Parameters.W2 = [1.373125386671390,0.518375832778130,1.852643433680295,0.828035657511897,-2.658626820664996,0.299130491770128,0.614188415551427];
Parameters.B = [2.655980267288513,4.239452479456858,3.368415909545313,2.635106169391717,4.832186052703635,2.340893735398992,2.400727055901095];
ErrorsA = 0;
ErrorsB = 0;

for k = 1:length(VA_DATA)
 if(InitialClassifier(VA_DATA(2,k),VA_DATA(3,k),Parameters) == 1)
 % Data point classified as A
 if(VA_DATA(1,k) == 1)
 % Data point classified correctly!
%  plot(TR_DATA(2,k),TR_DATA(3,k),'ok'); hold on
 else
%  plot(TR_DATA(2,k),TR_DATA(3,k),'or') ; hold on
 ErrorsA = ErrorsA + 1;
 end
 else
 % Data point classified as B
 if(VA_DATA(1,k) == 0)
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
ErrorsA
ErrorsB
value=ErrorsA+ErrorsB
