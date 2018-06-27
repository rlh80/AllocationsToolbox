% Richard Hollenbach
% Student Government Board Allocations Committee Liaison 2017-2018
% rhollen3@yahoo.com
% Cap Optimization Program

% The purpose of this program is to determine the most optimal quantity of
% each line item to get the request as close to the desired cap as
% possible

% Phase 1 is just a brute force calculation of the method.
% Phase 2 will include prompts to the user
% Phase 3 will be an html/Javascript webpage to be used during meetings

% Last updated on June 26th, 2018 by Ricky Hollenbach

clc;
clear;

disp('Welcome to the Allocations Cap Optimization Program:');
fprintf('\n');

% Initial Inputs from the user

cap = input('What is the cap for the request: ');                   % Cap or maximum amount that can be funded for
fprintf('\n');

items = input('How many lines items are in the request: ');         % Number of line items
fprintf('\n');

                                                                    % Initialization of Variables and Arrays

perms = 1;                                                          % Max number of permutations based up number of items and quantities
maxcap = 0;
Value = zeros(1,items);                                             % Array of item values
ItemCap = zeros(items,1);                                           % Array of Quantity Values
minerror = cap;
FinalQuant = zeros(items,1);                                        % Will be Array of the optimized quantities

% Line item inputs

for h = 1:items
    fprintf('For Line Item %d: \n',h);
    Value(1,h) = input('Enter its value here: ');                   % Value of each line item
    ItemCap(h,1) = input('Enter the quantity requested: ');         % Max quantity for each item
    perms = perms * (ItemCap(h,1)+ 1);                              % Adds up each item to find the total number of permutations
    tempCap = ItemCap(h,1);
    if tempCap > maxcap
        maxcap = tempCap;
    end
    fprintf('\n');
end

% Form matrix of all permutations up to the max quantities

Quant = zeros(items,perms);                                         % Array that will contain all the permutations
length = 1;
for i = items:-1:1
    j = 1;
    max = ItemCap(i,1);
    while j < perms
        for k = 0:max
            for l = 1:length
                Quant(i,j) = k;
                j = j+1;
            end
        end
    end
    length = length * (ItemCap(i,1)+1);
end

% Iterate through all permutations and determine the error for each
% Keep track of the quantities for the min error

count = 0;
TempQuant = zeros(items,1);                                         % Array that will temporarily hold the current quantities
for k = 1:perms
    TempQuant(:,1) = Quant(:,k);
    temperror = cap - (Value * TempQuant);                          % Temporary error from the cap and the current quantities
    if temperror < minerror && temperror >= 0                       % If this temp error is lower than the current error, it currently is the best solution
       minerror = temperror;
       FinalQuant = TempQuant;
       count = 1;
    end
    if temperror == minerror
        count = count + 1;                                          % If the temperror equals the current error, then it is another equal solution
    end
end

% Calculate how much will be funded and cut for optimized quantity

funding = 0;
total = 0;

for p=1:items
    funding = funding + FinalQuant(p,1)* Value(1,p);
    total = total + Value(p)*ItemCap(p);
end
cutcost = total-funding;

% Display the amount allocated for each line item

fprintf('-----------------------------------------------------------\n');
fprintf('-------------------------Results---------------------------\n');
fprintf('-----------------------------------------------------------\n\n');
for q=1:items
    fprintf('We can allocate %d out of %d for item %d ($%5.2f)', FinalQuant(q), ItemCap(q), q, Value(1,q));
    fprintf('\n');
end

% Display the final funded cost, cut cost, ect.

fprintf('\n The total cost of all items is: $%5.2f', total);
fprintf('\n The funded amount of all items is: $%5.2f', funding);
fprintf('\n The amount below the cap is: $%5.2f', minerror);
fprintf('\n The cut cost of all items is: $%5.2f', cutcost);
fprintf('\n The number of equal solutions is: %3d', count);
fprintf('\n\n');