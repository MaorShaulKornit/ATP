function [info1,info2,info3] = SplitInfo(info,HSPos)

T = struct2table(info);
info1 = T(strcmp(T.type,'OD'),:);
info2 = T(strcmp(T.type,'BiDir') | strcmp(T.type,'Scan'),:);
info3 = T(strcmp(T.type,'Line'),:);

info1 = table2struct(cat(1,info1,T(HSPos:end,:)));
info2 = table2struct(cat(1,info2,T(HSPos:end,:)));
info3 = table2struct(info3);
