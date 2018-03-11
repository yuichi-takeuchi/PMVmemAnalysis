function [DestMat] = pmf_APHzStatPreparation(SrcTable)

DestMat = zeros(5, 9);
IntVec = linspace(0,800,5); % Stimulus intensity vector

for l = 1:5
    for m = 1:5
        APHzPosiPre = length(SrcTable.Segment(SrcTable.Intensity == IntVec(l) & SrcTable.Sweep == m & SrcTable.Segment == 1))/2.5;
        APHzPosi = length(SrcTable.Segment(SrcTable.Intensity == IntVec(l) & SrcTable.Sweep == m & SrcTable.Segment == 2))/2.5;
        APHzNegaPre = length(SrcTable.Segment(SrcTable.Intensity == IntVec(l) & SrcTable.Sweep == m & SrcTable.Segment == 4))/2.5;
        APHzNega = length(SrcTable.Segment(SrcTable.Intensity == IntVec(l) & SrcTable.Sweep == m & SrcTable.Segment == 5))/2.5;
        if l == 1
            DestMat(m, 5) = (APHzPosi - APHzPosiPre + APHzNega - APHzNegaPre)/2;
        else
            DestMat(m, 5+(l-1)) = APHzPosi - APHzPosiPre;
            DestMat(m, 5-(l-1)) = APHzNega - APHzNegaPre;
        end
    end
end