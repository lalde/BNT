% Plot animal's run path for a specified trial
%
% Visualize animal's run path of a provided trial.
%
%  USAGE
%   plot.pathTrial(trialNum)
%   trialNum        Optional trial number that is used for visualization.
%                   If omited, then current trial is used.
%   <options>       Options for function <a href="matlab:help plot">plot</a>.
%
function pathTrial(trialNum, varargin)
    if nargin < 1
        trialNum = data.getCurrentTrialNum();
    elseif ischar(trialNum)
        varargin = {trialNum, varargin{:}};
        trialNum = data.getCurrentTrialNum();
    elseif ~helpers.isdscalar(trialNum, '>=0')
        error('Incorrect value for ''trialNum'' (type ''help <a href="matlab:help plot.pathTrial">plot.pathTrial</a>'' for details).');
    end

    oldTrial = data.getCurrentTrialNum();
    data.setTrial(trialNum);

    pos = data.getPositions();

    holded = ishold();
    for i = 1:data.getNumSessions()
        [startPos, endPos] = data.getRunIndices(i);
        plot(pos(startPos:endPos, 2), pos(startPos:endPos, 3), varargin{:});
        if i == 1
            hold on;
        end
    end

    if holded == 1
        hold on;
    else
        hold off;
    end

    data.setTrial(oldTrial);
end
