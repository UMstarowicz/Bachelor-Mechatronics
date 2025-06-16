clear all;
close all;
clc;
addpath Plants\

T = [0:0.1:100]; 
goalResult = ObjectForIdentification_4P_01(T,1);

figure; 
plot(T, goalResult)

PopulationSize = 50; 
MaxSteps = 200; 
InitialStep = 2.2; 
n = 30;
P1 = 2.5;
P2 = 15;

StartingPoint = 10*randn(4,PopulationSize);        
Population = StartingPoint; 
BestResult = Inf(1, MaxSteps);
BestResult(1) = 1e9;
MeanBestResult = zeros(1, MaxSteps);
for iter = 1:MaxSteps    
    clc; iter    
    % Adaptacyjny krok mutacji:
    if iter > 1
        if BestResult(iter-1) > BestResult(iter)
            S(iter) = S(iter-1) * P1;
        else
            S(iter) = S(iter-1) * P2;
        end
    else
        S(iter) = InitialStep;
    end

    
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
    MeanBestResult(iter) = mean(BestResult(1:iter)); % obliczenie średniej wartości przystosowania najlepszego osobnika przez wszystkie generacje    
    % And now lets build a new population        
    NewPopulation(:,1) = Population(:,Indices(1));    
    for pop = 2:PopulationSize               
        % krzyżowanie między najlepszymi osobnikami
        parent1 = Population(:,Indices(1));
        parent2 = Population(:,Indices(2));
        alpha = rand(4,1);
        offspring = alpha.*parent1 + (1-alpha).*parent2;
        % mutacja gaussowska
        offspring = offspring + S(iter)*randn(size(offspring));
        NewPopulation(:,pop) = offspring;                 
    end        
    Population = NewPopulation;        
    clear Values Indices StableOnes Residua 
end 
% Lets see the convergence curve: 
figure;   
plot(MeanBestResult); 
% And lets see the final result:  
finalSys = tf(1,Population(:,1)');  
finalResult = step(finalSys,T); 
figure; 
plot(goalResult,'k'); 
hold on 
plot(finalResult,'r');

[~, goalSys] = ObjectForIdentification_4P_01(T,1);
testSys = finalSys;

figure;
subplot(2,1,1)
pzmap(goalSys)
subplot(2,1,2)
pzmap(testSys)
