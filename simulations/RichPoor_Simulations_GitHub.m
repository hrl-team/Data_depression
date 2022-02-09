%% Define the parameters
% stefano Palminteri 2022
% require violinplot_stefano.m 
% require Smooth_SurfaceCurvePlot.m


rand('state',sum(100*clock));
close all
clear all



nsubjects=1000;                             % N of virtual subjects
initialization=0;                           % initial Q-value    
rescale=0;                                  %  outcome rescaling (none because centered task)
rewardprob(1,:)=[0.4 0.1];                  % rich
rewardprob(2,:)=[0.9 0.6];                  % poor
states=[repmat(1,1,50) repmat(2,1,50)];     % alternance among the states 

trials   =numel(states);                    % N of trials per conditions / context
%% Run the simulations
for n=1:nsubjects;
    
    paramsub=[rand rand];
    paramsub(3)=[paramsub(2)]; % the two learning rate are the same for the unbiased model
    scale=rand; % how much to degrate the othe rlearning rate
    paramsub2=[paramsub(1:2) paramsub(2)*scale]; % optimistic
    paramsub3=[paramsub(1) paramsub(2)*scale paramsub(3)];%pessimistic
    

    
    
    sub1(n,:)=paramsub;
    sub2(n,:)=paramsub2;
    sub3(n,:)=paramsub3;
    
    [choicesRe(n,:),  outcomesRe(n,:), probaRe(n,:)  Q1Re(n,:)  Q2Re(n,:)]  = RichPoorTask(paramsub,trials,rewardprob,initialization,rescale,states);
    [choicesRe2(n,:), outcomesRe2(n,:),probaRe2(n,:) Q1Re2(n,:) Q2Re2(n,:)] = RichPoorTask(paramsub2,trials,rewardprob,initialization,rescale,states);
    [choicesRe3(n,:), outcomesRe3(n,:),probaRe3(n,:) Q1Re3(n,:) Q2Re3(n,:)] = RichPoorTask(paramsub3,trials,rewardprob,initialization,rescale,states);
    

    
end



%% learning rates of the simulations 

colors(2,:)=[223 83 107]./255;
colors(1,:)=[146 208 80]./255;
colors(4,:)=[223 83 107]./255;
colors(3,:)=[146 208 80]./255;
figure
subplot(1,3,1)
violinplot_stefano(sub1(:,2:3)', colors, ...
    -0, 1, 14, 'Unbiased', '','','');
xticklabels({'\alpha_+','\alpha_-'});
box ON
plot(0:5,repmat(0,6,1),'k','Linewidth',1);
set(gca,'Fontsize',15)
subplot(1,3,2)
violinplot_stefano(sub2(:,2:3)', colors, ...
    -0, 1, 14, 'Positivity bias', '','','');
xticklabels({'\alpha_+','\alpha_-'});
box ON
plot(0:5,repmat(0,6,1),'k','Linewidth',1);
set(gca,'Fontsize',15)
subplot(1,3,3)
violinplot_stefano(sub3(:,2:3)', colors, ...
    -0, 1, 14, 'Negativity bias', '','','');
xticklabels({'\alpha_+','\alpha_-'});
box ON
plot(0:5,repmat(0,6,1),'k','Linewidth',1);
set(gca,'Fontsize',15)
%%

%% rerranging the simulations  
% to translate with our matrices
% 2 is optimistic is controls
% 3 is pessimisti is patients 
% 1:50 rich 
% 51:100 poor

richcont=choicesRe2(:,1:50)'-1;
poorcont=choicesRe2(:,51:100)'-1;
richdepr=choicesRe3(:,1:50)'-1;
poordepr=choicesRe3(:,51:100)'-1;
% Continuous plot with function smooth
green(1,:)=[0.1 0.5 0];   % green = control
green(2,:)=[0.4 0.8 0.5];
orange(1,:)=[0.9 0.4 0];     % orange = depressed
orange(2,:)=[1 0.7 0.3];



% Learning curves without legends
figure('Name','5pts Smoothed Correct Choice','NumberTitle','off','Renderer', 'painters');
x=subplot(1,2,1);
Smooth_SurfaceCurvePlot(richcont,green(1,:),green(1,:),2,0.25,0.35,0.85,12,'','','',[0:10:50]);
hold on 
Smooth_SurfaceCurvePlot(poorcont,green(2,:),green(2,:),2,0.25,0.35,0.85,12,'','','',[0:10:50]);
grid on
hold off
axis([1 50 0.35 0.85]);
set(gca,'Fontsize',18);
legend(x(1,:),{'rich','poor'}, 'location','south');
%legend(x(1,1),{'rich','poor','significativity'});
y=subplot(1,2,2);
Smooth_SurfaceCurvePlot(richdepr,orange(1,:),orange(1,:),2,0.25,0.35,0.85,12,'','','',[0:10:50]);
hold on 
Smooth_SurfaceCurvePlot(poordepr,orange(2,:),orange(2,:),2,0.25,0.35,0.85,12,'','','',[0:10:50]);
grid on

axis([1 50 0.35 0.85]);
set(gca,'Fontsize',18);
legend(y(1,:),{'rich','poor'}, 'location','south');


%%
function [act, rew, P Q1 Q2] = RichPoorTask(params,trials,contingencies,init,rescale,s)

beta  =params(1);
alpha1=params(2);
alpha2=params(3);


Q  = zeros(2,2)+init;

t=0;



for i=1:trials
    
    t=t+1;
    
    P(t)=1/(1+exp((Q(s(t),1)-Q(s(t),2))/( beta )));
    
    act(t)=(P(t)>rand)+1;
    
    
    rew(t)=((rand>contingencies(s(t),act(t)))-0.5)*2+rescale;
    
    
    PE = rew(t) - Q(s(t),act(t));
    
    Q(s(t),act(t))   = Q(s(t),act(t)) +  alpha1 * PE * (PE>0) +  alpha2 * PE * (PE<0) ;
    
    Q1(t)=Q(s(t),1);
    Q2(t)=Q(s(t),2);
    
end

end

