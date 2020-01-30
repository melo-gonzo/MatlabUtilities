function [varargout] = search(varargin)
% SEARCH Use Google to search the internet.
% 
%   SEARCH by itself opens http://www.google.com in a browser.
%
%   SEARCH SEARCHTERM1 SEARCHTERM2 SEARCHTERM3 ... searches Google for the
%   given search terms, displaying results in a browser.
% 
%   SEARCH -LUCKY SEARCHTERM1 SEARCHTERM2 SEARCHTERM3 ... searches using
%   the "I'm Feeling Lucky" feature.
% 
%   SEARCH uses similar syntax to the WEB function with the exception that
%   it does not expect a URL. Rather, any number of search terms may be
%   used. All other inputs and outputs for WEB work for SEARCH, e.g. [STAT,
%   BROWSER, URL] = SEARCH(SEARCHTERM,'-NOTOOLBAR','-NEW'). The -BROWSER
%   option is enabled by default. Use -MATLABBROWSER to disable.
% 
%   See also WEB, HELP, LUCKYSEARCH.
% Copyright 2013 Sky Sartorius
% Contact: www.mathworks.com/matlabcentral/fileexchange/authors/101715
link            = 'https://www.google.com/'; 
searchStr       = 'search?q=';
luckySearchStr  = 'search?btnI=1&q=';
defaultWebArgs  = {'-browser'}; % change to {} to use default WEB behavior.
% Arguments that can be passed to WEB function besides the URL:
validWebArgs = {'-browser' '-display' '-helpbrowser' '-new' ...
    '-notoolbar' '-noaddressbox' '1'};
searchTerm = '';
isaWebArg = false(1,nargin);
for iArg = 1:nargin
    arg = strtrim(varargin{iArg});
    isWebArg = strcmpi({arg},validWebArgs);
    if any(isWebArg)
        isaWebArg(iArg) = true;
    elseif strcmpi(arg,'-lucky')
        searchStr = luckySearchStr;
    elseif strcmpi(arg,'-matlabbrowser')
        defaultWebArgs  = {};
    else
        searchTerm = [searchTerm '+' arg]; %#ok<AGROW>
    end
end
if ~isempty(searchTerm) % Search for something.
    searchTerm(1) = ''; % Remove leading +.
    link = [link searchStr searchTerm];
end
webArguments = lower(varargin(isaWebArg));
[varargout{1:nargout}] = web(link,webArguments{:},defaultWebArgs{:});
