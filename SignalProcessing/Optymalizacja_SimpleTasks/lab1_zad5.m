clear all;
clc;

% litery F oraz T

F = load('StudentData/FeaturesF');
T = load('StudentData/FeaturesT');

for sample = 1:300
 TrainingDataClass0(:,sample) = ...
[F.Data(sample).Normal.Moments.M11,F.Data(sample).Normal.Area,F.Data(sample).Normal.Moments.M30,F.Data(sample).Normal.HuInvariants.I0];
 TrainingDataClass1(:,sample) = ...
[T.Data(sample).Normal.Moments.M11,T.Data(sample).Normal.Area,T.Data(sample).Normal.Moments.M30,T.Data(sample).Normal.HuInvariants.I0];
end

Means = abs(mean([TrainingDataClass0,TrainingDataClass1]'));
TrainingDataClass0 = TrainingDataClass0./Means';
TrainingDataClass1 = TrainingDataClass1./Means';

figure;
ErrorsF = 0;
ErrorsT = 0;

for k = 301:600

 F1 = F.Data(k).Normal.Moments.M11/Means(1);
 F2 = F.Data(k).Normal.Area/Means(2); 
 F3 = F.Data(k).Normal.Moments.M30/Means(3);
 F4 = F.Data(k).Normal.HuInvariants.I0/Means(4); 
 
 if(ClassifierKNN_4D([F1,F2,F3,F4],TrainingDataClass0,TrainingDataClass1) == 1) % Detected class "1" 
ErrorsF = ErrorsF + 1;
 plot(F.Data(k).Normal.Moments.M11,F.Data(k).Normal.Area,'.r'); hold on
 else
 plot(F.Data(k).Normal.Moments.M11,F.Data(k).Normal.Area,'.k'); hold on
 end

 F1 = T.Data(k).Normal.Moments.M11/Means(1);
 F2 = T.Data(k).Normal.Area/Means(2);
 F3 = T.Data(k).Normal.Moments.M30/Means(3);
 F4 = T.Data(k).Normal.HuInvariants.I0/Means(4);

 if(ClassifierKNN_4D([F1,F2,F3,F4],TrainingDataClass0,TrainingDataClass1) == 0) % Detected class "0 
ErrorsT = ErrorsT + 1;
 plot(T.Data(k).Normal.Moments.M11,T.Data(k).Normal.Area,'+r'); hold on
 else
 plot(T.Data(k).Normal.Moments.M11,T.Data(k).Normal.Area,'+k'); hold on
 end

end

xlabel('M11');
ylabel('Area');
