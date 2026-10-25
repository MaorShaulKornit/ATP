xclear info
T = [];
for t = 1:size(info,2)
    if length(info(t).ch)>1 && iscell(info(t).ch)
        Ch = info(t).ch;
        Msk = info(t).msk;
        A = [0,0,0];
        for p = 1:length(Ch)
            if strcmp(Ch{p},'Qc') | strcmp(Ch{p},'Qw') | strcmp(Ch{p},'Ic') | strcmp(Ch{p},'Iw')|...
                strcmp(Ch{p},'W1') | strcmp(Ch{p},'W2') | strcmp(Ch{p},'W3') | strcmp(Ch{p},'W4')
                Msk(p) = 0;
            end
        end

        if sum(Msk)>0
            Msk = Msk./sum(Msk);
        end

        for p = 1:length(Ch)
            Color = KUtils.getRGBVal(Ch{p});
            A = A + Color .* Msk(p);
        end
        T = cat(1,T,[t,A]);
    end
end

