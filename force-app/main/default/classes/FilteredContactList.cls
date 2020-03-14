public with sharing class FilteredContactList {  
   

	// Search string to fill in FilteredControllerPage.page
	public string searchstring {
		get;
		set;
	}

	private ApexPages.StandardSetController con;

	public FilteredContactList(ApexPages.StandardSetController controller) {
		this.con = controller;
		this.con.setpageNumber(1);
		this.con.setPageSize(5);
	}  

	/* Handling for the StandardSetController: 
			first, last, previous, next, 
			hasPrevious, hasNext, pageNumber, totalPageNumber
	*/

	public void first() {
		con.first();
	} 
	public void last() {
		con.last();
	} 
	public void previous() {
		con.previous();
	}

	public void next() {
		con.next();
	}

	public Boolean hasNext {
		get {
			return con.getHasNext();
		}
		set;
	}

	public Boolean hasPrevious {
		get {
			return con.getHasPrevious();
		}
		set;
	}

	public Integer pageNumber {
		get {
			return con.getPageNumber();
		}
		set;
	}

	public Integer totalPageNumber {
		get {
			Decimal totalSize = this.con.getResultSize();
			Decimal pageSize = this.con.getPageSize();
			Decimal pages = totalSize/pageSize;
			return (Integer)pages.round(System.RoundingMode.CEILING);
		}
		set;
	}

	/* ---------------------------------------- */

	public ApexPages.StandardSetController setCon {
		get {
			if(this.con == null) {
				this.con = new ApexPages.StandardSetController(Database.getQueryLocator(
					[SELECT Name, Email, Phone from Contact]));

			}
			return this.con;
		}
		set;
	}

    // Initialize setCon and return a list of records
    public List<Contact> getContacts() {
    	return (List<Contact>) setCon.getRecords();
    }

    /*
       search: Method that allows a search by string in name.
    */
    public void search() {
    	string searchingtoken = '%'+searchstring+'%';
    	Integer pageSize = this.con.getPageSize();
    	this.con = new ApexPages.StandardSetController(Database.getQueryLocator(
    		[SELECT Name, Email, Phone from Contact where Name like :searchingtoken]));
    	this.con.setpageNumber(1);
    	this.con.setPageSize(pageSize);
    }


 }