//
//  NLHomeVC.m
//  Nazanin
//
//  Created by Abdul Qavi on 12/01/2016.
//  Copyright © 2016 NikaLabs. All rights reserved.
//

#import "NLHomeVC.h"
#import "NLAPIManager.h"
#import "NLCinema.h"

@interface NLHomeVC () <UITableViewDataSource, UITabBarDelegate, NLAPIManagerDelegate> {
    
    NSArray* cinemaValues;
    
    __weak IBOutlet UITableView *tableViewValues;
    
}

@end

@implementation NLHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cinemaValues = [NSArray array];
    
    NLAPIManager* apiManager = [NLAPIManager sharedManager];
    [apiManager getAllValues:@"all" andTarget:self];
//    [apiManager getPhotos:nil andTarget:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NLAPIManagerDelegate Methods

- (void)getAllValuesCallback:(id)response {
  
    cinemaValues = (NSArray *)response;
    [tableViewValues reloadData];
}

//- (void)getPhotosCallback:(id)response {
//}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cinemaValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.numberOfLines = 0;
    }

    NLCinema* cinema = cinemaValues[indexPath.row];
    cell.textLabel.text = cinema.cinemaName;
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NLCinema* cinema = cinemaValues[indexPath.row];
    NSLog(@"ID of cinema name: %@", cinema.cinemaID);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
