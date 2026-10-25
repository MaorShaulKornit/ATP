classdef OD < elmnt   
    properties
        H
        W
    end
    methods
        function obj = OD(pos,sz,ch,msk,scnbl,ChName)
            obj = obj@elmnt(pos,sz,ch,'OD',msk,scnbl,pos,ChName);
            obj.H = sz(1);
            obj.W = sz(2);
        end      
    end
end

