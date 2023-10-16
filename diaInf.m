load('diaNet.mat', 'diaNet');

sw = 0;

if sw == 0
    data = readmatrix('diamonds.csv');

    data = rot90(data, -1);

    dataPrep = [ data(1,:); data(2,:); data(3,:); data(4,:); data(5,:); data(6,:); data(8,:); data(9,:); data(10,:)]; 

    test = dataPrep(:,30510)
end
if sw == 1
    carat = 0.3;
    cut = 1;
    color = 1;
    clarity = 1;
    depth = 60;
    table = 50;
    x = 4;
    y = 4;
    z = 4;

    test = [carat; cut; color; clarity; depth; table; x; y; z]
end

sampleSize = 100;
barData = zeros(1,sampleSize);
errHigh = zeros(1, sampleSize);
errLow = zeros(1,sampleSize);
barRange = 1:sampleSize;
stdDev = 0;

for k = 1:sampleSize
    randomI = randi([1 53940]);
    result = diaNet(dataPrep(:,randomI));
    barData(1,k) = result;

    % if result is higher than expected, save the deviation.
    if result > data(7,randomI)
        err = (result - data(7,randomI));
        errHigh(1,k) = err;
    end

    % if result is lower than expected, save the deviation.
    if result < data(7,randomI)
        err = (data(7,randomI) - result);
        errLow(1,k) = err;
    end

    % calculate the standard deviation.
    stdDev = stdDev + (err / sampleSize);
end

% displat standard deviation.
disp(stdDev);
bar(barRange, barData);
set(gca, 'Color', [0 0 0]);
hold on
er = errorbar(barRange, barData, errLow, errHigh);
er.Color = [1 0 0];                            
er.LineStyle = 'none';  
hold off

val = diaNet(test);
fprintf("Estimated Diamond Value: %f", val);

