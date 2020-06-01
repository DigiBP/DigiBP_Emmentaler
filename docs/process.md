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

Votings of proposals and their discussion are currently set up as a Telegram chatroom. The structure of a chatroom complicates the tracking of the status of proposals and their outcomes.

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

The current process to request proposals is done in the chat application Telegram. There is no overview of the ongoing proposals by other members of the company and discussions are hard to follow.

## <span style="color:blue">6. Process AS-IS Description</span>

### Process AS-IS Description


The process starts with the requester creating a proposal. It must be phrased to allow a yes / no decision. The Chief of innovation reviews the proposal. If the proposal is not complete, it is handed back to the requester. If the Chief of innovation declares the proposal as complete, the proposal is ready for voting. Next, the members need to decide if they want a pitch or presentation of the proposal to learn about its details. This can help to get a better understanding of the request or the idea. If not, the 10 days right to veto starts for all the members. During this period, two tasks commence: 
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
There are several factors why the current process can be enriched by a more modern process:
* Simplification and clear structuring of the application process
* Today all changes are made manually
* In the telegram chat, having multiple proposals in parallel, can end up in a mess.
* Someone must manually control the time for veto.
* History is not guaranteed (when did Veto start, when did it stop, etc.). Until now it was necessary to search the history in telegrams to find the contents again. This was inefficient and error-prone.


## <span style="color:blue">9. Process TO-BE Description</span>

### Digitized Process Architecture


![Architecture of the digitized process](architecture/architecture-model.jpg "Architecture of the digitized process")


Oracle APEX is a free tool for rapid application development that helps in developing and publishing desktop and mobile applications.



### Process TO-BE Description

The TO-BE process prepared in Camunda Modeler has been deployed on Heroku.

The most important steps are explained in the table below:

| Task | from | to | HTTP-Request | API | Description |
| --- | --- | --- | --- | --- | --- |
| Start | Apex | Heroku | POST | /process-definition/{id}/start | The trigger starting the process is when a requestor creates a new proposal in the front-end application provided by APEX. To retrieve application data for the business process on Heroku, the API created in Apex is exposed and consumed. |
| Inform Chief of Innovation | Heroku | Apex | POST | /sendMail | As soon as an applicant has submitted a new proposal, the Chief of Innovation is being informed via e-mail notification. Apex is triggered by Heroku, which then triggers the sending of mail. |
| Review of Proposal | Apex | Apex | - | - | The Chief of Innovation then reviews the proposal in a manual process. The result of the check is then being updated. The review date, proposal state, review state and the isReviewed flag is being set.|
| Receive Review Outcome | Apex | Heroku | POST | /execution/{id}/signal | As soon as the Chief of Innovation has given an answer to the proposal, the Camunda process is triggered. The CIO can either accept or decline the response, depending on whether it is complete or not. |
| Inform Requester | Heroku | Apex | POST | /sendMail | In case that the proposal is not completed, the requestor will be informed to complete the request. |
| Adapt Proposal | Apex | Apex | - | - | The requestor adapts the proposal. |
| Proposal submitted | Apex | Heroku | POST | /execution/{id}/signal | As soon as the adapted Proposal is submitted in APEX, Heroku will trigger the Mail sending. The Chief of Innovation will automatically be informed again and receive a notification email that a request has been adapted and is ready for review. Then the process starts again as described above, where the CIO needs to review the proposal. |
| Set Veto start time | Heroku | Apex | POST | /setVetoStartDate | If the proposal is complete and there's nothing to add from requesters side, the 10 days right to veto starts for all the members. The start date of the right to veto will be updated in APEX by using HTTP POST API. |
| Inform Members to Veto | Heroku | Apex | POST | /sendMail | The members will be informed about starting the right to veto. During these 10 days, three activities can occur: |
| Members can Veto | Apex | Apex | - | - | The 10 days right to veto will be not interrupted by any cases. Any member of company can make use of its right to veto. _Veto happens in APEX. If a Veto is submitted, a Request to Heroku is made._ |
| Veto submitted | Apex | Heroku | POST | /execution/{id}/signal | As soon as at least one member vetoed, the process will be terminated. |
| Proposal is declined | Heroku | Apex | POST | /setProposalStatus | The result of the process – acceptance or declination of proposal – is updated in APEX. |
| Business Rule if Presentation is needed | Heroku | Heroku | - | - | The decision table is used to decide whether a presentation of the requester is necessary or not. If a presentation or pitch is necessary, the requester prepares the pitch or presentation.|
| Update Decision | Heroku | Apex | POST | /isPitchNeeded | Sets the flag whether a presentation is required or not.|
| Inform Requester about Presentation | Heroku | Apex | POST | /sendMail | Requester is informed to make a Presentation about his Request. |
| Organization of Pitch or Presentation | User | User | - | - | Requester then need to prepare the presentation within the 10 days, even if the request can still be rejected with a veto and therefore its preparation would be useless. |
| Proposal is accepted | Heroku | Apex | POST | /setProposalStatus | The result of the process – acceptance or declination of proposal – is updated in APEX.|
| Inform members and requester | Heroku | Apex | POST | /sendMail | Members and Requester are informed about the outcome of the proposal process via Email. |
| End | - | - | - | - | The process ends. |



## <span style="color:blue">10. Deployement of External Services </span>



### APEX Frontend
The frontend allows the Schaltstelle Members to create and modify the proposals. It serves as the process GUI. 

### APEX REST Endpoints

All the APEX REST Endpoints for the proposal application are located under the proposal module: 

[https://apex.oracle.com/pls/apex/schaltstelle/proposal/](https://apex.oracle.com/pls/apex/schaltstelle/proposal/)



#### Ressources

|Ressource URI|Method|Parameters|
|---|---|---|
|sendMail|POST|IN - ccEmail <br> IN - emailBody <br> IN - emailBodyHTML  <br> IN - emailSubject <br> IN - fromEmail <br>  IN - toEmail <br>  OUT - http_status_code|
|isPitchNeeded|POST|IN - id <br> IN - is_pitch_needed <br> OUT - http_status_code  |
|setProposalStatus|POST|IN - id <br> IN - proposal_status <br> OUT - http_status_code  |
|setVetoStartDate|POST|IN - id <br> IN - veto_start_date <br> IN - proposal_status  <br> OUT - http_status_code  |

### Oracle Database

The data is stored in an Oracle database. To access and update the data the REST Endpoint described above can be used. 

![Database Entity Relationships](architecture/db-model.jpg "Database Entity Relationships")

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
|HAS_VETO|VARCHAR2(50)|Yes|Outcome if proposal has a veto - Yes / No|

## <span style="color:blue">11. Deployment of Project</span>
The project is deployed from camunda modeler to Herokuapp via button "deploy current diagram". In the section "Cockpit" in Herokuapp, the new instance of the process appears with associated Definition and Deployment ID. Definition ID is essential for starting the process from APEX. For that purpose, the trigger with associated procedure has been set up in APEX.

## <span style="color:blue">12. Testing of Project</span> 
The all endpoints were tested in POSTMAN. The table below presents tested endpoints with respective URL's.  

#### Tested Endpoints

| ID| Name | Method | URL | 
|---|---|---|---|
|1|Process Start|POST|https://emmentaler.herokuapp.com/rest/process-definition/digibp-tobe:2:70314c02-9de2-11ea-9c51-da029e11a7df/start?|
|2|Send Mail|POST|https://apex.oracle.com/pls/apex/schaltstelle/proposal/sendMail|
|3|Review Outcome Received|POST|https://emmentaler.herokuapp.com/rest/message|
|4|Proposal Submitted|POST|https://emmentaler.herokuapp.com/rest/message|
|5|Veto Received|POST|https://emmentaler.herokuapp.com/rest/message|
|6|Proposal Status|POST|https://apex.oracle.com/pls/apex/schaltstelle/proposal/setProposalStatus|
|7|Set Veto Start Date|POST|https://apex.oracle.com/pls/apex/schaltstelle/proposal/setVetoStartDate|
|8|Pitch Needed|POST|https://apex.oracle.com/pls/apex/schaltstelle/proposal/setProposalStatus|


#### Requested Bodies

<table>
<tr>
<th>
ID
</th>
<th>
Body
</th>
</tr>

<tr>

<td>
1
</td>

<td>
<pre>
{ 
  "variables": {
    "email" : {
        "value" : "jasmin.fluri@students.fhnw.ch",
        "type": "String"
    },
    "requester" : {
        "value" : "alain.schmutz@students.fhnw.ch",
        "type": "String"
    },
    "budget" : {
        "value" : 5000,
        "type": "Integer"
    },
    "proposalId" : {
        "value" : 361,
        "type": "Integer"
    },
    "category" : {
        "value" : "Innovation",
        "type": "String"
    }
  },
 "businessKey" : "proposalProcessAPEX"
} 
</pre>
</td>

</tr>

<tr><td>2</td><td>
<pre>{
    "toEmail": "alena.magliano@students.fhnw.ch",
    "fromEmail": "alena.magliano@students.fhnw.ch",
    "ccEmail": "alena.magliano@students.fhnw.ch",
    "emailSubject": "This is a Test from Postman",
    "emailBody": "This is a Postman Test",
    "emailBodyHTML": "This is a <b>Postman</b> Test"
}</pre>
</td></tr>

<tr><td>3</td><td><pre>{
  "messageName" : "ReceiveReviewOutcome",
  "businessKey" : "proposalProcessAPEX",
  "processVariables" : {
    "complete" : {"value" : "true", "type": "String"
                     }
  },
  "resultEnabled": true
}</pre></td></tr>

<tr><td>4</td><td><pre>{
  "messageName" : "ProposalSubmitted",
  "businessKey" : "proposalProcessAPEX",
  "processVariables" : {
    "edited" : {"value" : "true", "type": "String"
                     }
  },
  "resultEnabled": true
}</pre></td></tr>

<tr><td>5</td><td><pre>{
  "messageName" : "ReceiveVeto",
  "businessKey" : "proposalProcessAPEX",
  "processVariables" : {
    "veto" : {"value" : "Yes", "type": "String"
                     }
  },
  "resultEnabled": true
}</pre></td></tr>

<tr><td>6</td><td><pre>{
	"id": "361",
	"proposal_status" : "Accepted"
}</pre></td></tr>

<tr><td>7</td><td><pre>{
	"id": "361",
	"veto_start_date" : "2020-06-01T18:25:43.511Z"
}</pre></td></tr>

<tr><td>8</td><td><pre>{
	"id": "361",
	"is_pitch_needed" : "true"
}</pre></td></tr>


</table>



## <span style="color:blue">13. Summary</span>
There was no structured process for submission and handling of new and existing proposals in the company. The proposals were submitted and handled in Telegram chat, which made an overview more difficult.
With the redesigned and digitized process, the submission and handling of proposals is made easier. The requestor can submit the proposals via user-friendly fronted application APEX and review the status of proposals at every time. Additionally, in case that something is not clear, the requestor can make use of the implemented chatbot. The notifications are sent via email so there is no need anymore for using Telegram. Also the approver approves the proposals in APEX and can easily check e.g. how many proposals are pending or finished. The employees make the use of right to VETO via APEX. The new functionality whether presentation or pitch is needed is done with the help of automated decision logic.
In conclusion, the new digitalized process brings clear advantages over the old process.