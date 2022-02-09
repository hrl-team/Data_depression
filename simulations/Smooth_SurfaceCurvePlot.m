function [curve sem] = Smooth_SurfaceCurvePlot(DataMatrix,Chance,Color,Line,Alpha,Yinf,Ysup,Font,Title,LabelX,LabelY,XTickLabel)

[Ntrial Nsub]=size(DataMatrix);

curve= nanmean(DataMatrix,2);
sem  = nanstd(DataMatrix')'/sqrt(Nsub);

curveSup = (curve+sem);
curveInf = (curve-sem);

for n=1:Ntrial;
    chance(n,1)=Chance(1);
    chance(n,2)=Chance(2);
    chance(n,3)=Chance(3);
end
plot(smooth(curve+sem),...
    'Color',Color,...
    'LineWidth',Line, 'HandleVisibility','off');
hold on
plot(smooth(curve-sem),...
    'Color',Color,...
    'LineWidth',Line, 'HandleVisibility','off');
hold on
plot(smooth(curve),'B',...
    'Color',Color,...
    'LineWidth',Line*2);
hold on
fill([1:Ntrial flipud([1:Ntrial]')'],[smooth(curveSup)' flipud(smooth(curveInf))'],'k',...
    'LineWidth',1,...
    'LineStyle','none',...
    'FaceColor',Color,...
    'FaceAlpha',Alpha, 'HandleVisibility','off');
% plot(smooth(chance),'k:',...
%    'LineWidth',Line/4, 'HandleVisibility','off');
axis([0 Ntrial+1 Yinf Ysup]);
set(gca,'Fontsize',Font);
%set(gca, 'XTickLabel', XTickLabel)
title(Title);
xlabel(LabelX);
ylabel(LabelY);
box ON