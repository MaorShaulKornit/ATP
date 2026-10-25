classdef Types 
    methods (Static)
        function bw = OD(el,res)
            ODOb = ones(mm2pix_rounded(el.sz_mm,res));
            bw = BWMker.Mask_Stat(ODOb,el.msk);
        end
        
        function bw = Line(el,res)
            ODOb = ones(mm2pix_rounded(el.sz_mm,res(1)));
            bw = BWMker.Mask_Stat(ODOb,el.msk);
        end
        
        function [bw1,bw2] = Scan(el,res)
            esz_pix = mm2pix_rounded(el.sz_mm,res);
            dist_pix = mm2pix_rounded(el.dist,res);
            bw = ones(esz_pix(1),ceil(esz_pix(2)/2));
            bw = cat(1,bw,zeros(dist_pix(1),ceil(esz_pix(2)/2)));
            bw = cat(1,bw,zeros(esz_pix(1),ceil(esz_pix(2)/2)));
            bw1 = bw;
            bw2 = flipud(bw);
            emptybw = false(size(bw1));
            if el.ref
                bw1 = mergeLR(bw1,emptybw);
                bw2 = mergeLR(bw2,emptybw);
            else
                bw1 = mergeLR(emptybw,bw1);
                bw2 = mergeLR(emptybw,bw2);
            end
            bw1 = BWMker.Mask_Stat(bw1,el.msk);
            bw2 = BWMker.Mask_Stat(bw2,el.msk);
        end 
        
        function [bw] = BiDir(el,res)
            esz_pix = mm2pix_rounded(el.sz_mm,res);
            dist_pix = mm2pix_rounded(el.dist,res);
            bw = ones(esz_pix(1),ceil(esz_pix(2)/2));
            bw = cat(1,bw,zeros(dist_pix(1),ceil(esz_pix(2)/2)));
            bw = cat(1,bw,zeros(esz_pix(1),ceil(esz_pix(2)/2)));
            bw1 = bw;
            bw2 = flipud(bw);
            if el.ref
                bw = mergeLR(bw1,bw2);
            else
                bw = mergeLR(bw2,bw1);
            end
            bw = BWMker.Mask_Stat(bw,el.msk);
        end 
    end
end
