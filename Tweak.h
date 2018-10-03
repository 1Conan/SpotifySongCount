@interface SPTViewController
-(id)offlineSwitchCell;
-(void)updateSongCount;
@end

@interface SPTTableViewOfflineSwitchCell
-(id)offlineSwitchView;
@end

@interface SPTViewOfflineSwitch
-(id)offlineTitle;
@end

@interface GLUELabel : UILabel
@end

/* Library */
@interface SPTCollectionSongsViewController : SPTViewController
-(id)model;
@end

@interface SPTCollectionSongsModel
-(NSInteger)unfilteredLength;
@end

/* Album */
@interface SPTAlbumViewController : SPTViewController
-(id)viewModel;
@end

@interface SPTAlbumViewModel
-(NSInteger)numberOfTracks;
@end

/* Playlist */
@interface PlaylistViewController : SPTViewController
-(id)viewModel;
@end

@interface SPTPlaylistViewModel
-(NSInteger)numberOfItems;
@end

/* CollectionArtist */
@interface SPTCollectionArtistViewController : SPTViewController
-(id)artistModel;
@end

@interface SPTCollectionArtistModel
-(id)tracks;
@end
