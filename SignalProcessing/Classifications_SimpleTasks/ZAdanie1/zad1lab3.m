rng('shuffle');
Clusters.ClustersA = 5;
Clusters.ClustersB = 4;

%Clusters.ACoordinates = randn(2,Clusters.ClustersA);
%Clusters.BCoordinates = randn(2,Clusters.ClustersB);
for k = 1:Clusters.ClustersA
   plot(Clusters.ACoordinates(1,k),Clusters.ACoordinates(2,k),...
'or','MarkerSize',25); hold on
end
for k = 1:Clusters.ClustersB
   plot(Clusters.BCoordinates(1,k),Clusters.BCoordinates(2,k),...
'ob','MarkerSize',25); hold on
end
xlim([-2 4]);
ylim([-2,4]);
save Clusters Clusters