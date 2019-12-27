function bplot(Y, X, C)

% X & Y is cell array containing k elements.
% C is the legend of the plot; a string vector containing.
% This function only works if,
% unique(X{i}) is equal for any 1 < i <= k.

Colors = [0, 0, 0;
          0, 0, 1;
          0.9290, 0.6940, 0.1250;
          0.4940, 0.1840, 0.5560;
          0.4660, 0.6740, 0.1880;
          0.3010, 0.7450, 0.9330;
          0.6350, 0.0780, 0.1840];

XaxisVal = unique(X{1});
% Xticknum = max(ZXLOOP2)
Xticknum = length(XaxisVal);

% # of objects
k = length(C);

% Width of whisker
wd = 2;
% Distance between x-ticks
q = k*wd + 2*k*wd + 1.5*k;

% Center location on X-axis
loc = q*(1 : Xticknum)'; % 10,20,30,40,50,60
% Lookup Matrix for location on X-axis
lookup = split(loc, k, 2*wd);

for i =1:k
    % Ordering the values of X{i}
    [~,~,ValOrder{i}] = unique(X{i});
    Mloc{i} = lookup(ValOrder{i},i);
end

figure()
hold on
grid on
for i = 1:k
    boxplot(Y{i}, X{i}, 'Positions', lookup(:,i), 'Widths', 1.2*wd, 'Colors', Colors(i,:))
    scatter(Mloc{i}, Y{i}, 18, 'filled', 'MarkerFaceColor', Colors(i,:))
end
xticks(loc)
xticklabels(num2cell(XaxisVal))
% xlim([-0.2*min(f1),1.2*max(f1)])
% ylim([-20, 20])
set(gca, 'FontSize',12)
xlabel('Requested ANR','Interpreter','latex','FontSize',14)
ylabel('Offset(\%)','Interpreter','latex','FontSize',14)
legend(C,'Interpreter','latex','FontSize',8,'Location','northwest')
set(gca,'TickLabelInterpreter','latex')



end

function w = split(c, n, d)
   a1 = c - (n-1)*d/2;
   an = a1 + (n-1)*d;
   for i = 1:length(c)
        w(i,:) = linspace(a1(i,:), an(i,:), n);
   end
end

% Lessons learned: 
% 1. Using cell array to bundle up vectors of differing length.
% 2. Split function: to create an arithmetic sequence given its cental
% term, number of terms and the common difference.
% 3. Using xticks() & xticklabls()