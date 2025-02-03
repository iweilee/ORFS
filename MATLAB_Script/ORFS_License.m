%% ORFS_License.m script
%  displays the license and version of ORFS.

%% url
url_eAV = "www.asg.ed.tum.de/eav";
url_CC  = "http://creativecommons.org/licenses/by-nc-sa/4.0/";

%% heading
fprintf("                    ORFS                    \n");
fprintf("              Version: 1.0.4                \n");
fprintf("       Technical University of Munich       \n");
fprintf("    <a href=""%s"">Assistant Professorship of eAviation</a>\n", url_eAV);
fprintf("This work is licensed under <a href=""%s"">CC BY-NC-SA 4.0</a>.\n", url_CC);
fprintf("\n")

clear url_eAV url_CC