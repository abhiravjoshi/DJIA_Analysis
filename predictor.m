function [a,X] = predictor(xInput, p, r)
    % Abhirav Joshi, ECE 4271, Part II d
    % covariance predictor using:
    % xInput matrix of specific values in a certain period of time
    % p predictor value to determine closeness of data train
    % r value is interest (hardly used, but necessary)
    x_vec = []; X = [];
    for i=p+1:length(xInput)
        if(i+r<=length(xInput))
            x_vec = [x_vec;xInput(i+r)];
        else
            x_vec = [x_vec;0];
        end
        temp = [];
        for j=1:p
            if(i-j>=1 && i-j<=length(xInput))
                temp = [temp xInput(i-j)];
            else
                temp = [temp 0];
            end
        end
        X= [X; temp];
    end
    a = -X\x_vec;
    % output a vector of coefficients
    % output X matrix of predicted values
end