clear all
 
%% Optimization task:
FunctionForOptimization = str2func('Parametry_W1_W2_AG');
 
%% Adjustable parameters:
MaxRangeX = [-10 10];  % Range of parameters for optimization
MaxRangeY = [-10 10];
 
MaxSteps = 50;         % How many iterations do we perform?
FunctionPlot = 0;       % change to 0 If you want to get rid of the underlying function plot 
PointPlot = 0;          % Change to 0 if you want to get rid of the visualization
ConvergenceColor = 'b'; % Change color of the convergence curve here
%close all              % Comment this out if you want to have many convergence curves plotted
 
ViewVect = [0,90];             % Initial viewpoint
Delay = 0.001;                 % Inter-loop delay  - to slow down the visualization
FunctionPlotQuality = 0.05;    % Quality of function interpolation. Lower for a quicker run
 
%% Map initialization
InitialRangeX = MaxRangeX;      % This is the range from which we can draw points.
InitialRangeY = MaxRangeY;
 
%% Map visualization (this code is not used for problem solving)
% if(FunctionPlot == 1)
%     figure(1);
%     clf
%         vectX = [MaxRangeX(1):FunctionPlotQuality:MaxRangeX(2)];
%         vectY = [MaxRangeY(1):FunctionPlotQuality:MaxRangeY(2)];
%         [X,Y] = meshgrid(vectX,vectY);    indx = 1;  indy = 1;
%         for x = vectX
%             indy = 1;
%             for y = vectY
%                 Val(indx,indy) = FunctionForOptimization([x,y]);
%                 indy = indy + 1;
%             end
%             indx = indx + 1;
%         end
%         mesh(X,Y,Val);    surf(X,Y,Val,'LineStyle','none');
%         view(ViewVect);   colormap(bone);    hold on
% else end
%  
%% Storing of a best solution
    CurrentMin = 50000;
    ResultX = 1;
    ResultY = 1;

%% The main optimization loop
    EndingCondition = 0;
    P_size = 30;
    n = 3;
    iter = 0;
    tic;
    InitialStep = 1; 
    P1 = 6; 
    P2 = 7; 
    line_number=1;

    for k = 1:P_size
     Population(k).OF = Inf;
     Population(k).Parameters.W1 = randn(1,line_number);
     Population(k).Parameters.W2 = randn(1,line_number);
     Population(k).Parameters.B = randn(1,line_number);
%      Population(k).Parameters(4) = InitialRangeY(1) + rand()*(InitialRangeY(2) - InitialRangeY(1));
%      Population(k).Parameters(5) = InitialRangeY(1) + rand()*(InitialRangeY(2) - InitialRangeY(1));
%      Population(k).Parameters(6) = InitialRangeY(1) + rand()*(InitialRangeY(2) - InitialRangeY(1));
%      Population(k).Parameters(7) = InitialRangeY(1) + rand()*(InitialRangeY(2) - InitialRangeY(1));
    end

    while(EndingCondition == 0)
        iter = iter + 1;
        Step(iter) = InitialStep * (1/(1+exp((iter-(MaxSteps/P1))/P2))); 
        Step(1)=InitialStep;

            for k = 1:P_size
            Population(k).OF = FunctionForOptimization(Population(k).Parameters);
            end

        [~,Indices] = sortrows([Population(:).OF]');

        if(FunctionPlot == 1)
         figure(1);
         clf
%          surf(X,Y,Val,'LineStyle','none');
         view(ViewVect)
         colormap(bone)
         hold on
         else
         end
         
         if(PointPlot == 1)
         for k = 1:1:P_size 
            plot3([Population(k).Parameters(1)],[Population(k).Parameters(2)],[Population(k).OF],'.r'); 
            hold on
         end
         end

         BestHistory(iter) = Population(Indices(1)).OF;
         CurrentHistory(iter) = Population(Indices(floor(P_size/2))).OF; 
         BestIndividualGenome(iter) = Population(Indices(1));

         NewPopulation(1) = Population(Indices(1));

         for k = 2:1:P_size
         ind1 = randi(n);

         NewPopulation(k) = Population(Indices(ind1));
         NewPopulation(k).Parameters.W1=Population(Indices(ind1)).Parameters.W1 + Step(iter)*randn(1,line_number);
         NewPopulation(k).Parameters.W2=Population(Indices(ind1)).Parameters.W2 + Step(iter)*randn(1,line_number);
         NewPopulation(k).Parameters.B=Population(Indices(ind1)).Parameters.B + Step(iter)*randn(1,line_number);
         NewPopulation(k).OF = Inf;
%          NewPopulation(k).Parameters = min(MaxRangeX(2),max(NewPopulation(k).Parameters,MaxRangeX(1)));
         end

         Population = NewPopulation;

         SimTime = toc;


         if(iter > MaxSteps)
         EndingCondition = 1;
         else
         end
         pause(Delay);
    end
 
             clc
         fprintf('\nCurrent best: %f',BestHistory(end));
         fprintf('\nIteration: %d',iter);
         fprintf('\nTime: %d',SimTime);

    figure(2);
    plot(BestHistory,'Color',ConvergenceColor); hold on      
    plot(CurrentHistory,'Color',ConvergenceColor,'LineStyle',':'); hold on
    xlabel('Generation');
    ylabel('OF value');

        figure(4);
    plot(Step)
    xlabel('iteration');
    ylabel('mutation step value');
