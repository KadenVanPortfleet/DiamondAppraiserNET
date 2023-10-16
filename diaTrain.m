% import data set
data = readmatrix('diamonds.csv');

% rotate data set so that each item has variable in columns.
dataRot = rot90(data, -1);

% Get target values from dataset
targets = dataRot(7,:);

% Remove diamond cost from dataset.
dataPrep = [ dataRot(1,:); dataRot(2,:); dataRot(3,:); dataRot(4,:); dataRot(5,:); 
    dataRot(6,:); dataRot(8,:); dataRot(9,:); dataRot(10,:)]; 

% feed forward network using 10 hidden layers
net = feedforwardnet(10);

% start training
net = train(net, dataPrep, targets);

% save network as variable diaNet for later inference.
diaNet = net;

% save session variables to file (including our trained network)
save diaNet