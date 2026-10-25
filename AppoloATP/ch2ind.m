function ind = ch2ind(DB,ch)
if iscell(ch)
    ind = [];
    for p = 1:length(ch)
        ind = cat(2,ind,find(strcmp(DB.AllCh,ch{p})));
    end
else
    ind = find(strcmp(DB.AllCh,ch));
end
