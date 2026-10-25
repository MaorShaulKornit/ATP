classdef Line < elmnt    
    properties
       H
       W
       stepSz
    end
    methods
        function obj = Line(pos,ch,msk,H,W,isscanable,stepSz,ChName)
            sz = [H,W];
            obj = obj@elmnt(pos,sz,ch,'Line',msk,isscanable,[],ChName);
            obj.H = H;
            obj.W = W;
            obj.stepSz = stepSz;
            obj.scanpos = obj.getStepPos(obj.stepSz/2);
        end
        
        function spos = getStepPos(obj,offset)
            p1 = obj.pos - [0,obj.W/2] + [0,offset];
            p2 = obj.pos + [0,obj.W/2] - [0,offset];
            nsteps = round((p2(2)-p1(2))./obj.stepSz);
            spos = linspace2D(p1,p2,nsteps);
        end
    end
end
