% Richard Hollenbach
% Student Government Board Allocations Committee Liaison 2017-2018 
% rhollen3@yahoo.com
% Cap Calculation Program

% The purpose of this program is to determine the cap for a particular
% organization based upon member size, length of establishment, and contribution amount

% Phase 1 is just a brute force calculation of the method.
% Phase 2 will include prompts to the user
% Phase 3 will be an html/Javascript webpage to be used during meetings

clc;
clear;
disp('Welcome to the Competitive Organization Cap Calculator:');
fprintf('\n');

% Variable initilization

Cap = 0;

% Prompts to user

time = input('Please enter how full years the organization been active: ');      % Time since establishment (in years)
fprintf('\n');

if (time < 1)
    Cap = 3000;
end
if (time >= 1)
    Policy = input('Has the organization opted into the policy of allowing SGB to look at the group SORC account contributions (Y or N): ','s');       % Organization opted to release their SORC account contributions
    while(~strcmp(Policy,'Y') && ~strcmp(Policy,'N'))
            Policy = input('You did not enter a valid response, please enter another one (Y/N): ','s');
    end
    fprintf('\n');
    if (Policy == 'N')
        Cap = 2000;
    end
    if (Policy == 'Y')
        Contributions = input('Please enter how much the group has contributed to this account: ');      % Financial contributions from members/fundraisers/sponsors
        fprintf('\n');

        RosterSize = input('Please enter the roster size or number of active members (counting only undergraduate Pitt Students): ');     % Size of roster/ number of members
        fprintf('\n');

        % Cap Calculation

        if (Policy == 'Y')
            if (Contributions <= 15000)
                Cap = Contributions/2;
            end
            if (Contributions > 15000)
                Cap = Contributions/3;
            end
            if (RosterSize < 59 && RosterSize >= 50)
                if (Cap > 11000)
                    Cap = 11000;
                end
            end
            if (RosterSize < 69 && RosterSize >= 60)
                if (Cap > 12000)
                    Cap = 12000;
                end
            end
            if (RosterSize < 79 && RosterSize >= 70)
                if (Cap > 13000)
                    Cap = 13000;
                end
            end
            if (RosterSize < 89 && RosterSize >= 80)
                if (Cap > 14000)
                    Cap = 14000;
                end
            end
            if (RosterSize >= 90)
                if (Cap > 15000)
                    Cap = 15000;
                end
            end
        end
    end
end

fprintf('The cap for this organization is %5.2f.',Cap);