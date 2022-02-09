function [Nbar,Nsub] = violinplot(DataCell,Colors,Yinf,Ysup,Font,Title,LabelX,LabelY,varargin)

% Sophie Bavard - December 2018
% Creates a violin plot with mean, error bars, confidence interval, kernel density.
% Warning: the function can accept any number of arguments > 9.
% After the Title, LabelX, LabelY : varargin for bar names under X-axis

% transforms the Data matrix into cell format if needed
if iscell(DataCell)==0
    DataCell = num2cell(DataCell,2);
end

% number of factors/groups/conditions
Nbar = size(DataCell,1);
% bar size
Wbar = 0.75;

% confidence interval
ConfInter = 0.95;

% color of the box + error bar
trace = [0.5 0.5 0.5];

for n = 1:Nbar
    
    clear DataMatrix
    clear jitter jitterstrength
    DataMatrix = DataCell{n,:}';
    
    % number of subjects
    Nsub = length(DataMatrix(~isnan(DataMatrix)));
    
    curve = nanmean(DataMatrix);
    sem   = nanstd(DataMatrix')'/sqrt(Nsub);
    conf  = tinv(1 - 0.5*(1-ConfInter),Nsub);
    
    
    % PLOT THE VIOLINS
    
    % calculate kernel density estimation for the violin
    [density, value] = ksdensity(DataMatrix, 'Bandwidth', 0.9 * min(std(DataMatrix), iqr(DataMatrix)/1.34) * Nsub^(-1/5)); % change Bandwidth for violin shape. Default MATLAB: std(DataMatrix)*(4/(3*Nsub))^(1/5)
    density = density(value >= min(DataMatrix) & value <= max(DataMatrix));
    value = value(value >= min(DataMatrix) & value <= max(DataMatrix));
    value(1) = min(DataMatrix);
    value(end) = max(DataMatrix);
    
    % all data is identical
    if min(DataMatrix) == max(DataMatrix)
        density = 1; value = 1;
    end
    width = Wbar/2/max(density);
    
    % plot the violin
    fill([n+density*width n-density(end:-1:1)*width],...
        [value value(end:-1:1)],...
        Colors(n,:),...
        'EdgeColor', trace,...
        'FaceAlpha',0.15);
    hold on    
    
    % CONFIDENCE INTERVAL    
    inter = unique(DataMatrix(DataMatrix<curve+sem*conf & DataMatrix>curve-sem*conf),'stable')';
    if length(density) > 1
        d = interp1(value, density*width, [curve-sem*conf sort(inter) curve+sem*conf]);
    else % all data is identical
        d = repmat(density*width,1,2);
    end 
    fill([n n+d n],...
        [curve-sem*conf curve-sem*conf sort(inter) curve+sem*conf curve+sem*conf],...
        Colors(n,:),...
        'EdgeColor', 'none',...%trace,...
        'FaceAlpha',0.4);
    hold on
    fill([n n-d n],...
        [curve-sem*conf curve-sem*conf sort(inter) curve+sem*conf curve+sem*conf],...
        Colors(n,:),...
        'EdgeColor', 'none',...%trace,...
        'FaceAlpha',0.4);
    hold on
    
    % INDIVIDUAL DOTS INSIDE VIOLIN
    if length(density) > 1
        jitterstrength = interp1(value, density*width, DataMatrix);
    else % all data is identical
        jitterstrength = density*width;
    end
    % dots are scattered randomly
    %     jitter = 2*(rand(size(DataMatrix))-0.5);
    % dots are scattered in same order
    jitter = zscore(1:length(DataMatrix))'/max(zscore(1:length(DataMatrix))');
%     scatter(n + jitter.*jitterstrength, DataMatrix, 20,...
%         'marker','o',...
%         'LineWidth',1,...
%         'MarkerEdgeColor',Colors(n,:),...
%         'MarkerEdgeAlpha',.7);
    hold on
    
    % MEAN HORIZONTAL BAR
    xMean = [n-Wbar/2 ; n + Wbar/2];
    yMean = [curve; curve];
    plot(xMean,yMean,'-','LineWidth',1,'Color',Colors(n,:));
    hold on
    
    % ERROR BARS
    errorbar(n,curve,sem,...
        'Color',Colors(n,:)-.1,...
        'LineStyle','none',...  'CapSize',3,...
        'LineWidth',2);
    hold on    
        
    % CONFIDENCE INTERVAL RECTANGLE
    rectangle('Position',[n-Wbar/2, curve - sem*conf, Wbar, sem*conf*2],...
        'EdgeColor',[0.5 0.5 0.5],...
        'LineWidth',1);
    hold on
    
end

% axes and stuff
ylim([Yinf Ysup]);
set(gca,'FontSize',Font,...
    'XLim',[0 Nbar+1],...
    'XTick',1:Nbar,...
    'XTickLabel',varargin);
%yline(0);

title(Title);
xlabel(LabelX);
ylabel(LabelY);













