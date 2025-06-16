clear all;
close all;
clc;
addpath Plants\

T = [0:0.1:100]; 
goalResult = ObjectForIdentification_4P_01(T,1);

figure; 
plot(T, goalResult)

PopulationSize = 100; 
MaxSteps = 100; 
InitialStep = 2.297; 
n = 30;

StartingPoint = 10*randn(4,1000);        
Population = StartingPoint; 
for iter = 1:MaxSteps    
    clc; iter    
    S(iter) = InitialStep;    
    % Lets build phenotypes:        
    for k = 1:PopulationSize            
        L = 1;            
        M = Population(:,k);            
        testSys = tf(L,M');            
        testResult(:,k) = step(testSys,T);        
    end        
    Residua = testResult-goalResult;        
    % Lest sort the solutions and build a ranking:        
    [Values,Indices] = sort(rms(Residua));        
    BestResult(iter) = Values(1);        
    % And now lets build a new population        
    NewPopulation(:,1) = Population(:,Indices(1));           
    for pop = 2:PopulationSize               
        NewPopulation(:,pop) = Population(:,randi(n));                 
        NewPopulation(:,pop) = NewPopulation(:,pop) + ...     
        S(iter)*randn(size(NewPopulation(:,pop)));           
    end        
    Population = NewPopulation;        
    clear Values Indices StableOnes Residua 
end 
% Lets see the convergence curve: 
figure;   
plot(BestResult); 
% And lets see the final result:  
finalSys = tf(1,Population(:,1)');  
finalResult = step(finalSys,T); 
figure; 
plot(goalResult,'k'); 
hold on 
plot(finalResult,'r');

[~, goalSys] = ObjectForIdentification_4P_01(T,1);
testSys

figure;
subplot(2,1,1)
pzmap(goalSys)
subplot(2,1,2)
pzmap(testSys)