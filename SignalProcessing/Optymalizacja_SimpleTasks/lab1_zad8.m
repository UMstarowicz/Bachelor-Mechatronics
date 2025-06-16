clear all;
clc;

% litery F oraz T

F = load('StudentData/FeaturesF');
T = load('StudentData/FeaturesT');

%ogólnie to I1 N11 jest trochę lepsze

for sample = 1:300
 TrainingDataClass0(:,sample) = ...
[F.Data(sample).Normal.Moments.M11,F.Data(sample).Normal.Area];
 TrainingDataClass1(:,sample) = ...
[T.Data(sample).Normal.Moments.M11,T.Data(sample).Normal.Area];
end

Means = abs(mean([TrainingDataClass0,TrainingDataClass1]'));
TrainingDataClass0 = TrainingDataClass0./Means';
TrainingDataClass1 = TrainingDataClass1./Means';

TrainingData = [TrainingDataClass0,TrainingDataClass1];
TargetTrain = [ones(1,300),zeros(1,300)];

NetworkSize = [4 4 4]; % Number of neurons in all the hidden layers
% OurNet = newff(TrainingData,TargetTrain,NetworkSize); % Net initialization
% OurNet.TrainParam.time = 10; % Max time allowed [in sec]
% 
% OurNet = train(OurNet,TrainingData,TargetTrain);
% 
% figure;
% ErrorsF = 0;
% ErrorsT = 0;
% 
% for k = 301:600
% 
%  F1 = F.Data(k).Normal.Moments.M11/Means(1);
%  F2 = F.Data(k).Normal.Area/Means(2); 
%  
%  if(sim(OurNet,[F1,F2]') > 0.5) % Detected class "1" tu T
% ErrorsF = ErrorsF + 1;
%  plot(F.Data(k).Normal.Moments.M11,F.Data(k).Normal.Area,'.r'); hold on
%  else
%  plot(F.Data(k).Normal.Moments.M11,F.Data(k).Normal.Area,'.k'); hold on
%  end
% 
%  F1 = T.Data(k).Normal.Moments.M11/Means(1);
%  F2 = T.Data(k).Normal.Area/Means(2);
% 
%  if(sim(OurNet,[F1,F2]') <= 0.5) % Detected class "0  tu F
% ErrorsT = ErrorsT + 1;
%  plot(T.Data(k).Normal.Moments.M11,T.Data(k).Normal.Area,'+r'); hold on
%  else
%  plot(T.Data(k).Normal.Moments.M11,T.Data(k).Normal.Area,'+k'); hold on
%  end
% 
% end
% 
% xlabel('M11');
% ylabel('Area');

for sample = 1:300

 TestingDataClass0(:,sample) = ... 
[F.Data(300+sample).Normal.Moments.M11,F.Data(300+sample).Normal.Area];
 TestingDataClass1(:,sample) = ... 
[T.Data(300+sample).Normal.Moments.M11,T.Data(300+sample).Normal.Area];

end

TestingDataClass0 = TestingDataClass0./Means';
TestingDataClass1 = TestingDataClass1./Means';

for Test = 1:10

 OurNet = newff(TrainingData,TargetTrain,NetworkSize); % Net initialization
 OurNet.TrainParam.time = 20; % Max time allowed
 OurNet = train(OurNet,TrainingData,TargetTrain);
 Results0 = sim(OurNet,TestingDataClass0);
 Results1 = sim(OurNet,TestingDataClass1);
 
 ErrorsF1(Test) = sum([Results0>0.5]);
 ErrorsT1(Test) = sum([Results1<=0.5]);
 ErrorSum(Test) = ErrorsT1(Test)+ErrorsF1(Test);

end

wyn = [mean(ErrorSum) std(ErrorSum)];