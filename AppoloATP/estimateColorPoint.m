function Ch = estimateColorPoint(A)

% 0,0,0 - W
% 250,175,48 - Orange
% 100,120,197 - Purple
% 70,205,132 - Olive

C = [0,0,0;250,175,48;100,120,197;70,205,132];
D = pdist2(A,C);
[~,ind] = min(D);
switch ind
    case 1
        Ch = 'W';
    case 2
        Ch = 'Or';
    case 3
        Ch = 'Pr';
    case 4
        Ch = 'Ov';
    otherwise
        Ch = 'Unknown';
end