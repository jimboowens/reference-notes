

6 morning habits of high performers

	1.Silence - meditation.. do not try to think, and that can tap into clarity. DONT JUDGE YOUR EXPERIENCE. it lowers cortisol levels.
	2. Affirmation - dont lie and by extension falsify reality. 
		1. affirm what you are committed to
		2. state why 1 is important to you
		3. affirm what you are committed to in order to reach 1
		4. When are you committed to doing number 3?
	3. Visualization - visualize performing optimally (third person) visualize the activity and not just reaching the goal
	4. Excersize - this can be really helpful
	5. Reading - one book away from learning everything we need to learn to do what we want to do
	6. Scribing - journal, write things I am thankful for, and take the time to get clarity. 

	Busy does not mean productive.


# get IP
req.connection.remoteAddress (node.js)

# remove a db from sys311:
mssqlserver mgmtstudio, be sure to uncheck delete b/u and restore history, and check close existing connections. if you press okay, 
it will delete everything.
# make a new db from 
right click databases and add new. modify the files, on the FARRR right file name. Those are set on create, and renaming the files 
is not possible. You have to 'detach' them, rename them, and reattach it (databases, then do restore)
	
# merge - while in master (or others):
# Note, unless merging to master, do not attempt to create a pull request for a branch

First you want to try merging from the gogs UI, but if you cannot:
	1. go to the master branch of the module you want to modify, and input: git merge origin/CR012345
		A. if you want to merge into master, be in the master branch
		B. if not... 
			git checkout [branchYouWantToMergeInto]
			git merge origin/[branchYouWantToMerge]
	2. if there are merge conflicts, wait until the cource control provider for the module you are wanting to modify loads the changes. The merge conflicts will be 
		in the merge changes section, and you will be able to iterate through them with arrows in the open changes section on the top right of VSCode. 
	3. reference the git branch if need be to discern whether to accept current or incoming changes.

While the ideal is that master does not change while other CRs are being worked on, that is not the case. There will inevitably be merge conflicts at some time.

# Delete branches after merge conflicts -- be sure to be in the right directory 
# clean up extraneous branches locally
git fetch -p

 # delete branch locally
git branch -d localBranchName

# delete branch remotely
git push origin --delete remoteBranchName

# git diff between branches -- the next and master are the two, the -- denotes the file specifically, and piped to less
git diff next..master -- src/main/java/spec/integration/.../control/camel/....java | less

# database change request
go to service Now, put in db that needs modification, and add the script. add when the db needs changed

# turnover rubric-- replace components as needed

#regexp:
1. new line after comma
2. new line after '{','}','[', and ']'
^(.*)=(.*)(,)$  #dfl;kj=ad;fkj, (work in progress to change java obj to json) -> "$1" : "$2"$3
^(.*)=(.*)$ # asd;lfjk=d;flkj (for no commas) -> "$1" : "$2"
^(.*)=(\{\[)$ # a;sflkj=[ or adf;klj'{ -> "$1" : $2

best one so far: ([^\s.]*?)=(.*?)(,*) # "$1": "$2"$3

#JS Stuff:


# example of stuff from 
	const obj = this.insidePanels.reduce((accum, current) => {
		const key = `${current.panelNumber}|${current.type}`;
		accum[key] = current;
		return accum;
	}, {});

# cool complex function to revert a mode

    public revertMode(validating?) {
        setTimeout(() => {
            if (validating || (this.candidateList.A.fetched && this.candidateList.M.fetched && this.candidateList.T.fetched && this.candidateList.P.fetched)) {
                this.mode = `Normal`;
                this.candidateList = _.orderBy(this.candidateList, ['candidate', function (candidate) { return candidate.payload.length }], ['desc', 'desc']);
            } else this.revertMode();
        }, 1000);
    }


# steps to connect to an IBM  db2 camel route from the front end -- 
	# in the .ts file for the page we are on..
this.subscribers.push(this.svc.functionToGoToBackEnd(...args)
	.subscribe(response=>{
		handle response or ignore;
	})
)

# in the svc module..
	# connecting to v1/mps? v1/spec? look at a top level this.mpsURL or gesURL etc...

	public functionToGoToBackEnd(...args:type of){
		return this.chs.do[Get,Post,etc...](`${this.url}&{backendFunctionToCall}/${..args}`,`failure message, make sure it shows what failed`);
	}

# in the back end.. let's say it's in v1/mps (MultiProcessSpecificationV1.java)
# make sure you have the relevant tag.. if it's a post, you send a payload typically. more often than not, you want to do a get here and just kick off whatever you're wanting to do
@GET
@Path("backendFunctionToCall/{...args}")
public Response mpsFunctionToCall(@PathParam("arg1")String arg1...){
	try{
		mpsUtilities.mpsFunctionToCall(...args);
		return Response.ok().build();
	}catch (Exception e){
		throw new Error("could not call mpsFunctionToCall",e)
	}
}

# moving to mpsUtilities; this is a safer call because the only way to get to the function is by hitting the url rather than hitting the b/e url.
# This is an example using db2Actions, which has an action/payload jsonObject fed to the db2ActionsListener.java. This consumes what's sent out, and decides where to send it. 
# This means you can make a vanilla camel route in the relevan file, and pass the action as the name of the from("direct:db2-action-to-call").id("db2-action-to-call")...
# the payload is where you're going to get the data you will need for the camel route. This is what you need to feed to the .xquery, or to a sql, or to the exchange.

public Response mpsFunctionToCall(...args){
	try{
		String payload = Json.createObjectBuilder() // -
				.add("arg1",arg1) // -
				.add("arg2",arg2) // -
				.build().toString(); // -
		String db2Action = Json.createObjectBilder() // -
				.add("action","action-to-call") // -
				.add("payload",payload) // -
				.build().toString(); // -
		db2Actions.sendBody(db2Action);
		return Response.ok().build();
	}catch(Exception e){
		return Response.status(Status.BAD_REQUEST).entity("Could not call action-to-call").build();
	}
}

#helpful java stream code is in the sendEditRequestTo function and updateSpecialReqDetail

# Be sure to look ar the Db2ActionsListener to get a better understanding the formatting you need for the action object. This will be an exercise left to the reader.

# This is where you go to wherever you need to go in the db2 module (what're you working with? schematic? find where schematic work is being done and do it there. But 
# we are kind of working with mps, so I will move from that understanding. That is in db2>src>main>java>spec>integration>db2>control>camel>backfillapplicationpec.java)

from("direct:action-to-call").id("action-to-call") // -
		// .to("log:debug?multiline=true&showAll=true") // -
		.setHeader("arg1",jaonPath("arg1")) // -
		.process(exch->{
			# pseudo-java code. you can use logic here to manipulate that can be very difficult with the minimalistic camel code
			# if you want to learn more about camel, there are resources further down about that
			String arg1 = exch.getIn().[set(obviously not called here),get]Header("arg1",arg1);
		})
		.to...

# camel quartz2 cron route (top of every minute starting 60 seconds after compile (first one triggers exactly 60 seconds after war file is done or something))

from("quartz2:scheduleTimer?startDelayedSeconds=60&cron=0+0/1+*+*+*+?")//
    .id("MPSWizardScheduleTimer")//
    .to("sjms:queue:schedule-trigger")//
;


# cool ternary in a return
return item.getString("STR", "").isEmpty() || item.getString("STR", "").isEmpty() // -
				|| !Arrays.stream(new String[] { "A", "B", "C", "D", "E" }).anyMatch(item.getString("STR", "")::equals) // -
				|| "R".equals(item.getString("STR", ""))// -
						? Boolean.TRUE
						: Boolean.FALSE;

#  for a new modal/form--

# from the ts side--

import { FormBuilder, FormGroup, Validators } from '@angular/forms';

# and follow the precedent for these three. make sure the form in the modal references the formgroup you name. in this case, form (make sure this is set prior to page load)--

this.form = this.fb.group({
	input1:['',Validators.required],
	input2:['',Validators.required]
})

# html side you need a modal.open() from an onclick event and the barebones example is--

<bs-modal #modal [keyboard]="false" [backdrop]="'static'">
    <bs-modal-header [showDismiss]="false">
        <h4 class="modal-title">Create New Material</h4>
    </bs-modal-header>
    <bs-modal-body>
        <form [formGroup]="form" class="form-horizontal" novalidate>	
            <div class="form-group">
                <custom-field>
                    <input class="form-control" formControlName="input1" placeholder="Input 1" />
                </custom-field>
                <custom-field>
                    <textarea class="form-control" formControlName="input2" placeholder="Input 2"></textarea>
                </custom-field>
            </div>
        </form>
    </bs-modal-body>
    <bs-modal-footer>
        <button type="button" class="btn btn-default" data-dismiss="modal" (click)="modal.dismiss()">Cancel</button>
        <button type="button" class="btn btn-primary" [disabled]="!form.valid" (click)="modal.close();save()">Create</button>
    </bs-modal-footer>
</bs-modal>


# this is a good way to reduce the insanity of tables in repository

<table class="table table-condensed table-striped">
    <thead>
        <tr>
            <th class="col-sm-6">Name</th>
            <th class="col-sm-6">Description</th>
        </tr>
    </thead>
    <tbody *ngFor="let item of finishedItems|keyvalue;">
        <tr>
            <th class="col-sm-6">{{item.key}}</th>
            <td class="col-sm-6" style="white-space: pre-wrap">{{item.value}}</td>
        </tr>
    </tbody>
</table>

#########################################################################################################################

let mapToPrettyKeys: any = { rawItemOne:"Clean Item One", rawItemTwo:"Clean Item Two", etcEtcEtc: "And So On and So Forth"};
let desiredKeys = Object.keys(mapToPrettyKeys);
let rawKeys = Object.keys(this.rawFields);
let cleanFields = {};
for (let rawKey of rawKeys) {
    if (desiredKeys.includes(rawKey) && !(rawFields[rawKey] == null || rawFields[rawKey] == false)) {
        cleanFields[mapToPrettyKeys[rawKey]] = rawFields[rawKey];
    }
}
this.obj.finishedItems = cleanFields;

#########################################################################################################################

let clone = arg;
let original = this.original;
let keysToClean = [`iterableOne`,`iterableTwo`,`iterableThree`,`etc...`];
let keysToKeep = Object.keys(cloneItem);
for (let keyToKeep of keysToKeep) {
	if (keysToClean.includes(keyToKeep)) {
		if (clone[keyToKeep][0]) {
			let size = clone[keyToKeep].length;
			for (let i = 0; i < size; i++) {
				clone[keyToKeep][i].id = original[keyToKeep][i] ? original[keyToKeep][i].id : undefined;
				clone[keyToKeep][i].parentId = original[keyToKeep][i] ? original.id : undefined;
			}
		} else if (clone[keyToKeep].id) {
			clone[keyToKeep].id = original[keyToKeep].id || undefined;
			clone[keyToKeep].parentId = original.id;
		}
	}
}
this.objToImport = clone;
this.objReplacingOriginal = _.cloneDeep(clone);
    
#########################################################################################################################

public alternateSelection(e) {
	let targetItem = e.target.id;
	let checkboxValue = e.target.value;
	let keys = Object.keys(this.objReplacingOriginal)
	for (let key of keys) {
		if (key == targetItem) {
			if (checkboxValue == `on`) {
				this.objReplacingOriginal[key] = Array.isArray(this.objReplacingOriginal[key]) ? [] : {};
				toastr.info(`${targetItem} removed from SAF to import`);
				checkboxValue = `off`;
			} else {
				toastr.info(`${targetItem} added to SAF to import`);
				this.objReplacingOriginal[key] = this.objToImport[key];
				checkboxValue = `on`;
			}
			return;
		}
	}
}

# 2 years later: could also bind on a [checked] angular HTML attribute

    /**
     * alternates whether user wants to import attributes of imported SAF data
     * @param e PointerEvent
     * @returns void
     */
    public alternateSelection(e: PointerEvent): void {
        const target = (<HTMLInputElement>e.target);
        const safCategoryToClone = this.safCategoriesToClone.find(safCategoryToClone => safCategoryToClone.key === target.id);
        safCategoryToClone.unchecked = !target.checked;
    }

#########################################################################################################################

# get the location of a ™ symbol and analyze its bytes
let bytes = [];
let bytesv2 = [];
console.log(this.obj.data['arg'].deeperData.attribute);
let str = this.obj.data['arg'].deeperData.attribute.substring(19,20);
for (let i = 0; i < str.length; i++) {
	let code = str.charCodeAt(i);
	bytes = bytes.concat([code]);

	bytesv2 = bytesv2.concat([code & 0xff, code / 256 >>> 0]);
}

console.log('bytes', bytes.join(', '));


console.log('bytesv2', bytesv2.join(', '));



# Backend Stuff

# this one allows me to change a Boolean through an atomicBoolean in a lambda.

	public Boolean checkIfMPSHasOpenWorkflow(String attribute) {
		Map<String, String> params = new HashMap<>();
		params.put("attribute", attribute);
		AtomicBoolean hasOpenWorkflows = new AtomicBoolean(false);
		String sql = "select convert(varchar(max),data,0) data, personId, initiatorId, assigneeId, step from mpsWizard where mode = 'import'";
		List<Map<String, Object>> rs = jdbc.queryForList(sql, params);
		rs.forEach(item -> item.forEach((k, v) -> {
			if (k == "data") {
				log.info("in here");
				String importedAttribute = ((JsonObject) v).getString("attribute");
				if (attribute == importedattribute) {
					log.warning("attribute: "+attribute + "has an open workflow against it");
					hasOpenWorkflows.set(true);
				}
			}
		}));
		return hasOpenWorkflows.get();
	}


	==============================================================================

	
		StringBuilder relatedAttribute = new StringBuilder();
		if (jso.getString("attr0") != null) { // private entry, get related
			StringBuilder url = new StringBuilder().append("v1/gds/table/");
			jso.forEach((k, v) -> url.append(k + "/" + v + "/"));
			JsonObject obj = Json.createObjectBuilder().add("url", url.toString()).build();
			relatedAttribute.append((String) getImportCandidateData(obj).get("attr1"));
		}
		relatedAttribute.toString();
		if (relatedAttribute == null) {
			throw new IllegalArgumentException("Argument Invalid; entry not mapped");
		}
		Exchange ret = importToNewObject.send(exch -> exch.getIn().setBody(relatedAttribute.length() > 0 ? relatedAttribute : original));


# Camel Stuff
 # log debug without having to look elsewhere

.to("log:debug?multiline=true&showAll=true") // -

.setHeader("table_item_numbers").xpath("/LinkedCaseInsensitiveMap/*/table/item_number/text()")
.setHeader("table_elements").xpath("/LinkedCaseInsensitiveMap/*/table")

.process(exch->{
	NodeList nl = (NodeList) exch.getIn().getHeader("table_item_numbers");
	List<String> processesList = new ArrayList<>();
	for (int x = 0; x < nl.getLength(); x++) {
		Text t = (Text) nl.item(x);
		processesList.add(t.getData());
	}
	# This is for elements, and you have to exch.setProperty("processesList",processesList) for xquery to read it. ref importToWizard for more info
	NodeList nl = (NodeList) exch.getIn().getHeader("table_elements");
	List<String> processesList = new ArrayList<>();
	for (int x = 0; x < nl.getLength(); x++) {
		Text t = (Text) nl.item(x);
		processesList.add(new XMLMapper.writeValueAsString(t));
	}
	
	# do stuff here, like
	String item = exch.getIn().getHeader("arg1");
	item.slice();
	exch.getIn().setHeader("arg2",item);
	exch.getIn().setBody( // -
	 jdbc.queryForList(
		 "select * from shxp.table_name where field_matching_arg1 = :arg1 and field_matching_arg1 in (:arg2) with ur",
		 exch.getIn().getHeaders()
	 )
	)
})
.marshal().jasksonxml() // convert to xml
.convertBodyTo(String.class) // -
.to("xquery:xquery-file-to-be-called.xquery?configuration=#xqConfig")

.choice() // 
.when().[x,json]path("parameterWeDontWant") // -
# this is the true section, let's say we don't want it and it's true 
.to("seda:dlc").stop() // -
.otherwise().to("direct:desired-db2-camel-route") // -
.end() // ends it


# db stuff

# roll back master role rights (trade roleId for the 'CAB...' GUID in the grant master role query to switch back
# update roleassignment set roleId='FAB60583-32D8-4A9F-8739-376EF5C104C8' where personId ='E8855443-EB77-47FF-B3A0-6D4E2BA70C8E'

# have to set to simple recovery, then shrink the db

ALTER DATABASE [dbname] SET RECOVERY SIMPLE WITH NO_WAIT

dbcc shrinkdatabase (dbname, TRUNCATEONLY)

#  checking activity, the db, the nOverview, and the nSQL PI for history and then active blockas are in the activity

# set up a new db for co-op or another user: make a new db, name it spec_dev_${developer last name}
scroll all the way to the right and make the File Name the same as the db name. Then update the application-db-mgmt destName field to restore the dbs we just made. run those and see what the new dev(s) find

# get foreign keys
select 
    t.name as TableWithForeignKey, 
    fk.constraint_column_id as FK_PartNo, 
	c.name as ForeignKeyColumn 
from 
    sys.foreign_key_columns as fk
inner join 
    sys.tables as t on fk.parent_object_id = t.object_id
inner join 
    sys.columns as c on fk.parent_object_id = c.object_id and fk.parent_column_id = c.column_id
where 
    fk.referenced_object_id = (select object_id 
                               from sys.tables 
                               where name = 'TABLE_NAME_HERE')
order by 
    TableWithForeignKey, FK_PartNo

# get space specs for SqlServer
USE db_here -- replace your dbname
GO
DBCC UPDATEUSAGE (db_here)

SELECT
	s.Name AS SchemaName,
	t.Name AS TableName,
	p.rows AS RowCounts,
	CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB,
	CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB,
	CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB
FROM 
	sys.tables t
INNER JOIN 
	sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
	sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
	sys.allocation_units a ON p.partition_id = a.container_id
INNER JOIN 
	sys.schemas s ON t.schema_id = s.schema_id
GROUP BY 
	t.Name, s.Name, p.Rows
ORDER BY 
	Total_MB,s.Name, t.Name
GO

# helpful check for column names in DB2

select TBNAME, NAME
from sysibm.syscolumns
where NAME like '%column_name%'
ORDER BY TBNAME

# and in SqlServer:
# Search Tables:

SELECT
	c.name  AS 'ColumnName',
	t.name AS 'TableName'
FROM
	[db_name].sys.columns c
JOIN
	[db_name].sys.tables t
		ON c.object_id = t.object_id
WHERE
	c.name LIKE '%MyName%'
ORDER BY
	TableName, ColumnName;

# Search Tables and Views:

SELECT
	COLUMN_NAME AS 'ColumnName',
	TABLE_NAME AS  'TableName'
FROM
	[db_name].INFORMATION_SCHEMA.COLUMNS
WHERE
	COLUMN_NAME LIKE '%MyName%'
ORDER BY
	TableName, ColumnName;

# more detailed:
select  
	s.[name]            'Schema',
	t.[name]            'Table',
	c.[name]            'Column',
	d.[name]            'Data Type',
	c.[max_length]      'Length',
	d.[max_length]      'Max Length',
	d.[precision]       'Precision',
	c.[is_identity]     'Is Id',
	c.[is_nullable]     'Is Nullable',
	c.[is_computed]     'Is Computed',
	d.[is_user_defined] 'Is UserDefined',
	t.[modify_date]     'Date Modified',
	t.[create_date]     'Date created'
from
	[db_name].sys.schemas s
inner join
	[db_name].sys.tables  t
on s.schema_id = t.schema_id
inner join
	[db_name].sys.columns c
on t.object_id = c.object_id
inner join
	[db_name].sys.types   d
on c.user_type_id = d.user_type_id
where 
	c.name like '%ColumnName%'
order by Schema, Table, Column

# Terminal commands (Not filtered by shell but mostly *nix flavor)
# Ubuntu help - https://help.ubuntu.com/community/Beginners/BashScripting

man [arg] prints out the manual with all flags(annotations) available for a given bin command. 

grep (ed g/re/p [arg]) '[arg]' is a Global Regular Expression Print command that takes an arg

$ cat /proc/cpuinfo | grep 'vendor' 	| uniq		# view vendor name (pipe through grep, and only return unique arguments)
$ cat /proc/cpuinfo | grep 'model name' | uniq		# display model name ( "" )
$ cat /proc/cpuinfo | grep processor 	| wc -l		# count the number of processing units
$ cat /proc/cpuinfo | grep 'core id'				# show individual cores	
# useful
lscpu 		# list cpu
lshw  		# add -C [hardware class(e.g. CPU)] flag list hardware, can pipe through the different attributes
cpuid 		# had to apt-get this.. also huge. need to filter out info
inxi  		# add -C flag for complete info, including clock-speed and max cpu speed
hardinfo 	# not installed, opens a System Information pane
hwinfo 		# --cpu flag helps, but not a command in my current machine (Windows 1909 with WSL Ubuntu 1804)
systemctl 	# need more time for this one
top 		# get dynamic relatime view of teh running system 

ipconfig 	# /all
get-netConnectionProfile
set-networkConnectionProfile # --[attribute] [matching attribute] -[category to update] [update]
nslookup [arg] # 

# update jdk for machine (not container)
change $JAVA_HOME to the jdk11, also the JDK_HOME changed to the new one. Then restart and update.

@Entity
@Table(name = "PM_COMM_PRICE_LIST", schema = "dbo")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PmCommPriceList extends KafkaMessage {
@JsonProperty("Status")
    @Column(name = "Status")
    private String status;
PowerUser: 1:02 PM
PmCommPriceList pl = mapper.readValue(json, PmCommPriceList.class);
PowerUser: 1:35 PM
		ObjectMapper cmapper = new ObjectMapper();
		cmapper.registerModule(new JavaTimeModule());
		return cmapper;

# handle windows defender

update and security
virus and threat protection, manage settings times 2
exclusions > add or remove exclusions