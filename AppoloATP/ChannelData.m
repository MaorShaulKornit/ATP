classdef ChannelData
    properties
        Dta
        Ch
        ind
    end
    
    methods
        function obj = ChannelData(Dta,Ch,ind)
            obj.Dta = Dta;
            obj.Ch = Ch;
            obj.ind = ind;
        end
    end
end

