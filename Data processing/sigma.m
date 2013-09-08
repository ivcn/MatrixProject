function [ output ] = sigma( noised, smoothed )
% SIGMA ��������� ������������������ ���������� ����� ������� �� ������
% ������ ��������-����������� ������� �� ������� ��������� ����������
% ������ - �������, ���������� ������� ���������
if(size(noised)~=size(smoothed))
    error('MATLAB: size mismatch');
end
N = size(smoothed,1)*size(smoothed,2);
sum = 0; 
for i=1:size(smoothed,1)
    for j=1:size(smoothed,2)
        if ~isnan(noised(i,j)) && ~isnan(smoothed(i,j))
            sum = sum + (smoothed(i,j)-noised(i,j))^2;
        end
    end
end
output=sqrt(sum/N);

end

