function tf = invertCond(ch,Type)
tf = false;
if strcmp(Type,'OD')
    if strcmp(ch,'W1')|| strcmp(ch,'W2') || strcmp(ch,'W3') || strcmp(ch,'W4') ||...
            strcmp(ch,'DB') || strcmp(ch,'Ic') || strcmp(ch,'Qc') || strcmp(ch,'Iw') ||...
            strcmp(ch,'Qw') 
        tf = true;
    end
end
end