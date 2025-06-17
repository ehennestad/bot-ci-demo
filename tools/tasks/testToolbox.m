function testToolbox(varargin)
    projectRootDir = bottools.projectdir();
    prefs = bot.util.getPreferences;
    prefs.CacheDirectory = fullfile(fileparts(projectRootDir), 'bot_cache');
    if ~isfolder(prefs.CacheDirectory); mkdir(prefs.CacheDirectory); end
    prefs.DialogMode = "Command Window";

    matbox.tasks.testToolbox(projectRootDir, varargin{:})
end
