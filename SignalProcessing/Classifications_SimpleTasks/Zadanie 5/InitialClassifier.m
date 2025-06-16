function [ClassLabel] = InitialClassifier(x,y,Parameters)

 ClassLikelihood=0;

 for k = 1:length(Parameters.W1)

 if(Parameters.W1*x + Parameters.W2*y + Parameters.B > 0)
 ClassLikelihood = ClassLikelihood + 1;

 else
 ClassLikelihood = ClassLikelihood - 1;

 end
 end

 if(ClassLikelihood>0)
     ClassLabel=1;
 else
     ClassLabel=0;
 end
end