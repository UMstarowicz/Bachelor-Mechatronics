clear all;
clc;

% litery F oraz T

F = load('StudentData/FeaturesF');
T = load('StudentData/FeaturesT');

for sample = 1:300
 TrainingDataClass0(:,sample) = [F.Data(sample).Normal.Moments.M11,F.Data(sample).Normal.Area];
 TrainingDataClass1(:,sample) = [T.Data(sample).Normal.Moments.M11,T.Data(sample).Normal.Area];
end

Means = abs(mean([TrainingDataClass0,TrainingDataClass1]'));
% TrainingDataClass0 = TrainingDataClass0./Means';
% TrainingDataClass1 = TrainingDataClass1./Means';

TrainingData = [TrainingDataClass0,TrainingDataClass1];
TargetTrain = [zeros(1,300),ones(1,300)];

Indices = randperm(300); % Here we randomly permute data indices
for sample = 1:150
 TestingDataClass0(:,sample) = [F.Data(300+Indices(sample)).Normal.Moments.M11,F.Data(300+Indices(sample)).Normal.Area];
 TestingDataClass1(:,sample) = [T.Data(300+Indices(sample)).Normal.Moments.M11,T.Data(300+Indices(sample)).Normal.Area];
end

for sample = 1:150
 FinalTestClass0(:,sample) = [F.Data(300+Indices(sample)).Normal.Moments.M11,F.Data(300+Indices(sample)).Normal.Area];
 FinalTestClass1(:,sample) = [T.Data(300+Indices(sample)).Normal.Moments.M11,T.Data(300+Indices(sample)).Normal.Area];
end

for TestSerie = 1:10
NetworkSize = [2*TestSerie]; % Number of neurons in all the hidden layers
 for Test = 1:10
 OurNet = newff(TrainingData,TargetTrain,NetworkSize); % Net initialization
 OurNet.TrainParam.time = 20; % Max time allowed
 OurNet = train(OurNet,TrainingData,TargetTrain);
 Results0 = sim(OurNet,TestingDataClass0);
 Results1 = sim(OurNet,TestingDataClass1);
 ErrorsF(Test,TestSerie) = sum([Results0>0.5]);
 ErrorsT(Test,TestSerie) = sum([Results1<=0.5]);
 ErrorSum(Test,TestSerie) = ErrorsT(Test,TestSerie)+ErrorsF(Test,TestSerie);
 end
end

figure; boxplot(ErrorSum); ylabel('ErrorSum'); xlabel('NetNumber');