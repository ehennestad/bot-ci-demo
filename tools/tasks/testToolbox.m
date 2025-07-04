function testToolbox(varargin)
    projectRootDir = bottools.projectdir();
    
    botPrefs = bot.util.getPreferences();
    if botPrefs.CacheDirectory == "" || ~isfolder(botPrefs.CacheDirectory)
        botPrefs.DialogMode = "Command Window";
        tempCache = fullfile(tempdir, 'bot_cache');
        if ~isfolder(tempCache)
            fprintf('Making cache directory "%s"', tempCache)
            mkdir(tempCache); 
        end
        cleanupObj = onCleanup(@(fp) rmdir(tempCache, "s"));
        botPrefs.CacheDirectory = tempCache;
        botPrefs.AutoDownloadNwb = false;
        disp(botPrefs)
    end
    
    matbox.tasks.testToolbox(projectRootDir, ...
        "SourceFolderName", "src", ...
        "TestsFolderName", "tests", varargin{:})
end
