function zapis_vektora(x,str)
%funkciya zapisivaet stolbec ili stroku "x" v vide stolbca po adresu "str"

F=fopen(str,'wt+');
if F ~= -1  %eto zna4it 4to fayl uspeshno otkrilsya
    for r=1:length(x)
        fprintf(F,' %15.8f \n ',x(r));
    end
end
fclose(F);
