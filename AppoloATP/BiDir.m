classdef BiDir < elmnt   
    properties
       dist 
       ref
       H
       W
    end    
    methods
        function obj = BiDir(pos,sz,ch,msk,dist,isref,ChName)
            obj = obj@elmnt(pos,sz,ch,'BiDir',msk,1,pos,ChName);
            obj.dist = dist;
            if isref
                obj.ref = true;
            else
                obj.ref = false;
            end
            obj.H = sz(1);
            obj.W = sz(2);
        end
    end
end
