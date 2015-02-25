//
//  ViewController.m
//  Search_C
//
//  Created by Justin Chee on 2015-02-24.
//  Copyright (c) 2015 Justin Chee. All rights reserved.
//

#import "ViewController.h"
#import "Game.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSArray *searchResults;

@property NSMutableArray *games;
@property NSArray *filteredGames;

@end

@implementation ViewController

- (void)loadInitialData
{
    Game *game1 = [[Game alloc] init];
    game1.title = @"Resident Evil"; game1.genre = @"Survival Horror"; game1.year = @"1996";
    [self.games addObject:game1];
    
    Game *game2 = [[Game alloc] init];
    game2.title = @"The Legend of Zelda: Ocarina of Time"; game2.genre = @"Action-Adventure"; game2.year = @"1998";
    [self.games addObject:game2];
    
    Game *game3 = [[Game alloc] init];
    game3.title = @"Silent Hill"; game3.genre = @"Survival Horror"; game3.year = @"1999";
    [self.games addObject:game3];
    
    Game *game4 = [[Game alloc] init];
    game4.title = @"The Legend of Zelda: Majora's Mask"; game4.genre = @"Action-Advanture"; game4.year = @"2000";
    [self.games addObject:game4];
    
    Game *game5 = [[Game alloc] init];
    game5.title = @"Silent Hill 2"; game5.genre = @"Survival Horror"; game5.year = @"2001";
    [self.games addObject:game5];
    
    Game *game6 = [[Game alloc] init];
    game6.title = @"Silent Hill 3"; game6.genre = @"Survival Horror"; game6.year = @"2003";
    [self.games addObject:game6];
    
    Game *game7 = [[Game alloc] init];
    game7.title = @"Rule of Rose"; game7.genre = @"Survival Horror"; game7.year = @"2006";
    [self.games addObject:game7];
    
    Game *game8 = [[Game alloc] init];
    game8.title = @"Portal"; game8.genre = @"Puzzle-Platformer"; game5.year = @"2007";
    [self.games addObject:game8];
    
    Game *game9 = [[Game alloc] init];
    game9.title = @"Dead Space"; game9.genre = @"Survival Horror"; game9.year = @"2008";
    [self.games addObject:game9];
    
    Game *game10 = [[Game alloc] init];
    game10.title = @"Dead Space 2"; game10.genre = @"Survival Horror"; game10.year = @"2011";
    [self.games addObject:game10];
    
    Game *game11 = [[Game alloc] init];
    game11.title = @"Hatoful Boyfriend"; game11.genre = @"Visual Novel"; game11.year = @"2011";
    [self.games addObject:game11];
    
    Game *game12 = [[Game alloc] init];
    game12.title = @"How to Survive"; game12.genre = @"Survival Horror"; game12.year = @"2013";
    [self.games addObject:game12];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.array = [[NSArray alloc] initWithObjects:@"Apple", @"Samsung", @"htc", nil];
    self.searchResults = [[NSArray alloc] init];
    self.games = [[NSMutableArray alloc] init];
    [self loadInitialData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Start table functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check if the search bar has results
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.filteredGames count];
        }
    return [self.games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    // Check if the search bar has results
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        Game *game = [self.filteredGames objectAtIndex:indexPath.row];
        cell.textLabel.text = game.title;
    }
    else
    {
        Game *game = [self.games objectAtIndex:indexPath.row];
        cell.textLabel.text = game.title;
    }

    return cell;
}


// Start search functions


- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
    NSPredicate *predicate;
    
    int selectedScope = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
    
    if (selectedScope == 0)
    {
        predicate = [NSPredicate predicateWithFormat:@"SELF.title CONTAINS[c] %@ OR SELF.year CONTAINS %@ OR SELF.genre CONTAINS[c] %@", searchText, searchText, searchText];
    }
    else if (selectedScope == 1)
    {
        predicate = [NSPredicate predicateWithFormat:@"SELF.title CONTAINS[c] %@", searchText];
    }
    else if (selectedScope == 2)
    {
        predicate = [NSPredicate predicateWithFormat:@"SELF.genre CONTAINS[c] %@", searchText];
    }
    else
    {
        predicate = [NSPredicate predicateWithFormat:@"SELF.year CONTAINS %@", searchText];
    }
    
    self.filteredGames = [self.games filteredArrayUsingPredicate:predicate];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
     return true;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return true;
}



@end
