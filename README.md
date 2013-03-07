Just A Table Cell Factory
=====================

Just a table cell factory. A lightweight, thin, low coupling table cell factory, which aims at providing highly customised cells with thin setup implementation

######Features
- Makes the cell responsible for it self (height, layout)
- No Model <-> cell coupling
- Reduce ViewController code
- Easily Integrated into existing code

####1: Get
Getting JATableCellFactory is easy! <br />
In fact, there are 2 ways: 

I _suggest_ installing via cocoapods to integrate into your project and also clone the code as the demo, tests and AppleDoc will **not** be included in the cocoapods version.
######Cocoapods
######Cloning

####2: Using
There is are a few steps to take in order to reap the benefit of JATableCellFactory.
<br/>3 steps, total.

 - ######1 Cells
 Cells need to implement the protocol `JACell` <br />
 `JACell` does 3 things:
 	- Calculate its Height `heightFromObject:(id)object atIndexPath:(NSIndexPath *)indexPath;`
 	- Update itself `updateCellWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;`
 	- Tell the factory if it is using a nib `nibNameForCellOrNil`
 	- __these are all required.__
 
 - ######2 Mapping provider
 `JAMapping` is a simple class with one function
 	- Map a Model `Class` to a cell `Class`<br />
 	`mappingFromModelClass:(Class)objectClass toCellClass:(Class)cellClass;`
 	- Its worth mentioning: ` NSAssert(NO, @"Cell class NEEDS to be a UITableViewCell Subclass");`
 	- One more thing; adding the mapping into the factory <br />
 	`addObjectMapping:(JAMapping *)m`
 	
 - ######3 Datasource 
`UITableViewDatasource` `UITableViewDelegate` Here is where the magic happens
	- Cell for row <br />
	`return [self.cellFactory cellForObject:anObject atIndexPath:indexPath fromTableView:tableView];`
	- Height for row <br />
	` Class cellClass = [self.cellFactory cellClassFromObject:modelObject];` <br />
	`return [cellClass heightFromObject:modelObject atIndexPath:indexPath];`

####3: TODO's
Yes, this is an ongoing endeavour of mine and here is a backlog of _if you will_ features i wish to implement:

- ###### Cocoapods
Integrate this into cocoapods!
- ###### AppleDoc
 HTML generated and Xcode integrated appledoc comments
- ###### ViewController based mapping
 Add functionality to easily add/preserve ViewController -> Cell mapping. Minimising coupling _of course._
 - ###### A Proper Demo
 Learn by doing and by looking at what I did.
 - ###### Have Fun
 At the end of the day, this is why i do this.
