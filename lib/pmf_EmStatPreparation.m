function [DestMat] = pmf_EmStatPreparation(SrcTable)

DestMat = zeros(5, 9);
IntVec = linspace(0,800,5); % Stimulus intensity vector

for l = 1:5
    for m = 1:5
        ValueVec =  SrcTable.Value(SrcTable.Intensity == IntVec(l) & SrcTable.Sweep == m);
        if l == 1
            DestMat(m, 5) = (ValueVec(2) - ValueVec(1) + ValueVec(5) - ValueVec(4))/2;
        else
            DestMat(m, 5+(l-1)) = ValueVec(2) - ValueVec(1);
            DestMat(m, 5-(l-1)) = ValueVec(5) - ValueVec(4);
        end
    end
end