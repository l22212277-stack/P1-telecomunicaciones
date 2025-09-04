function Yout = cuantificador(Xin, Nbits)
   p=(max(Xin)/(2^Nbits))-1 :(max(Xin)/(2^Nbits)): max(Xin);
   Yout = quantiz (Xin,p);
end

