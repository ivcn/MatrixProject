function [DM] = diffmomentSub(V,N,NTau,Ord,type,nGap,nPercentGap);

%----------------------------DIFFMOMENTSUB---------------------------------
%Ord - difference moment order
%type - type of difference moment
%    'cumulant'
%    'regular'
%N - number of points in the averaging interval;
%NTau - for how many taus;
%--------------------------------------------------------------------------

DM=zeros(1,NTau);

switch type
    case 0
        for nTau = 0:NTau-1            
                if nGap == -1
                    DM(nTau+1) = 1/(N-nTau)* sum( (V(1:(N-nTau))-V((1+nTau):N)).^Ord );
                else    
                    Tmp1 = 0;
                    i = 0;
                    for n = 1:(N-nTau)                   
                        if (V(n) == nGap) | (V(n+nTau) == nGap)
                            i = i + 1;
                        else
                            Tmp1 = Tmp1 + (V(n)-V(n+nTau)).^Ord;
                        end  
                    end
                    if i > nPercentGap./100.*(N-nTau)
                        DM(nTau+1) = 0;
                    else
                        DM(nTau+1) = 1/(N-nTau-i)*Tmp1;                                      
                    end    
                end
        end         
    case 1
        for nTau = 0:NTau-1
                if nGap == -1
                    df1 = 1/(N-nTau)* sum( (V(1:(N-nTau))-V((1+nTau):N)).^Ord );
                    df2 = 1/(N-nTau)* sum( (V(1:(N-nTau))-V((1+nTau):N)).^2 );
                else
                    df1 = 0;
                    df2 = 0;
                    i = 0;
                    for n = 1:(N-nTau)                   
                        if (V(n) == nGap) | (V(n+nTau) == nGap)
                            i = i + 1;
                        else
                            df1 = df1 + (V(n)-V(n+nTau)).^Ord;
                            df2 = df2 + (V(n)-V(n+nTau)).^2;
                        end  
                    end
                    if i > nPercentGap./100.*(N-nTau)   
                        df1 = 0;
                        df2 = 0;
                    else
                        df1 = 1/(N-nTau-i)*df1;                         
                        df2 = 1/(N-nTau-i)*df2;                      
                    end
                end
                if isequal(df2,0)
                    DM(nTau+1) = 0;
                else
                    DM(nTau+1) = df1/df2.^(Ord/2);
                end
        end                    
end

    