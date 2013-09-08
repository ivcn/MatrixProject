function [ out ] = Normalization( in )
%NORMALIZATION ������������ �������.
%�������������� ������� �������� � ����� ��� ������ ������.
%����������� �������� ������� �������� �� ��������, ����� ������� �� �����.
%� ���������� ���������� ��������������� ������� ����������.
Nrow = size(in,1);
Ncol = size(in,2);
out = zeros(size(in));
for i=1:Nrow
    m = mean(in(i,:));
    s = std(in(i,:));
    for j=1:Ncol
        out(i,j) = (in(i,j)-m)/s;
    end
end

end

