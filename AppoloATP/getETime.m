function T = getETime(ch,Type)
if strcmp(Type,'OD')
   if strcmp(ch,'W1') || strcmp(ch,'W2') || strcmp(ch,'W3') || strcmp(ch,'W4')
       T = 3;
   else
       switch ch
           case 'DB'
               T = 1;
           case 'C'
               T = 3.06;               
           case 'M'
               T = 3.6;
           case 'Y'
               T = 3.96;
           case 'K'
               T = 7;
           case 'R'
               T = 3;
           case 'G'
               T = 3;
           case 'Np'
               T = 1;
           case 'Ny'
               T = 2;
           otherwise
               T = 1;
       end
end
else
   if strcmp(ch,'W1') || strcmp(ch,'W2') || strcmp(ch,'W3') || strcmp(ch,'W4') ||...
           strcmp(ch,'Ic') || strcmp(ch,'Qc') || strcmp(ch,'Iw') || strcmp(ch,'Qw')
       T = 10;
   else
       T = 3.06;
   end
end
    