%% Quickstart: Accessing Two-Photon Calcium Imaging Data from the Allen Brain Observatory
% This short example demonstrates the basics of exploring and examining items 
% within the Visual Coding 2P dataset [1] from the Allen Brain Observatory [2].
% View and Filter Visual Coding 2P Dataset Items 
% View Available Items
% Use a |*bot.list()* function to obtain a listing of all available experimental 
% _*session*_ items: 

availSessions = bot.listSessions('VisualCoding', 'Ophys'); % specify 'ophys' to indicate the Visual Coding 2P dataset
%% 
% Similar functions exist for other dataset item types: |bot.listCells() & bot.listExperiments().|
%% 
% The |*bot.list()*| functions return <https://www.mathworks.com/help/matlab/tables.html 
% *table* objects> containing identifiers and other columns of information about 
% the available items: 

availSessions % simplified command equivalent to disp(availSessions)
%% 
% There are thousands of sessions in this dataset. The displayed table can be 
% scrolled horizontally & vertically in the Live Editor to explore information 
% about each. 
% Filter Items by Criteria
% Item tables can be filtered to focus on those meeting particular criteria 
% of interest, by using <https://www.mathworks.com/help/matlab/matlab_prog/access-data-in-a-table.html 
% *tabular indexing*> operations: 

% select experiments from the most orientation/direction-selective areas of visual cortex 
filteredSessions = availSessions(ismember(availSessions.targeted_structure_acronym, categorical(["VISal" "VISrl" "VISam"])), :);

% select experiments with GCaMP6f expression enriched in Layer 2/3 and Layer 4 of cortex
filteredSessions = filteredSessions(filteredSessions.cre_line == "Cux2-CreERT2", :);

% select experiments imaging from the shallowest depth in Layer 2/3
filteredSessions = filteredSessions(filteredSessions.imaging_depth == 175,:);

% select experiments with eye tracking data available
filteredSessions = filteredSessions(~filteredSessions.fail_eye_tracking, :);

% select experiments with drifting grating and natural movie stimuli
filteredSessions = filteredSessions(filteredSessions.session_type == "three_session_A", :);
disp(filteredSessions)
% Examine Session Items
% Obtain Session of Interest
% From the table of filtered items, one or more specific items can be obtained 
% for further examination using the |*bot.get()*| functions|:| 

sessionUnderStudy = bot.getSessions(filteredSessions(1,:)); 
sessionUnderStudy.info    
%% 
% These |*info*| structure fields reflect the information from the session item's 
% corresponding row in the filtered table above.
% Examine Session of Interest
% The session of interest can be examined more closely by displaying the obtained 
% session item: 

disp(sessionUnderStudy)
%% 
% The displayed session item is an <https://www.mathworks.com/help/matlab/matlab_oop/create-a-simple-class.html 
% *object*> with has numerous additional <https://www.mathworks.com/help/matlab/matlab_oop/create-a-simple-class.html#buoz2sc 
% *properties*>, allowing the session of interest to be examined more closely. 
% View and Plot Neural Activity in Detected Cells
% For the Visual Coding 2P dataset, neural recordings were obtained from the 
% visual cortex in the form of two-photon fluoresence. These are reflected in 
% the varioius |fluorescence| properties: 

traces = sessionUnderStudy.fluorescence_traces_dff;
tall(traces) % display as a tall array 
%% 
% Here the |fluorescence_traces_dff| property is displayed as a <https://www.mathworks.com/help/matlab/tall-arrays.html 
% *tall array*> making its contents easier to understand at a glance. It contains 
% 100K+ rows (timepoints)  across a much smaller number (100+) of columns. The 
% columns represent *cells* (putative neurons) which were detected by the originators 
% of the Visual Coding 2P dataset. 
%% 
% The corresponding timepoints are also provided in another session property: 

timestamps = sessionUnderStudy.fluorescence_timestamps;
size(timestamps)
%% 
% The number of timestamps equals the height of the fluorescence traces above.
%% 
% With the timepoints and fluorescence traces from the computationally detected 
% cells, a sampling of putative neural recordings can be plotted: 

plot(timestamps, traces(:, 1:10:end) + (1:10:size(traces, 2))/3)
axis tight; xlabel('Time (s)'); set(gca, 'YTick', []); ylabel('dF/F0');
%% 
% These putative cells differ considerably in the rates and patterns of peaks 
% in their traces. This suggests there are a range of neural cell types and response 
% types to the visual stimuli during the session. 
% Learn More
% For an example of more in-depth neural data analysis of the Visual Coding 
% 2P dataset using the Brain Observatory Toolbox, see the <./VisualCoding_OphysDemo.mlx 
% *Ophys Demo*>.
% 
% For more detailed guidance on how to use the Brain Observatory Toolbox with 
% the Visual Coding 2P dataset, see the <./VisualCoding_OphysTutorial.mlx *Ophys 
% Tutorial*>.
% References
% [1] Copyright 2016 Allen Institute for Brain Science. Visual Coding 2P dataset. 
% Available from: <http://portal.brain-map.org/explore/circuits/visual-coding-2p 
% http://portal.brain-map.org/explore/circuits/visual-coding-2p>.
% 
% [2] Copyright 2016 Allen Institute for Brain Science. Allen Brain Observatory. 
% Available from: <http://portal.brain-map.org/explore/circuits portal.brain-map.org/explore/circuits>.