classdef Scan < elmnt 
    properties
       dist 
       ref
       H
       W
    end
    methods
        function obj = Scan(pos,sz,ch,msk,dist,isref,ChName)
            obj = obj@elmnt(pos,sz,ch,'Scan',msk,1,pos,ChName);
            obj.dist = dist;
            if isref
                obj.ref = true;
            else
                obj.ref = false;
            end
            obj.H = sz(1);
            obj.W = sz(2);            
        end
        
%         function A = AddToA(obj,A,res)
%             bw = Types.(obj.type)(obj,res);
%             pos_pix = mm2pix_rounded(obj.pos,res);
%             A = AddCntrBW2A(bw,A,pos_pix);
%         end        
    end
end
