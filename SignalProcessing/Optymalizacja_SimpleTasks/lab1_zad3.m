clear all;
clc;

% litery F oraz T

F = load('StudentData/FeaturesF');
T = load('StudentData/FeaturesT');

ErrorsF = 0;
ErrorsT = 0;
for k = 1:300

 if(ClassifierDT(F.Data(k).Normal) == 1) % Detected class "1", (our "T")
    ErrorsF = ErrorsF + 1;
    plot(F.Data(k).Normal.Moments.M11,F.Data(k).Normal.Area,'.r'); hold on
 else
    plot(F.Data(k).Normal.Moments.M11,F.Data(k).Normal.Area,'.k'); hold on
 end

 if(ClassifierDT(T.Data(k).Normal) == 0) % Detected class "0", (our "F")
    ErrorsT = ErrorsT + 1;
    plot(T.Data(k).Normal.Moments.M11,T.Data(k).Normal.Area,'+r'); hold on
 else
     plot(T.Data(k).Normal.Moments.M11,T.Data(k).Normal.Area,'+k'); hold on
 end

end
