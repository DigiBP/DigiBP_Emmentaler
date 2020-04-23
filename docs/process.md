# <span style="color:blue">**Process Documentation**</span>

## <span style="color:blue">1. Project Scope</span>
The scope of the project is to investigate how the digitalisation affects business processes in an enterprise, how an ideal interaction of natural and artificial intelligence in an organisational environment can be achieved, and how cooperation and partnership among humans and technology can result in adequate business process execution. This investigation will be realised by application, implementation and demonstration of real prototypical instantiations.

## <span style="color:blue">2. Team Members</span>

| Name | Email |
|---|---|
| Jasmin Fluri  | jasmin.fluri@fhnw.ch |
| Alena Magliano | alena.magliano@students.fhnw.ch |
| Alain Schmutz | alain.schmutz@students.fhnw.ch |

## <span style="color:blue">3. Use Case Identification</span>
The team has worked together in a brainstorming phase on identification of use case they would like to work on. It was decided to model a process owned by company of one of the team members. The process presents the procedure for the new proposals with respect to changing the business guidlines, innovation, general improvements or future events inside the company. It has to be pointed out that the process does not relate to external clients.


## <span style="color:blue">4. Scenario and User Experience (UX)

### Project Use Case

The company structure of Schaltstelle (schaltstelle.ch) allows each member of the company to have the same power of co-decision. No management rules over the company. If decisions have to be made, the members decide according to the principle of consent. The principle of consent means, as long as no member disapproves, the voting at hand is accepted. 

If a topic needs to be put to the vote, the related member has to explain it to the others, so that they can veto against it, if they disapprove. If any member disapproves, the proposal is declined. It is not a majority decision where the outcome is defined in what most members vote. 

Votings of proposals and their discussion and improvement suggestions are currently set up as a Telegram chatroom. The structure of a chatroom complicates the tracking of the status of proposals and their outcomes.

## <span style="color:blue">5. Process Modelling


The process contains three roles: A requester, an innovation manager and the remaining members of the company.

| Role | Description |
|---|---|
| Requester | Person who can raise the new proposal and is necessarily a member of the company. |
| Innovation Manager | Person who is responsible for reviewing the new proposal. He makes suggestions to refine the proposal before it is up for voting. |
| Members | Members of the company who can make use of the right to veto. Any member has the possibility to propose requests. |


 Proposals that are up for voting can be classified amongst the following categories: 
 * Change of business guidelines (code of conduct, code of ethics)
 * Innovation (new business ideas or projects)
 * General improvements (office, infrastructure, technologies)
 * Future events (regulars' table, networking events, team events)
 * Marketing (social media, website, sponsoring)
 * New Member

The current process to request proposals is done in the chat application Telegram. There is no overview of the ongoing proposals, no possibility for improvement suggestions by other members of the company and discussions are hard to follow.

## <span style="color:blue">6. Process AS-IS Description</span>

### Process AS-IS Description


The process starts with the requester creating a proposal. It must be phrased to allow a yes / no decision. The Chief of innovation reviews the proposal. If the proposal is not complete, it is handed back to the requester. If the Chief of innovation declares the proposal as complete, the proposal is ready for voting. Next, the members need to decide if they want a pitch or presentation of the proposal to learn about its details. This can help to get a better understanding of the request or the idea. If not, the 10 days right to veto starts for all the members. During this period, two tasks commence: 
- Members of the company could suggest improvements to the proposal. The improvements can be accepted by the requester and implemented into the description. If the requestor rejects the improvements, nothing changes.
- Members of the company can make use of their right to veto. If at least one member makes the use of the right to veto, the proposal is declined, and the process ends. If the members do not make their use of the right to veto within the ten days, the proposal is accepted, and the process ends.



## <span style="color:blue">7. Decision Logic</span>


Decision logic is a verification system enabling the company automatically verify the proposal information relating to category and requested budget. Decision logic is defined in a decision table which consists of inputs, outputs and rules. The inputs are conditions and the outputs are the conclusion of the rules. In the above described AS-IS Process, the members have to decide if they want a pitch or presentation of the proposal. This step can be automated with the help of decision table. With the pre-defined inputs, outpus and rules can be decided if the presentation is needed or not.
In the decision table there are 2 input columns and one output columns.

INPUT                     
* Proposal Category        
* Amount Budgeted

OUTPUT
 * Decision Outcome

The following conditions have been defined to design a decision model to decide whether the presentation or pitch is needed:
1. If the proposal category is innovation and the amounted budget is greater than CHF 1000 then the presentation or pitch is needed.
2. If the proposal category is marketing and the amounted budget is greater than CHF 2000 then the presentation or pitch needed.
3. If the proposal category is future events and the amounted budget is greater than CHF 3000 then the presentation or pitch needed.
4. If the proposal category is new members then the presentation or pitch is always needed.
5. The presentation or pitch is required only for conditions 1.-4.

|Proposal Category | Amount Budgeted | Decision Outcome|
|---|---|---|
| Innovation | > 1000 |true|
| Marketing | > 2000 |true|
| Future Events | > 3000 |true|
| New Members | > 0 |true|
|"Innovation","GeneralImprovements","FutureEvents","Marketing" "ChangeOfBusinessGuidelines"|- |false|

## <span style="color:blue">8. Identification of Digitalisation Aspects</span>

## <span style="color:blue">9. Process TO-BE Description</span>

### Digitized Process Architecture


![Architecture of the digitized process](architecture/architecture-model.jpg "Architecture of the digitized process")


Oracle APEX is a free tool for rapid application development that helps in developing and publishing desktop and mobile applications.



### Process TO-BE Description




### Calls between Frontend Service (REST Endpoint) and BPM Process

|Source - Target|Parameter|Description|Technology|
|---|---|---|---|
|REST -> BPM|PROPOSAL_STATUS  |New Proposal is created (Start Event)|REST (GET)|
|BPM -> REST|PROPOSAL_STATUS|Update of the proposal status|REST (PUT)|
|BPM -> REST|IS_PITCH_NEEDED|Outcome of decision table if pitch is needed|REST (PUT)|
|REST -> BPM|CHANGE|New Change is added for Proposal|REST (GET)|
|BPM -> REST|HAS_VETO|Outcome of process if the proposal is accepted or declined|REST (PUT)|
|BPM -> REST|VETO_START_DATE|Start date of the right to veto|REST (PUT)|



## <span style="color:blue">10. Deployement of External Services </span>



### APEX Frontend
The frontend allows the Schaltstelle Members to create and modify the proposals. It serves as the process GUI. 

### APEX REST Endpoints

All the APEX REST Endpoints for the proposal application are located under the proposal module: 

[https://apex.oracle.com/pls/apex/schaltstelle/proposal/](https://apex.oracle.com/pls/apex/schaltstelle/proposal/)



#### Ressources

|Ressource URI|Methode|Parameters|
|---|---|---|
|change/:id|GET|IN - id|
|change/:id|POST|IN - antrag_id <br> IN - change_desc <br> IN - change_titel <br> OUT - http_status_code|
|has_veto/:id|PUT|IN - id <br> IN - has_veto <br> OUT - http_status_code|
|is_pitch_needed/:id|PUT|IN - id <br> IN - is_pitch_needed <br> OUT - http_status_code  |
|proposal_status/:id|PUT|IN - id <br> IN - proposal_status <br> OUT - http_status_code  |
|proposal_status/:id|GET|IN - id  |
|veto_start_date/:id|PUT|IN - id <br> IN - veto_start_date <br> OUT - http_status_code  |

### Oracle Database

The data is stored in an Oracle database. To access and update the data the REST Endpoint described above can be used. 

<code>
+-------------------+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /+-----------------+<br>
|..... ANTRAG ..... | -||--------< | ... CHANGE ....  | <br>
+-------------------+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \+-----------------+
</code>

#### Proposal Table 

| Column Name| Datatype | Nullable | Description |
|---|---|---|---|
|ID|NUMBER|No|Primary Key of the Proposal Table |
|TITLE|VARCHAR2(500)|No|Title of a Proposal|
|DESCRIPTION|VARCHAR2(4000)|Yes|Description of a Proposal|
|APPLICANT|VARCHAR2(100)|No|Applicant of a Proposal - This value is filled automatically with the username of the APEX User|
|BUDGET|NUMBER|Yes|Budget of the proposal|
|CATEGORY|VARCHAR2(255)|No|Category of the proposal - Value is filled with a Dropdown field in the APEX form|
|LINKS|VARCHAR2(4000)|Yes|Additional links for the proposals to external sources|
|SUBMISSION_DATE|TIMESTAMP(6)|No|Submission date of the proposal - This value is automatically filled by the APEX form at the submission of the proposal|
|PROPOSAL_STATUS|VARCHAR2(100)|No|Status of the proposal - This value is initially set by the APEX form. During the process Camunda is tracking the proposal status. - Created / Reviewed / Declined / Accepted / ... |
|IS_REVIEWED|VARCHAR2(50)|Yes|Flag if the proposal is reviewed - Yes / No|
|REVIEW_DATE|TIMESTAMP(6)|Yes|Date of the Review|
|REVIEW_STATUS|VARCHAR2(100)|Yes|Outcome of the review - Approved / Denied|
|IS_PITCH_NEEDED|VARCHAR2(50)|Yes|Flag if Pitch is needed - Yes / No|
|VETO_START_DATE|TIMESTAMP(6)|Yes|Date from when the veto timeframe starts|
|HAS_CHANGE|VARCHAR2(50)|Yes|Status if the proposal has a change from a member - Yes / No|
|HAS_VETO|VARCHAR2(50)|Yes|Outcome if proposal has a veto - Yes / No|
	


#### Change Table

| Column Name| Datatype | Nullable | Description |
|---|---|---|---|
|ID|NUMBER|No|Primary Key of the Change Table|
|ANTRAG_ID|NUMBER|No|Foreign Key to the Proposal Table|
|CHANGE_TITEL|VARCHAR2(100)|No|Title of a change|
|CHANGE_DESC|VARCHAR2(4000)|Yes|Description of a change|
|IS_ACCEPTED|VARCHAR2(50)|Yes|Flag if Change is accepted from applicant|



## <span style="color:blue">11. Deployment of Project</span>



## <span style="color:blue">12. Testing of Project</span> 

## <span style="color:blue">13. Summary</span>