function [indStart,indEnd] = getVerticalStartEndValues(im)
C = max(im);
indStart = find(C,1);
indEnd = find(C,1,'last');
end
