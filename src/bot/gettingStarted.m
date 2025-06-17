function gettingStarted()
    % GETTINGSTARTED Open the getting started guide for the toolbox
    %
    %   GETTINGSTARTED() opens the getting started guide for the toolbox.
    %
    %   Example:
    %       bot.gettingStarted()
    %
    %   See also bot.toolboxdir, bot.toolboxversion

    % Display welcome message
    fprintf('Welcome to Brain Observatory Toolbox!\n\n');
    fprintf('A MATLAB toolbox for interacting with the Allen Brain Observatory\n\n');
    
    % Display version information
    fprintf('Version: %s\n', bot.toolboxversion());
    
    % Display directory information
    fprintf('Toolbox directory: %s\n\n', bot.toolboxdir());
    
    % Display available functions
    fprintf('Available functions:\n');
    fprintf('  - bot.toolboxdir\n');
    fprintf('  - bot.toolboxversion\n');
    fprintf('  - bot.gettingStarted\n\n');
    
    % Display examples
    fprintf('Examples:\n');
    examplesDir = fullfile(bot.toolboxdir(), 'code', 'examples');
    if exist(examplesDir, 'dir')
        exampleFiles = dir(fullfile(examplesDir, '*.m'));
        if ~isempty(exampleFiles)
            for i = 1:length(exampleFiles)
                fprintf('  - %s\n', exampleFiles(i).name);
            end
        else
            fprintf('  No examples found.\n');
        end
    else
        fprintf('  Examples directory not found.\n');
    end
    
    % Display documentation
    fprintf('\nDocumentation:\n');
    docsDir = fullfile(bot.toolboxdir(), 'docs');
    if exist(docsDir, 'dir')
        fprintf('  Documentation is available in the docs directory:\n');
        fprintf('  %s\n', docsDir);
    else
        fprintf('  Documentation directory not found.\n');
    end
    
    fprintf('\nFor more information, see the README.md file in the toolbox directory.\n');
end
