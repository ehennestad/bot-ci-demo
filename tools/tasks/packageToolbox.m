function [newVersion, mltbxPath] = packageToolbox(releaseType, versionString)
    arguments
        releaseType {mustBeTextScalar,mustBeMember(releaseType,["build","major","minor","patch","specific"])} = "build"
        versionString {mustBeTextScalar} = "";
    end
    projectRootDir = bottools.projectdir();
    addpath(genpath(projectRootDir))

    [newVersion, mltbxPath] = matbox.tasks.packageToolbox(...
        projectRootDir, releaseType, versionString, ...
        "SourceFolderName", fullfile("src", "bot") );
end
