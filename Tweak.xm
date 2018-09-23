#include "Tweak.h"

#define UPDATE(orig) \
[self updateSongCount];\
return orig;

void setSongCount(NSInteger songCount, id controller) {
  SPTTableViewOfflineSwitchCell *switchCell = (SPTTableViewOfflineSwitchCell *)[controller offlineSwitchCell];
	SPTViewOfflineSwitch *view = (SPTViewOfflineSwitch *)[switchCell offlineSwitchView];
	GLUELabel *label = (GLUELabel *)[view offlineTitle];
	NSString *originalText = [label text];

  NSRegularExpression *regex = [NSRegularExpression
    regularExpressionWithPattern:@"\\ \\-\\ [0-9]+"
    options:NSRegularExpressionCaseInsensitive
    error:nil];

  NSString *baseText = [regex
    stringByReplacingMatchesInString:originalText
    options:0
    range:NSMakeRange(0, originalText.length)
    withTemplate:@""];
	
	NSString *newLabel = [NSString stringWithFormat: @"%@ - %ld", baseText, (long)songCount];

	[label setText:newLabel];
}

%hook SPTCollectionSongsViewController
-(void)songsModelDidUpdate:(id)arg1 {UPDATE(%orig)}
-(void)updateInfoView {UPDATE(%orig)}
%new
-(void)updateSongCount {
  NSInteger songCount = [(SPTCollectionSongsModel *)[self model] unfilteredLength];
  setSongCount(songCount, self);
}
%end

%hook SPTAlbumViewController
-(void)updateInfoViewWithError:(id)arg1 {UPDATE(%orig)}
-(void)updateOnCollectionChange {UPDATE(%orig)}
%new
-(void)updateSongCount {
  NSInteger songCount = [(SPTAlbumViewModel *)[self viewModel] numberOfTracks];
  setSongCount(songCount, self);
}
%end

%hook PlaylistViewController
-(void)updateInfoView {UPDATE(%orig)}
-(void)updateOfflineInfoView {UPDATE(%orig)}
-(void)offlineSwitchCellDidChangeState:(id)arg1 isOn:(BOOL)arg2 {UPDATE(%orig)}
%new
-(void)updateSongCount {
  NSInteger songCount = [(SPTPlaylistViewModel *)[self viewModel] numberOfItems];
  setSongCount(songCount, self);
}
%end
